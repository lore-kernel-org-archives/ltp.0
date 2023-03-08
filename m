Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74507C64EC4
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 09:32:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334EA3CD945
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 10:32:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A0FC3C2A67
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 10:32:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 71EC9600269
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 10:32:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A164D21A02;
 Wed,  8 Mar 2023 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678267944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCoL7FBJ7yDwKZn0EZtzvTrj4P023PSY3FRtLmL0pXs=;
 b=TaZ3tGK+/2yJm+9TmEJxa4RhaqCSVhYbI0M69pqhI8SMxEJW1wWCeuFL4KXwKQUZZr2Z8W
 hvqTWu/V2VXcs529QIiin3j7gXZXRGEY85Ss/zx+F5W3DQuU+QJ/fWXnbiZ25EO68G5BCr
 EJbUMFPTajlG1VWUq3Ff88aU130I6ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678267944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCoL7FBJ7yDwKZn0EZtzvTrj4P023PSY3FRtLmL0pXs=;
 b=Vbif0pYhvSs1b9aTa9sWqM3Fp4ZZx0GwYVwY3hBEmVGnCuNMqt/jB7q+a/Bo9ptyvYpxbW
 FsUnSY3Q3vYGjGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63E1A1391B;
 Wed,  8 Mar 2023 09:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MNSBFShWCGTFPAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Mar 2023 09:32:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Mar 2023 10:32:18 +0100
Message-Id: <20230308093219.27090-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308093219.27090-1-pvorel@suse.cz>
References: <20230308093219.27090-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: shell: Add tst_lockdown_enabled.c
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

