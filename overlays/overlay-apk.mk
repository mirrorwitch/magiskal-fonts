keystore = ~/cutegay.keystore
keyalias = cutegay_key
kspass := $(if $(KEYSTORE_PASSWORD),--ks-pass env:KEYSTORE_PASSWORD,)
androidjar=/usr/lib/android-sdk/platforms/android-30/android.jar 
ifndef APKNAME
	$(error APKNAME not set)
endif

$(APKNAME).apk: $(APKNAME)_unsigned.apk Makefile
	apksigner sign --ks $(keystore) --ks-key-alias $(keyalias) $(kspass) --out $(APKNAME).apk $(APKNAME)_unsigned.apk
$(APKNAME)_unsigned.apk: $(APKNAME)_unaligned.apk Makefile
	rm -f $(APKNAME)_unsigned.apk
	zipalign -v 4 $(APKNAME)_unaligned.apk $(APKNAME)_unsigned.apk
$(APKNAME)_unaligned.apk: AndroidManifest.xml res_compiled.zip Makefile
	aapt2 link --manifest AndroidManifest.xml -I $(androidjar) -o $(APKNAME)_unaligned.apk res_compiled.zip
res_compiled.zip: res/values/strings.xml res/values/config.xml Makefile
	aapt2 compile res/values/strings.xml res/values/config.xml -o res_compiled.zip
clean:
	rm -vf $(APKNAME)_unsigned.apk $(APKNAME)_unaligned.apk $(APKNAME).apk.idsig res_compiled.zip
distclean: clean
	rm -f $(APKNAME).apk
verify:
	apksigner verify --print-certs $(APKNAME).apk
.PHONY: clean distclean verify

