Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C55CE7A88
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 03:48:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 997863CBDF0
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 05:48:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8772E3C9C98
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 05:48:36 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 794BA200A11
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 05:48:35 +0200 (CEST)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-65651954089so5639906d6.1
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 20:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695527314; x=1696132114; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hPMN2o/ZqUoEz5/wi2BDt0qa0xXbgkWYs6F/LLcrWB4=;
 b=F2wW2ovftImKq+50Uz5O+W0+HrThzZO3v8RplTZH2vyFzypYFm/VND8S9jNJvJMEBU
 cayuLz+rRr6cwP+RXc7yVD1e8nsw/lnjJNB9/DdZZ6Q/YugHZAh+dtg+H5DJ1A4jK/hH
 ygWyRwW5adTW4PJvEAfvvFfSEfeunfWw7keShELvKKfTnoyk0b54sSzZB+K07Lkamfom
 TZeoCDCb6iwXRPG//a0QVa22mtfM6QiwrC76WmHsEe1Fqy7aIxMY43r8Z7QRd6OdTnqy
 w3lSn54j4iEqWsFD3IDjeSNxNNPAgwO9yhrCfX1faZByRE8M9J3NlP3vOrtSZMnjvrYB
 Vd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695527314; x=1696132114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hPMN2o/ZqUoEz5/wi2BDt0qa0xXbgkWYs6F/LLcrWB4=;
 b=XistflWhf7J1BBl6bMALKjTFdNl6gf3itWAO2O4GTuLaQtE0BKPBfqDEL08KnvrXR7
 CfsQw2gBQB7LALrQtny3iAGtwV+YvWb9ZVz7Zt1phyX5YdV4KRcFdIxip+KRP7UuAp+y
 WfdYwBO7u5gL1NtGsoOKqArw1Ipqbn7hPCUH39Y0n/bXb1fNwKnCbkj7ziDjyNWJQc4a
 SQ/iFjG7UtI3YbDTelYrOafZ9nbFq4beamk3ALUG0UdFXQdtYD/aFA3xVvWHUIEzw/P5
 rpt3J+5TJ4qs3TCvFPHuQ2I7VUsqHIJvgDjOgG5OkIFiaZMspkL4M58HfzrhVhAgVnww
 M5ig==
X-Gm-Message-State: AOJu0Yx3AlyKsRY66gDQuXAVM07XQL2+LWcNh1LdGocAFJg1n5xvLBly
 jSBTT6epbnePPA4wFycnYyAet8y5kZd+gcfZOXI=
X-Google-Smtp-Source: AGHT+IHaAqbx0G7o7CtYdt5WfAFvTYEbRG8xwmQN+hwPHYe2NzhTrFd6UXoCUufkW7VLPXEKFGN2WjPWiYo7R4t5LlY=
X-Received: by 2002:a05:620a:1aa9:b0:772:5267:3ddf with SMTP id
 bl41-20020a05620a1aa900b0077252673ddfmr3894228qkb.2.1695527314190; Sat, 23
 Sep 2023 20:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
From: Reuben Hawkins <reubenhwk@gmail.com>
Date: Sat, 23 Sep 2023 22:48:23 -0500
Message-ID: <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com,
 Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBTZXAgMjMsIDIwMjMgYXQgMTA6NDjigK9BTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPiB3cm90ZToKCj4gT24gU2F0LCBTZXAgMjMsIDIwMjMgYXQgNTo0MeKAr1BN
IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPgo+IHdyb3RlOgo+ID4KPiA+IE9u
IFNhdCwgU2VwIDIzLCAyMDIzIGF0IDA4OjU2OjI4QU0gKzAzMDAsIEFtaXIgR29sZHN0ZWluIHdy
b3RlOgo+ID4gPiBXZSBkZWNpZGVkIHRvIGRlbGliZXJhdGVseSB0cnkgdGhlIGNoYW5nZSBvZiBi
ZWhhdmlvcgo+ID4gPiBmcm9tIEVJTlZBTCB0byBFU1BJUEUsIHRvIGFsaWduIHdpdGggZmFkdmlz
ZSBiZWhhdmlvciwKPiA+ID4gc28gZXZlbnR1YWxseSB0aGUgTFRQIHRlc3Qgc2hvdWxkIGJlIGNo
YW5nZWQgdG8gYWxsb3cgYm90aC4KPiA+ID4KPiA+ID4gSXQgd2FzIHRoZSB0ZXN0IGZhaWx1cmUg
b24gdGhlIHNvY2tldCB0aGF0IGFsYXJtZWQgbWUuCj4gPiA+IEhvd2V2ZXIsIGlmIHdlIHdpbGwg
aGF2ZSB0byBzcGVjaWFsIGNhc2Ugc29ja2V0IGluCj4gPiA+IHJlYWRhaGVhZCgpIGFmdGVyIGFs
bCwgd2UgbWF5IGFzIHdlbGwgYWxzbyBzcGVjaWFsIGNhc2UKPiA+ID4gcGlwZSB3aXRoIGl0IGFu
ZCByZXRhaW4gdGhlIEVJTlZBTCBiZWhhdmlvciAtIGxldCdzIHNlZQo+ID4gPiB3aGF0IHlvdXIg
ZmluZGluZ3MgYXJlIGFuZCBkZWNpZGUuCj4gPgo+ID4gSWYgSSByZWFkIGl0IGNvcnJlY3RseSwg
TFRQIGlzIHJlcG9ydGluZyB0aGF0IHJlYWRoYWVhZCgpIG9uIGEgc29ja2V0Cj4gPiByZXR1cm5l
ZCBzdWNjZXNzIGluc3RlYWQgb2YgYW4gZXJyb3IuICBTb2NrZXRzIGRvIGhhdmUgYV9vcHMsIHJp
Z2h0Pwo+ID4gSXQncyBzZXQgdG8gZW1wdHlfYW9wcyBpbiBpbm9kZV9pbml0X2Fsd2F5cywgSSB0
aGluay4KPiA+Cj4KPiBZZWgsIHlvdSBhcmUgcmlnaHQuCj4gSSBndWVzcyB0aGUgY2hlY2sgIWYu
ZmlsZS0+Zl9tYXBwaW5nLT5hX29wcyBpcyBjb21wbGV0ZWx5IGZ1dGlsZQo+IGluIHRoYXQgY29k
ZS4gSXQncyB0aGUgb25seSBwbGFjZSBJIGNvdWxkIGZpbmQgdGhpcyBzb3J0IG9mIGNoZWNrCj4g
ZXhjZXB0IGZvciBwbGFjZXMgbGlrZToKPiBpZiAoZi0+Zl9tYXBwaW5nLT5hX29wcyAmJiBmLT5m
X21hcHBpbmctPmFfb3BzLT5kaXJlY3RfSU8pCj4gd2hpY2gganVzdCBsb29rcyBsaWtlIGEgY29k
aW5nIGhhYml0Lgo+Cj4gPiBJdCB3b3VsZCBiZSBuaWNlIGlmIHdlIGRvY3VtZW50ZWQgc29tZXdo
ZXJlIHdoaWNoIHBvaW50ZXJzIHNob3VsZCBiZQo+ID4gY2hlY2tlZCBmb3IgTlVMTCBmb3Igd2hp
Y2ggY2FzZXMgLi4uIGl0IGRvZXNuJ3QgcmVhbGx5IG1ha2Ugc2Vuc2UgZm9yCj4gPiBhIHNvY2tl
dCBpbm9kZSB0byBoYXZlIGFuIGlfbWFwcGluZyBzaW5jZSBpdCBkb2Vzbid0IGhhdmUgcGFnZWNh
Y2hlLgo+ID4gQnV0IG1heWJlIHdlIHJlbHkgb24gaV9tYXBwaW5nIGFsd2F5cyBiZWluZyBzZXQu
Cj4gPgo+Cj4gSSBjYW4ndCBpbWFnaW5lIHRoYXQgYSBzb2NrZXQgaGFzIGZfbWFwcGluZy4KPiBU
aGVyZSBtdXN0IGhhdmUgYmVlbiBzb21ldGhpbmcgb2ZmIHdpdGggdGhpcyBzcGVjaWZpYyBidWcg
cmVwb3J0LAo+IGJlY2F1c2UgaXQgd2FzIHJlcG9ydGVkIG9uIGEgV0lQIHBhdGNoLgo+Cj4gPiBJ
cnJpdGF0aW5nbHksIFBPU0lYIHNwZWNpZmllcyBFU1BJUEUgZm9yIHBpcGVzLCBidXQgZG9lcyBu
b3Qgc3BlY2lmeQo+ID4gd2hhdCB0byBkbyB3aXRoIHNvY2tldHMuICBJdCdzIGtpbmQgb2YgYSBt
ZWFuaW5nbGVzcyBzeXNjYWxsIGZvcgo+ID4gYW55IGtpbmQgb2Ygbm9uLXNlZWthYmxlIGZkLiAg
bHNlZWsoKSByZXR1cm5zIEVTUElQRSBmb3Igc29ja2V0cwo+ID4gYXMgd2VsbCBhcyBwaXBlcywg
c28gSSdkIHNlZSB0aGlzIGFzIGFuIG92ZXJzaWdodC4KPiA+Cj4gaHR0cHM6Ly9wdWJzLm9wZW5n
cm91cC5vcmcvb25saW5lcHVicy85Njk5OTE5Nzk5L2Z1bmN0aW9ucy9wb3NpeF9mYWR2aXNlLmh0
bWwKPiA+IGh0dHBzOi8vcHVicy5vcGVuZ3JvdXAub3JnL29ubGluZXB1YnMvOTY5OTkxOTc5OS9m
dW5jdGlvbnMvbHNlZWsuaHRtbAo+ID4KPgo+IEluZGVlZCwgd2UgdGhvdWdodCBpdCB3b3VsZG4n
dCBiZSB0b28gYmFkIHRvIGFsaWduIHRoZQo+IHJlYWRhaGVhZCBlcnJvcnMgd2l0aCB0aG9zZSBv
ZiBwb3NpeF9mYWR2aXNlLgo+IFRoYXQncyB3aHkgd2UgYXNrZWQgdG8gcmVtb3ZlIHRoZSBTX0lT
RklGTyBjaGVjayBmb3IgdjIuCj4gQnV0IGxvb2tpbmcgYWdhaW4sIHBpcGUgd2lsbCBnZXQgRUlO
VkFMIGZvciAhZl9tYXBwaW5nLCBzbyB0aGUKPiBVQVBJIHdhc24ndCBjaGFuZ2VkIGF0IGFsbCBh
bmQgd2Ugd2VyZSBqdXN0IHRhbGtpbmcgQlMgYWxsIGFsb25nLgo+IExldCdzIGxlYXZlIHRoZSBV
QVBJIGFzIGlzLgo+Cj4gPiBPZiBjb3Vyc2UgcmVhZGFoZWFkKCkgaXMgYSBMaW51eC1zcGVjaWZp
YyBzeXNjYWxsLCBzbyB3ZSBjYW4gZG8gd2hhdGV2ZXIKPiA+IHdlIHdhbnQgaGVyZSwgYnV0IEkn
bSByZWFsbHkgdGVtcHRlZCB0byBqdXN0IGFsbG93IHJlYWRhaGVhZCgpIGZvcgo+ID4gcmVndWxh
ciBmaWxlcyBhbmQgYmxvY2sgZGV2aWNlcy4gIEhtbS4gIENhbiB3ZSBjaGVjayBGTU9ERV9MU0VF
Swo+ID4gaW5zdGVhZCBvZiAoU19JU0ZJTEUgfHwgU19JU0JMSyk/Cj4KPiBJIHRoaW5rIHRoZSBm
X21hcHBpbmcgY2hlY2sgc2hvdWxkIGJlIGdvb2QuCj4gUmV1YmVuIGFscmVhZHkgc2FpZCBoZSBj
b3VsZCBub3QgcmVwcm9kdWNlIHRoZSBMVFAgZmFpbHVyZSB3aXRoCj4gdjIgdGhhdCBpcyBvbiBD
aHJpc3RpYW4ncyB2ZnMubWlzYyBicmFuY2guCj4KPiBUaGUgU19JU1JFRyBjaGVjayBJIHB1dCBp
biB0aGUgRml4ZXMgY29tbWl0IHdhcyBjb21wbGV0ZWx5Cj4gdW5leHBsYWluZWQgaW4gdGhlIGNv
bW1pdCBtZXNzYWdlIGFuZCBjb21wbGV0ZWx5IHVubmVlZGVkLgo+IEp1c3QgcmVtb3ZpbmcgaXQg
YXMgd2FzIGRvbmUgaW4gdjIgaXMgZW5vdWdoLgo+Cj4gSG93ZXZlciwgdjIgaGFzIHRoaXMgd3Jv
bmcgY29tbWVudCBpbiB0aGUgY29tbWl0IG1lc3NhZ2U6Cj4gIlRoZSBjaGFuZ2UgYWxzbyBtZWFu
cyB0aGF0IHJlYWRhaGVhZCB3aWxsIHJldHVybiAtRVNQSVBFCj4gICBvbiBGSUZPIGZpbGVzIGlu
c3RlYWQgb2YgLUVJTlZBTC4iCj4KPiBXZSBuZWVkIHRvIHJlbW92ZSB0aGlzIGNvbW1lbnQKPiBh
bmQgY291bGQgYWxzbyByZW1vdmUgdGhlIHVubmVlZGVkICFmLmZpbGUtPmZfbWFwcGluZy0+YV9v
cHMKPiBjaGVjayB3aGlsZSBhdCBpdC4KPgo+IFRoYW5rcywKPiBBbWlyLgo+CgpJdCBsb29rcyB0
byBtZSBsaWtlIHRoZSBmb2xsb3dpbmcgd2lsbCBmaXggdGhlIHByb2JsZW0gd2l0aG91dCBicmVh
a2luZyB0aGUKdGVzdHMuLi4KCi0gaWYgKCFmLmZpbGUtPmZfbWFwcGluZyB8fCAhZi5maWxlLT5m
X21hcHBpbmctPmFfb3BzIHx8Ci0gICAgIVNfSVNSRUcoZmlsZV9pbm9kZShmLmZpbGUpLT5pX21v
ZGUpKQorIGlmICghKGYuZmlsZS0+Zl9tb2RlICYgRk1PREVfTFNFRUspKQoKLi4uSSdsbCBwdXQg
dGhpcyBpbiBhIHYzIHBhdGNoIHNvb24gdW5sZXNzIHNvbWVib2R5IGNhbiBzcG90IGFueSByZWFz
b25zIHdoeQp0aGlzIGlzIG5vIGdvb2QuCgotUmV1YmVuCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
