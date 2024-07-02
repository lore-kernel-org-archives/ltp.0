Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E71C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:33:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF20F3D3EDB
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:33:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76ABA3C8B23
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:00:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=digikod.net (client-ip=2001:1600:7:10::8fad;
 helo=smtp-8fad.mail.infomaniak.ch; envelope-from=mic@digikod.net;
 receiver=lists.linux.it)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3A8B1401704
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:00:22 +0200 (CEST)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WD3123C0hzvBv;
 Tue,  2 Jul 2024 15:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
 s=20191114; t=1719925222;
 bh=Ic/kjYsPEipQ9NHrPvcvu6Sb0kBMtH0ZUyIbOE9nIas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TRxOWj+bskt0EHK1FIrQpZ64bwJIQz7yI1XvZC8jTCNbyMC0q/jJDDfbw3Zf7PDet
 bG5sJZb9hO5p5B3AMUmZBGdxk4Ow6FOwl2HpnRxNkRiUpvxm2QEyMtUK2OYDOsow4T
 nHO3QOtE7hiDtrkc1+Y/2iyMBccQ7NcoIi95iGaM=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4WD3114kzCz153h; Tue,  2 Jul 2024 15:00:21 +0200 (CEST)
Date: Tue, 2 Jul 2024 15:00:20 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240702.Auya5Chaipho@digikod.net>
References: <20240702094745.96521-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240702094745.96521-1-liwang@redhat.com>
X-Infomaniak-Routing: alpha
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:32:40 +0200
Subject: Re: [LTP] [RFC PATCH] landlock: fix minimal required size for
 landlock_ruleset_attr copying
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it,
 paul@paul-moore.com, gnoack@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdWwgMDIsIDIwMjQgYXQgMDU6NDc6NDVQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBBcyBrZXJuZWwgY29tbWl0IGZmZjY5ZmIwM2RkZSAoImxhbmRsb2NrOiBTdXBwb3J0IG5ldHdv
cmsgcnVsZXMgd2l0aCBUQ1AgYmluZCBhbmQgY29ubmVjdCIpCj4gaW50cm9kdWNpbmcgYSBuZXcg
ZmllbGQgJ2hhbmRsZWRfYWNjZXNzX25ldCcgaW4gdGhlIHN0cnVjdHVyZSBsYW5kbG9ja19ydWxl
c2V0X2F0dHIsCj4gYnV0IGluIHRoZSBsYW5kbG9ja19jcmVhdGVfcnVsZXNldCgpIGl0IHN0aWxs
IHVzZXMgdGhlIGZpcnN0IGZpZWxkICdoYW5kbGVkX2FjY2Vzc19mcycKPiB0byBjYWxjdWxhdGUg
bWluaW1hbCBzaXplLCBzbyB0aGF0IG1hZGUgZGVjcmVhc2UgMSBpcyB1c2VsZXNzIGluIExUUCBs
YW5kbG9jazAxLmMgdG8KPiB0ZXN0IHRoZSB0b28tc21hbGwtc2l6ZS4KPiAKPiBUZXN0IGNvZGU6
Cj4gICAgcnVsZV9zbWFsbF9zaXplID0gc2l6ZW9mKHN0cnVjdCBsYW5kbG9ja19ydWxlc2V0X2F0
dHIpIC0gMTsKPiAgICB0c3Rfc3lzY2FsbChfX05SX2xhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0LCAu
Li4sIHJ1bGVfc21hbGxfc2l6ZSwgMCkKPiAKPiBSZXN1bHQ6Cj4gICBsYW5kbG9jazAxLmM6NDk6
IFRGQUlMOiBTaXplIGlzIHRvbyBzbWFsbCBleHBlY3RlZCBFSU5WQUw6IEVOT01TRyAoNDIpCgpJ
bnRlcmVzdGluZywgdGhpcyBsb29rcyBsaWtlIGEgYnVnIGluIHRoZXNlIExUUCB0ZXN0cy4KCj4g
Cj4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gQ2M6IE1pY2th
w6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5ldD4KPiBDYzogS29uc3RhbnRpbiBNZXNraGlkemUg
PGtvbnN0YW50aW4ubWVza2hpZHplQGh1YXdlaS5jb20+Cj4gQ2M6IFBhdWwgTW9vcmUgPHBhdWxA
cGF1bC1tb29yZS5jb20+Cj4gLS0tCj4gCj4gTm90ZXM6Cj4gICAgIEhpIE1pY2thZWwsCj4gICAg
ICAgIEknbSBub3QgcXVpdGUgc3VyZSBpZiB0aGF0IGlzIG9uIHB1cnBvc2UgdG8gdXNlIHRoZSBm
aXJzdCBmaWVsZCBvciBrZXJuZWwKPiAgICAgICAgYnVnLCBjYW4geW91IHRha2UgYSBsb29rPwoK
SGkgTGksCgpZZXMgdGhpcyBpcyBvbiBwdXJwb3NlLiAgVGhlIGhhbmRsZWRfYWNjZXNzX2ZzIG1p
bmltYWwgc2l6ZSBjaGVjayBzaG91bGQKbmV2ZXIgY2hhbmdlIGZvciBiYWNrd2FyZCBjb21wYXRp
YmlsaXR5IHJlYXNvbi4gIFVzZXIgc3BhY2UgYnVpbHQgd2l0aApvbGQgaGVhZGVycyBtdXN0IHN0
aWxsIHdvcmsgd2l0aCBuZXcga2VybmVscy4gIFRoaXMgaXMgdGVzdGVkIHdpdGggdGhlCiJpbmNv
bnNpc3RlbnRfYXR0ciIgdGVzdCBpbiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9i
YXNlX3Rlc3QuYwoKCj4gCj4gIHNlY3VyaXR5L2xhbmRsb2NrL3N5c2NhbGxzLmMgfCAyICstCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYg
LS1naXQgYS9zZWN1cml0eS9sYW5kbG9jay9zeXNjYWxscy5jIGIvc2VjdXJpdHkvbGFuZGxvY2sv
c3lzY2FsbHMuYwo+IGluZGV4IDAzYjQ3MGY1YTg1YS4uZjNjZDdkZWY3NjI0IDEwMDY0NAo+IC0t
LSBhL3NlY3VyaXR5L2xhbmRsb2NrL3N5c2NhbGxzLmMKPiArKysgYi9zZWN1cml0eS9sYW5kbG9j
ay9zeXNjYWxscy5jCj4gQEAgLTE5OCw3ICsxOTgsNyBAQCBTWVNDQUxMX0RFRklORTMobGFuZGxv
Y2tfY3JlYXRlX3J1bGVzZXQsCj4gIAkvKiBDb3BpZXMgcmF3IHVzZXIgc3BhY2UgYnVmZmVyLiAq
Lwo+ICAJZXJyID0gY29weV9taW5fc3RydWN0X2Zyb21fdXNlcigmcnVsZXNldF9hdHRyLCBzaXpl
b2YocnVsZXNldF9hdHRyKSwKPiAgCQkJCQlvZmZzZXRvZmVuZCh0eXBlb2YocnVsZXNldF9hdHRy
KSwKPiAtCQkJCQkJICAgIGhhbmRsZWRfYWNjZXNzX2ZzKSwKPiArCQkJCQkJICAgIGhhbmRsZWRf
YWNjZXNzX25ldCksCj4gIAkJCQkJYXR0ciwgc2l6ZSk7Cj4gIAlpZiAoZXJyKQo+ICAJCXJldHVy
biBlcnI7Cj4gLS0gCj4gMi40NS4yCj4gCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
