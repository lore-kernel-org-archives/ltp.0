Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5297DC41513
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 13:22:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF7083CE662
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 15:22:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46C023CE657
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FD3A600731
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB022219C4;
 Fri, 28 Jul 2023 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690550483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi2iQGNf4NUfpRw1mamk5MnBJAUBqTjib7lwXuxytRs=;
 b=IuoqpBrB29CLnwYkZPV4YvhZ1VOgAexQaSiwQdv+6m5cMZdfmu53VeUWnQwYWte5K2MIJK
 HAjkX1/JQyOrrCRvCdJ3M/B20mcick+jRwNu1qwmINGCDAxUEdxVlCh6+qElHSQvR/rZ3s
 DY63bu2t6X/4BvExx0wnyf/+JU8wpMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690550483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pi2iQGNf4NUfpRw1mamk5MnBJAUBqTjib7lwXuxytRs=;
 b=qBNPAgUkonbWAMENKYWzZEEIbyiMl3H2TBwap4WYQBkNJNFw77Ks+8yib4We0h/4sxjs8o
 4c49qyECXjmW4/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91104133F7;
 Fri, 28 Jul 2023 13:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6JfIINPAw2RKBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jul 2023 13:21:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Jul 2023 15:21:14 +0200
Message-ID: <20230728132120.17322-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728132120.17322-1-pvorel@suse.cz>
References: <20230728132120.17322-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] lib: shell: Add TST_SKIP_IN_LOCKDOWN=1
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

