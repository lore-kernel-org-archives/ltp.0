Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46977C77B7A
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 15:37:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC62C3CDCEC
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 17:37:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69DBF3CD47D
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C9DA21A009B9
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:36:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6AEFF1FFB4;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684337803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osAGnfW0eHyI0iv6+DXV2DKxSfGb6mgCQyJQ0B+xQ0E=;
 b=CR0Bwe9JGNW5OU4VCzc1REpcslb4LjCh4ER8kWgzxzdFmHCWYTDiHuTwCshx5cSWeu/YMA
 nbY63jM/24CpFTx8147K/NYIdBkj7nqmFH4/02dE+sV2LHg1U8ypmI7m4QobmoHdk0I3PU
 6P4NK8e3liyzYB61c5IvjmnGF1Rr+tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684337803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osAGnfW0eHyI0iv6+DXV2DKxSfGb6mgCQyJQ0B+xQ0E=;
 b=tVcr5+euF+DHeX6X/VXLq1vPz3x113ciZBOwMWwLLQQhN2fha1Xy8dHTluTQocOfd5kX0G
 iqHRaRl2odH2ezDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54E7C13478;
 Wed, 17 May 2023 15:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UJ8LFIv0ZGSTCgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 17 May 2023 15:36:43 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Nicolai Stange <nstange@suse.de>,
	ltp@lists.linux.it
Date: Wed, 17 May 2023 17:36:40 +0200
Message-Id: <20230517153642.26919-6-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230517153642.26919-1-mdoucha@suse.cz>
References: <20230517153642.26919-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/7] KVM: Allow expected KVM_RUN errors in
 tst_kvm_run_instance()
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

