Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212C5C77B61
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 03:29:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13D6B3CE9FD
	for <ltp@archiver.kernel.org>; Tue, 25 Apr 2023 05:29:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47ACF3CB302
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 05:29:04 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 777091400538
 for <ltp@lists.linux.it>; Tue, 25 Apr 2023 05:29:00 +0200 (CEST)
X-UUID: b99cefd8e11a46d9a26937e1a1238b14-20230425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:a6d69fee-2775-4c4d-8c78-7a0b218adf87, IP:10,
 URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
 TION:release,TS:-30
X-CID-INFO: VERSION:1.1.22, REQID:a6d69fee-2775-4c4d-8c78-7a0b218adf87, IP:10,
 UR
 L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-30
X-CID-META: VersionHash:120426c, CLOUDID:ce3466a2-8fcb-430b-954a-ba3f00fa94a5,
 B
 ulkID:230425112855GBB3V8OE,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
 I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b99cefd8e11a46d9a26937e1a1238b14-20230425
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
 (envelope-from <zenghao@kylinos.cn>) (Generic MTA)
 with ESMTP id 375452005; Tue, 25 Apr 2023 11:28:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id BBFC9E0084A1;
 Tue, 25 Apr 2023 11:28:54 +0800 (CST)
X-ns-mid: postfix-644748F6-66525442
Received: from zdzh5-QiTianM428-A376.. (unknown [172.20.12.253])
 by mail.kylinos.cn (NSMail) with ESMTPA id 4291DE0084A1;
 Tue, 25 Apr 2023 11:28:53 +0800 (CST)
