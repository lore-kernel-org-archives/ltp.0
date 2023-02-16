Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AC3C636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:30:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 759CC3CBED4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:30:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F80F3CB073
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:30:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B75212009B0
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:30:00 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AC3F222254;
 Thu, 16 Feb 2023 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676543399;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hCeaTSC0VGc3u+AuhloBkn9ZjlGwS6LCqE+Zh8U+js=;
 b=1X9w2IelrEb0oTOX4BfuYeTMQFKXrkr74Bu6B6Jfy5ISSURnGieK485catoRNq7QrYdKR8
 xpsqsYC2szQJiiO4TZm6vjoiv8jmGu5oy+4l4wrlmABR3H+Dj+4EibBPVU+OgMmcda5pdt
 I8Hwykp3jqg1DqD8ypa3wJBXPDUiSwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676543399;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hCeaTSC0VGc3u+AuhloBkn9ZjlGwS6LCqE+Zh8U+js=;
 b=DaTcHi3y5CMor9XWOsdKAAZOt/w+sVSS523OvWNhWWzLwkcVKInscMI8zIEdotBLoZbbAR
 0Msy9RchEB8NaYAQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 66D212C141;
 Thu, 16 Feb 2023 10:29:59 +0000 (UTC)
References: <20230215144225.25008-1-mdoucha@suse.cz>
 <Y+z4MNO+jwydz1w8@pevik> <abf5eb48-d63d-1b5f-4047-1a8c210a48a1@arm.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Date: Thu, 16 Feb 2023 10:12:05 +0000
