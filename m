Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18889C77B7C
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 12:20:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEB9D3CE05C
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 14:20:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC7C43CB4A5
 for <ltp@lists.linux.it>; Thu, 11 May 2023 14:20:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E6CF66007B2
 for <ltp@lists.linux.it>; Thu, 11 May 2023 14:20:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683807607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npe7GIAUyRZvRRhyssxbgR8hUUIN9mtyJ7+y8imruS8=;
 b=b8SBgUUu8/Y4ywsUvsIfXv1fmuDCxxJzmPPEbVWZjQ9/cAGa49tEvriY+eueSaYLPaDD1B
 7YTXZZhmT4u8vSjbDKmc1gxxB4pUkSNk2SS7+Ujxwrd65uH5kVvrs6kGce4lYfVBqM80bn
 bHBIbqsebgC5dy3n5GZYxvLOFK4nP7o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-IJiyLzaVNyCzrqQWd5CCjw-1; Thu, 11 May 2023 08:20:05 -0400
X-MC-Unique: IJiyLzaVNyCzrqQWd5CCjw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2adaf72737eso11036161fa.0
 for <ltp@lists.linux.it>; Thu, 11 May 2023 05:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683807604; x=1686399604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=npe7GIAUyRZvRRhyssxbgR8hUUIN9mtyJ7+y8imruS8=;
 b=GT/IVi/iL4Wa/4jScSJ4lFL/2GwRw9A2PW6vYH1rpzQ+s3nYljdzxeiCZRQKXfadRQ
 uslEAcVJPWhNMIlG8aHC5ALtURYmP5lXzbw6ZvAsSp9aE4hXleRFWUO1mK4I6bMjcuYg
 NQqYmZEGZSNBA1v6nghEbopTu1yKyn0bUND5BEaD+xIvPEQ+wYBwQA4cP36XX9T+MPXq
 3y3uYgGUiLx6K+hxDSypngIa8JgelItaL22l9zOz6B2k3lC9KBwdnyxr/q+CNEJTsnCa
 KZSB602nSuLU4WiSCpYsw4b8BaoOJTSG336pQR8ZTsan+TbneYaPpxfCxbS87hRFjUrY
 NWpw==
X-Gm-Message-State: AC+VfDxMD2zp8XraVX9J2bjj7acHvlzr/TfPSB7ot9rYJavg7k15GuA/
 6j8jFn2X6uexcclqf09mHjrrfWRfMwoL3djXDxYUSsqzzyNFuYRBMxMO0AYoqw47cXfV2oWTHdK
 8lfwfkOu0IoGgn94GCEkAhva4YAo=
X-Received: by 2002:a2e:9d03:0:b0:2a7:a616:c39 with SMTP id
 t3-20020a2e9d03000000b002a7a6160c39mr3064815lji.48.1683807604045; 
 Thu, 11 May 2023 05:20:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UBhbHXtxXNcPtjWONJTVqEsrO0NXmMNTWKsks0zOUN3luk+2zRpUCqDhUTnTn2c73p2A25wRpRQx7SykAvBs=
X-Received: by 2002:a2e:9d03:0:b0:2a7:a616:c39 with SMTP id
 t3-20020a2e9d03000000b002a7a6160c39mr3064808lji.48.1683807603695; Thu, 11 May
 2023 05:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230508134903.83591-1-liwang@redhat.com>
 <cdd66dfb-b9a1-2a58-abe0-895def28d2ed@suse.cz>
