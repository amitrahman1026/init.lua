#!/usr/bin/env python3
"""
CodeStats Offline Sync Script

This script reads offline pulse files created by the modified CodeStats nvim plugin
and sends them to the CodeStats API. Designed for environments where the development
server has restricted internet access.

Usage:
    python codestats_sync.py [--pulse-dir DIR] [--token TOKEN] [--dry-run]
"""

import argparse
import json
import os
import requests
import sys
from pathlib import Path
from datetime import datetime, timedelta


def send_pulse_to_api(pulse_data, token, endpoint="https://codestats.net"):
    """Send a single pulse to the CodeStats API"""
    headers = {
        "Content-Type": "application/json",
        "X-API-Token": token
    }
    
    try:
        response = requests.post(
            f"{endpoint}/api/my/pulses",
            headers=headers,
            json=pulse_data,
            timeout=30
        )
        
        if response.status_code == 201:
            return True, "Success"
        else:
            return False, f"HTTP {response.status_code}: {response.text}"
    except requests.exceptions.RequestException as e:
        return False, f"Network error: {str(e)}"


def process_pulse_files(pulse_dir, token, dry_run=False, endpoint="https://codestats.net"):
    """Process all pulse files in the directory"""
    pulse_dir = Path(pulse_dir)
    
    if not pulse_dir.exists():
        print(f"Pulse directory {pulse_dir} does not exist")
        return
    
    pulse_files = list(pulse_dir.glob("pulse_*.json"))
    
    if not pulse_files:
        print("No pulse files found")
        return
    
    print(f"Found {len(pulse_files)} pulse files")
    
    sent_count = 0
    error_count = 0
    
    for pulse_file in sorted(pulse_files):
        try:
            with open(pulse_file, 'r') as f:
                pulse_data = json.load(f)
            
            # Check if pulse is not too old (API rejects pulses older than a week)
            coded_at = datetime.fromisoformat(pulse_data['coded_at'].replace('Z', '+00:00'))
            if datetime.now(coded_at.tzinfo) - coded_at > timedelta(days=7):
                print(f"Skipping old pulse: {pulse_file.name}")
                if not dry_run:
                    pulse_file.unlink()  # Delete old pulse
                continue
            
            if dry_run:
                print(f"Would send: {pulse_file.name}")
                continue
            
            success, message = send_pulse_to_api(pulse_data, token, endpoint)
            
            if success:
                print(f"Sent: {pulse_file.name}")
                pulse_file.unlink()  # Delete successfully sent pulse
                sent_count += 1
            else:
                print(f"Failed to send {pulse_file.name}: {message}")
                error_count += 1
                
        except Exception as e:
            print(f"Error processing {pulse_file.name}: {str(e)}")
            error_count += 1
    
    print(f"\nSummary: {sent_count} sent, {error_count} errors")


def main():
    parser = argparse.ArgumentParser(description="Send offline CodeStats pulses")
    parser.add_argument("--pulse-dir", default="~/.codestats/pending",
                      help="Directory containing pulse files")
    parser.add_argument("--token", 
                      help="CodeStats API token (or set CODESTATS_API_KEY env var)")
    parser.add_argument("--endpoint", default="https://codestats.net",
                      help="CodeStats endpoint URL")
    parser.add_argument("--dry-run", action="store_true",
                      help="Show what would be sent without actually sending")
    
    args = parser.parse_args()
    
    # Get token from args or environment
    token = args.token or os.environ.get("CODESTATS_API_KEY")
    if not token:
        print("Error: CodeStats API token required (use --token or CODESTATS_API_KEY env var)")
        sys.exit(1)
    
    pulse_dir = Path(args.pulse_dir).expanduser()
    
    process_pulse_files(pulse_dir, token, args.dry_run, args.endpoint)


if __name__ == "__main__":
    main()