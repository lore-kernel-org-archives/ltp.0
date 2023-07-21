Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D2EB64DC
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 09:16:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E91A13CB2E7
	for <ltp@archiver.kernel.org>; Fri, 21 Jul 2023 11:16:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 345293C94FC
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26CB4200C11
 for <ltp@lists.linux.it>; Fri, 21 Jul 2023 11:15:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E10861FD82;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689930922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3crdV2YH74zGOSBkhAPiJJHtib+JtbhpUY3tHJvzgs8=;
 b=ucC9DBCXzFH8dtAPNb8GfNm0ACnYhG6vXQr1ZBA8MZ5miz1ZUp+rrxbBmSxcM1g+lClwLT
 sfnwXGPWff2TK3JvnXUelfh8swBNKxNS1COjY6Yny5o3NcFugkPIpHt6sK4eIZlAjIXfeU
 Ygr+6XOjfT6BY4fp2ViVKGoyZ8F1DoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689930922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3crdV2YH74zGOSBkhAPiJJHtib+JtbhpUY3tHJvzgs8=;
 b=768MB/5ApcZuwuj2BdB/mPOyzOa6cJPH8ULLE4Ik0SIr8lNC0+KVuIT/NjBTlUjn+x4ORB
 OnBgEytEPliTPMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD36D134B0;
 Fri, 21 Jul 2023 09:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iDjRLKpMumRSawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jul 2023 09:15:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Jul 2023 11:15:13 +0200
Message-Id: <20230721091515.1353371-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721091515.1353371-1-pvorel@suse.cz>
References: <20230721091515.1353371-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] lib: Add .skip_in_secureboot flag
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

VGhpcyB3aWxsIGJlIHVzZWQgaW4gbW9kdWxlIHJlbGF0ZWQgdGVzdHMuCgpSZXZpZXdlZC1ieTog
TWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgpTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVs
IDxwdm9yZWxAc3VzZS5jej4KLS0tCiBkb2MvdGVzdC13cml0aW5nLWd1aWRlbGluZXMudHh0IHwg
MSArCiBpbmNsdWRlL3RzdF90ZXN0LmggICAgICAgICAgICAgIHwgNCArKysrCiBsaWIvdHN0X3Rl
c3QuYyAgICAgICAgICAgICAgICAgIHwgMyArKysKIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dCBiL2Rv
Yy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQKaW5kZXggYjgzYTZmZGI2Li42ZDFhNjkxNjUg
MTAwNjQ0Ci0tLSBhL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQKKysrIGIvZG9jL3Rl
c3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dApAQCAtMzkzLDYgKzM5Myw3IEBAIGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvU2hlbGwtVGVzdC1BUElbU2hlbGwg
VGVzdCBBUEldLgogfCAnLnNraXBfZmlsZXN5c3RlbXMnIHwgJ1RTVF9TS0lQX0ZJTEVTWVNURU1T
JwogfCAnLnNraXBfaW5fY29tcGF0JyB8IOKAkwogfCAnLnNraXBfaW5fbG9ja2Rvd24nIHwg4oCT
Cit8ICcuc2tpcF9pbl9zZWN1cmVib290JyB8IOKAkwogfCAnLnN1cHBvcnRlZF9hcmNocycgfCBu
b3QgYXBwbGljYWJsZQogfCAnLnRhZ3MnIHwg4oCTCiB8ICcudGFpbnRfY2hlY2snIHwg4oCTCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL3RzdF90ZXN0LmggYi9pbmNsdWRlL3RzdF90ZXN0LmgKaW5kZXgg
MjJhY2ZiYTU5Li4wYWM0OTJhODAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdHN0X3Rlc3QuaAorKysg
Yi9pbmNsdWRlL3RzdF90ZXN0LmgKQEAgLTE3Nyw2ICsxNzcsNyBAQCBzdHJ1Y3QgdHN0X3Rlc3Qg
ewogCWludCBjaGlsZF9uZWVkc19yZWluaXQ6MTsKIAlpbnQgbmVlZHNfZGV2ZnM6MTsKIAlpbnQg
cmVzdG9yZV93YWxsY2xvY2s6MTsKKwogCS8qCiAJICogSWYgc2V0IHRoZSB0ZXN0IGZ1bmN0aW9u
IHdpbGwgYmUgZXhlY3V0ZWQgZm9yIGFsbCBhdmFpbGFibGUKIAkgKiBmaWxlc3lzdGVtcyBhbmQg
dGhlIGN1cnJlbnQgZmlsZXN5c3RlbSB0eXBlIHdvdWxkIGJlIHNldCBpbiB0aGUKQEAgLTE4Niw4
ICsxODcsMTEgQEAgc3RydWN0IHRzdF90ZXN0IHsKIAkgKiB0byB0aGUgdGVzdCBmdW5jdGlvbi4K
IAkgKi8KIAlpbnQgYWxsX2ZpbGVzeXN0ZW1zOjE7CisKIAlpbnQgc2tpcF9pbl9sb2NrZG93bjox
OworCWludCBza2lwX2luX3NlY3VyZWJvb3Q6MTsKIAlpbnQgc2tpcF9pbl9jb21wYXQ6MTsKKwog
CS8qCiAJICogSWYgc2V0LCB0aGUgaHVnZXRsYmZzIHdpbGwgYmUgbW91bnRlZCBhdCAubW50cG9p
bnQuCiAJICovCmRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3QuYyBiL2xpYi90c3RfdGVzdC5jCmlu
ZGV4IDA0ZGE0NTZjNi4uOGY3MjIzYjBlIDEwMDY0NAotLS0gYS9saWIvdHN0X3Rlc3QuYworKysg
Yi9saWIvdHN0X3Rlc3QuYwpAQCAtMTE2MCw2ICsxMTYwLDkgQEAgc3RhdGljIHZvaWQgZG9fc2V0
dXAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlpZiAodHN0X3Rlc3QtPnNraXBfaW5fbG9ja2Rv
d24gJiYgdHN0X2xvY2tkb3duX2VuYWJsZWQoKSkKIAkJdHN0X2JyayhUQ09ORiwgIktlcm5lbCBp
cyBsb2NrZWQgZG93biwgc2tpcHBpbmcgdGVzdCIpOwogCisJaWYgKHRzdF90ZXN0LT5za2lwX2lu
X3NlY3VyZWJvb3QgJiYgdHN0X3NlY3VyZWJvb3RfZW5hYmxlZCgpKQorCQl0c3RfYnJrKFRDT05G
LCAiU2VjdXJlQm9vdCBlbmFibGVkLCBza2lwcGluZyB0ZXN0Iik7CisKIAlpZiAodHN0X3Rlc3Qt
PnNraXBfaW5fY29tcGF0ICYmIFRTVF9BQkkgIT0gdHN0X2tlcm5lbF9iaXRzKCkpCiAJCXRzdF9i
cmsoVENPTkYsICJOb3Qgc3VwcG9ydGVkIGluIDMyLWJpdCBjb21wYXQgbW9kZSIpOwogCi0tIAoy
LjQwLjEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
