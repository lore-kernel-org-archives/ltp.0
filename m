Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D609CE7A8A
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 15:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 718953CDDDF
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 17:32:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B7A93C8946
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 17:32:43 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CD062600857
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 17:32:42 +0200 (CEST)
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-452b4fd977eso1738403137.1
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695569561; x=1696174361; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSJZSZOUN6KSZ1Fr0SU6EUu5NSVFxvEmO17713Eu80I=;
 b=QNC5wJbYQCoI/5Sl2NgHRMNQtgwIT41k4ISZl7ELfKSM04S414k7oF2WvqDKN6ie6n
 r+p7iTURRFbElpRuXE/Mb1+iOx8sL0k+hPavPaLcLLbLop/quXan2RV9R71COQEJmvAw
 egjSCBZLRyJO9vJOBorPlaLfNWuv2wTaRvV4XVzjzvFh32k/h/oAZs8J0z6+kYAqr+k6
 +tVuZzU96oX1ToVME1vkddvFhVZ7qTFYyEOrfQhGpvvwaGdFrvs7BFE88KLR2rGXzjE9
 CMHMWK9Hg6+HVFqrj1vSwAr5V028Rw4q+pG0XBTCkpFVu2NbMmWlrwDaLq1aMLkYZ06V
 VYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695569561; x=1696174361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSJZSZOUN6KSZ1Fr0SU6EUu5NSVFxvEmO17713Eu80I=;
 b=EZsMQ2acmxJnTxivIWe6r2zc07/Ey48IG6E1qUoK0Cmqq/MDvhFodcaGVuFSkgXnQh
 RW82ihEtdecVudzOtty4Wcifg/T4PA9JSezodvTMpgngb8UgR416tNOx29HT2dmv6/yX
 GQf5EvwGz4WoHAkh9Bc1h/H1aCMAikdifinysc0RjSeH8pnPABopFKXApk482IXnoSzz
 LixYxsekKyDpy2DQH82a56jyY7ntmeTYKHm6HsRJSoI2ojYie4Kpd1685zCCB54KpXq7
 a0k1cDq57dXCkAhUqVuRdA+VUeYb6t1j9Urf+h2LrLi8zVo0fkJYvKJ2i+GqrfdJwlRN
 do0A==
X-Gm-Message-State: AOJu0YxUS41D/+egJqGmnPUs8/PTmGx811ikHmBJNl3lVw35C/B8UCxD
 9JwHTtS9FMQhCCJt+vo0HyUfLwQ4mpbM7DjaCfw=
X-Google-Smtp-Source: AGHT+IGaW7Sz7LnHaiHMPxCDOprArU6bv7d1igX5IF19CZvB5oCjZWd8rNuEQr9WVblupNky/X8iMDYXlIT9ved+/kE=
X-Received: by 2002:a67:f947:0:b0:44d:3f96:6c61 with SMTP id
 u7-20020a67f947000000b0044d3f966c61mr2463076vsq.30.1695569561610; Sun, 24 Sep
 2023 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
In-Reply-To: <ZRBHSACF5NdZoQwx@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Sep 2023 18:32:30 +0300
Message-ID: <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
To: Matthew Wilcox <willy@infradead.org>,
 kernel test robot <oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, oe-lkp@lists.linux.dev, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgNToyN+KAr1BNIE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IE9uIFN1biwgU2VwIDI0LCAyMDIzIGF0IDAyOjQ3OjQy
