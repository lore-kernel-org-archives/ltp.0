Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEA1C282EC
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741619359; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bd9OK9p0bdy00tcfRYh84cVs62eBh+VkIhPw/wKB+ko=;
 b=ngLGaX2l46t9OY8FlSnyh3mSCZ2jikZApg6oko6k6s5I4qFKA5kTSds45vLxOb0G6DHT/
 84Dfv/X1AH+9rnjSzVKhxYILzgW7KXKPt+4I4Syhx+RHb9ykBhFL/BRQCFlkAwV3c59JMTc
 5ETTbqXRwjx8J2rIb7IoFfQ2n64fsf4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DE213CA258
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 16:09:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A5D33C93E6
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 16:08:56 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBA851400BD7
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 16:08:54 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6C4F75C6755
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 15:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A5FC4CEEF
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741619332;
 bh=yACnC19QpgCnPoDYE5Ar+CLW29NLK6jOmQ9puWyFoYc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jHeEklpgdql8nYlIL94+A0iPGtJ8NTPcEleOgHU+kW48aREvU6hIObXBOmTDmoYJu
 2T/thHR17zWX4RPssqz7GpUDjiYoGTddkeDlmfoSg8hY+2NKa8YsiTClxhT4O6aTj3
 RpXgcfa2tOvJcejr/OsTyeXtrfLt3s2iep2z6ktNiwvX217gjsDnPHoJEe3udrQMi6
 Yytya3mMyBPyh/IR3SNEID6ZC3zUPUxwdfI8eCKSkjP/kdeP0oV+Laavi1o0yM1L4q
 vX+DprP0W7o56jvSYLG/XLs9QhQXCGPJ6YrnTVMIF69lU2PWCnh+qeeSMgRgQnk9Hp
 pDV2dDc7yMjBw==
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so37352745e9.3
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 08:08:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXqbc/TzaXaJXCloSXR6k9EiPHpBoqti18GPhuL2894zhyGODz8lHURkii0CT95fB9+gCg=@lists.linux.it
X-Gm-Message-State: AOJu0Yz1uM3vqe/j/gMsxQGq9/rtifHgCMlPJ7FMVJ1B33NeTusBDISU
 4uMdNGrC1ZXrqOgEITuwZNoJme97x3ZIc6N9AHClGj/j8YKaVjFAkPVqi4592nDG5/HvkcHw5qO
 utrl6fVrAi4uKJifQKg6cy5votjk=
X-Google-Smtp-Source: AGHT+IEacNbgd5mz6hRXaFfN2GOtiKwthOtdanAoclDFmDhfAZrPHNQ0SBi49UbjB+2XFGF+S4bOYh8PnOhqK56BA+0=
X-Received: by 2002:a05:600c:4507:b0:43c:f4df:4870 with SMTP id
 5b1f17b1804b1-43cf4df4c44mr29746945e9.25.1741619331348; Mon, 10 Mar 2025
 08:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <202503101538.84c33cd4-lkp@intel.com>
 <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