RGV0ZWN0aW9uIGlzIG5lZWRlZCBmb3IgaW5zbW9kMDEuc2guCgpTaWduZWQtb2ZmLWJ5OiBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KLS0tCiBkb2MvdGVzdC13cml0aW5nLWd1aWRlbGluZXMu
dHh0ICAgICAgfCAgMiArLQogdGVzdGNhc2VzL2xpYi8uZ2l0aWdub3JlICAgICAgICAgICAgIHwg
IDEgKwogdGVzdGNhc2VzL2xpYi9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgIDIgKy0KIHRlc3Rj
YXNlcy9saWIvdHN0X2xvY2tkb3duX2VuYWJsZWQuYyB8IDEyICsrKysrKysrKysrKwogdGVzdGNh
c2VzL2xpYi90c3RfdGVzdC5zaCAgICAgICAgICAgIHwgIDYgKysrKystCiA1IGZpbGVzIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdGNhc2VzL2xpYi90c3RfbG9ja2Rvd25fZW5hYmxlZC5jCgpkaWZmIC0tZ2l0IGEvZG9jL3Rl
c3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dCBiL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50
eHQKaW5kZXggYjgzYTZmZGI2Li44NzVjMjBlYWUgMTAwNjQ0Ci0tLSBhL2RvYy90ZXN0LXdyaXRp
bmctZ3VpZGVsaW5lcy50eHQKKysrIGIvZG9jL3Rlc3Qtd3JpdGluZy1ndWlkZWxpbmVzLnR4dApA
QCAtMzkyLDcgKzM5Miw3IEBAIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3Qv
bHRwL3dpa2kvU2hlbGwtVGVzdC1BUElbU2hlbGwgVGVzdCBBUEldLgogfCAnLnNldHVwJyB8ICdU
U1RfU0VUVVAnCiB8ICcuc2tpcF9maWxlc3lzdGVtcycgfCAnVFNUX1NLSVBfRklMRVNZU1RFTVMn
CiB8ICcuc2tpcF9pbl9jb21wYXQnIHwg4oCTCi18ICcuc2tpcF9pbl9sb2NrZG93bicgfCDigJMK
K3wgJy5za2lwX2luX2xvY2tkb3duJyB8ICdUU1RfU0tJUF9JTl9MT0NLRE9XTicKIHwgJy5zdXBw
b3J0ZWRfYXJjaHMnIHwgbm90IGFwcGxpY2FibGUKIHwgJy50YWdzJyB8IOKAkwogfCAnLnRhaW50
X2NoZWNrJyB8IOKAkwpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi8uZ2l0aWdub3JlIGIvdGVz
dGNhc2VzL2xpYi8uZ2l0aWdub3JlCmluZGV4IDM0ZGVhMjcyZC4uNjFjZjA1MjI2IDEwMDY0NAot
LS0gYS90ZXN0Y2FzZXMvbGliLy5naXRpZ25vcmUKKysrIGIvdGVzdGNhc2VzL2xpYi8uZ2l0aWdu
b3JlCkBAIC04LDYgKzgsNyBAQAogL3RzdF9nZXRfbWVkaWFuCiAvdHN0X2dldF91bnVzZWRfcG9y
dAogL3RzdF9rdmNtcAorL3RzdF9sb2NrZG93bl9lbmFibGVkCiAvdHN0X25ldF9pZmFjZV9wcmVm
aXgKIC90c3RfbmV0X2lwX3ByZWZpeAogL3RzdF9uZXRfdmFycwpkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2xpYi9NYWtlZmlsZSBiL3Rlc3RjYXNlcy9saWIvTWFrZWZpbGUKaW5kZXggZjRmOGM4NTI0
Li42ZmQ1OGIzYWIgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9saWIvTWFrZWZpbGUKKysrIGIvdGVz
dGNhc2VzL2xpYi9NYWtlZmlsZQpAQCAtMTIsNiArMTIsNiBAQCBNQUtFX1RBUkdFVFMJCTo9IHRz
dF9zbGVlcCB0c3RfcmFuZG9tIHRzdF9jaGVja3BvaW50IHRzdF9yb2QgdHN0X2t2Y21wXAogCQkJ
ICAgdHN0X2RldmljZSB0c3RfbmV0X2lmYWNlX3ByZWZpeCB0c3RfbmV0X2lwX3ByZWZpeCB0c3Rf
bmV0X3ZhcnNcCiAJCQkgICB0c3RfZ2V0Y29uZiB0c3Rfc3VwcG9ydGVkX2ZzIHRzdF9jaGVja19k
cml2ZXJzIHRzdF9nZXRfdW51c2VkX3BvcnRcCiAJCQkgICB0c3RfZ2V0X21lZGlhbiB0c3RfaGV4
ZHVtcCB0c3RfZ2V0X2ZyZWVfcGlkcyB0c3RfdGltZW91dF9raWxsXAotCQkJICAgdHN0X2NoZWNr
X2tjb25maWdzIHRzdF9jZ2N0bAorCQkJICAgdHN0X2NoZWNrX2tjb25maWdzIHRzdF9jZ2N0bCB0
c3RfbG9ja2Rvd25fZW5hYmxlZAogCiBpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9n
ZW5lcmljX2xlYWZfdGFyZ2V0Lm1rCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL3RzdF9sb2Nr
ZG93bl9lbmFibGVkLmMgYi90ZXN0Y2FzZXMvbGliL3RzdF9sb2NrZG93bl9lbmFibGVkLmMKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwLi4wZTQwYzQyOGMKLS0tIC9kZXYvbnVs
bAorKysgYi90ZXN0Y2FzZXMvbGliL3RzdF9sb2NrZG93bl9lbmFibGVkLmMKQEAgLTAsMCArMSwx
MiBAQAorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKy8qCisg
KiBDb3B5cmlnaHQgKGMpIDIwMjMgUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+CisgKi8KKwor
I2RlZmluZSBUU1RfTk9fREVGQVVMVF9NQUlOCisjaW5jbHVkZSAidHN0X3Rlc3QuaCIKKworaW50
IG1haW4odm9pZCkKK3sKKwlyZXR1cm4gIXRzdF9sb2NrZG93bl9lbmFibGVkKCk7Cit9CmRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoIGIvdGVzdGNhc2VzL2xpYi90c3RfdGVz
dC5zaAppbmRleCBjODE3ZWVjNzcuLjUwOTM5ZDRlNCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2xp
Yi90c3RfdGVzdC5zaAorKysgYi90ZXN0Y2FzZXMvbGliL3RzdF90ZXN0LnNoCkBAIC02NzgsNyAr
Njc4LDcgQEAgdHN0X3J1bigpCiAJCQlDSEVDS1BPSU5UX1dBSVR8Q0hFQ0tQT0lOVF9XQUtFKTs7
CiAJCQlDSEVDS1BPSU5UX1dBS0UyfENIRUNLUE9JTlRfV0FLRV9BTkRfV0FJVCk7OwogCQkJREVW
X0VYVFJBX09QVFN8REVWX0ZTX09QVFN8Rk9STUFUX0RFVklDRXxNT1VOVF9ERVZJQ0UpOzsKLQkJ
CVNLSVBfRklMRVNZU1RFTVMpOzsKKwkJCVNLSVBfRklMRVNZU1RFTVN8U0tJUF9JTl9MT0NLRE9X
Tik7OwogCQkJKikgdHN0X3JlcyBUV0FSTiAiUmVzZXJ2ZWQgdmFyaWFibGUgVFNUXyRfdHN0X2kg
dXNlZCEiOzsKIAkJCWVzYWMKIAkJZG9uZQpAQCAtNjk4LDYgKzY5OCwxMCBAQCB0c3RfcnVuKCkK
IAogCVsgIiRUU1RfTkVFRFNfUk9PVCIgPSAxIF0gJiYgdHN0X3JlcXVpcmVfcm9vdAogCisJaWYg
WyAiJFRTVF9TS0lQX0lOX0xPQ0tET1dOIiA9IDEgXSAmJiB0c3RfbG9ja2Rvd25fZW5hYmxlZDsg
dGhlbgorCQl0c3RfYnJrIFRDT05GICJLZXJuZWwgaXMgbG9ja2VkIGRvd24sIHNraXBwaW5nIHRl
c3QiCisJZmkKKwogCVsgIiRUU1RfRElTQUJMRV9BUFBBUk1PUiIgPSAxIF0gJiYgdHN0X2Rpc2Fi
bGVfYXBwYXJtb3IKIAlbICIkVFNUX0RJU0FCTEVfU0VMSU5VWCIgPSAxIF0gJiYgdHN0X2Rpc2Fi
bGVfc2VsaW51eAogCi0tIAoyLjM5LjIKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
