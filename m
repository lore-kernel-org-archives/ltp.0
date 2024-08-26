Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519BDC5321E
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 13:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91FE33D2731
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 15:32:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83393C7F5D
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:31:52 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 666F01000D3E
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724679109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5cGox3Aq0B8sRuCCbXOy9MFgxEPuhWinwvN0f8/Ey3o=;
 b=Q/h4CwXb9Hd9mfH+6qDto6XYPvmK992dR1Nv87JZaTQpbnt8IsYs6y0ypFywlPvGLBfRf6
 WnkC9NVyv7TNr+YXXs5uDPXhmMDPn64BhDbNo45YGW5OS67hwsVAm/+udQu7PdNlsdR7UO
 WQepjP+QqF6PiHKXMxbMKdySh8zk27k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-3JMnkf1lPOa8Gusg3ZDlaw-1; Mon, 26 Aug 2024 09:31:47 -0400
X-MC-Unique: 3JMnkf1lPOa8Gusg3ZDlaw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d3cd20b25cso5748980a91.1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 06:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724679106; x=1725283906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cGox3Aq0B8sRuCCbXOy9MFgxEPuhWinwvN0f8/Ey3o=;
 b=mRt+gctGplrsQ8iq4qokk2h6yk6PAewedcRJzPXiWBYwaUWu3jz18t8PBRHv3vk73T
 Kpkq0SsrZVTQwOV3Aq87LnDvp5iJ49D+JxL3AcPXxEJedNxdOGKoILP7D9Vvbj2MqrTY
 MNZB8mK3HHklByObsF2zSKL03hq7qOfJCaDNaaSab4yZxIFk4SwPF+rfRgOIWI2oQKdy
 gfdxt21duIZmqOf0i/GeXDrUQj/Ialz8aVdaQ2fe6zE7vDp6pf2RTbxzNqyuHb9ajpZG
 NcyLuXKnSm27oi8j2ShuAxlrP1snT/KIF0IanAws+JwI31BgvGvQm5xcJlLx4xxT1WhD
 LEBw==
X-Gm-Message-State: AOJu0YxN05fqop4azMauKaIdPulfQLvtEOkaDhSn8g49ns/Zv+j8wq0i
 CaUT3GWB+isDPkYU/v37n8ptaZ0YZVbLKOSVBICSXh/TF4C+HtjQh+PjupLskcIzhVbFFQyASi2
 R2M/vKJRehaP/wm4oriXEvi2eHUk1/0QPaHcRP7XAU1uWZkOe91aUEwqdV/LgYulSLn86PHGOhW
 3p8C4vbwncSuHD+fJASxS0g9M=
X-Received: by 2002:a17:90a:bf0d:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2d646d5fa1amr10464925a91.35.1724679106228; 
 Mon, 26 Aug 2024 06:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE//ETY9o/TsXIyyuQscSPzDoGAaL0jBbSqd18u30dARfgv2xyufjFm3Hrfu3sjtrpwFpOZFrH0MIzyAXs4Rkg=
X-Received: by 2002:a17:90a:bf0d:b0:2c9:6d07:18f4 with SMTP id
 98e67ed59e1d1-2d646d5fa1amr10464885a91.35.1724679105707; Mon, 26 Aug 2024
 06:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240826120205.5506-1-liwang@redhat.com>
 <CAEemH2dYB3tyG4xjE_b1rGBRqtCDOwByq5ZdA0VUxvL3nqW0Vw@mail.gmail.com>
 <CAASaF6xh7_wXiFn9LakEv-LY-szkZ+5fJ0B67ygdCV0g4T-89Q@mail.gmail.com>
 <CAEemH2eBjOmLL-=zVFhoQiJXVDU0h1WThu5AP_Wf5S51RAtx7w@mail.gmail.com>
