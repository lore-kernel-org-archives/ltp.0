Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593D7CE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 04:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02F923CDD2D
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 06:36:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB26E3C997B
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 06:36:01 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2AB93600919
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 06:36:01 +0200 (CEST)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4527065c9b8so566182137.0
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695616560; x=1696221360; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZmcynVj4UrxljoR3ZTKSzkktGK3QDrO5FxIGZ6wMgQ=;
 b=Ovu+llBkeGUxiM5FjganUy788dM25JY+wjSf2DYfA2NR0MFCXfIqnmYTK7fSGJ2bFc
 cDtckr7J6MMYN95em/T4b0Qd+0NFpXvvI4eB+ASWUrZL4vlK8C49JCP2dpcdWc1S6cAH
 vgD/pHXFt7ERFmB51BW7YB/+1mqXANGRob1a9FRLFMrFLczFwBvsR3tJ8kVyoaaBcbUh
 cDjFIZniqc/Hwq3kQr9Yfzn0yaDAe9x8frzKp0MDMtlkUWnO8UIMBSG2pCyykc8EWCtT
 v28n0LkCqyYVYjtZ2PgLlsl1VRWVc+6rl4pzb47fa57pBqPaK+GHI1eV8PIGYEupydJy
 UvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695616560; x=1696221360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ZmcynVj4UrxljoR3ZTKSzkktGK3QDrO5FxIGZ6wMgQ=;
 b=dKWNBopexxWTCAgBDdzJclimXbcYRs776eQXKxY1NTWPaRyPBzjTR4h6gGEXtRZv5O
 XcMFEHvwtQVGzhD2XDrj+YNOj13FY0a0SQRLOhcLqLZ6F+87K0nyLbg7AkP41nFKaVN6
 CGdjoZK9cSbVwMaEOi+lVu1dAXZQZ365DXZ5/KVLKl0bfMOiLiOonyN3Ig22djbVf8k8
 BXm3fRaHKxaO5Z2/u8smDhs9K66UTcEDJoS8OZwegNyDuwWMCvJIYL2o1wPwtZgcOa9F
 q2IpZm+TPB918IAYRNScBIpitXahA8MYF7j2+lJSdek21dmzmqRuvb2i74Fn3PuzIpQ7
 1Xiw==
X-Gm-Message-State: AOJu0YxQ+5SGF11d2as2QTXJUgpcxfnUMwgB3DH7r2ZM9Gk1ba8KTX5V
 jSNEyo+f/g4ioeS237VFXvrB4U10iKfAjCwFniE=
X-Google-Smtp-Source: AGHT+IHzOnZTo1Q9v7ns8Z2MfIV7aNBCl1/QrvTEIkdSxqSAGYZT4VT6zMxbz7YtzlNF8HZYD0dd/bLBnejt1jaXbx4=
X-Received: by 2002:a67:e713:0:b0:452:61ef:5542 with SMTP id
 hw19-20020a67e713000000b0045261ef5542mr1120335vsb.3.1695616559977; Sun, 24
 Sep 2023 21:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