In-Reply-To: <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
Date: Mon, 10 Mar 2025 08:08:39 -0700
X-Gmail-Original-Message-ID: <CAB=NE6UWzyq+qXhGmpH2-6bePE+Zi=dJjBH7y3HeJnYyh6xvtw@mail.gmail.com>
X-Gm-Features: AQ5f1JpyvAGFqukkKtqO2BKgvSkLUNK6MxJYUCFsx6T4PInm2dsFIGzVoMTSi08
Message-ID: <CAB=NE6UWzyq+qXhGmpH2-6bePE+Zi=dJjBH7y3HeJnYyh6xvtw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linux-next:master] [block/bdev] 47dd675323:
 ltp.ioctl_loop06.fail
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 0day robot <lkp@intel.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-block@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 oe-lkp@lists.linux.dev, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhlcmUncyBhIGZpeCBmb3IgdGhpcyBhbHJlYWR5IGluIG5leHQKCk9uIE1vbiwgTWFyIDEwLCAy
MDI1LCAxOjM24oCvQU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiBIaSwK
Pgo+IFRoZSBpb2N0bF9sb29wMDYgdGVzdCBleHBlY3RzIFBBR0VfU0laRSB0byBiZSB0aGUgdXBw
ZXIgbGltaXQsIGJ1dCB0aGUKPiBrZXJuZWwKPiBub3cgYWxsb3dzIHVwIHRvIDY0SyAoU1pfNjRL
KS4gSWYgUEFHRV9TSVpFIDwgNjRLIChlLmcuLCA0SyBvbiB4ODYpLAo+IHRoZSB0ZXN0IHdyb25n
bHkgYXNzdW1lcyBhbnl0aGluZyBhYm92ZSBQQUdFX1NJWkUgc2hvdWxkIGJlIHJlamVjdGVkLAo+
IGJ1dCB0aGUga2VybmVsIG5vdyBhbGxvd3MgdXAgdG8gNjRLLgo+Cj4gSSBndWVzcyB3ZSBwcm9i
YWJseSBuZWVkIHRvIGFkanVzdCB0ZXN0Y2FzZSB0byBkeW5hbWljYWxseSBkZWZpbmUgYW4KPiBF
WFBFQ1RFRF9NQVhfQkxPQ0tfU0laRSBhY2NvcmRpbmcgdG8ga2VybmVsIHZlcnNpb25zLgo+IEkg
d2lsbCBzZW5kIG91dCBhIHBhdGNoIHRvIExUUCBNTC4KPgo+Cj4KPiBPbiBNb24sIE1hciAxMCwg
MjAyNSBhdCAzOjQx4oCvUE0ga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNv
bT4KPiB3cm90ZToKPgo+Pgo+Pgo+PiBIZWxsbywKPj4KPj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90
aWNlZCAibHRwLmlvY3RsX2xvb3AwNi5mYWlsIiBvbjoKPj4KPj4gY29tbWl0OiA0N2RkNjc1MzIz
MDM4MDNhODdmNDMxOTVlMDg4YjNiNGJjZjA0NTRkICgiYmxvY2svYmRldjogbGlmdCBibG9jawo+
PiBzaXplIHJlc3RyaWN0aW9ucyB0byA2NGsiKQo+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL2Nn
aXQvbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0IG1hc3Rlcgo+Pgo+PiBpbiB0
ZXN0Y2FzZTogbHRwCj4+IHZlcnNpb246IGx0cC14ODZfNjQtMGY5ZDgxN2EzLTFfMjAyNTAyMjIK
Pj4gd2l0aCBmb2xsb3dpbmcgcGFyYW1ldGVyczoKPj4KPj4gICAgICAgICBkaXNrOiAxSERECj4+
ICAgICAgICAgZnM6IHhmcwo+PiAgICAgICAgIHRlc3Q6IHN5c2NhbGxzLTAxL2lvY3RsX2xvb3Aw
Ngo+Pgo+Pgo+Pgo+PiBjb25maWc6IHg4Nl82NC1yaGVsLTkuNC1sdHAKPj4gY29tcGlsZXI6IGdj
Yy0xMgo+PiB0ZXN0IG1hY2hpbmU6IDQgdGhyZWFkcyAxIHNvY2tldHMgSW50ZWwoUikgQ29yZShU
TSkgaTMtMzIyMCBDUFUgQCAzLjMwR0h6Cj4+IChJdnkgQnJpZGdlKSB3aXRoIDhHIG1lbW9yeQo+
Pgo+PiAocGxlYXNlIHJlZmVyIHRvIGF0dGFjaGVkIGRtZXNnL2ttc2cgZm9yIGVudGlyZSBsb2cv
YmFja3RyYWNlKQo+Pgo+Pgo+Pgo+Pgo+PiBJZiB5b3UgZml4IHRoZSBpc3N1ZSBpbiBhIHNlcGFy
YXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldwo+PiB2ZXJzaW9uIG9mCj4+IHRo
ZSBzYW1lIHBhdGNoL2NvbW1pdCksIGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MKPj4gfCBSZXBv
cnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+Cj4+IHwgQ2xvc2VzOgo+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1sa3AvMjAyNTAzMTAxNTM4Ljg0YzMzY2Q0LWxr
cEBpbnRlbC5jb20KPj4KPj4KPj4gUnVubmluZyB0ZXN0cy4uLi4uLi4KPj4gPDw8dGVzdF9zdGFy
dD4+Pgo+PiB0YWc9aW9jdGxfbG9vcDA2IHN0aW1lPTE3NDEzMjIzODgKPj4gY21kbGluZT0iaW9j
dGxfbG9vcDA2Igo+PiBjb250YWN0cz0iIgo+PiBhbmFseXNpcz1leGl0Cj4+IDw8PHRlc3Rfb3V0
cHV0Pj4+Cj4+IHRzdF90bXBkaXIuYzozMTY6IFRJTkZPOiBVc2luZwo+PiAvZnMvc2RhMi90bXBk
aXIvbHRwLWY1dUVDMVRIVm0vTFRQX2lvY2JCeWNwaiBhcyB0bXBkaXIgKHhmcyBmaWxlc3lzdGVt
KQo+PiB0c3RfdGVzdC5jOjE5MDA6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMTE4LWcw
ZjlkODE3YTMKPj4gdHN0X3Rlc3QuYzoxOTA0OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi4xNC4w
LXJjMS0wMDAwNy1nNDdkZDY3NTMyMzAzICMxCj4+IFNNUCBQUkVFTVBUX0RZTkFNSUMgRnJpIE1h
ciAgNyAxMToyNTo1MCBDU1QgMjAyNSB4ODZfNjQKPj4gdHN0X2tjb25maWcuYzo4ODogVElORk86
IFBhcnNpbmcga2VybmVsIGNvbmZpZyAnL3Byb2MvY29uZmlnLmd6Jwo+PiB0c3Rfa2NvbmZpZy5j
OjY3NjogVElORk86IENPTkZJR19LQVNBTiBrZXJuZWwgb3B0aW9uIGRldGVjdGVkIHdoaWNoIG1p
Z2h0Cj4+IHNsb3cgdGhlIGV4ZWN1dGlvbgo+PiB0c3RfdGVzdC5jOjE3MjI6IFRJTkZPOiBPdmVy
YWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAxMG0gMDBzCj4+IHRzdF9kZXZpY2UuYzo5NzogVElO
Rk86IEZvdW5kIGZyZWUgZGV2aWNlIDAgJy9kZXYvbG9vcDAnCj4+IGlvY3RsX2xvb3AwNi5jOjc0
OiBUSU5GTzogVXNpbmcgTE9PUF9TRVRfQkxPQ0tfU0laRSB3aXRoIGFyZyA8IDUxMgo+PiBpb2N0
bF9sb29wMDYuYzo2NTogVFBBU1M6IFNldCBibG9jayBzaXplIGZhaWxlZCBhcyBleHBlY3RlZDog
RUlOVkFMICgyMikKPj4gaW9jdGxfbG9vcDA2LmM6NzQ6IFRJTkZPOiBVc2luZyBMT09QX1NFVF9C
TE9DS19TSVpFIHdpdGggYXJnID4gUEFHRV9TSVpFCj4+IGlvY3RsX2xvb3AwNi5jOjU3OiBURkFJ
TDogU2V0IGJsb2NrIHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPj4gaW9jdGxfbG9vcDA2LmM6
NzQ6IFRJTkZPOiBVc2luZyBMT09QX1NFVF9CTE9DS19TSVpFIHdpdGggYXJnICE9IHBvd2VyX29m
XzIKPj4gaW9jdGxfbG9vcDA2LmM6NjU6IFRQQVNTOiBTZXQgYmxvY2sgc2l6ZSBmYWlsZWQgYXMg
ZXhwZWN0ZWQ6IEVJTlZBTCAoMjIpCj4+IGlvY3RsX2xvb3AwNi5jOjc0OiBUSU5GTzogVXNpbmcg
TE9PUF9DT05GSUdVUkUgd2l0aCBibG9ja19zaXplIDwgNTEyCj4+IGlvY3RsX2xvb3AwNi5jOjY1
OiBUUEFTUzogU2V0IGJsb2NrIHNpemUgZmFpbGVkIGFzIGV4cGVjdGVkOiBFSU5WQUwgKDIyKQo+
PiBpb2N0bF9sb29wMDYuYzo3NDogVElORk86IFVzaW5nIExPT1BfQ09ORklHVVJFIHdpdGggYmxv
Y2tfc2l6ZSA+IFBBR0VfU0laRQo+PiBpb2N0bF9sb29wMDYuYzo1NzogVEZBSUw6IFNldCBibG9j
ayBzaXplIHN1Y2NlZWQgdW5leHBlY3RlZGx5Cj4+IGlvY3RsX2xvb3AwNi5jOjc0OiBUSU5GTzog
VXNpbmcgTE9PUF9DT05GSUdVUkUgd2l0aCBibG9ja19zaXplICE9Cj4+IHBvd2VyX29mXzIKPj4g
aW9jdGxfbG9vcDA2LmM6NjU6IFRQQVNTOiBTZXQgYmxvY2sgc2l6ZSBmYWlsZWQgYXMgZXhwZWN0
ZWQ6IEVJTlZBTCAoMjIpCj4+Cj4+IFN1bW1hcnk6Cj4+IHBhc3NlZCAgIDQKPj4gZmFpbGVkICAg
Mgo+PiBicm9rZW4gICAwCj4+IHNraXBwZWQgIDAKPj4gd2FybmluZ3MgMAo+PiBpbmNyZW1lbnRp
bmcgc3RvcAo+PiA8PDxleGVjdXRpb25fc3RhdHVzPj4+Cj4+IGluaXRpYXRpb25fc3RhdHVzPSJv
ayIKPj4gZHVyYXRpb249MSB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlvbl9pZD0x
IGNvcmVmaWxlPW5vCj4+IGN1dGltZT0wIGNzdGltZT02Cj4+IDw8PHRlc3RfZW5kPj4+Cj4+IElO
Rk86IGx0cC1wYW4gcmVwb3J0ZWQgc29tZSB0ZXN0cyBGQUlMCj4+IExUUCBWZXJzaW9uOiAyMDI1
MDEzMC0xMTgtZzBmOWQ4MTdhMwo+Pgo+PiAgICAgICAgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCj4+Cj4+ICAgICAgICAgICAg
IERvbmUgZXhlY3V0aW5nIHRlc3RjYXNlcy4KPj4gICAgICAgICAgICAgTFRQIFZlcnNpb246ICAy
MDI1MDEzMC0xMTgtZzBmOWQ4MTdhMwo+PiAgICAgICAgIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCj4+Cj4+Cj4+Cj4+Cj4+IFRo
ZSBrZXJuZWwgY29uZmlnIGFuZCBtYXRlcmlhbHMgdG8gcmVwcm9kdWNlIGFyZSBhdmFpbGFibGUg
YXQ6Cj4+Cj4+IGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI1MDMx
MC8yMDI1MDMxMDE1MzguODRjMzNjZDQtbGtwQGludGVsLmNvbQo+Pgo+Pgo+Pgo+PiAtLQo+PiAw
LURBWSBDSSBLZXJuZWwgVGVzdCBTZXJ2aWNlCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9s
a3AtdGVzdHMvd2lraQo+Pgo+Pgo+PiAtLQo+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPj4KPj4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBX
YW5nCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