From: Hao Zeng <zenghao@kylinos.cn>
To: chrubis@suse.cz
Date: Tue, 25 Apr 2023 11:28:52 +0800
Message-Id: <20230425032852.4095325-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] fs/doio:Use the snprintf function to prevent buffer
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
Cc: Hao Zeng <zenghao@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VXNlIHRoZSBzbnByaW50ZiBmdW5jdGlvbiBpbnN0ZWFkIG9mIHNwcmludGYgaW4gdGhlIHdyaXRl
X2xvZy5jIGZpbGUKQ2hhbmdlIHRoZSBXbG9nX0Vycm9yX1N0cmluZyBmcm9tIDI1NiB0byAyMDQ4
IHRvIHNvbHZlIHRoZSBmb2xsb3dpbmcgY29tcGlsYXRpb24gQWxhcm0gcHJvYmxlbe+8mgp3YXJu
aW5nOiDigJglc+KAmSBkaXJlY3RpdmUgb3V0cHV0IG1heSBiZSB0cnVuY2F0ZWQgd3JpdGluZyB1
cCB0byAxMDIzIGJ5dGVzIGludG8gYSByZWdpb24gb2Ygc2l6ZSAyMjgKClNpZ25lZC1vZmYtYnk6
IEhhbyBaZW5nIDx6ZW5naGFvQGt5bGlub3MuY24+ClN1Z2dlc3RlZC1ieTogQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9mcy9kb2lvL3dyaXRlX2xv
Zy5jIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
ZnMvZG9pby93cml0ZV9sb2cuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZG9pby93cml0ZV9sb2cu
YwppbmRleCBlOGVmOWM3Y2IuLmMwNjY3N2ZjNiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5l
bC9mcy9kb2lvL3dyaXRlX2xvZy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZG9pby93cml0
ZV9sb2cuYwpAQCAtODcsNyArODcsNyBAQAogLyojZGVmaW5lIFBBVEhfTUFYIHBhdGhjb25mKCIv
IiwgX1BDX1BBVEhfTUFYKSovCiAjZW5kaWYKIAotY2hhciBXbG9nX0Vycm9yX1N0cmluZ1syNTZd
OworY2hhciBXbG9nX0Vycm9yX1N0cmluZ1syMDQ4XTsKIAogI2lmIF9fU1REQ19fCiBzdGF0aWMg
aW50IHdsb2dfcmVjX3BhY2soc3RydWN0IHdsb2dfcmVjICp3cmVjLCBjaGFyICpidWYsIGludCBm
bGFnKTsKQEAgLTEyOSw3ICsxMjksNyBAQCBpbnQgd2xvZ19vcGVuKHN0cnVjdCB3bG9nX2ZpbGUg
KndmaWxlLCBpbnQgdHJ1bmMsIGludCBtb2RlKQogCXVtYXNrKG9tYXNrKTsKIAogCWlmICh3Zmls
ZS0+d19hZmQgPT0gLTEpIHsKLQkJc3ByaW50ZihXbG9nX0Vycm9yX1N0cmluZywKKwkJc25wcmlu
dGYoV2xvZ19FcnJvcl9TdHJpbmcsIHNpemVvZihXbG9nX0Vycm9yX1N0cmluZyksCiAJCQkiQ291
bGQgbm90IG9wZW4gd3JpdGVfbG9nIC0gb3BlbiglcywgJSNvLCAlI28pIGZhaWxlZDogICVzXG4i
LAogCQkJd2ZpbGUtPndfZmlsZSwgb2ZsYWdzLCBtb2RlLCBzdHJlcnJvcihlcnJubykpOwogCQly
ZXR1cm4gLTE7CkBAIC0xNDEsNyArMTQxLDcgQEAgaW50IHdsb2dfb3BlbihzdHJ1Y3Qgd2xvZ19m
aWxlICp3ZmlsZSwgaW50IHRydW5jLCBpbnQgbW9kZSkKIAogCW9mbGFncyA9IE9fUkRXUjsKIAlp
ZiAoKHdmaWxlLT53X3JmZCA9IG9wZW4od2ZpbGUtPndfZmlsZSwgb2ZsYWdzKSkgPT0gLTEpIHsK
LQkJc3ByaW50ZihXbG9nX0Vycm9yX1N0cmluZywKKwkJc25wcmludGYoV2xvZ19FcnJvcl9TdHJp
bmcsIHNpemVvZihXbG9nX0Vycm9yX1N0cmluZyksCiAJCQkiQ291bGQgbm90IG9wZW4gd3JpdGUg
bG9nIC0gb3BlbiglcywgJSNvKSBmYWlsZWQ6ICAlc1xuIiwKIAkJCXdmaWxlLT53X2ZpbGUsIG9m
bGFncywgc3RyZXJyb3IoZXJybm8pKTsKIAkJY2xvc2Uod2ZpbGUtPndfYWZkKTsKQEAgLTIxOCwx
NCArMjE4LDE0IEBAIGludCB3bG9nX3JlY29yZF93cml0ZShzdHJ1Y3Qgd2xvZ19maWxlICp3Zmls
ZSwgc3RydWN0IHdsb2dfcmVjICp3cmVjLAogCQlyZWNsZW4gKz0gMjsKIAogCQlpZiAod3JpdGUo
d2ZpbGUtPndfYWZkLCB3YnVmLCByZWNsZW4pID09IC0xKSB7Ci0JCQlzcHJpbnRmKFdsb2dfRXJy
b3JfU3RyaW5nLAorCQkJc25wcmludGYoV2xvZ19FcnJvcl9TdHJpbmcsIHNpemVvZihXbG9nX0Vy
cm9yX1N0cmluZyksCiAJCQkJIkNvdWxkIG5vdCB3cml0ZSBsb2cgLSB3cml0ZSglcywgJXMsICVk
KSBmYWlsZWQ6ICAlc1xuIiwKIAkJCQl3ZmlsZS0+d19maWxlLCB3YnVmLCByZWNsZW4sIHN0cmVy
cm9yKGVycm5vKSk7CiAJCQlyZXR1cm4gLTE7CiAJCX0gZWxzZSB7CiAJCQlvZmZzZXQgPSBsc2Vl
ayh3ZmlsZS0+d19hZmQsIDAsIFNFRUtfQ1VSKSAtIHJlY2xlbjsKIAkJCWlmIChvZmZzZXQgPT0g
LTEpIHsKLQkJCQlzcHJpbnRmKFdsb2dfRXJyb3JfU3RyaW5nLAorCQkJCXNucHJpbnRmKFdsb2df
RXJyb3JfU3RyaW5nLCBzaXplb2YoV2xvZ19FcnJvcl9TdHJpbmcpLAogCQkJCQkiQ291bGQgbm90
IHJlcG9zaXRpb24gZmlsZSBwb2ludGVyIC0gbHNlZWsoJXMsIDAsIFNFRUtfQ1VSKSBmYWlsZWQ6
ICAlc1xuIiwKIAkJCQkJd2ZpbGUtPndfZmlsZSwgc3RyZXJyb3IoZXJybm8pKTsKIAkJCQlyZXR1
cm4gLTE7CkBAIC0yMzMsMTMgKzIzMywxMyBAQCBpbnQgd2xvZ19yZWNvcmRfd3JpdGUoc3RydWN0
IHdsb2dfZmlsZSAqd2ZpbGUsIHN0cnVjdCB3bG9nX3JlYyAqd3JlYywKIAkJfQogCX0gZWxzZSB7
CiAJCWlmICgobHNlZWsod2ZpbGUtPndfcmZkLCBvZmZzZXQsIFNFRUtfU0VUKSkgPT0gLTEpIHsK
LQkJCXNwcmludGYoV2xvZ19FcnJvcl9TdHJpbmcsCisJCQlzbnByaW50ZihXbG9nX0Vycm9yX1N0
cmluZywgc2l6ZW9mKFdsb2dfRXJyb3JfU3RyaW5nKSwKIAkJCQkiQ291bGQgbm90IHJlcG9zaXRp
b24gZmlsZSBwb2ludGVyIC0gbHNlZWsoJXMsICVsZCwgU0VFS19TRVQpIGZhaWxlZDogICVzXG4i
LAogCQkJCXdmaWxlLT53X2ZpbGUsIG9mZnNldCwgc3RyZXJyb3IoZXJybm8pKTsKIAkJCXJldHVy
biAtMTsKIAkJfSBlbHNlIHsKIAkJCWlmICgod3JpdGUod2ZpbGUtPndfcmZkLCB3YnVmLCByZWNs
ZW4pKSA9PSAtMSkgewotCQkJCXNwcmludGYoV2xvZ19FcnJvcl9TdHJpbmcsCisJCQkJc25wcmlu
dGYoV2xvZ19FcnJvcl9TdHJpbmcsIHNpemVvZihXbG9nX0Vycm9yX1N0cmluZyksCiAJCQkJCSJD
b3VsZCBub3Qgd3JpdGUgbG9nIC0gd3JpdGUoJXMsICVzLCAlZCkgZmFpbGVkOiAgJXNcbiIsCiAJ
CQkJCXdmaWxlLT53X2ZpbGUsIHdidWYsIHJlY2xlbiwKIAkJCQkJc3RyZXJyb3IoZXJybm8pKTsK
QEAgLTI3NCwxNCArMjc0LDE0IEBAIGludCB3bG9nX3NjYW5fYmFja3dhcmQoc3RydWN0IHdsb2df
ZmlsZSAqd2ZpbGUsIGludCBucmVjcywKIAkgKi8KIAogCWlmICgobHNlZWsoZmQsIDAsIFNFRUtf
RU5EKSkgPT0gLTEpIHsKLQkJc3ByaW50ZihXbG9nX0Vycm9yX1N0cmluZywKKwkJc25wcmludGYo
V2xvZ19FcnJvcl9TdHJpbmcsIHNpemVvZihXbG9nX0Vycm9yX1N0cmluZyksCiAJCQkiQ291bGQg
bm90IHJlcG9zaXRpb24gZmlsZSBwb2ludGVyIC0gbHNlZWsoJXMsIDAsIFNFRUtfRU5EKSBmYWls
ZWQ6ICAlc1xuIiwKIAkJCXdmaWxlLT53X2ZpbGUsIHN0cmVycm9yKGVycm5vKSk7CiAJCXJldHVy
biAtMTsKIAl9CiAJb2Zmc2V0ID0gbHNlZWsoZmQsIDAsIFNFRUtfQ1VSKTsKIAlpZiAoKG9mZnNl
dCA9PSAtMSkpIHsKLQkJc3ByaW50ZihXbG9nX0Vycm9yX1N0cmluZywKKwkJc25wcmludGYoV2xv
Z19FcnJvcl9TdHJpbmcsIHNpemVvZihXbG9nX0Vycm9yX1N0cmluZyksCiAJCQkiQ291bGQgbm90
IHJlcG9zaXRpb24gZmlsZSBwb2ludGVyIC0gbHNlZWsoJXMsIDAsIFNFRUtfQ1VSKSBmYWlsZWQ6
ICAlc1xuIiwKIAkJCXdmaWxlLT53X2ZpbGUsIHN0cmVycm9yKGVycm5vKSk7CiAJCXJldHVybiAt
MTsKQEAgLTMwOSw3ICszMDksNyBAQCBpbnQgd2xvZ19zY2FuX2JhY2t3YXJkKHN0cnVjdCB3bG9n
X2ZpbGUgKndmaWxlLCBpbnQgbnJlY3MsCiAJCSAqIE1vdmUgdG8gdGhlIHByb3BlciBmaWxlIG9m
ZnNldCwgYW5kIHJlYWQgaW50byBidWYKIAkJICovCiAJCWlmICgobHNlZWsoZmQsIG9mZnNldCwg
U0VFS19TRVQpKSA9PSAtMSkgewotCQkJc3ByaW50ZihXbG9nX0Vycm9yX1N0cmluZywKKwkJCXNu
cHJpbnRmKFdsb2dfRXJyb3JfU3RyaW5nLCBzaXplb2YoV2xvZ19FcnJvcl9TdHJpbmcpLAogCQkJ
CSJDb3VsZCBub3QgcmVwb3NpdGlvbiBmaWxlIHBvaW50ZXIgLSBsc2VlayglcywgJWQsIFNFRUtf
U0VUKSBmYWlsZWQ6ICAlc1xuIiwKIAkJCQl3ZmlsZS0+d19maWxlLCBvZmZzZXQsIHN0cmVycm9y
KGVycm5vKSk7CiAJCQlyZXR1cm4gLTE7CkBAIC0zMTgsNyArMzE4LDcgQEAgaW50IHdsb2dfc2Nh
bl9iYWNrd2FyZChzdHJ1Y3Qgd2xvZ19maWxlICp3ZmlsZSwgaW50IG5yZWNzLAogCQluYnl0ZXMg
PSByZWFkKGZkLCBidWZzdGFydCwgYnVmZW5kIC0gYnVmc3RhcnQgLSBsZWZ0b3Zlcik7CiAKIAkJ
aWYgKG5ieXRlcyA9PSAtMSkgewotCQkJc3ByaW50ZihXbG9nX0Vycm9yX1N0cmluZywKKwkJCXNu
cHJpbnRmKFdsb2dfRXJyb3JfU3RyaW5nLCBzaXplb2YoV2xvZ19FcnJvcl9TdHJpbmcpLAogCQkJ
CSJDb3VsZCBub3QgcmVhZCBoaXN0b3J5IGZpbGUgYXQgb2Zmc2V0ICVkIC0gcmVhZCglZCwgJXAs
ICVkKSBmYWlsZWQ6ICAlc1xuIiwKIAkJCQlvZmZzZXQsIGZkLCBidWZzdGFydCwKIAkJCQkoaW50
KShidWZlbmQgLSBidWZzdGFydCAtIGxlZnRvdmVyKSwKLS0gCjIuMzcuMgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
