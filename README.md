# vendor_parasite-signatures_scripts

* Script to generate your own private keys for signing builds
* Will generates following keys:<br>
`bluetooth cts_uicc_2021 sdk_sandbox releasekey platform shared media networkstack testkey`

* Usage

```sh
./generate-keys.sh '/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com' /home/foo/signatures
```

* References:
  1. [Sign builds for release](https://source.android.com/docs/core/ota/sign_builds) - from source.android.com
  2. [Generating Keys](https://github.com/chenxiaolong/avbroot?tab=readme-ov-file#generating-keys) - from avbroot readme
  3. make_key script is taken from development/tools/make_key and modified
