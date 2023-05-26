Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E61C7EE23
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 13:35:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 811FE3CE796
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 15:35:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9D8A3CB059
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 618491400F4A
 for <ltp@lists.linux.it>; Fri, 26 May 2023 15:34:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D08F71FD8A;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685108076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhY22ELtIQONnJO9F3k6c+k7T8lQgis7JQCW+QWV3/8=;
 b=uCkWgTiiFwF0ZM/3s0ln8uvEZuxO1WFduRrJXkMg9nkQbR7DRvHhVMxMLs18mzAKRJqneb
 sGrSBO5P6CTQJtMQmSE76t2TcdJAyI3/N/aUHxLh88mu8sBsVIpHq6ejbs5csrqZw5Gt0B
 M9wEFxMgmcAvb1I3Zz6XWMtcK4A4piQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685108076;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhY22ELtIQONnJO9F3k6c+k7T8lQgis7JQCW+QWV3/8=;
 b=J1G0SC1APwYN/wXpOBkR1PgERlS3R+F2uYyTgDobMQsdUmXOCp5VV29ayen6ag8l7ltlLM
 Jh+2QoWR0wFP6uDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B62DA13A89;
 Fri, 26 May 2023 13:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KOS9K2y1cGTMZQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 26 May 2023 13:34:36 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 May 2023 15:34:33 +0200