In-Reply-To: <ZRCwjGSF//WUPohL@casper.infradead.org>
From: Reuben Hawkins <reubenhwk@gmail.com>
Date: Sun, 24 Sep 2023 23:35:48 -0500
Message-ID: <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
To: Matthew Wilcox <willy@infradead.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgNDo1NuKAr1BNIE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPiB3cm90ZToKCj4gT24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgMDY6MzI6MzBQ
TSArMDMwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4gPiBPbiBTdW4sIFNlcCAyNCwgMjAyMyBh
dCA1OjI34oCvUE0gTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+Cj4gd3JvdGU6
Cj4gPiA+Cj4gPiA+IE9uIFN1biwgU2VwIDI0LCAyMDIzIGF0IDAyOjQ3OjQyUE0gKzAzMDAsIEFt
aXIgR29sZHN0ZWluIHdyb3RlOgo+ID4gPiA+IFNpbmNlIHlvdSBqb2luZWQgdGhlIGRpc2N1c3Np
b24sIHlvdSBoYXZlIHRoZSBvcHBvcnR1bml0eSB0byBhZ3JlZSBvcgo+ID4gPiA+IGRpc2FncmVl
IHdpdGggb3VyIGRlY2lzaW9uIHRvIGNoYW5nZSByZWFkYWhlYWQoKSB0byBFU1BJUEUuCj4gPiA+
ID4gSnVkZ2luZyAgYnkgeW91ciBjaXRpbmcgb2YgbHNlZWsgYW5kIHBvc2l4X2ZhZHZpc2Ugc3Rh
bmRhcmQsCj4gPiA+ID4gSSBhc3N1bWUgdGhhdCB5b3Ugd2lsbCBiZSBvbiBib2FyZD8KPiA+ID4K
PiA+ID4gSSdtIGZpbmUgd2l0aCByZXR1cm5pbmcgRVNQSVBFIChpdCdzIGxpa2UgRU5PVFRZIGlu
IGEgc2Vuc2UpLiAgYnV0Cj4gPiA+IHRoYXQncyBub3Qgd2hhdCBrYnVpbGQgcmVwb3J0ZWQ6Cj4g
Pgo+ID4ga2J1aWxkIHJlcG9ydCBpcyBmcm9tIHYxIHBhdGNoIHRoYXQgd2FzIHBvc3RlZCB0byB0
aGUgbGlzdAo+ID4gdGhpcyBpcyBub3QgdGhlIHBhdGNoICh2MikgdGhhdCBpcyBhcHBsaWVkIHRv
IHZmcy5taXNjCj4gPiBhbmQgaGFzIGJlZW4gaW4gbGludXgtbmV4dCBmb3IgYSBmZXcgZGF5cy4K
Pgo+IEFoISAgSSB3YXMgY29uZnVzZWQuCj4KPiA+ID4gSSB0aGluayB0aGF0IHNob3VsZAo+ID4g
PiBhbHNvIHJldHVybiBFU1BJUEUuICBJIHRoaW5rIHBvc2l4X2ZhZHZpc2UoKSBzaG91bGQgcmV0
dXJuIEVTUElQRSBvbiBhCj4gPiA+IHNvY2tldCB0b28sIGJ1dCByZXBvcnRpbmcgYnVncyB0byB0
aGUgQXVzdGluIEdyb3VwIHNlZW1zIHF1aXRlIHBhaW5mdWwuCj4gPiA+IFBlcmhhcHMgc29tZWJv
ZHkgaGFzIGJlZW4gdGhyb3VnaCB0aGlzIHByb2Nlc3MgYW5kIGNhbiBkbyB0aGF0IGZvciB1cz8K
PiA+Cj4gPiBUaGlzIGlzIFJldWJlbidzIGZpcnN0IGtlcm5lbCBwYXRjaC4KPiA+IExldCdzIGFn
cmVlIHRoYXQgY2hhbmdpbmcgdGhlIHN0YW5kYXJkIG9mIHBvc2l4X2ZhZHZpc2UoKSBmb3Igc29j
a2V0IGlzCj4gPiBiZXlvbmQgdGhlIHNjb3BlIG9mIGhpcyBjb250cmlidXRpb24gOikKPgo+IFRo
YW5rIHlvdSBmb3Igc2hlcGhlcmRpbmcgaGlzIGZpcnN0IGNvbnRyaWJ1dGlvbi4gIFVuZm9ydHVu
YXRlbHksIHRoaXMKPiBpcyByYXRoZXIgdGhlIHdheSBvZiBpdCB3aGVuIHlvdSBzdGFydCB0byBw
aWNrIGF0IHNvbWV0aGluZyAuLi4geW91IGZpbmQKPiBtb3JlIHRoaW5ncyB0aGF0IGFyZSBicm9r
ZW4uICBJdCdzIHJhdGhlciB1bnVzdWFsIHRoYXQgdGhpcyBvbmUgdHVybmVkCj4gb3V0IHRvIGJl
ICJUaGUgUE9TSVggc3BlYyBoYXMgYSBkZWZlY3QiIDstKQo+Cj4gQnV0IHllcywgSSdtIGNvbnRl
bnQgd2l0aCB2MiBpZiB2MiBkb2VzIGluIGZhY3QgcmV0dXJuIEVTUElQRSBmb3IKPiByZWFkYWhl
YWQoKSBvbiBhIHNvY2tldC4gIExldCdzIHdhaXQgdG8gZmluZCBvdXQuICBXZSBjYW4gYWRkcmVz
cyB0aGUKPiBQT1NJWCBkZWZlY3QgbGF0ZXIuCj4KClRoZSB2MiBwYXRjaCBkb2VzIE5PVCByZXR1
cm4gRVNQSVBFIG9uIGEgc29ja2V0LiAgSXQgc3VjY2VlZHMuCgpyZWFkYWhlYWQwMS5jOjU0OiBU
SU5GTzogdGVzdF9pbnZhbGlkX2ZkIHBpcGUKcmVhZGFoZWFkMDEuYzo1NjogVEZBSUw6IHJlYWRh
aGVhZChmZFswXSwgMCwgZ2V0cGFnZXNpemUoKSkgZXhwZWN0ZWQKRUlOVkFMOiBFU1BJUEUgKDI5
KQpyZWFkYWhlYWQwMS5jOjYwOiBUSU5GTzogdGVzdF9pbnZhbGlkX2ZkIHNvY2tldApyZWFkYWhl
YWQwMS5jOjYyOiBURkFJTDogcmVhZGFoZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6ZSgpKSBzdWNj
ZWVkZWQKPC0tLS0tLS1oZXJlCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
