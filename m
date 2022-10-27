Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1DDC38A2D
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 09:16:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6272B3CA817
	for <ltp@archiver.kernel.org>; Thu, 27 Oct 2022 11:16:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8638E3C2297
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 11:16:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B2C4A200BC3
 for <ltp@lists.linux.it>; Thu, 27 Oct 2022 11:16:34 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1410022708;
 Thu, 27 Oct 2022 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666862194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihFNMKRCdoudFxKb3lHPI8c0r0UViaNVXWE7rxu4Zr8=;
 b=A/n02v0xKzuknVAtldFJt4nhCDIA1ox7E+dd1KGLE7sbGQgWUbzz5ZIPbasrTdSHGrEmPG
 ALLq5pe5Pra6MXu9EBnNbrV1Oju4mwaQHytrx+NLepxpLkbKyt1nos1O6wbevH3pojnPZl
 Pihzkgerl1aHSnzMvlJM2Xogvqo5Ec8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666862194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihFNMKRCdoudFxKb3lHPI8c0r0UViaNVXWE7rxu4Zr8=;
 b=qHVxmTobqglW3kqsBE/PeNEZ7Lhwa8lOJG9GpWxzyg9Gj2P8kxm0j+Pt6BNnVp1uXc/INu
 RmL5NlHM64C0YOCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 459262C141;
 Thu, 27 Oct 2022 09:16:33 +0000 (UTC)
References: <[LTP] [PATCH] Fix tst_find_backing_dev when no initramfs>
 <20221026140408.471609-1-alessandro.carminati@gmail.com>
 <20221026140408.471609-2-alessandro.carminati@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 27 Oct 2022 09:08:30 +0100
