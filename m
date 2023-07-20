Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F565EB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6C703CBDEC
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:02:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F02A3CDC92
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 88B3E600BFF
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F51E22C83;
 Thu, 20 Jul 2023 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689865334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zu/syvDoB2RLTyTi1rJcHcaz6JsOwC5/RVKFqoF/09Q=;
 b=Cryv6So6qEVS7NKxrutPZdjnBJW4iiLla8xx8mduzVqBoii+IVzhEX4G5jHNUv8nBJFDmc
 0ycj80sVEHj1osthsoLK1nOg1C2WVnRS9fnzloG9xEXcFUiXGU8pEK7tbCZGQp7OUsl5Yx
 0BOYZRsh/3Wqi68q40gsPVNYbeLN8XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689865334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zu/syvDoB2RLTyTi1rJcHcaz6JsOwC5/RVKFqoF/09Q=;
 b=Eu3bEZEYLON7EWSMU+1ETHJ7gZX6jYKqI4AEuAzouEOOoW8WtY4gKv6DdGjzdQse+nRTAk
 P+OmBftDEswnm5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E89C8138EC;
 Thu, 20 Jul 2023 15:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IAErNnVMuWR6CQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jul 2023 15:02:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jul 2023 17:02:04 +0200
Message-Id: <20230720150206.1338520-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720150206.1338520-1-pvorel@suse.cz>
References: <20230720150206.1338520-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] lib: Add .skip_in_secureboot flag
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

VGhpcyB3aWxsIGJlIHVzZWQgaW4gbW9kdWxlIHJlbGF0ZWQgdGVzdHMuCgpTaWduZWQtb2ZmLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KLS0tCiBkb2MvdGVzdC13cml0aW5nLWd1aWRl
bGluZXMudHh0IHwgMSArCiBpbmNsdWRlL3RzdF90ZXN0LmggICAgICAgICAgICAgIHwgNCArKysr
CiBsaWIvdHN0X3Rlc3QuYyAgICAgICAgICAgICAgICAgIHwgMyArKysKIDMgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxp
bmVzLnR4dCBiL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQKaW5kZXggYjgzYTZmZGI2
Li42ZDFhNjkxNjUgMTAwNjQ0Ci0tLSBhL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQK
KysrIGIvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dApAQCAtMzkzLDYgKzM5Myw3IEBA
IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvU2hlbGwtVGVz
dC1BUElbU2hlbGwgVGVzdCBBUEldLgogfCAnLnNraXBfZmlsZXN5c3RlbXMnIHwgJ1RTVF9TS0lQ
X0ZJTEVTWVNURU1TJwogfCAnLnNraXBfaW5fY29tcGF0JyB8IOKAkwogfCAnLnNraXBfaW5fbG9j
a2Rvd24nIHwg4oCTCit8ICcuc2tpcF9pbl9zZWN1cmVib290JyB8IOKAkwogfCAnLnN1cHBvcnRl
ZF9hcmNocycgfCBub3QgYXBwbGljYWJsZQogfCAnLnRhZ3MnIHwg4oCTCiB8ICcudGFpbnRfY2hl
Y2snIHwg4oCTCmRpZmYgLS1naXQgYS9pbmNsdWRlL3RzdF90ZXN0LmggYi9pbmNsdWRlL3RzdF90
ZXN0LmgKaW5kZXggMjJhY2ZiYTU5Li4wYWM0OTJhODAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdHN0
X3Rlc3QuaAorKysgYi9pbmNsdWRlL3RzdF90ZXN0LmgKQEAgLTE3Nyw2ICsxNzcsNyBAQCBzdHJ1
Y3QgdHN0X3Rlc3QgewogCWludCBjaGlsZF9uZWVkc19yZWluaXQ6MTsKIAlpbnQgbmVlZHNfZGV2
ZnM6MTsKIAlpbnQgcmVzdG9yZV93YWxsY2xvY2s6MTsKKwogCS8qCiAJICogSWYgc2V0IHRoZSB0
ZXN0IGZ1bmN0aW9uIHdpbGwgYmUgZXhlY3V0ZWQgZm9yIGFsbCBhdmFpbGFibGUKIAkgKiBmaWxl
c3lzdGVtcyBhbmQgdGhlIGN1cnJlbnQgZmlsZXN5c3RlbSB0eXBlIHdvdWxkIGJlIHNldCBpbiB0
aGUKQEAgLTE4Niw4ICsxODcsMTEgQEAgc3RydWN0IHRzdF90ZXN0IHsKIAkgKiB0byB0aGUgdGVz
dCBmdW5jdGlvbi4KIAkgKi8KIAlpbnQgYWxsX2ZpbGVzeXN0ZW1zOjE7CisKIAlpbnQgc2tpcF9p
bl9sb2NrZG93bjoxOworCWludCBza2lwX2luX3NlY3VyZWJvb3Q6MTsKIAlpbnQgc2tpcF9pbl9j
b21wYXQ6MTsKKwogCS8qCiAJICogSWYgc2V0LCB0aGUgaHVnZXRsYmZzIHdpbGwgYmUgbW91bnRl
ZCBhdCAubW50cG9pbnQuCiAJICovCmRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3QuYyBiL2xpYi90
c3RfdGVzdC5jCmluZGV4IDA0ZGE0NTZjNi4uOGY3MjIzYjBlIDEwMDY0NAotLS0gYS9saWIvdHN0
X3Rlc3QuYworKysgYi9saWIvdHN0X3Rlc3QuYwpAQCAtMTE2MCw2ICsxMTYwLDkgQEAgc3RhdGlj
IHZvaWQgZG9fc2V0dXAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlpZiAodHN0X3Rlc3QtPnNr
aXBfaW5fbG9ja2Rvd24gJiYgdHN0X2xvY2tkb3duX2VuYWJsZWQoKSkKIAkJdHN0X2JyayhUQ09O
RiwgIktlcm5lbCBpcyBsb2NrZWQgZG93biwgc2tpcHBpbmcgdGVzdCIpOwogCisJaWYgKHRzdF90
ZXN0LT5za2lwX2luX3NlY3VyZWJvb3QgJiYgdHN0X3NlY3VyZWJvb3RfZW5hYmxlZCgpKQorCQl0
c3RfYnJrKFRDT05GLCAiU2VjdXJlQm9vdCBlbmFibGVkLCBza2lwcGluZyB0ZXN0Iik7CisKIAlp
ZiAodHN0X3Rlc3QtPnNraXBfaW5fY29tcGF0ICYmIFRTVF9BQkkgIT0gdHN0X2tlcm5lbF9iaXRz
KCkpCiAJCXRzdF9icmsoVENPTkYsICJOb3Qgc3VwcG9ydGVkIGluIDMyLWJpdCBjb21wYXQgbW9k
ZSIpOwogCi0tIAoyLjQwLjEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