In-Reply-To: <CAEemH2eBjOmLL-=zVFhoQiJXVDU0h1WThu5AP_Wf5S51RAtx7w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Aug 2024 21:31:33 +0800
Message-ID: <CAEemH2cR4nz8nqD3C9-tTXJC=3XTGX6+SO6aRscWefw8Qzi0_g@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ioctl_loop06: no validate block size
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
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Garry <john.g.garry@oracle.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgOToyMeKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0IDk6MTXigK9QTSBKYW4g
U3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPj4gT24gTW9uLCBBdWcgMjYs
IDIwMjQgYXQgMjo0NuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4g
Pgo+PiA+IEhpIEFsbCwKPj4gPgo+PiA+IE9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0IDg6MDLigK9Q
TSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+ID4KPj4gPiA+IFNpbmNlIGNv
bW1pdCA5NDIzYzY1M2ZlNjExMCAoImxvb3A6IERvbid0IGJvdGhlciB2YWxpZGF0aW5nCj4+IGJs
b2Nrc2l6ZSIpCj4+ID4gPiBrZXJuZWwKPj4gPiA+IGRyb3AgdmFsaWRhdGluZyBibG9ja3NpemUg
Zm9yIGJvdGggbG9vcF9jb25maWd1cmUgYW5kCj4+IGxvb3Bfc2V0X2Jsb2NrX3NpemUKPj4gPiA+
IHNvCj4+ID4gPiB0aGF0IHNldCBsYXJnZSBibG9jayBzaXplIHN1Y2NlZWRzLgo+PiA+ID4KPj4g
PiA+IEVycm9yIGxvZzoKPj4gPiA+ICAgMTIgaW9jdGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBVc2lu
ZyBMT09QX1NFVF9CTE9DS19TSVpFIHdpdGggYXJnID4KPj4gPiA+IFBBR0VfU0laRQo+PiA+ID4g
ICAxMyBpb2N0bF9sb29wMDYuYzo1OTogVEZBSUw6IFNldCBibG9jayBzaXplIHN1Y2NlZWQgdW5l
eHBlY3RlZGx5Cj4+ID4gPiAgIC4uLgo+PiA+ID4gICAxOCBpb2N0bF9sb29wMDYuYzo3NjogVElO
Rk86IFVzaW5nIExPT1BfQ09ORklHVVJFIHdpdGggYmxvY2tfc2l6ZSA+Cj4+ID4gPiBQQUdFX1NJ
WkUKPj4gPiA+ICAgMTkgaW9jdGxfbG9vcDA2LmM6NTk6ICBURkFJTDogU2V0IGJsb2NrIHNpemUg
c3VjY2VlZCB1bmV4cGVjdGVkbHkKPj4gPiA+Cj4+ID4KPj4gPiBIbW0sIG1heWJlIEkgd2FzIHdy
b25nIGhlcmUsIHRoZSBjb21taXQgc2F5cwo+PiA+Cj4+ID4gICAiVGhlIGJsb2NrIHF1ZXVlIGxp
bWl0cyB2YWxpZGF0aW9uIGRvZXMgdGhpcyBmb3IgdXMgbm93LiIKPj4gPgo+PiA+IHdoaWNoIGlu
ZGljYXRlcyB0aGUgdmFsaWRhdGlvbiBpcyBzdGlsbCBvbi4KPj4gPgo+PiA+IFNvIHRoZSB0ZXN0
IGZhaWx1cmUgcHJvYmFibHkgbWVhbnMgYSBrZXJuZWwgYnVnIGJ1dCBub3QgYSB0ZXN0IHByb2Js
ZW0uCj4+Cj4+IEJlZm9yZSB0aGUgcGF0Y2gsIGJsa192YWxpZGF0ZV9ibG9ja19zaXplKCkgZGlk
IHZhbGlkYXRlIG9yaWdpbmFsCj4+IHZhbHVlIGFzIHVuc2lnbmVkIGxvbmcsCj4+IGFmdGVyIHBh
dGNoIGl0J3MgdmFsaWRhdGVkIGFmdGVyIGNhc3QgdG8gdW5zaWduZWQgc2hvcnQuCj4+Cj4+IElu
IExUUCB0aHJlYWQgeW91IG1lbnRpb25lZCBpdCBmYWlsZWQgb24gcHBjNjRsZS9hYXJjaDY0IGFu
ZCB3b3JrZWQgb24KPj4geDg2XzY0IGFuZCBzMzkweC4KPj4gSXMgaXQgYnkgY2hhbmNlIG5vdyBm
YWlsaW5nIG9ubHkgb24ga2VybmVscyB3aXRoIDY0ayBwYWdlIHNpemU/Cj4+Cj4KPiBSaWdodCwg
SSBjaGVja2VkIHRoZSBhdXRvbWF0aW9uIGpvYnMsIGFsbCByZWNlbnQgKHY2LjExKQo+IGFhcmNo
NjQta2VybmVsLTY0ayByZXBvcnRzIHRoYXQgZmFpbC4KPgoKQW5kIEkgdmVyaWZpZWQgeW91ciBp
bmZlcmVuY2UuIE9uY2UgSSBsb3dlciB0aGUgaW52YWxpZF92YWx1ZSB0byAncGdfc2l6ZSArCjEn
CnRoZSB0ZXN0IHBhc3NlZCBvbiBteSBwcGM2NGxlIHBsYXRmb3JtLgoKQW5kIGxvb2tpbmcgYXQg
dGhlIGNvZGUsIHNlZW1zIGZyb20gbG9vcF9yZWNvbmZpZ3VyZV9saW1pdHMoKSBjYXN0IHRvCid1
bnNpbmVkIHNob3J0JwpjYXVzZWQgdGhhdC4gVGhhdCdzIHdoeSBhbm90aGVyIHBhdGNoIEpvaG4g
c3VibWl0dGVkIGZlM2Q1MDhiYTk1YmM2M2EKKCJibG9jazogVmFsaWRhdGUgbG9naWNhbCBibG9j
ayBzaXplIGluIGJsa192YWxpZGF0ZV9saW1pdHMoKSIpIGRvZXNuJ3QKbWFrZSB0aGUKYmVoYXZp
b3IgY29uc2lzdGVudCBvbiBhbGwgYXJjaGVzICh3aXRoIGRpZmZlcmVudCBwYWdlIHNpemUpLgoK
CgoKPgo+Cj4+IChUZXN0IGF0dGVtcHRzIHRvIHNldCBibG9jayBzaXplIHRvIDIqcGFnZSBzaXpl
LikKPj4KPj4gPgo+PiA+IENDIGJsb2NrIGRldnMgdG8gZ2l2ZSBzb21lIGFkdmljZS4KPj4gPgo+
PiA+Cj4+ID4KPj4gPiA+Cj4+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVk
aGF0LmNvbT4KPj4gPiA+IC0tLQo+PiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9j
dGwvaW9jdGxfbG9vcDA2LmMgfCA5ICsrKysrKysrKwo+PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKykKPj4gPiA+Cj4+ID4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9pb2N0bC9pb2N0bF9sb29wMDYuYwo+PiA+ID4gYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4+ID4gPiBpbmRleCAzMTdmNjkzYTAuLjRh
YWNkMjg0YSAxMDA2NDQKPj4gPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9j
dGwvaW9jdGxfbG9vcDA2LmMKPj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW9jdGwvaW9jdGxfbG9vcDA2LmMKPj4gPiA+IEBAIC0yMyw2ICsyMyw3IEBAIHN0YXRpYyBjaGFy
IGRldl9wYXRoWzEwMjRdOwo+PiA+ID4gIHN0YXRpYyBpbnQgZGV2X251bSwgZGV2X2ZkLCBmaWxl
X2ZkLCBhdHRhY2hfZmxhZywgbG9vcF9jb25maWd1cmVfc3VwCj4+ID0gMTsKPj4gPiA+ICBzdGF0
aWMgdW5zaWduZWQgaW50IGludmFsaWRfdmFsdWUsIGhhbGZfdmFsdWUsIHVuYWxpZ25fdmFsdWU7
Cj4+ID4gPiAgc3RhdGljIHN0cnVjdCBsb29wX2NvbmZpZyBsb29wY29uZmlnOwo+PiA+ID4gK3N0
YXRpYyBpbnQgbm92YWxpZGF0ZV9ibG9ja3NpemUgPSAwOwo+PiA+ID4KPj4gPiA+ICBzdGF0aWMg
c3RydWN0IHRjYXNlIHsKPj4gPiA+ICAgICAgICAgdW5zaWduZWQgaW50ICpzZXR2YWx1ZTsKPj4g
PiA+IEBAIC03NCw2ICs3NSwxMSBAQCBzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IG4pCj4+
ID4gPiAgICAgICAgIHN0cnVjdCB0Y2FzZSAqdGMgPSAmdGNhc2VzW25dOwo+PiA+ID4KPj4gPiA+
ICAgICAgICAgdHN0X3JlcyhUSU5GTywgIiVzIiwgdGMtPm1lc3NhZ2UpOwo+PiA+ID4gKyAgICAg
ICBpZiAoKCoodGMtPnNldHZhbHVlKSA9PSBpbnZhbGlkX3ZhbHVlKSAmJgo+PiBub3ZhbGlkYXRl
X2Jsb2Nrc2l6ZSkgewo+PiA+ID4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJLZXJu
ZWwgZG9lc24ndCB2YWxpZGF0ZSBibG9jayBzaXplLAo+PiBza2lwCj4+ID4gPiBpbnZhbGlkIHZh
bHVlIHRlc3QiKTsKPj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4+ID4gPiArICAgICAg
IH0KPj4gPiA+ICsKPj4gPiA+ICAgICAgICAgaWYgKHRjLT5pb2N0bF9mbGFnID09IExPT1BfU0VU
X0JMT0NLX1NJWkUpIHsKPj4gPiA+ICAgICAgICAgICAgICAgICBpZiAoIWF0dGFjaF9mbGFnKSB7
Cj4+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfYXR0YWNoX2RldmljZShkZXZfcGF0
aCwgInRlc3QuaW1nIik7Cj4+ID4gPiBAQCAtMTI2LDYgKzEzMiw5IEBAIHN0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpCj4+ID4gPiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+PiA+ID4gICAgICAgICB9
Cj4+ID4gPiAgICAgICAgIGxvb3Bjb25maWcuZmQgPSBmaWxlX2ZkOwo+PiA+ID4gKwo+PiA+ID4g
KyAgICAgICBpZiAoKHRzdF9rdmVyY21wKDYsIDExLCAwKSkgPj0gMCkKPj4gPiA+ICsgICAgICAg
ICAgICAgICBub3ZhbGlkYXRlX2Jsb2Nrc2l6ZSA9IDE7Cj4+ID4gPiAgfQo+PiA+ID4KPj4gPiA+
ICBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4+ID4gPiAtLQo+PiA+ID4gMi40Ni4wCj4+ID4g
Pgo+PiA+ID4KPj4gPiA+IC0tCj4+ID4gPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAKPj4gPiA+Cj4+ID4gPgo+PiA+Cj4+ID4gLS0KPj4gPiBS
ZWdhcmRzLAo+PiA+IExpIFdhbmcKPj4gPgo+PiA+IC0tCj4+ID4gTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4+Cj4+Cj4KPiAtLQo+IFJlZ2Fy
ZHMsCj4gTGkgV2FuZwo+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
