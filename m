Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C161E8181B
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 05:35:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8E333CBBC3
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 07:35:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBBE53C88C8
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 07:34:52 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1684A100046D
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 07:34:47 +0200 (CEST)
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4526ae5b0b3so3276034137.2
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 22:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695706485; x=1696311285; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSkbghx5rrzjOMhhAlkPeMs9G2sVzf6qQF2DH4QfBao=;
 b=csuMkdb5mXo9CUMWmX6ZIbFijxYllTH6M3MB3V6ukYb9kW3gCFhHkvOmCTdaR98wy1
 SDxpptIFNV3mozYuVsSWyl4v1irvak/QgvthDvt2RTMBBsxyA1sQax3G17FebuJPC3+5
 NPzHzAjor9PmykhMlV0nCUUGO7uAFwfJUW7FMTTn3lZVDc/UlFBZqYWE2zvvjuTzR2un
 e8xbzC9FbDJvuQ8/RyHQu8SShlVXaNCSNCJWMzoJb4KGo1Bj1dNU89+6ikbCUqzfSS5N
 UsgoCUjcQbGrPl0m6QilIxrhcruOL3Ib4T2/jCEeQPWqw6idHjuwbGtIsADRMm9GHor1
 0m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695706485; x=1696311285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSkbghx5rrzjOMhhAlkPeMs9G2sVzf6qQF2DH4QfBao=;
 b=o0Rs8zyyb6s690O0w2cLJJMexHJfPSL1f7vPgHOfbrQkf7je98+6x3MeC7Wj1Yxbwq
 Quu9RW+46x8zT/tvJkNWo3sivdhLOUVpVin2/EZ2byjoGpXyOWufO3kN5vhe/7qezr+A
 6H3ftreZdd2TaVsxbX9h3Pi0wPiPcuPUo00qOXHF1Dqzs1n+1RIPL/idFzQ+mQIU/JXD
 xulHvP6+mIquIEppoAz+ZBKQODGPIdZluSY4WLUKZnEDZ7eWeJX1XSaiPNgxGViiBPWQ
 X2NCSpeGGineXqA32z8hl+9m30zJWHg8PC3+7FBEF7sK4+H3r2CkSzM6LHExrir+HjXe
 sSIQ==
X-Gm-Message-State: AOJu0YwAGsN9pYCIH0+BcnAt1goAt+UjvzsMlb2+ObLvkJneQ2FazsiF
 +dFpmAS3AiVBkiBjynjDC9GILMAqoBRfKUTJEkQ=
X-Google-Smtp-Source: AGHT+IHTDW6g2Tc/NjDzsxfrnkbQgYGREbZGtPAwsFltUq/iWFHSo9kGF9e0kVp3kKTZXnUIgmPl3AIMzTNYCOHJpPo=
X-Received: by 2002:a67:fa10:0:b0:452:6366:b0ed with SMTP id
 i16-20020a67fa10000000b004526366b0edmr6080464vsq.13.1695706485364; Mon, 25
 Sep 2023 22:34:45 -0700 (PDT)
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
 <ZRI6MsKeEgDnsyTo@xsang-OptiPlex-9020>
In-Reply-To: <ZRI6MsKeEgDnsyTo@xsang-OptiPlex-9020>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 Sep 2023 08:34:34 +0300
Message-ID: <CAOQ4uxgjnMZQOwOzzi6XH4eFn+UoHQ3cq5CYGjqbHOE0BZRG8g@mail.gmail.com>
To: Oliver Sang <oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
 lkp@intel.com, Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 Reuben Hawkins <reubenhwk@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgNDo1NuKAr0FNIE9saXZlciBTYW5nIDxvbGl2ZXIuc2Fu
