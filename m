Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5930FCDB47E
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 07:48:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03C743CD3C1
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 09:48:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE3A53C8767
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A28123799C
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 09:48:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22205219BA;
 Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697183289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xh5KHpj/ZbQsjJ1kWKm4Rikd6Fngd9XkwjPQdzrHsHA=;
 b=ZRJzyRX1oulqvR861zn4SvyJEYdslzixt4bByh1acnvkt9QWHGuk81PeiKuXKgxbfEF9oS
 se38QojFuWXaUEMsobMOpB71PMMzqPOVpwHFs7bHPQzENr998ExpYpUAn2RbZh1P4iUMzd
 MYt+Gpn1Ypez2e6J2FEmHTm4iAZ/Wmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697183289;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xh5KHpj/ZbQsjJ1kWKm4Rikd6Fngd9XkwjPQdzrHsHA=;
 b=O5mtDbnAgpJhjW5hZINGNvKYpIKOKKOtBKCshMtboir3cLcAuZB3/HJGG4D8uFZIdKbAuO
 wypMwMUYClxqlTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C92E13A00;
 Fri, 13 Oct 2023 07:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SMMQAjn2KGVqXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Oct 2023 07:48:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Oct 2023 09:47:45 +0200
Message-ID: <20231013074748.702214-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013074748.702214-1-pvorel@suse.cz>
References: <20231013074748.702214-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] lib: Add .modprobe
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Ci0tLQogZG9jL0MtVGVz
dC1BUEkuYXNjaWlkb2MgICAgICAgICAgICAgIHwgIDUgKysrCiBkb2MvVGVzdC1Xcml0aW5nLUd1
aWRlbGluZXMuYXNjaWlkb2MgfCAgMSArCiBpbmNsdWRlL3RzdF90ZXN0LmggICAgICAgICAgICAg
ICAgICAgfCAgNSArKy0KIGxpYi90c3RfdGVzdC5jICAgICAgICAgICAgICAgICAgICAgICB8IDUz
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgNjMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RvYy9DLVRlc3QtQVBJLmFzY2lp
ZG9jIGIvZG9jL0MtVGVzdC1BUEkuYXNjaWlkb2MKaW5kZXggZGFiODExNTY0Li5mMmJhMzAyZTIg
MTAwNjQ0Ci0tLSBhL2RvYy9DLVRlc3QtQVBJLmFzY2lpZG9jCisrKyBiL2RvYy9DLVRlc3QtQVBJ
LmFzY2lpZG9jCkBAIC0xNjA5LDYgKzE2MDksMTEgQEAgZmlyc3QgbWlzc2luZyBkcml2ZXIuCiBU
aGUgZGV0ZWN0aW9uIGlzIGJhc2VkIG9uIHJlYWRpbmcgJ21vZHVsZXMuZGVwJyBhbmQgJ21vZHVs
ZXMuYnVpbHRpbicgZmlsZXMKIGdlbmVyYXRlZCBieSBrbW9kLiBUaGUgY2hlY2sgaXMgc2tpcHBl
ZCBvbiBBbmRyb2lkLgogCitOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgJy5tb2Rwcm9iZScgb2Yga2Vy
bmVsIG1vZHVsZSBuYW1lcyBhcmUgdHJpZWQgdG8gYmUgbG9hZGVkCit3aXRoICdtb2Rwcm9iZScg
dW5sZXNzIHRoZXkgYXJlIGJ1aWx0aW4gb3IgYWxyZWFkeSBsb2FkZWQuIFRlc3QgZXhpdHMgd2l0
aAorJ1RDT05GJyBvbiBmaXJzdCAnbW9kcHJvYmUnIG5vbi16ZXJvIGV4aXQuIER1cmluZyBjbGVh
bnVwIGFyZSB0aGUgbW9kdWxlcworbG9hZGVkIGJ5IHRoZSB0ZXN0IHVubG9hZGVkIHdpdGggJ3Jt
bW9kJy4KKwogMS4yNyBTYXZpbmcgJiByZXN0b3JpbmcgL3Byb2N8c3lzIHZhbHVlcwogfn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgogCmRpZmYgLS1naXQgYS9kb2MvVGVz
dC1Xcml0aW5nLUd1aWRlbGluZXMuYXNjaWlkb2MgYi9kb2MvVGVzdC1Xcml0aW5nLUd1aWRlbGlu
ZXMuYXNjaWlkb2MKaW5kZXggMGRiODUyYWU2Li4xOTQ4NzgxNmUgMTAwNjQ0Ci0tLSBhL2RvYy9U
ZXN0LVdyaXRpbmctR3VpZGVsaW5lcy5hc2NpaWRvYworKysgYi9kb2MvVGVzdC1Xcml0aW5nLUd1
aWRlbGluZXMuYXNjaWlkb2MKQEAgLTM3MSw2ICszNzEsNyBAQCBodHRwczovL2dpdGh1Yi5jb20v
bGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtpL1NoZWxsLVRlc3QtQVBJW1NoZWxsIFRlc3QgQVBJ
XS4KIHwgJy5taW5fbWVtX2F2YWlsJyB8IG5vdCBhcHBsaWNhYmxlCiB8ICcubW50X2ZsYWdzJyB8
ICdUU1RfTU5UX1BBUkFNUycKIHwgJy5taW5fc3dhcF9hdmFpbCcgfCBub3QgYXBwbGljYWJsZQor
fCAnLm1vZHByb2JlJyB8IOKAkwogfCAnLm1udHBvaW50JywgJy5tbnRfZGF0YScgfCAnVFNUX01O
VFBPSU5UJwogfCAnLm1vdW50X2RldmljZScgfCAnVFNUX01PVU5UX0RFVklDRScKIHwgJy5uZWVk
c19jZ3JvdXBfY3RybHMnIHwg4oCTCmRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF90ZXN0LmggYi9p
bmNsdWRlL3RzdF90ZXN0LmgKaW5kZXggNzVjMjEwOWI5Li42YjRmYWM5ODUgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvdHN0X3Rlc3QuaAorKysgYi9pbmNsdWRlL3RzdF90ZXN0LmgKQEAgLTI5Nyw5ICsy
OTcsMTIgQEAgc3RydWN0IHRzdF90ZXN0IHsKIAkvKiBOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgb2Yg
cmVzb3VyY2UgZmlsZSBuYW1lcyAqLwogCWNvbnN0IGNoYXIgKmNvbnN0ICpyZXNvdXJjZV9maWxl
czsKIAotCS8qIE5VTEwgdGVybWluYXRlZCBhcnJheSBvZiBuZWVkZWQga2VybmVsIGRyaXZlcnMg
Ki8KKwkvKiBOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgb2YgbmVlZGVkIGtlcm5lbCBkcml2ZXJzIHRv
IGJlIGNoZWNrZWQgKi8KIAljb25zdCBjaGFyICogY29uc3QgKm5lZWRzX2RyaXZlcnM7CiAKKwkv
KiBOVUxMIHRlcm1pbmF0ZWQgYXJyYXkgb2YgbmVlZGVkIGtlcm5lbCBkcml2ZXJzIHRvIGJlIGxv
YWRlZCB3aXRoIG1vZHByb2JlICovCisJY29uc3QgY2hhciAqIGNvbnN0ICptb2Rwcm9iZTsKKwog
CS8qCiAJICoge05VTEwsIE5VTEx9IHRlcm1pbmF0ZWQgYXJyYXkgb2YgKC9wcm9jLCAvc3lzKSBm
aWxlcyB0byBzYXZlCiAJICogYmVmb3JlIHNldHVwIGFuZCByZXN0b3JlIGFmdGVyIGNsZWFudXAK
ZGlmZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKaW5kZXggMDg3YzYy
YTE2Li5jY2JhYTRjMDIgMTAwNjQ0Ci0tLSBhL2xpYi90c3RfdGVzdC5jCisrKyBiL2xpYi90c3Rf
dGVzdC5jCkBAIC00OSw2ICs0OSw3IEBAIGNvbnN0IGNoYXIgKlRDSUQgX19hdHRyaWJ1dGVfXygo
d2VhaykpOwogI2RlZmluZSBDVkVfREJfVVJMICJodHRwczovL2N2ZS5taXRyZS5vcmcvY2dpLWJp
bi9jdmVuYW1lLmNnaT9uYW1lPUNWRS0iCiAKICNkZWZpbmUgREVGQVVMVF9USU1FT1VUIDMwCisj
ZGVmaW5lIE1PRFVMRVNfTUFYX0xFTiAxMAogCiBzdHJ1Y3QgdHN0X3Rlc3QgKnRzdF90ZXN0Owog
CkBAIC04Myw2ICs4NCw4IEBAIGNvbnN0IGNoYXIgKnRzdF9pcGNfcGF0aCA9IGlwY19wYXRoOwog
CiBzdGF0aWMgY2hhciBzaG1fcGF0aFsxMDI0XTsKIAorc3RhdGljIGludCBtb2R1bGVzX2xvYWRl
ZFtNT0RVTEVTX01BWF9MRU5dOworCiBpbnQgVFNUX0VSUjsKIGludCBUU1RfUEFTUzsKIGxvbmcg
VFNUX1JFVDsKQEAgLTExMzUsNiArMTEzOCwyOSBAQCBzdGF0aWMgdm9pZCBkb19jZ3JvdXBfcmVx
dWlyZXModm9pZCkKIAl0c3RfY2dfaW5pdCgpOwogfQogCisvKgorICogU2VhcmNoIGtlcm5lbCBk
cml2ZXIgaW4gL3Byb2MvbW9kdWxlcy4KKyAqCisgKiBAcGFyYW0gZHJpdmVyIFRoZSBuYW1lIG9m
IHRoZSBkcml2ZXIuCisgKiBAcmV0dXJuIDEgaWYgZHJpdmVyIGlzIGZvdW5kLCBvdGhlcndpc2Ug
MC4KKyAqLworc3RhdGljIGludCBtb2R1bGVfbG9hZGVkKGNvbnN0IGNoYXIgKmRyaXZlcikKK3sK
KwljaGFyIGxpbmVbNDA5Nl07CisJaW50IGZvdW5kID0gMDsKKwlGSUxFICpmaWxlID0gU0FGRV9G
T1BFTigiL3Byb2MvbW9kdWxlcyIsICJyIik7CisKKwl3aGlsZSAoZmdldHMobGluZSwgc2l6ZW9m
KGxpbmUpLCBmaWxlKSkgeworCQlpZiAoc3Ryc3RyKGxpbmUsIGRyaXZlcikpIHsKKwkJCWZvdW5k
ID0gMTsKKwkJCWJyZWFrOworCQl9CisJfQorCVNBRkVfRkNMT1NFKGZpbGUpOworCisJcmV0dXJu
IGZvdW5kOworfQorCiBzdGF0aWMgdm9pZCBkb19zZXR1cChpbnQgYXJnYywgY2hhciAqYXJndltd
KQogewogCWlmICghdHN0X3Rlc3QpCkBAIC0xMTk0LDYgKzEyMjAsMjAgQEAgc3RhdGljIHZvaWQg
ZG9fc2V0dXAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJCXNhZmVfY2hlY2tfZHJpdmVyKG5h
bWUpOwogCX0KIAorCWlmICh0c3RfdGVzdC0+bW9kcHJvYmUpIHsKKwkJY29uc3QgY2hhciAqbmFt
ZTsKKwkJaW50IGk7CisKKwkJZm9yIChpID0gMDsgKG5hbWUgPSB0c3RfdGVzdC0+bW9kcHJvYmVb
aV0pOyArK2kpIHsKKwkJCS8qIG9ubHkgbG9hZCBtb2R1bGUgaWYgbm90IGFscmVhZHkgbG9hZGVk
ICovCisJCQlpZiAoIW1vZHVsZV9sb2FkZWQobmFtZSkgJiYgdHN0X2NoZWNrX2J1aWx0aW5fZHJp
dmVyKG5hbWUpKSB7CisJCQkJY29uc3QgY2hhciAqY29uc3QgY21kX21vZHByb2JlW10gPSB7Im1v
ZHByb2JlIiwgbmFtZSwgTlVMTH07CisJCQkJU0FGRV9DTUQoY21kX21vZHByb2JlLCBOVUxMLCBO
VUxMKTsKKwkJCQltb2R1bGVzX2xvYWRlZFtpXSA9IDE7CisJCQl9CisJCX0KKwl9CisKIAlpZiAo
dHN0X3Rlc3QtPm1vdW50X2RldmljZSkKIAkJdHN0X3Rlc3QtPmZvcm1hdF9kZXZpY2UgPSAxOwog
CkBAIC0xMzYyLDYgKzE0MDIsMTkgQEAgc3RhdGljIHZvaWQgZG9fY2xlYW51cCh2b2lkKQogCiAJ
dHN0X3N5c19jb25mX3Jlc3RvcmUoMCk7CiAKKwlpZiAodHN0X3Rlc3QtPm1vZHByb2JlKSB7CisJ
CWNvbnN0IGNoYXIgKm5hbWU7CisJCWludCBpOworCisJCWZvciAoaSA9IDA7IChuYW1lID0gdHN0
X3Rlc3QtPm1vZHByb2JlW2ldKTsgKytpKSB7CisJCQlpZiAoIW1vZHVsZXNfbG9hZGVkW2ldKQor
CQkJCWNvbnRpbnVlOworCisJCQljb25zdCBjaGFyICpjb25zdCBjbWRfcm1tb2RbXSA9IHsicm1t
b2QiLCBuYW1lLCBOVUxMfTsKKwkJCVNBRkVfQ01EKGNtZF9ybW1vZCwgTlVMTCwgTlVMTCk7CisJ
CX0KKwl9CisKIAlpZiAodHN0X3Rlc3QtPnJlc3RvcmVfd2FsbGNsb2NrKQogCQl0c3Rfd2FsbGNs
b2NrX3Jlc3RvcmUoKTsKIAotLSAKMi40Mi4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
