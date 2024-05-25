#!/bin/sh

AVBROOT=.bin/avbroot

subject=$1
if [ -z "$subject" ]
then
    echo -e "Subject not specified!"
    exit 1
fi

outdir=$2
if [ -z "$outdir" ]
then
    echo -e "Output dir not specified!"
    exit 1
fi

for x in bluetooth cts_uicc_2021 sdk_sandbox releasekey platform shared media networkstack testkey; do \
    ./make_key $outdir/$x "$subject" rsa; \
done

$AVBROOT key extract-avb -k $outdir/releasekey-private.pem -o $outdir/avb_pkmd.bin
$AVBROOT key generate-cert -k $outdir/releasekey-private.pem -o $outdir/ota.crt