Z0BpbnRlbC5jb20+IHdyb3RlOgo+Cj4gaGkgQW1pciwKPgo+IE9uIFN1biwgU2VwIDI0LCAyMDIz
IGF0IDA2OjMyOjMwUE0gKzAzMDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+ID4gT24gU3VuLCBT
ZXAgMjQsIDIwMjMgYXQgNToyN+KAr1BNIE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQu
b3JnPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgMDI6NDc6NDJQ
TSArMDMwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4gPiA+ID4gU2luY2UgeW91IGpvaW5lZCB0
aGUgZGlzY3Vzc2lvbiwgeW91IGhhdmUgdGhlIG9wcG9ydHVuaXR5IHRvIGFncmVlIG9yCj4gPiA+
ID4gZGlzYWdyZWUgd2l0aCBvdXIgZGVjaXNpb24gdG8gY2hhbmdlIHJlYWRhaGVhZCgpIHRvIEVT
UElQRS4KPiA+ID4gPiBKdWRnaW5nICBieSB5b3VyIGNpdGluZyBvZiBsc2VlayBhbmQgcG9zaXhf
ZmFkdmlzZSBzdGFuZGFyZCwKPiA+ID4gPiBJIGFzc3VtZSB0aGF0IHlvdSB3aWxsIGJlIG9uIGJv
YXJkPwo+ID4gPgo+ID4gPiBJJ20gZmluZSB3aXRoIHJldHVybmluZyBFU1BJUEUgKGl0J3MgbGlr
ZSBFTk9UVFkgaW4gYSBzZW5zZSkuICBidXQKPiA+ID4gdGhhdCdzIG5vdCB3aGF0IGtidWlsZCBy
ZXBvcnRlZDoKPiA+Cj4gPiBrYnVpbGQgcmVwb3J0IGlzIGZyb20gdjEgcGF0Y2ggdGhhdCB3YXMg
cG9zdGVkIHRvIHRoZSBsaXN0Cj4gPiB0aGlzIGlzIG5vdCB0aGUgcGF0Y2ggKHYyKSB0aGF0IGlz
IGFwcGxpZWQgdG8gdmZzLm1pc2MKPiA+IGFuZCBoYXMgYmVlbiBpbiBsaW51eC1uZXh0IGZvciBh
IGZldyBkYXlzLgo+ID4KPiA+IE9saXZlciwKPiA+Cj4gPiBDYW4geW91IHNheSB0aGUgZmFpbHVy
ZSAob24gc29ja2V0KSBpcyByZXByb2R1Y2VkIG9uCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC92ZnMvdmZzLmdpdCB2ZnMubWlzYz8KPiA+Cj4gPiBJ
IHdvdWxkIGV4cGVjdCB0aGUgcGlwZSB0ZXN0IHRvIGZhaWwgZm9yIGdldHRpbmcgRVNQSVBFCj4g
PiBidXQgYWNjb3JkaW5nIHRvIFJldWJlbiB0aGUgc29ja2V0IHRlc3QgZG9lcyBub3QgZmFpbC4K
Pgo+IEkgdGVzdGVkIG9uIHRoaXMgY29tbWl0Ogo+IDE1ZDQwMDBiOTM1MzkgKGJyYXVuZXItdmZz
L3Zmcy5taXNjKSB2ZnM6IGZpeCByZWFkYWhlYWQoMikgb24gYmxvY2sgZGV2aWNlcwo+Cj4gYmVs
b3cgaXMgdGhlIHRlc3Qgb3V0cHV0Ogo+Cj4gPDw8dGVzdF9vdXRwdXQ+Pj4KPiB0c3RfdGVzdC5j
OjE1NTg6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDJtIDMwcwo+IHJlYWRhaGVhZDAx
LmM6MzY6IFRJTkZPOiB0ZXN0X2JhZF9mZCAtMQo+IHJlYWRhaGVhZDAxLmM6Mzc6IFRQQVNTOiBy
ZWFkYWhlYWQoLTEsIDAsIGdldHBhZ2VzaXplKCkpIDogRUJBREYgKDkpCj4gcmVhZGFoZWFkMDEu
YzozOTogVElORk86IHRlc3RfYmFkX2ZkIE9fV1JPTkxZCj4gcmVhZGFoZWFkMDEuYzo0NTogVFBB
U1M6IHJlYWRhaGVhZChmZCwgMCwgZ2V0cGFnZXNpemUoKSkgOiBFQkFERiAoOSkKPiByZWFkYWhl
YWQwMS5jOjU0OiBUSU5GTzogdGVzdF9pbnZhbGlkX2ZkIHBpcGUKPiByZWFkYWhlYWQwMS5jOjU2
OiBURkFJTDogcmVhZGFoZWFkKGZkWzBdLCAwLCBnZXRwYWdlc2l6ZSgpKSBleHBlY3RlZCBFSU5W
QUw6IEVTUElQRSAoMjkpCj4gcmVhZGFoZWFkMDEuYzo2MDogVElORk86IHRlc3RfaW52YWxpZF9m
ZCBzb2NrZXQKPiByZWFkYWhlYWQwMS5jOjYyOiBURkFJTDogcmVhZGFoZWFkKGZkWzBdLCAwLCBn
ZXRwYWdlc2l6ZSgpKSBzdWNjZWVkZWQKPgo+IFN1bW1hcnk6Cj4gcGFzc2VkICAgMgo+IGZhaWxl
ZCAgIDIKPiBicm9rZW4gICAwCj4gc2tpcHBlZCAgMAo+IHdhcm5pbmdzIDAKPgo+CgpUaGFuayB5
b3UhCldlIGhhZCBzb21lIGNvbmZ1c2lvbiBhYm91dCBwYXRjaCBvZiByZXBvcnRlZCBidWcgdnMu
IGN1cnJlbnQgcGF0Y2gsCmJ1dCB0aGVzZSByZXN1bHRzIGFyZSBtYXRjaGluZyB0aGUgb3RoZXIg
cmVwb3J0cyB3cnQgY3VycmVudCBwYXRjaC4KCgo+IEJUVywgSSBub3RpY2VkIHRoZSBicmFuY2gg
dXBkYXRlZCwgbm93Ogo+IGU5MTY4YjY4MDBlY2QgKGJyYXVuZXItdmZzL3Zmcy5taXNjKSB2ZnM6
IGZpeCByZWFkYWhlYWQoMikgb24gYmxvY2sgZGV2aWNlcwo+Cj4gdGhvdWdoIHRoZSBwYXRjaC1p
ZCBhcmUgc2FtZS4gZG8geW91IHdhbnQgdXMgdG8gdGVzdCBpdCBhZ2Fpbj8KPgoKSXQncyB0aGUg
c2FtZSBwYXRjaC4gbm8gbmVlZCB0byByZS10ZXN0LgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