QW5kIHRzdF9sb2NrZG93bl9lbmFibGVkLmMgaGVscGVyLgpEZXRlY3Rpb24gaXMgbmVlZGVkIGZv
ciBpbnNtb2QwMS5zaC4KClNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
PgotLS0KIGRvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQgICAgICB8ICAyICstCiB0ZXN0
Y2FzZXMvbGliLy5naXRpZ25vcmUgICAgICAgICAgICAgfCAgMSArCiB0ZXN0Y2FzZXMvbGliL01h
a2VmaWxlICAgICAgICAgICAgICAgfCAgMiArLQogdGVzdGNhc2VzL2xpYi90c3RfbG9ja2Rvd25f
ZW5hYmxlZC5jIHwgMTIgKysrKysrKysrKysrCiB0ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoICAg
ICAgICAgICAgfCAgNiArKysrKy0KIDUgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMvbGliL3RzdF9sb2Nr
ZG93bl9lbmFibGVkLmMKCmRpZmYgLS1naXQgYS9kb2MvdGVzdC13cml0aW5nLWd1aWRlbGluZXMu
dHh0IGIvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dAppbmRleCA2ZDFhNjkxNjUuLjM2
N2ZhNzgwYiAxMDA2NDQKLS0tIGEvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dAorKysg
Yi9kb2MvdGVzdC13cml0aW5nLWd1aWRlbGluZXMudHh0CkBAIC0zOTIsNyArMzkyLDcgQEAgaHR0
cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9TaGVsbC1UZXN0LUFQ
SVtTaGVsbCBUZXN0IEFQSV0uCiB8ICcuc2V0dXAnIHwgJ1RTVF9TRVRVUCcKIHwgJy5za2lwX2Zp
bGVzeXN0ZW1zJyB8ICdUU1RfU0tJUF9GSUxFU1lTVEVNUycKIHwgJy5za2lwX2luX2NvbXBhdCcg
fCDigJMKLXwgJy5za2lwX2luX2xvY2tkb3duJyB8IOKAkworfCAnLnNraXBfaW5fbG9ja2Rvd24n
IHwgJ1RTVF9TS0lQX0lOX0xPQ0tET1dOJwogfCAnLnNraXBfaW5fc2VjdXJlYm9vdCcgfCDigJMK
IHwgJy5zdXBwb3J0ZWRfYXJjaHMnIHwgbm90IGFwcGxpY2FibGUKIHwgJy50YWdzJyB8IOKAkwpk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2xpYi8uZ2l0
aWdub3JlCmluZGV4IGE4NTczOTIyZC4uYjgyNDc2N2Y3IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMv
bGliLy5naXRpZ25vcmUKKysrIGIvdGVzdGNhc2VzL2xpYi8uZ2l0aWdub3JlCkBAIC0xMCw2ICsx
MCw3IEBACiAvdHN0X2dldF91bnVzZWRfcG9ydAogL3RzdF9oZXhkdW1wCiAvdHN0X2t2Y21wCisv
dHN0X2xvY2tkb3duX2VuYWJsZWQKIC90c3RfbmV0X2lmYWNlX3ByZWZpeAogL3RzdF9uZXRfaXBf
cHJlZml4CiAvdHN0X25ldF92YXJzCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL01ha2VmaWxl
IGIvdGVzdGNhc2VzL2xpYi9NYWtlZmlsZQppbmRleCAxNDcyOGJmODkuLjMwOTRhYTQ2MyAxMDA2
NDQKLS0tIGEvdGVzdGNhc2VzL2xpYi9NYWtlZmlsZQorKysgYi90ZXN0Y2FzZXMvbGliL01ha2Vm
aWxlCkBAIC0xMyw2ICsxMyw2IEBAIE1BS0VfVEFSR0VUUwkJOj0gdHN0X3NsZWVwIHRzdF9yYW5k
b20gdHN0X2NoZWNrcG9pbnQgdHN0X3JvZCB0c3Rfa3ZjbXBcCiAJCQkgICB0c3RfZ2V0Y29uZiB0
c3Rfc3VwcG9ydGVkX2ZzIHRzdF9jaGVja19kcml2ZXJzIHRzdF9nZXRfdW51c2VkX3BvcnRcCiAJ
CQkgICB0c3RfZ2V0X21lZGlhbiB0c3RfaGV4ZHVtcCB0c3RfZ2V0X2ZyZWVfcGlkcyB0c3RfdGlt
ZW91dF9raWxsXAogCQkJICAgdHN0X2NoZWNrX2tjb25maWdzIHRzdF9jZ2N0bCB0c3RfZnNmcmVl
emUgdHN0X25zX2NyZWF0ZSB0c3RfbnNfZXhlY1wKLQkJCSAgIHRzdF9uc19pZm1vdmUKKwkJCSAg
IHRzdF9uc19pZm1vdmUgdHN0X2xvY2tkb3duX2VuYWJsZWQKIAogaW5jbHVkZSAkKHRvcF9zcmNk
aXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawpkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2xpYi90c3RfbG9ja2Rvd25fZW5hYmxlZC5jIGIvdGVzdGNhc2VzL2xpYi90c3RfbG9ja2Rv
d25fZW5hYmxlZC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMC4uMGU0MGM0
MjhjCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2xpYi90c3RfbG9ja2Rvd25fZW5hYmxl
ZC5jCkBAIC0wLDAgKzEsMTIgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
LW9yLWxhdGVyCisvKgorICogQ29weXJpZ2h0IChjKSAyMDIzIFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6PgorICovCisKKyNkZWZpbmUgVFNUX05PX0RFRkFVTFRfTUFJTgorI2luY2x1ZGUgInRz
dF90ZXN0LmgiCisKK2ludCBtYWluKHZvaWQpCit7CisJcmV0dXJuICF0c3RfbG9ja2Rvd25fZW5h
YmxlZCgpOworfQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5zaCBiL3Rlc3Rj
YXNlcy9saWIvdHN0X3Rlc3Quc2gKaW5kZXggNTUxMzM2NjZkLi5hZmNmNjZiMjAgMTAwNjQ0Ci0t
LSBhL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2gKKysrIGIvdGVzdGNhc2VzL2xpYi90c3RfdGVz
dC5zaApAQCAtNjc4LDcgKzY3OCw3IEBAIHRzdF9ydW4oKQogCQkJQ0hFQ0tQT0lOVF9XQUlUfENI
RUNLUE9JTlRfV0FLRSk7OwogCQkJQ0hFQ0tQT0lOVF9XQUtFMnxDSEVDS1BPSU5UX1dBS0VfQU5E
X1dBSVQpOzsKIAkJCURFVl9FWFRSQV9PUFRTfERFVl9GU19PUFRTfEZPUk1BVF9ERVZJQ0V8TU9V
TlRfREVWSUNFKTs7Ci0JCQlTS0lQX0ZJTEVTWVNURU1TKTs7CisJCQlTS0lQX0ZJTEVTWVNURU1T
fFNLSVBfSU5fTE9DS0RPV04pOzsKIAkJCSopIHRzdF9yZXMgVFdBUk4gIlJlc2VydmVkIHZhcmlh
YmxlIFRTVF8kX3RzdF9pIHVzZWQhIjs7CiAJCQllc2FjCiAJCWRvbmUKQEAgLTY5OCw2ICs2OTgs
MTAgQEAgdHN0X3J1bigpCiAKIAlbICIkVFNUX05FRURTX1JPT1QiID0gMSBdICYmIHRzdF9yZXF1
aXJlX3Jvb3QKIAorCWlmIFsgIiRUU1RfU0tJUF9JTl9MT0NLRE9XTiIgPSAxIF0gJiYgdHN0X2xv
Y2tkb3duX2VuYWJsZWQ7IHRoZW4KKwkJdHN0X2JyayBUQ09ORiAiS2VybmVsIGlzIGxvY2tlZCBk
b3duLCBza2lwcGluZyB0ZXN0IgorCWZpCisKIAlbICIkVFNUX0RJU0FCTEVfQVBQQVJNT1IiID0g
MSBdICYmIHRzdF9kaXNhYmxlX2FwcGFybW9yCiAJWyAiJFRTVF9ESVNBQkxFX1NFTElOVVgiID0g
MSBdICYmIHRzdF9kaXNhYmxlX3NlbGludXgKIAotLSAKMi40MS4wCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