QWRkIGEgbmV3IHBhcmFtZXRlciB0byB0c3Rfa3ZtX3J1bl9pbnN0YW5jZSgpIGZvciBleHBlY3Rl
ZCBlcnJubyB2YWx1ZSwKZS5nLiBFSU5UUiBmb3IgdGVzdGluZyB0aGUgcG9zc2libGl0eSB0byBr
aWxsIHJ1bm5pbmcgZ3Vlc3QuIFdoZW4KaW9jdGwoS1ZNX1JVTikgZmFpbHMgd2l0aCB0aGUgZXhw
ZWN0ZWQgZXJybm8sIHRzdF9rdm1fcnVuX2luc3RhbmNlKCkKd2lsbCByZXR1cm4gLTEgd2l0aG91
dCB0ZXJtaW5hdGluZyB0aGUgdGVzdC4KCkRlZmF1bHQgdHN0X2t2bV9ydW4oKSBmdW5jdGlvbiBl
eHBlY3RzIG5vIEtWTV9SVU4gZXJyb3JzLgoKU2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8
bWRvdWNoYUBzdXNlLmN6PgotLS0KIGRvYy9rdm0tdGVzdC1hcGkudHh0ICAgICAgICAgICAgICAg
ICAgICB8ICA5ICsrKysrKy0tLQogdGVzdGNhc2VzL2tlcm5lbC9rdm0vaW5jbHVkZS9rdm1faG9z
dC5oIHwgIDYgKysrKy0tCiB0ZXN0Y2FzZXMva2VybmVsL2t2bS9saWJfaG9zdC5jICAgICAgICAg
fCAyMiArKysrKysrKysrKysrKysrKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZG9jL2t2bS10ZXN0LWFwaS50eHQg
Yi9kb2Mva3ZtLXRlc3QtYXBpLnR4dAppbmRleCA4MTJlMTJiMzguLjdlNTM3YWZjYiAxMDA2NDQK
LS0tIGEvZG9jL2t2bS10ZXN0LWFwaS50eHQKKysrIGIvZG9jL2t2bS10ZXN0LWFwaS50eHQKQEAg
LTE5NCw5ICsxOTQsMTIgQEAgcHJldmlvdXNseSBhbGxvY2F0ZWQgZ3VhcmRlZCBidWZmZXJzLgog
ICB3aXRoIGF0IGxlYXN0IGByYW1fc2l6ZWAgYnl0ZXMgb2YgbWVtb3J5LiBUaGUgVk0gaW5zdGFu
Y2UgaW5mbyB3aWxsIGJlCiAgIHN0b3JlZCBpbiBgaW5zdGAuCiAKLS0gYHZvaWQgdHN0X2t2bV9y
dW5faW5zdGFuY2Uoc3RydWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QpYCDigJMgRXhlY3V0ZXMK
LSAgdGhlIHByb2dyYW0gaW5zdGFsbGVkIGluIEtWTSB2aXJ0dWFsIG1hY2hpbmUgYGluc3RgLiBB
bnkgcmVzdWx0IG1lc3NhZ2VzCi0gIHJldHVybmVkIGJ5IHRoZSBWTSB3aWxsIGJlIGF1dG9tYXRp
Y2FsbHkgcHJpbnRlZCB0byBjb250cm9sbGVyIHByb2dyYW0gb3V0cHV0LgorLSBgaW50IHRzdF9r
dm1fcnVuX2luc3RhbmNlKHN0cnVjdCB0c3Rfa3ZtX2luc3RhbmNlICppbnN0LCBpbnQgZXhwX2Vy
cm5vKWAg4oCTCisgIEV4ZWN1dGVzIHRoZSBwcm9ncmFtIGluc3RhbGxlZCBpbiBLVk0gdmlydHVh
bCBtYWNoaW5lIGBpbnN0YC4gQW55IHJlc3VsdAorICBtZXNzYWdlcyByZXR1cm5lZCBieSB0aGUg
Vk0gd2lsbCBiZSBhdXRvbWF0aWNhbGx5IHByaW50ZWQgdG8gY29udHJvbGxlcgorICBwcm9ncmFt
IG91dHB1dC4gUmV0dXJucyB6ZXJvLiBJZiBgZXhwX2Vycm5vYCBpcyBub24temVybywgdGhlIFZN
IGV4ZWN1dGlvbgorICBzeXNjYWxsIGlzIGFsbG93ZWQgdG8gZmFpbCB3aXRoIHRoZSBgZXhwX2Vy
cm5vYCBlcnJvciBjb2RlIGFuZAorICBgdHN0X2t2bV9ydW5faW5zdGFuY2UoKWAgd2lsbCByZXR1
cm4gLTEgaW5zdGVhZCBvZiB0ZXJtaW5hdGluZyB0aGUgdGVzdC4KIAogLSBgdm9pZCB0c3Rfa3Zt
X2Rlc3Ryb3lfaW5zdGFuY2Uoc3RydWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QpYCDigJMgRGVs
ZXRlcwogICB0aGUgS1ZNIHZpcnR1YWwgbWFjaGluZSBgaW5zdGAuIE5vdGUgdGhhdCB0aGUgZ3Vh
cmRlZCBidWZmZXJzIGFzc2lnbmVkCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2t2bS9p
bmNsdWRlL2t2bV9ob3N0LmggYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9pbmNsdWRlL2t2bV9ob3N0
LmgKaW5kZXggY2JiZGFkYzA2Li4zZTYwZDQ3MzggMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwva3ZtL2luY2x1ZGUva3ZtX2hvc3QuaAorKysgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9pbmNs
dWRlL2t2bV9ob3N0LmgKQEAgLTEyNSw5ICsxMjUsMTEgQEAgc3RydWN0IGt2bV9jcHVpZDIgKnRz
dF9rdm1fZ2V0X2NwdWlkKGludCBzeXNmZCk7CiB2b2lkIHRzdF9rdm1fY3JlYXRlX2luc3RhbmNl
KHN0cnVjdCB0c3Rfa3ZtX2luc3RhbmNlICppbnN0LCBzaXplX3QgcmFtX3NpemUpOwogCiAvKgot
ICogRXhlY3V0ZSB0aGUgZ2l2ZW4gS1ZNIGluc3RhbmNlIGFuZCBwcmludCByZXN1bHRzLgorICog
RXhlY3V0ZSB0aGUgZ2l2ZW4gS1ZNIGluc3RhbmNlIGFuZCBwcmludCByZXN1bHRzLiBJZiBpb2N0
bChLVk1fUlVOKSBpcworICogZXhwZWN0ZWQgdG8gZmFpbCwgcGFzcyB0aGUgZXhwZWN0ZWQgZXJy
b3IgY29kZSBpbiBleHBfZXJybm8sIG90aGVyd2lzZQorICogc2V0IGl0IHRvIHplcm8uIFJldHVy
bnMgbGFzdCB2YWx1ZSByZXR1cm5lZCBieSBpb2N0bChLVk1fUlVOKS4KICAqLwotdm9pZCB0c3Rf
a3ZtX3J1bl9pbnN0YW5jZShzdHJ1Y3QgdHN0X2t2bV9pbnN0YW5jZSAqaW5zdCk7CitpbnQgdHN0
X2t2bV9ydW5faW5zdGFuY2Uoc3RydWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QsIGludCBleHBf
ZXJybm8pOwogCiAvKgogICogQ2xvc2UgdGhlIGdpdmVuIEtWTSBpbnN0YW5jZS4KZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2xpYl9ob3N0LmMgYi90ZXN0Y2FzZXMva2VybmVsL2t2
bS9saWJfaG9zdC5jCmluZGV4IGE1ZjA1NDQ5Yy4uZTMzYTVmNWFhIDEwMDY0NAotLS0gYS90ZXN0
Y2FzZXMva2VybmVsL2t2bS9saWJfaG9zdC5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2xp
Yl9ob3N0LmMKQEAgLTIzNCwxNCArMjM0LDI4IEBAIHZvaWQgdHN0X2t2bV9jcmVhdGVfaW5zdGFu
Y2Uoc3RydWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QsIHNpemVfdCByYW1fc2l6ZSkKIAlpbnN0
LT5yZXN1bHQtPm1lc3NhZ2VbMF0gPSAnXDAnOwogfQogCi12b2lkIHRzdF9rdm1fcnVuX2luc3Rh
bmNlKHN0cnVjdCB0c3Rfa3ZtX2luc3RhbmNlICppbnN0KQoraW50IHRzdF9rdm1fcnVuX2luc3Rh
bmNlKHN0cnVjdCB0c3Rfa3ZtX2luc3RhbmNlICppbnN0LCBpbnQgZXhwX2Vycm5vKQogewogCXN0
cnVjdCBrdm1fcmVncyByZWdzOworCWludCByZXQ7CiAKIAl3aGlsZSAoMSkgewogCQlpbnN0LT5y
ZXN1bHQtPnJlc3VsdCA9IEtWTV9UTk9ORTsKIAkJaW5zdC0+cmVzdWx0LT5tZXNzYWdlWzBdID0g
J1wwJzsKLQkJU0FGRV9JT0NUTChpbnN0LT52Y3B1X2ZkLCBLVk1fUlVOLCAwKTsKKwkJZXJybm8g
PSAwOworCQlyZXQgPSBpb2N0bChpbnN0LT52Y3B1X2ZkLCBLVk1fUlVOLCAwKTsKKworCQlpZiAo
cmV0ID09IC0xKSB7CisJCQlpZiAoZXJybm8gPT0gZXhwX2Vycm5vKQorCQkJCXJldHVybiByZXQ7
CisKKwkJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sICJpb2N0bChLVk1fUlVOKSBmYWlsZWQiKTsK
KwkJfQorCisJCWlmIChyZXQgPCAwKSB7CisJCQl0c3RfYnJrKFRCUk9LIHwgVEVSUk5PLAorCQkJ
CSJJbnZhbGlkIGlvY3RsKEtWTV9SVU4pIHJldHVybiB2YWx1ZSAlZCIsIHJldCk7CisJCX0KIAog
CQlpZiAoaW5zdC0+dmNwdV9pbmZvLT5leGl0X3JlYXNvbiAhPSBLVk1fRVhJVF9ITFQpIHsKIAkJ
CVNBRkVfSU9DVEwoaW5zdC0+dmNwdV9mZCwgS1ZNX0dFVF9SRUdTLCAmcmVncyk7CkBAIC0yNTUs
NiArMjY5LDggQEAgdm9pZCB0c3Rfa3ZtX3J1bl9pbnN0YW5jZShzdHJ1Y3QgdHN0X2t2bV9pbnN0
YW5jZSAqaW5zdCkKIAogCQl0c3Rfa3ZtX3ByaW50X3Jlc3VsdChpbnN0KTsKIAl9CisKKwlyZXR1
cm4gcmV0OwogfQogCiB2b2lkIHRzdF9rdm1fZGVzdHJveV9pbnN0YW5jZShzdHJ1Y3QgdHN0X2t2
bV9pbnN0YW5jZSAqaW5zdCkKQEAgLTMwNCw3ICszMjAsNyBAQCB2b2lkIHRzdF9rdm1fc2V0dXAo
dm9pZCkKIHZvaWQgdHN0X2t2bV9ydW4odm9pZCkKIHsKIAl0c3Rfa3ZtX2NyZWF0ZV9pbnN0YW5j
ZSgmdGVzdF92bSwgREVGQVVMVF9SQU1fU0laRSk7Ci0JdHN0X2t2bV9ydW5faW5zdGFuY2UoJnRl
c3Rfdm0pOworCXRzdF9rdm1fcnVuX2luc3RhbmNlKCZ0ZXN0X3ZtLCAwKTsKIAl0c3Rfa3ZtX2Rl
c3Ryb3lfaW5zdGFuY2UoJnRlc3Rfdm0pOwogCXRzdF9mcmVlX2FsbCgpOwogfQotLSAKMi40MC4w
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
