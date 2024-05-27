#!/bin/sh

AVBROOT=.bin/avbroot
subject=$1

if [ -z "$subject" ]; then
    echo "Subject not specified!"
    exit 1
fi

outdir=$2
if [ -z "$outdir" ]; then
    echo "Output dir not specified!"
    exit 1
fi

# Ensure the output directory exists
if [ ! -d "$outdir" ]; then
    mkdir -p "$outdir"
fi

# List of key names
keys="bluetooth cts_uicc_2021 sdk_sandbox releasekey platform shared media networkstack testkey"

# Function to remove existing files
remove_existing_files() {
    key_base=$1
    rm -f "$outdir/$key_base.pk8"
    rm -f "$outdir/$key_base.x509.pem"
}

# Remove existing files for each key
for key in $keys; do
    remove_existing_files "$key"
done

# Generate keys
for key in $keys; do
    ./make_key "$outdir/$key" "$subject" rsa
done

# Extract and generate AVB-related files, replacing if they exist
$AVBROOT key extract-avb -k "$outdir/releasekey-private.pem" -o "$outdir/avb_pkmd.bin"
$AVBROOT key generate-cert -k "$outdir/releasekey-private.pem" -o "$outdir/ota.crt"