UE0gKzAzMDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+ID4gU2luY2UgeW91IGpvaW5lZCB0aGUg
ZGlzY3Vzc2lvbiwgeW91IGhhdmUgdGhlIG9wcG9ydHVuaXR5IHRvIGFncmVlIG9yCj4gPiBkaXNh
Z3JlZSB3aXRoIG91ciBkZWNpc2lvbiB0byBjaGFuZ2UgcmVhZGFoZWFkKCkgdG8gRVNQSVBFLgo+
ID4gSnVkZ2luZyAgYnkgeW91ciBjaXRpbmcgb2YgbHNlZWsgYW5kIHBvc2l4X2ZhZHZpc2Ugc3Rh
bmRhcmQsCj4gPiBJIGFzc3VtZSB0aGF0IHlvdSB3aWxsIGJlIG9uIGJvYXJkPwo+Cj4gSSdtIGZp
bmUgd2l0aCByZXR1cm5pbmcgRVNQSVBFIChpdCdzIGxpa2UgRU5PVFRZIGluIGEgc2Vuc2UpLiAg
YnV0Cj4gdGhhdCdzIG5vdCB3aGF0IGtidWlsZCByZXBvcnRlZDoKCmtidWlsZCByZXBvcnQgaXMg
ZnJvbSB2MSBwYXRjaCB0aGF0IHdhcyBwb3N0ZWQgdG8gdGhlIGxpc3QKdGhpcyBpcyBub3QgdGhl
IHBhdGNoICh2MikgdGhhdCBpcyBhcHBsaWVkIHRvIHZmcy5taXNjCmFuZCBoYXMgYmVlbiBpbiBs
aW51eC1uZXh0IGZvciBhIGZldyBkYXlzLgoKT2xpdmVyLAoKQ2FuIHlvdSBzYXkgdGhlIGZhaWx1
cmUgKG9uIHNvY2tldCkgaXMgcmVwcm9kdWNlZCBvbgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC92ZnMvdmZzLmdpdCB2ZnMubWlzYz8KCkkgd291bGQgZXhw
ZWN0IHRoZSBwaXBlIHRlc3QgdG8gZmFpbCBmb3IgZ2V0dGluZyBFU1BJUEUKYnV0IGFjY29yZGlu
ZyB0byBSZXViZW4gdGhlIHNvY2tldCB0ZXN0IGRvZXMgbm90IGZhaWwuCgo+Cj4gcmVhZGFoZWFk
MDEuYzo2MjogVEZBSUw6IHJlYWRhaGVhZChmZFswXSwgMCwgZ2V0cGFnZXNpemUoKSkgc3VjY2Vl
ZGVkCj4KPiA2MTogICAgIGZkWzBdID0gU0FGRV9TT0NLRVQoQUZfSU5FVCwgU09DS19TVFJFQU0s
IDApOwo+IDYyOiAgICAgVFNUX0VYUF9GQUlMKHJlYWRhaGVhZChmZFswXSwgMCwgZ2V0cGFnZXNp
emUoKSksIEVJTlZBTCk7Cj4KPiBJIHRoaW5rIExUUCB3b3VsZCByZXBvcnQgJ3dyb25nIGVycm9y
IGNvZGUnIHJhdGhlciB0aGFuICdzdWNjZWVkZWQnCj4gaWYgaXQgd2VyZSByZXR1cm5pbmcgRVNQ
SVBFLgo+Cj4gSSdtIG5vdCBPSyB3aXRoIHJlYWRhaGVhZCgpIHN1Y2NlZWRpbmcgb24gYSBzb2Nr
ZXQuCgpBZ3JlZS4gUmV1YmVuIHJlcG9ydGVkIHRoYXQgdGhpcyBkb2VzIG5vdCBoYXBwZW4gb24g
djIKYWx0aG91Z2ggSSBjYW5ub3QgZXhwbGFpbiB3aHkgaXQgd2FzIHJlcG9ydGVkIG9uIHYxLi4u
Cgo+IEkgdGhpbmsgdGhhdCBzaG91bGQKPiBhbHNvIHJldHVybiBFU1BJUEUuICBJIHRoaW5rIHBv
c2l4X2ZhZHZpc2UoKSBzaG91bGQgcmV0dXJuIEVTUElQRSBvbiBhCj4gc29ja2V0IHRvbywgYnV0
IHJlcG9ydGluZyBidWdzIHRvIHRoZSBBdXN0aW4gR3JvdXAgc2VlbXMgcXVpdGUgcGFpbmZ1bC4K
PiBQZXJoYXBzIHNvbWVib2R5IGhhcyBiZWVuIHRocm91Z2ggdGhpcyBwcm9jZXNzIGFuZCBjYW4g
ZG8gdGhhdCBmb3IgdXM/Cj4KClRoaXMgaXMgUmV1YmVuJ3MgZmlyc3Qga2VybmVsIHBhdGNoLgpM
ZXQncyBhZ3JlZSB0aGF0IGNoYW5naW5nIHRoZSBzdGFuZGFyZCBvZiBwb3NpeF9mYWR2aXNlKCkg
Zm9yIHNvY2tldCBpcwpiZXlvbmQgdGhlIHNjb3BlIG9mIGhpcyBjb250cmlidXRpb24gOikKClRo
YW5rcywKQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
