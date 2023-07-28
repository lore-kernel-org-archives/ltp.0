Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9074C001DF
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 13:21:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D1F3CE668
	for <ltp@archiver.kernel.org>; Fri, 28 Jul 2023 15:21:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87F223CD696
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 946EF1400E56
 for <ltp@lists.linux.it>; Fri, 28 Jul 2023 15:21:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09F391F8AC;
 Fri, 28 Jul 2023 13:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690550484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZ+r6DQ3rXgfxpBm5H3IVJ6nyeJKP/6IkkLMxc66EH8=;
 b=TV4yh58PBimX9xt/w1TOA008xYpY2cXrNPb+o4+z+pJEG3yYSbywTvaFWbweF0bU/GgILm
 oNMQTn5uKHZjWtfvFoMQQ+ImdOsaBFz3l2iHnAJdKi09X/AIH/96i4lVVWkPUTz5rK8dMh
 TScNJ52cdvk8m0rzlJSMaht7eIZIjm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690550484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZ+r6DQ3rXgfxpBm5H3IVJ6nyeJKP/6IkkLMxc66EH8=;
 b=pEhkLqY80FheFkWWrjrApMxVJzsv9L3eZU8Bp63EvHAL2sXNEZbk44uJfQD4RKg059JENt
 4t+SrNGKvlt1yCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6F81133F7;
 Fri, 28 Jul 2023 13:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cA2gMtPAw2RKBgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Jul 2023 13:21:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 28 Jul 2023 15:21:15 +0200
Message-ID: <20230728132120.17322-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728132120.17322-1-pvorel@suse.cz>
References: <20230728132120.17322-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] lib: shell: Add TST_SKIP_IN_SECUREBOOT=1
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