Message-Id: <20230526133435.7369-6-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230526133435.7369-1-mdoucha@suse.cz>
References: <20230526133435.7369-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/7] KVM: Allow expected KVM_RUN errors in
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
Cc: Nicolai Stange <nstange@suse.de>
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
bWRvdWNoYUBzdXNlLmN6PgpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
ClJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KLS0tCgpDaGFuZ2Vz
IHNpbmNlIHYxOiBOb25lCgogZG9jL2t2bS10ZXN0LWFwaS50eHQgICAgICAgICAgICAgICAgICAg
IHwgIDkgKysrKysrLS0tCiB0ZXN0Y2FzZXMva2VybmVsL2t2bS9pbmNsdWRlL2t2bV9ob3N0Lmgg
fCAgNiArKysrLS0KIHRlc3RjYXNlcy9rZXJuZWwva3ZtL2xpYl9ob3N0LmMgICAgICAgICB8IDIy
ICsrKysrKysrKysrKysrKysrKystLS0KIDMgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kb2Mva3ZtLXRlc3QtYXBpLnR4dCBiL2Rv
Yy9rdm0tdGVzdC1hcGkudHh0CmluZGV4IDgxMmUxMmIzOC4uN2U1MzdhZmNiIDEwMDY0NAotLS0g
YS9kb2Mva3ZtLXRlc3QtYXBpLnR4dAorKysgYi9kb2Mva3ZtLXRlc3QtYXBpLnR4dApAQCAtMTk0
LDkgKzE5NCwxMiBAQCBwcmV2aW91c2x5IGFsbG9jYXRlZCBndWFyZGVkIGJ1ZmZlcnMuCiAgIHdp
dGggYXQgbGVhc3QgYHJhbV9zaXplYCBieXRlcyBvZiBtZW1vcnkuIFRoZSBWTSBpbnN0YW5jZSBp
bmZvIHdpbGwgYmUKICAgc3RvcmVkIGluIGBpbnN0YC4KIAotLSBgdm9pZCB0c3Rfa3ZtX3J1bl9p
bnN0YW5jZShzdHJ1Y3QgdHN0X2t2bV9pbnN0YW5jZSAqaW5zdClgIOKAkyBFeGVjdXRlcwotICB0
aGUgcHJvZ3JhbSBpbnN0YWxsZWQgaW4gS1ZNIHZpcnR1YWwgbWFjaGluZSBgaW5zdGAuIEFueSBy
ZXN1bHQgbWVzc2FnZXMKLSAgcmV0dXJuZWQgYnkgdGhlIFZNIHdpbGwgYmUgYXV0b21hdGljYWxs
eSBwcmludGVkIHRvIGNvbnRyb2xsZXIgcHJvZ3JhbSBvdXRwdXQuCistIGBpbnQgdHN0X2t2bV9y
dW5faW5zdGFuY2Uoc3RydWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QsIGludCBleHBfZXJybm8p
YCDigJMKKyAgRXhlY3V0ZXMgdGhlIHByb2dyYW0gaW5zdGFsbGVkIGluIEtWTSB2aXJ0dWFsIG1h
Y2hpbmUgYGluc3RgLiBBbnkgcmVzdWx0CisgIG1lc3NhZ2VzIHJldHVybmVkIGJ5IHRoZSBWTSB3
aWxsIGJlIGF1dG9tYXRpY2FsbHkgcHJpbnRlZCB0byBjb250cm9sbGVyCisgIHByb2dyYW0gb3V0
cHV0LiBSZXR1cm5zIHplcm8uIElmIGBleHBfZXJybm9gIGlzIG5vbi16ZXJvLCB0aGUgVk0gZXhl
Y3V0aW9uCisgIHN5c2NhbGwgaXMgYWxsb3dlZCB0byBmYWlsIHdpdGggdGhlIGBleHBfZXJybm9g
IGVycm9yIGNvZGUgYW5kCisgIGB0c3Rfa3ZtX3J1bl9pbnN0YW5jZSgpYCB3aWxsIHJldHVybiAt
MSBpbnN0ZWFkIG9mIHRlcm1pbmF0aW5nIHRoZSB0ZXN0LgogCiAtIGB2b2lkIHRzdF9rdm1fZGVz
dHJveV9pbnN0YW5jZShzdHJ1Y3QgdHN0X2t2bV9pbnN0YW5jZSAqaW5zdClgIOKAkyBEZWxldGVz
CiAgIHRoZSBLVk0gdmlydHVhbCBtYWNoaW5lIGBpbnN0YC4gTm90ZSB0aGF0IHRoZSBndWFyZGVk
IGJ1ZmZlcnMgYXNzaWduZWQKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2luY2x1
ZGUva3ZtX2hvc3QuaCBiL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2luY2x1ZGUva3ZtX2hvc3QuaApp
bmRleCAzOTQ5ZGQwNDAuLjA2YmNiNWQ0NSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9r
dm0vaW5jbHVkZS9rdm1faG9zdC5oCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2luY2x1ZGUv
a3ZtX2hvc3QuaApAQCAtMTI1LDkgKzEyNSwxMSBAQCBzdHJ1Y3Qga3ZtX2NwdWlkMiAqdHN0X2t2
bV9nZXRfY3B1aWQoaW50IHN5c2ZkKTsKIHZvaWQgdHN0X2t2bV9jcmVhdGVfaW5zdGFuY2Uoc3Ry
dWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QsIHNpemVfdCByYW1fc2l6ZSk7CiAKIC8qCi0gKiBF
eGVjdXRlIHRoZSBnaXZlbiBLVk0gaW5zdGFuY2UgYW5kIHByaW50IHJlc3VsdHMuCisgKiBFeGVj
dXRlIHRoZSBnaXZlbiBLVk0gaW5zdGFuY2UgYW5kIHByaW50IHJlc3VsdHMuIElmIGlvY3RsKEtW
TV9SVU4pIGlzCisgKiBleHBlY3RlZCB0byBmYWlsLCBwYXNzIHRoZSBleHBlY3RlZCBlcnJvciBj
b2RlIGluIGV4cF9lcnJubywgb3RoZXJ3aXNlCisgKiBzZXQgaXQgdG8gemVyby4gUmV0dXJucyBs
YXN0IHZhbHVlIHJldHVybmVkIGJ5IGlvY3RsKEtWTV9SVU4pLgogICovCi12b2lkIHRzdF9rdm1f
cnVuX2luc3RhbmNlKHN0cnVjdCB0c3Rfa3ZtX2luc3RhbmNlICppbnN0KTsKK2ludCB0c3Rfa3Zt
X3J1bl9pbnN0YW5jZShzdHJ1Y3QgdHN0X2t2bV9pbnN0YW5jZSAqaW5zdCwgaW50IGV4cF9lcnJu
byk7CiAKIC8qCiAgKiBDbG9zZSB0aGUgZ2l2ZW4gS1ZNIGluc3RhbmNlLgpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9rdm0vbGliX2hvc3QuYyBiL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2xp
Yl9ob3N0LmMKaW5kZXggMmY1MjRlM2NlLi44ZTNkNjA5NGUgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwva3ZtL2xpYl9ob3N0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9rdm0vbGliX2hv
c3QuYwpAQCAtMjM2LDE0ICsyMzYsMjggQEAgdm9pZCB0c3Rfa3ZtX2NyZWF0ZV9pbnN0YW5jZShz
dHJ1Y3QgdHN0X2t2bV9pbnN0YW5jZSAqaW5zdCwgc2l6ZV90IHJhbV9zaXplKQogCWluc3QtPnJl
c3VsdC0+bWVzc2FnZVswXSA9ICdcMCc7CiB9CiAKLXZvaWQgdHN0X2t2bV9ydW5faW5zdGFuY2Uo
c3RydWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QpCitpbnQgdHN0X2t2bV9ydW5faW5zdGFuY2Uo
c3RydWN0IHRzdF9rdm1faW5zdGFuY2UgKmluc3QsIGludCBleHBfZXJybm8pCiB7CiAJc3RydWN0
IGt2bV9yZWdzIHJlZ3M7CisJaW50IHJldDsKIAogCXdoaWxlICgxKSB7CiAJCWluc3QtPnJlc3Vs
dC0+cmVzdWx0ID0gS1ZNX1ROT05FOwogCQlpbnN0LT5yZXN1bHQtPm1lc3NhZ2VbMF0gPSAnXDAn
OwotCQlTQUZFX0lPQ1RMKGluc3QtPnZjcHVfZmQsIEtWTV9SVU4sIDApOworCQllcnJubyA9IDA7
CisJCXJldCA9IGlvY3RsKGluc3QtPnZjcHVfZmQsIEtWTV9SVU4sIDApOworCisJCWlmIChyZXQg
PT0gLTEpIHsKKwkJCWlmIChlcnJubyA9PSBleHBfZXJybm8pCisJCQkJcmV0dXJuIHJldDsKKwor
CQkJdHN0X2JyayhUQlJPSyB8IFRFUlJOTywgImlvY3RsKEtWTV9SVU4pIGZhaWxlZCIpOworCQl9
CisKKwkJaWYgKHJldCA8IDApIHsKKwkJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sCisJCQkJIklu
dmFsaWQgaW9jdGwoS1ZNX1JVTikgcmV0dXJuIHZhbHVlICVkIiwgcmV0KTsKKwkJfQogCiAJCWlm
IChpbnN0LT52Y3B1X2luZm8tPmV4aXRfcmVhc29uICE9IEtWTV9FWElUX0hMVCkgewogCQkJU0FG
RV9JT0NUTChpbnN0LT52Y3B1X2ZkLCBLVk1fR0VUX1JFR1MsICZyZWdzKTsKQEAgLTI1Nyw2ICsy
NzEsOCBAQCB2b2lkIHRzdF9rdm1fcnVuX2luc3RhbmNlKHN0cnVjdCB0c3Rfa3ZtX2luc3RhbmNl
ICppbnN0KQogCiAJCXRzdF9rdm1fcHJpbnRfcmVzdWx0KGluc3QpOwogCX0KKworCXJldHVybiBy
ZXQ7CiB9CiAKIHZvaWQgdHN0X2t2bV9kZXN0cm95X2luc3RhbmNlKHN0cnVjdCB0c3Rfa3ZtX2lu
c3RhbmNlICppbnN0KQpAQCAtMzEzLDcgKzMyOSw3IEBAIHZvaWQgdHN0X2t2bV9zZXR1cCh2b2lk
KQogdm9pZCB0c3Rfa3ZtX3J1bih2b2lkKQogewogCXRzdF9rdm1fY3JlYXRlX2luc3RhbmNlKCZ0
ZXN0X3ZtLCBERUZBVUxUX1JBTV9TSVpFKTsKLQl0c3Rfa3ZtX3J1bl9pbnN0YW5jZSgmdGVzdF92
bSk7CisJdHN0X2t2bV9ydW5faW5zdGFuY2UoJnRlc3Rfdm0sIDApOwogCXRzdF9rdm1fZGVzdHJv
eV9pbnN0YW5jZSgmdGVzdF92bSk7CiAJdHN0X2ZyZWVfYWxsKCk7CiB9Ci0tIAoyLjQwLjAKCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