In-Reply-To: <cdd66dfb-b9a1-2a58-abe0-895def28d2ed@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 May 2023 20:19:51 +0800
Message-ID: <CAEemH2dRVgPxw0TV40M_xgbwPezR1eehooV9ksazbATrPpBqAA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugemmap32: guarantee enough memory for gigantic
 hugepage
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXkgMTEsIDIwMjMgYXQgNzoxMOKAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpLAo+Cj4gT24gMDguIDA1LiAyMyAxNTo0OSwgTGkgV2FuZyB3
cm90ZToKPiA+ICAgIFRvIGdldCByaWQgb2Ygd2FybmluZyBvbiBwcGM2NGxlOgo+ID4KPiA+ICAg
ICAgaHVnZW1tYXAzMi5jOjM0OiBUV0FSTjogRmFpbGVkIHRvIGNsb3NlIEZJTEUKPiA+ICAgICAg
ICAgICAnL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xNjc3NzIxNmtCL25yX2h1
Z2VwYWdlcycKPiA+ICAgICAgaHVnZW1tYXAzMi5jOjM1OiBUQ09ORjogQ2FuJ3QgdXBkYXRlIHRo
ZSBnaWdhbnRpYyBodWdlcGFnZXMuCj4gPiAgICAgIGh1Z2VtbWFwMzIuYzo2OTogVFdBUk46IEZh
aWxlZCB0byBjbG9zZSBGSUxFCj4gPiAgICAgICAgICAgJy9zeXMva2VybmVsL21tL2h1Z2VwYWdl
cy9odWdlcGFnZXMtMTY3NzcyMTZrQi9ucl9odWdlcGFnZXMnOgo+IEVJTlZBTCAoMjIpCj4gPgo+
ID4gICAgIyBsbCAvc3lzL2tlcm5lbC9tbS9odWdlcGFnZXMvCj4gPiAgICB0b3RhbCAwCj4gPiAg
ICBkcnd4ci14ci14LiAyIHJvb3Qgcm9vdCAwIE1heSAgNCAwMjowMiBodWdlcGFnZXMtMTYzODRr
Qgo+ID4gICAgZHJ3eHIteHIteC4gMiByb290IHJvb3QgMCBNYXkgIDQgMDI6MDIgaHVnZXBhZ2Vz
LTE2Nzc3MjE2a0IKPiA+Cj4gPiAgICAjIGNhdCAvcHJvYy9tZW1pbmZvIHwgZ3JlcCAtaSBIdWdl
cGFnZXNpemUKPiA+ICAgIEh1Z2VwYWdlc2l6ZTogICAgICAxNjM4NCBrQgo+ID4KPiA+ICAgICMg
ZnJlZSAtaAo+ID4gICAgICAgICAgICAgICAgICAgdG90YWwgICAgICAgIHVzZWQgICAgICAgIGZy
ZWUgICAgICBzaGFyZWQgIGJ1ZmYvY2FjaGUKPiAgYXZhaWxhYmxlCj4gPiAgICBNZW06ICAgICAg
ICAgICA3LjRHaSAgICAgICAxLjFHaSAgICAgICA5OTJNaSAgICAgICAgMTNNaSAgICAgICA1LjlH
aQo+ICAgICAgNi4zR2kKPiA+ICAgIFN3YXA6ICAgICAgICAgIDQuMEdpICAgICAgICAgIDBCICAg
ICAgIDQuMEdpCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+Cj4gPiAtLS0KPiA+ICAgdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9o
dWdlbW1hcDMyLmMgfCA2ICsrKysrKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZW1tYXAvaHVnZW1tYXAzMi5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2Vt
bWFwL2h1Z2VtbWFwMzIuYwo+ID4gaW5kZXggMzRiMzIyYmZhLi43ZmYyM2IyMzYgMTAwNjQ0Cj4g
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzIu
Ywo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1h
cDMyLmMKPiA+IEBAIC02MCw2ICs2MCwxMiBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ID4g
ICAgICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAiR2lnYW50aWMgaHVnZXBhZ2VzIG5vdCBzdXBw
b3J0ZWQiKTsKPiA+Cj4gPiAgICAgICBTQUZFX0NMT1NFRElSKGRpcik7Cj4gPiArCj4gPiArICAg
ICBpZiAodHN0X2F2YWlsYWJsZV9tZW0oKSA8IChsb25nIGxvbmcpaHBhZ2Vfc2l6ZSkgewo+ID4g
KyAgICAgICAgICAgICBnX2hwYWdlX3BhdGhbMF0gPSAnXDAnOwo+ID4gKyAgICAgICAgICAgICB0
c3RfYnJrKFRDT05GLCAiTm8gZW5vdWdoIG1lbW9yeSBmb3IgZ2lnYW50aWMgaHVnZXBhZ2UKPiBy
ZXNlcnZpbmciKTsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICAgICAgIFNBRkVfRklMRV9MSU5FU19T
Q0FORihnX2hwYWdlX3BhdGgsICIlZCIsICZvcmdfZ19ocGFnZXMpOwo+ID4gICB9Cj4KPiBJIGFs
c28gcmVjb21tZW5kIGNhbGxpbmcKPiBTQUZFX0ZJTEVfUFJJTlRGKCIvcHJvYy9zeXMvdm0vZHJv
cF9jYWNoZXMiLCAiMyIpOwo+Cj4gSXQgZG9lc24ndCB3aGV0aGVyIHlvdSBkbyBpdCBiZWZvcmUg
b3IgYWZ0ZXIgdHN0X2F2YWlsYWJsZV9tZW0oKSBzaW5jZQo+IGNhY2hlcyBjb3VudCBhcyBhdmFp
bGFibGUuCj4KCkdvb2QgcG9pbnQsIGNvdWxkIHlvdSBzZW5kIGEgcGF0Y2ggb3IgZGVsYXkgdGhp
cyB3b3JrIGFmdGVyIHJlbGVhc2UgYXMgd2VsbD8KCgoKPgo+IC0tCj4gTWFydGluIERvdWNoYSAg
IG1kb3VjaGFAc3VzZS5jego+IFFBIEVuZ2luZWVyIGZvciBTb2Z0d2FyZSBNYWludGVuYW5jZQo+
IFNVU0UgTElOVVgsIHMuci5vLgo+IENPUlNPIElJYQo+IEtyaXppa292YSAxNDgvMzQKPiAxODYg
MDAgUHJhZ3VlIDgKPiBDemVjaCBSZXB1YmxpYwo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