QW5kIHRzdF9zZWN1cmVib290X2VuYWJsZWQuYyBoZWxwZXIuCkRldGVjdGlvbiBpcyBuZWVkZWQg
Zm9yIGluc21vZDAxLnNoLgoKU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+Ci0tLQogZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dCAgICAgICAgfCAgMiArLQog
dGVzdGNhc2VzL2xpYi8uZ2l0aWdub3JlICAgICAgICAgICAgICAgfCAgMSArCiB0ZXN0Y2FzZXMv
bGliL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAyICstCiB0ZXN0Y2FzZXMvbGliL3RzdF9z
ZWN1cmVib290X2VuYWJsZWQuYyB8IDEyICsrKysrKysrKysrKwogdGVzdGNhc2VzL2xpYi90c3Rf
dGVzdC5zaCAgICAgICAgICAgICAgfCAgNiArKysrKy0KIDUgZmlsZXMgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMv
bGliL3RzdF9zZWN1cmVib290X2VuYWJsZWQuYwoKZGlmZiAtLWdpdCBhL2RvYy90ZXN0LXdyaXRp
bmctZ3VpZGVsaW5lcy50eHQgYi9kb2MvdGVzdC13cml0aW5nLWd1aWRlbGluZXMudHh0CmluZGV4
IDM2N2ZhNzgwYi4uNGVlOTE5OWFiIDEwMDY0NAotLS0gYS9kb2MvdGVzdC13cml0aW5nLWd1aWRl
bGluZXMudHh0CisrKyBiL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQKQEAgLTM5Myw3
ICszOTMsNyBAQCBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtp
L1NoZWxsLVRlc3QtQVBJW1NoZWxsIFRlc3QgQVBJXS4KIHwgJy5za2lwX2ZpbGVzeXN0ZW1zJyB8
ICdUU1RfU0tJUF9GSUxFU1lTVEVNUycKIHwgJy5za2lwX2luX2NvbXBhdCcgfCDigJMKIHwgJy5z
a2lwX2luX2xvY2tkb3duJyB8ICdUU1RfU0tJUF9JTl9MT0NLRE9XTicKLXwgJy5za2lwX2luX3Nl
Y3VyZWJvb3QnIHwg4oCTCit8ICcuc2tpcF9pbl9zZWN1cmVib290JyB8ICdUU1RfU0tJUF9JTl9T
RUNVUkVCT09UJwogfCAnLnN1cHBvcnRlZF9hcmNocycgfCBub3QgYXBwbGljYWJsZQogfCAnLnRh
Z3MnIHwg4oCTCiB8ICcudGFpbnRfY2hlY2snIHwg4oCTCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
bGliLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMvbGliLy5naXRpZ25vcmUKaW5kZXggYjgyNDc2N2Y3
Li5lOGFmZDA2ZjMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9saWIvLmdpdGlnbm9yZQorKysgYi90
ZXN0Y2FzZXMvbGliLy5naXRpZ25vcmUKQEAgLTE5LDYgKzE5LDcgQEAKIC90c3RfbnNfaWZtb3Zl
CiAvdHN0X3JhbmRvbQogL3RzdF9yb2QKKy90c3Rfc2VjdXJlYm9vdF9lbmFibGVkCiAvdHN0X3Ns
ZWVwCiAvdHN0X3N1cHBvcnRlZF9mcwogL3RzdF90aW1lb3V0X2tpbGwKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9saWIvTWFrZWZpbGUgYi90ZXN0Y2FzZXMvbGliL01ha2VmaWxlCmluZGV4IDMwOTRh
YTQ2My4uOTkwYjQ2MDg5IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMvbGliL01ha2VmaWxlCisrKyBi
L3Rlc3RjYXNlcy9saWIvTWFrZWZpbGUKQEAgLTEzLDYgKzEzLDYgQEAgTUFLRV9UQVJHRVRTCQk6
PSB0c3Rfc2xlZXAgdHN0X3JhbmRvbSB0c3RfY2hlY2twb2ludCB0c3Rfcm9kIHRzdF9rdmNtcFwK
IAkJCSAgIHRzdF9nZXRjb25mIHRzdF9zdXBwb3J0ZWRfZnMgdHN0X2NoZWNrX2RyaXZlcnMgdHN0
X2dldF91bnVzZWRfcG9ydFwKIAkJCSAgIHRzdF9nZXRfbWVkaWFuIHRzdF9oZXhkdW1wIHRzdF9n
ZXRfZnJlZV9waWRzIHRzdF90aW1lb3V0X2tpbGxcCiAJCQkgICB0c3RfY2hlY2tfa2NvbmZpZ3Mg
dHN0X2NnY3RsIHRzdF9mc2ZyZWV6ZSB0c3RfbnNfY3JlYXRlIHRzdF9uc19leGVjXAotCQkJICAg
dHN0X25zX2lmbW92ZSB0c3RfbG9ja2Rvd25fZW5hYmxlZAorCQkJICAgdHN0X25zX2lmbW92ZSB0
c3RfbG9ja2Rvd25fZW5hYmxlZCB0c3Rfc2VjdXJlYm9vdF9lbmFibGVkCiAKIGluY2x1ZGUgJCh0
b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9saWIvdHN0X3NlY3VyZWJvb3RfZW5hYmxlZC5jIGIvdGVzdGNhc2VzL2xpYi90
c3Rfc2VjdXJlYm9vdF9lbmFibGVkLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwLi43YzI2ZmIxMTgKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMvbGliL3RzdF9zZWN1
cmVib290X2VuYWJsZWQuYwpAQCAtMCwwICsxLDEyIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorLyoKKyAqIENvcHlyaWdodCAoYykgMjAyMyBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KKyAqLworCisjZGVmaW5lIFRTVF9OT19ERUZBVUxUX01BSU4K
KyNpbmNsdWRlICJ0c3RfdGVzdC5oIgorCitpbnQgbWFpbih2b2lkKQoreworCXJldHVybiAhdHN0
X3NlY3VyZWJvb3RfZW5hYmxlZCgpOworfQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi90c3Rf
dGVzdC5zaCBiL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2gKaW5kZXggYWZjZjY2YjIwLi5iNWIz
OGY1MjQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2gKKysrIGIvdGVzdGNh
c2VzL2xpYi90c3RfdGVzdC5zaApAQCAtNjc4LDcgKzY3OCw3IEBAIHRzdF9ydW4oKQogCQkJQ0hF
Q0tQT0lOVF9XQUlUfENIRUNLUE9JTlRfV0FLRSk7OwogCQkJQ0hFQ0tQT0lOVF9XQUtFMnxDSEVD
S1BPSU5UX1dBS0VfQU5EX1dBSVQpOzsKIAkJCURFVl9FWFRSQV9PUFRTfERFVl9GU19PUFRTfEZP
Uk1BVF9ERVZJQ0V8TU9VTlRfREVWSUNFKTs7Ci0JCQlTS0lQX0ZJTEVTWVNURU1TfFNLSVBfSU5f
TE9DS0RPV04pOzsKKwkJCVNLSVBfRklMRVNZU1RFTVN8U0tJUF9JTl9MT0NLRE9XTnxTS0lQX0lO
X1NFQ1VSRUJPT1QpOzsKIAkJCSopIHRzdF9yZXMgVFdBUk4gIlJlc2VydmVkIHZhcmlhYmxlIFRT
VF8kX3RzdF9pIHVzZWQhIjs7CiAJCQllc2FjCiAJCWRvbmUKQEAgLTY5OCw2ICs2OTgsMTAgQEAg
dHN0X3J1bigpCiAKIAlbICIkVFNUX05FRURTX1JPT1QiID0gMSBdICYmIHRzdF9yZXF1aXJlX3Jv
b3QKIAorCWlmIFsgIiRUU1RfU0tJUF9JTl9TRUNVUkVCT09UIiA9IDEgXSAmJiB0c3Rfc2VjdXJl
Ym9vdF9lbmFibGVkOyB0aGVuCisJCXRzdF9icmsgVENPTkYgIlNlY3VyZUJvb3QgZW5hYmxlZCwg
c2tpcHBpbmcgdGVzdCIKKwlmaQorCiAJaWYgWyAiJFRTVF9TS0lQX0lOX0xPQ0tET1dOIiA9IDEg
XSAmJiB0c3RfbG9ja2Rvd25fZW5hYmxlZDsgdGhlbgogCQl0c3RfYnJrIFRDT05GICJLZXJuZWwg
aXMgbG9ja2VkIGRvd24sIHNraXBwaW5nIHRlc3QiCiAJZmkKLS0gCjIuNDEuMAoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