Organization: Linux Private Site
In-reply-to: <abf5eb48-d63d-1b5f-4047-1a8c210a48a1@arm.com>
Message-ID: <87lekxrjh6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2015-3290: Fix tst_syscall() return value
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ClRlbyBDb3VwcmllIERpYXogPHRlby5jb3VwcmllZGlhekBhcm0uY29tPiB3cml0ZXM6Cgo+IEhp
IGFsbCwKPgo+IE9uIDE1LzAyLzIwMjMgMTU6MjAsIFBldHIgVm9yZWwgd3JvdGU6Cj4+IEhpIGFs
bCwKPj4KPj4+IFRoZSBtb2RpZnlfbGR0KCkgc3lzY2FsbCByZXR1cm5zIDMyLWJpdCBzaWduZWQg
aW50ZWdlciB2YWx1ZS4gUmVjZW50IGNoYW5nZXMKPj4+IGluIHRzdF9zeXNjYWxsKCkgY2F1c2Vk
IHRoZSB2YWx1ZSB0byBiZSBpbnRlcnByZXRlZCBhcyB1bnNpZ25lZCBvbiBvbGRlcgo+Pj4ga2Vy
bmVscy9nbGliYywgd2hpY2ggYnJlYWtzIHRoZSBjdmUtMjAxNS0zMjkwIHRlc3QuIEFkZCBleHBs
aWNpdCB0eXBlIGNhc3QKPj4+IHRvIGZpeCBpdC4KPj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6Pgo+Pgo+PiBUaGlzIGlzIGNhdXNlZCBieSBlNWQyYTA1YTkgKCJyZWdl
bi5zaDogVXNlIGludHB0cl90IGZvciB0c3Rfc3lzY2FsbCByZXR1cm4iKQo+PiB3aGljaCBjaGFu
Z2VkIHJldHVybmluZyB0c3RfcmV0IGZyb20gaW50IHRvIGludHB0cl90ICh3aGljaCBpcyBhbHNv
IGludCBmb3IgMzIKPj4gYml0IGFyY2hzLCBidXQgbG9uZyBmb3IgNjQgYml0IGFyY2hzKS4gVGhp
cyBjb21taXQgaXMgYWxzbyBuZWVkZWQsIHRodXMgSSBkb24ndAo+PiBzdWdnZXN0IHRvIHJldmVy
dCBpdCwgYnV0IEkgd29uZGVyIGhvdyBtYW55IG90aGVyIHRlc3RzIGl0IGJyb2tlLgoKSSB0aGlu
ayBtb2RpZnlfbGR0IGlzIHNwZWNpYWwuIFlvdSBjb3VsZCBzZWFyY2ggZm9yIG90aGVyIHN5c2Nh
bGxzIHdoaWNoCm9ubHkgcmV0dXJuIDMyYml0IHRvIG1ha2Ugc3VyZS4KCj4KPiBJIHNlbnQgdGhl
IHRzdF9zeXNjYWxsIHJldHVybiBwYXRjaC4gSSBkaWQgc29tZSB0ZXN0aW5nIHdpdGggd2hhdCBz
eXN0ZW1zIEkKPiBoYWQgYXZhaWxhYmxlIHdoZW4gd29ya2luZyBvbiBpdCBhbmQsIGF0IHRoZSB0
aW1lLCBkaWRuJ3Qgc2VlIGFueQo+IHJlZ3Jlc3Npb25zLAo+IGluY2x1ZGluZyBmb3IgY3ZlLTIw
MTUtMzI5MC4KPgo+IEhvd2V2ZXIgdGhpcyB3YXMgd2l0aCBmYWlybHkgcmVjZW50IGtlcm5lbHMg
YW5kIGxpYmNzLCBhbmQgYWNjb3JkaW5nCj4gdG8gTWFydGluCj4gdGhlIHRlc3QgZmFpbGVkIGZv
ciB0aGVtIG9uIGFuIG9sZGVyIGNvbWJpbmF0aW9uLgo+Cj4gSSBzaGFyZWQgdGhlIHRlc3Qgc3Vp
dGVbMF0gSSB0ZXN0ZWQgdGhlIHBhdGNoIHdpdGgsIGNvbnRhaW5pbmcgYWxsIHRoZQo+IHVzZXMg
SSBmb3VuZC4KPiBJdCBtaWdodCBiZSB3b3J0aHdoaWxlIHRvIHJ1biBpdCBvbiBhIHN5c3RlbSB3
aGVyZSB3ZSBub3cga25vdyBvbmUgb2YKPiB0aGUgdGVzdHMKPiB3YXMgYWZmZWN0ZWQgPyBIb3Bl
ZnVsbHksIG5vbmUgbW9yZSwgYnV0IGhhdmluZyBhIHJlc3VsdCB3b3VsZCBiZQo+IGJldHRlci4K
CkkgdGhpbmsgdGhlIHRlc3RpbmcgeW91IGRpZCB3YXMgbW9yZSB0aGFuIGFkZXF1YXRlLgoKPgo+
IEJlc3QgcmVnYXJkcywKPiBUw6lvCj4KPiBbMF06IGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlw
ZXJtYWlsL2x0cC8yMDIyLU5vdmVtYmVyLzAzMTY0MC5odG1sCj4KPj4KPj4gS2luZCByZWdhcmRz
LAo+PiBQZXRyCj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1
c2UuY3o+Cj4+PiAtLS0KPj4+ICAgdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMgfCAzICsr
LQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMgYi90ZXN0Y2FzZXMv
Y3ZlL2N2ZS0yMDE1LTMyOTAuYwo+Pj4gaW5kZXggZjYxZDI4MDliLi5hMmE4ZmNlZGQgMTAwNjQ0
Cj4+PiAtLS0gYS90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+Pj4gKysrIGIvdGVzdGNh
c2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMKPj4+IEBAIC0xOTUsNyArMTk1LDggQEAgc3RhdGljIHZv
aWQgc2V0X2xkdCh2b2lkKQo+Pj4gICAJCS51c2VhYmxlCSA9IDAKPj4+ICAgCX07Cj4+PiAtCVRF
U1QodHN0X3N5c2NhbGwoX19OUl9tb2RpZnlfbGR0LCAxLCAmZGF0YV9kZXNjLCBzaXplb2YoZGF0
YV9kZXNjKSkpOwo+Pj4gKwlURVNUKChpbnQpdHN0X3N5c2NhbGwoX19OUl9tb2RpZnlfbGR0LCAx
LCAmZGF0YV9kZXNjLAo+Pj4gKwkJc2l6ZW9mKGRhdGFfZGVzYykpKTsKPj4+ICAgCWlmIChUU1Rf
UkVUID09IC1FSU5WQUwpIHsKPj4+ICAgCQl0c3RfYnJrKFRDT05GIHwgVFJFUlJOTywKPj4+ICAg
CQkJIm1vZGlmeV9sZHQ6IDE2LWJpdCBkYXRhIHNlZ21lbnRzIGFyZSBwcm9iYWJseSBkaXNhYmxl
ZCIpOwoKCi0tIApUaGFuayB5b3UsClJpY2hhcmQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