In-reply-to: <20221026140408.471609-2-alessandro.carminati@gmail.com>
Message-ID: <87fsf9sk2e.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Reply-To: rpalethorpe@suse.de
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpBbGVzc2FuZHJvIENhcm1pbmF0aSA8YWxlc3NhbmRyby5jYXJtaW5hdGlAZ21haWwu
Y29tPiB3cml0ZXM6Cgo+IEluIHNvbWUgbWluaW1hbCBMaW51eCB0aGUgL2Rldi9yb290IGNhbiBi
ZSBtaXNzaW5nLiBUaGUgY29uc2VxdWVuY2UgZm9yIHRoaXMKPiBpcyB0aGF0IG1vdW50aW5mbyBk
b2Vzbid0IGNvbnRhaW4gdGhlIGNvcnJlY3QgaW5mb3JtYXRpb24uCj4KPiBUaGUgdW5ldmVudCBm
aWxlIGluIHN5c2ZzIGlzIGFub3RoZXIgbWV0aG9kIHRvIHJldHJpZXZlIGRldmljZSBpbmZvIGdp
dmVuwqAKPiBhIG1ham9yL21pbm9yLgo+Cj4gYnRyZnMgc3Vidm9sdW1lcyBjYW4gYmUgYW4gZXhj
ZXB0aW9uIHRvIHRoaXMgcnVsZSwgYnV0IHRoZXkgYXJlIG5vdCBleHBlY3RlZAo+IHRvIGJlIHVz
ZWQgaW4gdGhlIGN1cnJlbnQgdXNlY2FzZS4KClVuZm9ydHVuYXRlbHkgdGhpcyBpcyBub3QgdHJ1
ZS4gSWYgeW91IG1vdW50IC90bXAgb24gQlRSRlMgKG9yIHNldApUTVBESVIgdG8gc29tZSBCVFJG
UyBtb3VudCksIHRoZW4gd2UgaGl0IHRoaXMgaXNzdWUuCgo+Cj4gVGhpcyBzb2x1dGlvbiByZXF1
aXJlcyBzeXNmcyB0byBiZSBtb3VudGVkIGluIC9zeXMsIGJ1dCBjb25zaWRlcmluZyBtYW55wqAK
PiB0ZXN0cyBkZXBlbmRzIG9uIHRoZSBzYW1lLCBpbmNsdWRpbmcgdGhlIGlvY3RsX2xvb3AwNSB0
aGF0IHRyaWdnZXJlZCB0aGlzwqAKPiBwYXRjaCwgdGhpcyByZXF1aXJlbWVudCBpcyBub3QgdG9v
IHJlc3RyaWN0ZWQsIGFuZCB0aGUgb2xkIG1vdW50aW5mbyBjYW4gYmXCoAo+IGRyb3BwZWQgYWx0
b2dldGhlci4KClRoZSBtb3VudGluZm8gbWV0aG9kIGlzIG5vdCBzdWNoIGEgbWFpbnRlbmFuY2Ug
aXNzdWUgdGhhdCBpdCBuZWVkcyB0byBiZQpyZW1vdmVkIElNTy4gUG9zc2libHkgaXQgY291bGQg
YmUgcmVwbGFjZWQgYnkgdHN0X3N0YXRfbW91bnRfZGV2Cmluc3RlYWQsIGJ1dCB3ZSdyZSBjYXV0
aW91cyBhYm91dCB0b3VjaGluZyB0aGlzIGZ1bmN0aW9uLgoKVG8gYmUgY2xlYXIsIEknbSBub3Qg
c3VyZSBhbnlvbmUgY29tcGlsZXMgTGludXggd2l0aG91dCAvc3lzIHRoZW4gdHJpZXMKdG8gcnVu
IExUUCBvbiBpdC4gSG93ZXZlciB0aGUgZmFjdCB0aGF0IGl0IGlzIHBvc3NpYmxlIHRvIHJlbW92
ZSAvc3lzIGlzCmFub3RoZXIgc2lnbmFsIChpbiBhZGRpdGlvbiB0byBCVFJGUykgdGhhdCB0aGUg
c2l0dWF0aW9uIGlzIGNvbXBsaWNhdGVkLgoKPgo+ICQgc3VkbyAvdXNyL2xpYi9sdHAtdGVzdHN1
aXRlL3Rlc3RjYXNlcy9iaW4vaW9jdGxfbG9vcDA1Cj4gdHN0X3Rlc3QuYzoxMzYzOiBUSU5GTzog
VGltZW91dCBwZXIgcnVuIGlzIDBoIDA1bSAwMHMKPiB0c3RfdGVzdC5jOjExMTU6IFRJTkZPOiBl
eHQyL2V4dDMvZXh0NCBpcyBzdXBwb3J0ZWQgYnkgdGhlIHRlc3QKPiB0c3RfZGV2aWNlLmM6OTE6
IFRJTkZPOiBGb3VuZCBmcmVlIGRldmljZSAwICcvZGV2L2xvb3AwJwo+IGxvb3AwOiBkZXRlY3Rl
ZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDIwNDgKPiB0c3RfZGV2aWNlLmM6NTcwOiBUSU5G
TzogRGV2aWNlIG5hbWUgcmV0cml2ZWQgdGhyb3VnaCBtb3VudGluZm8KPiBpb2N0bF9sb29wMDUu
YzoxMjY6IFRJTkZPOiBiYWNraW5nIGRldigvZGV2L3Jvb3QpIGxvZ2ljYWxfYmxvY2tfc2l6ZSBp
cyA1MTIKPiBpb2N0bF9sb29wMDUuYzo2MjogVElORk86IFdpdGhvdXQgc2V0dGluZyBsb19vZmZz
ZXQgb3Igc2l6ZWxpbWl0Cj4gaW9jdGxfbG9vcDA1LmM6NDU6IFRJTkZPOiBJbiBkaW8gbW9kZQo+
IGlvY3RsX2xvb3AwNS5jOjQ4OiBUUEFTUzogbG9fZmxhZ3MgaGFzIExPX0ZMQUdTX0RJUkVDVF9J
TyBmbGFnCj4gaW9jdGxfbG9vcDA1LmM6NTI6IFRCUk9LOiBGYWlsZWQgdG8gb3BlbiBGSUxFICcv
c3lzL2Jsb2NrL2xvb3AwL2xvb3AvZGlvJyBmb3IgcmVhZGluZzogRU5PRU5UICgyKQo+Cj4gU3Vt
bWFyeToKPiBwYXNzZWQgICAxCj4gZmFpbGVkICAgMAo+IGJyb2tlbiAgIDEKPiBza2lwcGVkICAw
Cj4gd2FybmluZ3MgMAo+Cj4gVGhlIGV4YW1wbGUgaGVyZSBzaG93cyB3aGF0IGhhcHBlbiBpZiBz
eXNmcyBpcyBub3QgbW91bnRlZCBhbmQgdGhlCj4gbW91bnRpbmZvIG1ldGhvZCBpcyB1c2VkOiB0
aGUgdGVzdHMgdGhhdCBkZXBlbmRzIG9uIHN5c2ZzIGZhaWwgd2l0aAo+IGJyb2tlbiBhbmQgbm90
IGp1c3Qgd2Fybi4KPgo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgUGFsZXRob3JwZSA8cnBhbGV0
aG9ycGVAc3VzZS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWxlc3NhbmRybyBDYXJtaW5hdGkgPGFs
ZXNzYW5kcm8uY2FybWluYXRpQGdtYWlsLmNvbT4KPiAtLS0KPiAgbGliL3RzdF9kZXZpY2UuYyB8
IDQxICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9saWIvdHN0X2RldmljZS5jIGIvbGliL3RzdF9kZXZpY2UuYwo+IGluZGV4IDg0MTliODBjMy4u
NGNjYjcxYWM4IDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfZGV2aWNlLmMKPiArKysgYi9saWIvdHN0
X2RldmljZS5jCj4gQEAgLTUyMCw0OCArNTIwLDI3IEBAIHZvaWQgdHN0X2ZpbmRfYmFja2luZ19k
ZXYoY29uc3QgY2hhciAqcGF0aCwgY2hhciAqZGV2KQo+ICB7Cj4gIAlzdHJ1Y3Qgc3RhdCBidWY7
Cj4gIAlGSUxFICpmaWxlOwo+IC0JY2hhciBsaW5lW1BBVEhfTUFYXTsKPiAtCWNoYXIgKnByZSA9
IE5VTEw7Cj4gLQljaGFyICpuZXh0ID0gTlVMTDsKPiAtCXVuc2lnbmVkIGludCBkZXZfbWFqb3Is
IGRldl9taW5vciwgbGluZV9tanIsIGxpbmVfbW5yOwo+IC0JdW5zaWduZWQgaW50IGxlbiwgYmVz
dF9tYXRjaF9sZW4gPSAxOwo+IC0JY2hhciBtbnRfcG9pbnRbUEFUSF9NQVhdOwo+ICsJdW5zaWdu
ZWQgaW50IGRldl9tYWpvciwgZGV2X21pbm9yOwo+ICsJY2hhciB1ZXZlbnRfcGF0aFtQQVRIX01B
WF07Cj4gKwljaGFyIGRldl9uYW1lW05BTUVfTUFYXTsKPiAgCj4gIAlpZiAoc3RhdChwYXRoLCAm
YnVmKSA8IDApCj4gIAkJdHN0X2Jya20oVFdBUk4gfCBURVJSTk8sIE5VTEwsICJzdGF0KCkgZmFp
bGVkIik7Cj4gIAo+ICsJKmRldiA9ICdcMCc7Cj4gIAlkZXZfbWFqb3IgPSBtYWpvcihidWYuc3Rf
ZGV2KTsKPiAgCWRldl9taW5vciA9IG1pbm9yKGJ1Zi5zdF9kZXYpOwo+IC0JZmlsZSA9IFNBRkVf
Rk9QRU4oTlVMTCwgIi9wcm9jL3NlbGYvbW91bnRpbmZvIiwgInIiKTsKPiAtCSpkZXYgPSAnXDAn
Owo+IC0KPiAtCXdoaWxlIChmZ2V0cyhsaW5lLCBzaXplb2YobGluZSksIGZpbGUpKSB7Cj4gLQkJ
aWYgKHNzY2FuZihsaW5lLCAiJSpkICUqZCAlZDolZCAlKnMgJXMiLAo+IC0JCQkmbGluZV9tanIs
ICZsaW5lX21uciwgbW50X3BvaW50KSAhPSAzKQo+IC0JCQljb250aW51ZTsKPiAgCj4gLQkJcHJl
ID0gc3Ryc3RyKGxpbmUsICIgLSAiKTsKPiAtCQlwcmUgPSBzdHJ0b2tfcihwcmUsICIgIiwgJm5l
eHQpOwo+IC0JCXByZSA9IHN0cnRva19yKE5VTEwsICIgIiwgJm5leHQpOwo+IC0JCXByZSA9IHN0
cnRva19yKE5VTEwsICIgIiwgJm5leHQpOwo+ICsJc3ByaW50Zih1ZXZlbnRfcGF0aCwKPiArCQki
L3N5cy9kZXYvYmxvY2svJWQ6JWQvdWV2ZW50IiwgZGV2X21ham9yLCBkZXZfbWlub3IpOwo+ICAK
PiAtCQlpZiAobGluZV9tanIgPT0gZGV2X21ham9yICYmIGxpbmVfbW5yID09IGRldl9taW5vcikg
ewo+IC0JCQlzdHJjcHkoZGV2LCBwcmUpOwo+IC0JCQlicmVhazsKPiAtCQl9Cj4gKwlpZiAoIWFj
Y2Vzcyh1ZXZlbnRfcGF0aCwgUl9PSykpIHsKPiArCQlGSUxFX0xJTkVTX1NDQU5GKE5VTEwsIHVl
dmVudF9wYXRoLCAiREVWTkFNRT0lcyIsIGRldl9uYW1lKTsKPiAgCj4gLQkJbGVuID0gY291bnRf
bWF0Y2hfbGVuKHBhdGgsIG1udF9wb2ludCk7Cj4gLQkJaWYgKGxlbiA+IGJlc3RfbWF0Y2hfbGVu
KSB7Cj4gLQkJCXN0cmNweShkZXYsIHByZSk7Cj4gLQkJCWJlc3RfbWF0Y2hfbGVuID0gbGVuOwo+
IC0JCX0KPiArCQlpZiAoZGV2X25hbWVbMF0pCj4gKwkJCXNwcmludGYoZGV2LCAiL2Rldi8lcyIs
IGRldl9uYW1lKTsKPiAgCX0KPiAgCj4gLQlTQUZFX0ZDTE9TRShOVUxMLCBmaWxlKTsKPiAtCj4g
LQlpZiAoISpkZXYpCj4gLQkJdHN0X2Jya20oVEJST0ssIE5VTEwsICJDYW5ub3QgZmluZCBibG9j
ayBkZXZpY2UgZm9yICVzIiwgcGF0aCk7Cj4gLQo+ICAJaWYgKHN0YXQoZGV2LCAmYnVmKSA8IDAp
Cj4gIAkJdHN0X2Jya20oVFdBUk4gfCBURVJSTk8sIE5VTEwsICJzdGF0KCVzKSBmYWlsZWQiLCBk
ZXYpOwoKCi0tIApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
