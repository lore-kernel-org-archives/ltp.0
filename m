Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE833C5321E
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 13:15:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 204153D2732
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 15:15:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3020B3C4AD1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:15:27 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61C68601BAB
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 15:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724678124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlU9cDRS151p3RNA7bzVGSnTyd6HT4EiI2pPDBkoArU=;
 b=FqGF9EfAG/zKG5F1QtRqlsrsjJssEmgwxBOXDbu4HReXm/kKjNlVGRPG8LgcMWvo7pQ4L4
 Q5s//vu7bel/a1J43zO3sHbtZguUaJ4rwfAEqfDoPGfehYlOnxMyDQUpdIvIUAYf9slXTw
 9HO0UBtk8mZ971Vm2N/TMlBtmmAPo3k=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-6QoMA_ruOLmGwlKU5aSbzQ-1; Mon, 26 Aug 2024 09:15:23 -0400
X-MC-Unique: 6QoMA_ruOLmGwlKU5aSbzQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5dcb1d95b5dso5630304eaf.3
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 06:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724678122; x=1725282922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlU9cDRS151p3RNA7bzVGSnTyd6HT4EiI2pPDBkoArU=;
 b=rtEhfEIjLTRcCbC8NL44BqmGv4Uv7Fy4QRJwYb0gX0FOw0qKg5yTSqqea7KyC3av5p
 +Zs92P2ZZnrlueS8nJIptTxL2wKD9F5cSbvsbrUG/rGEbl8kmpCiV0gz4lm7Z/hIYjvo
 DLhp503L1PboXJ52P37PNKDmyqdqlJQMdNoouTEwwkHGuwc4IujL7UWBwilvNsgG+kV7
 VewmGCFSFv+vGm9ZW+jmnKGjv7Db5herD+YX1l22XrgaACEGMTSlARqExngs5HE1KqHD
 dQB3/zlhvh4H6W7RHcCEADoDD13KS0Ak8NbXDbSLZvdQkA71/s76dFKLyf3iNZNoSF1B
 dkow==
X-Gm-Message-State: AOJu0YwtH4jfW5lXm4hFoztzbI/McBSOyB7FCxYhXsstaKSuyq43zJpH
 hsAuiE83xdh2jpeOq7wHyG5Aym4kEJpgJ9XnZZ1YzxmxjUJAIvOnxaWFHe5jMIFlWrCxKAj3k8r
 7jcUMRl8yIQMGm/ckdoeka1wFjhq5P24sqYoiJyihBZ3y3VTc0Bjif8K/oNWnMLEWamEEphtUJs
 fIeIUSgYRbCuk3BEUuB2e9ZK4=
X-Received: by 2002:a05:6870:e0c9:b0:25d:f285:d008 with SMTP id
 586e51a60fabf-273e63f21e6mr11597752fac.7.1724678122705; 
 Mon, 26 Aug 2024 06:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzq2bSMG3n1mMWMxD3e9ncSJzObbAvcFCnCPnp8GOZioFDMaUJRjND+0VdyhQ/m7KU7RFZ8Thw8coLI6QWg6c=
X-Received: by 2002:a05:6870:e0c9:b0:25d:f285:d008 with SMTP id
 586e51a60fabf-273e63f21e6mr11597712fac.7.1724678122259; Mon, 26 Aug 2024
 06:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240826120205.5506-1-liwang@redhat.com>
 <CAEemH2dYB3tyG4xjE_b1rGBRqtCDOwByq5ZdA0VUxvL3nqW0Vw@mail.gmail.com>
In-Reply-To: <CAEemH2dYB3tyG4xjE_b1rGBRqtCDOwByq5ZdA0VUxvL3nqW0Vw@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Aug 2024 15:15:06 +0200
Message-ID: <CAASaF6xh7_wXiFn9LakEv-LY-szkZ+5fJ0B67ygdCV0g4T-89Q@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
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

T24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgMjo0NuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEhpIEFsbCwKPgo+IE9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0IDg6MDLi
gK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiA+IFNpbmNlIGNvbW1p
dCA5NDIzYzY1M2ZlNjExMCAoImxvb3A6IERvbid0IGJvdGhlciB2YWxpZGF0aW5nIGJsb2Nrc2l6
ZSIpCj4gPiBrZXJuZWwKPiA+IGRyb3AgdmFsaWRhdGluZyBibG9ja3NpemUgZm9yIGJvdGggbG9v
cF9jb25maWd1cmUgYW5kIGxvb3Bfc2V0X2Jsb2NrX3NpemUKPiA+IHNvCj4gPiB0aGF0IHNldCBs
YXJnZSBibG9jayBzaXplIHN1Y2NlZWRzLgo+ID4KPiA+IEVycm9yIGxvZzoKPiA+ICAgMTIgaW9j
dGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBVc2luZyBMT09QX1NFVF9CTE9DS19TSVpFIHdpdGggYXJn
ID4KPiA+IFBBR0VfU0laRQo+ID4gICAxMyBpb2N0bF9sb29wMDYuYzo1OTogVEZBSUw6IFNldCBi
bG9jayBzaXplIHN1Y2NlZWQgdW5leHBlY3RlZGx5Cj4gPiAgIC4uLgo+ID4gICAxOCBpb2N0bF9s
b29wMDYuYzo3NjogVElORk86IFVzaW5nIExPT1BfQ09ORklHVVJFIHdpdGggYmxvY2tfc2l6ZSA+
Cj4gPiBQQUdFX1NJWkUKPiA+ICAgMTkgaW9jdGxfbG9vcDA2LmM6NTk6ICBURkFJTDogU2V0IGJs
b2NrIHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPiA+Cj4KPiBIbW0sIG1heWJlIEkgd2FzIHdy
b25nIGhlcmUsIHRoZSBjb21taXQgc2F5cwo+Cj4gICAiVGhlIGJsb2NrIHF1ZXVlIGxpbWl0cyB2
YWxpZGF0aW9uIGRvZXMgdGhpcyBmb3IgdXMgbm93LiIKPgo+IHdoaWNoIGluZGljYXRlcyB0aGUg
dmFsaWRhdGlvbiBpcyBzdGlsbCBvbi4KPgo+IFNvIHRoZSB0ZXN0IGZhaWx1cmUgcHJvYmFibHkg
bWVhbnMgYSBrZXJuZWwgYnVnIGJ1dCBub3QgYSB0ZXN0IHByb2JsZW0uCgpCZWZvcmUgdGhlIHBh
dGNoLCBibGtfdmFsaWRhdGVfYmxvY2tfc2l6ZSgpIGRpZCB2YWxpZGF0ZSBvcmlnaW5hbAp2YWx1
ZSBhcyB1bnNpZ25lZCBsb25nLAphZnRlciBwYXRjaCBpdCdzIHZhbGlkYXRlZCBhZnRlciBjYXN0
IHRvIHVuc2lnbmVkIHNob3J0LgoKSW4gTFRQIHRocmVhZCB5b3UgbWVudGlvbmVkIGl0IGZhaWxl
ZCBvbiBwcGM2NGxlL2FhcmNoNjQgYW5kIHdvcmtlZCBvbgp4ODZfNjQgYW5kIHMzOTB4LgpJcyBp
dCBieSBjaGFuY2Ugbm93IGZhaWxpbmcgb25seSBvbiBrZXJuZWxzIHdpdGggNjRrIHBhZ2Ugc2l6
ZT8KKFRlc3QgYXR0ZW1wdHMgdG8gc2V0IGJsb2NrIHNpemUgdG8gMipwYWdlIHNpemUuKQoKPgo+
IENDIGJsb2NrIGRldnMgdG8gZ2l2ZSBzb21lIGFkdmljZS4KPgo+Cj4KPiA+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxfbG9vcDA2LmMgfCA5ICsrKysrKysrKwo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9sb29wMDYuYwo+ID4gYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4gPiBpbmRleCAzMTdmNjkz
YTAuLjRhYWNkMjg0YSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW9jdGwvaW9jdGxfbG9vcDA2LmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW9jdGwvaW9jdGxfbG9vcDA2LmMKPiA+IEBAIC0yMyw2ICsyMyw3IEBAIHN0YXRpYyBjaGFyIGRl
dl9wYXRoWzEwMjRdOwo+ID4gIHN0YXRpYyBpbnQgZGV2X251bSwgZGV2X2ZkLCBmaWxlX2ZkLCBh
dHRhY2hfZmxhZywgbG9vcF9jb25maWd1cmVfc3VwID0gMTsKPiA+ICBzdGF0aWMgdW5zaWduZWQg
aW50IGludmFsaWRfdmFsdWUsIGhhbGZfdmFsdWUsIHVuYWxpZ25fdmFsdWU7Cj4gPiAgc3RhdGlj
IHN0cnVjdCBsb29wX2NvbmZpZyBsb29wY29uZmlnOwo+ID4gK3N0YXRpYyBpbnQgbm92YWxpZGF0
ZV9ibG9ja3NpemUgPSAwOwo+ID4KPiA+ICBzdGF0aWMgc3RydWN0IHRjYXNlIHsKPiA+ICAgICAg
ICAgdW5zaWduZWQgaW50ICpzZXR2YWx1ZTsKPiA+IEBAIC03NCw2ICs3NSwxMSBAQCBzdGF0aWMg
dm9pZCBydW4odW5zaWduZWQgaW50IG4pCj4gPiAgICAgICAgIHN0cnVjdCB0Y2FzZSAqdGMgPSAm
dGNhc2VzW25dOwo+ID4KPiA+ICAgICAgICAgdHN0X3JlcyhUSU5GTywgIiVzIiwgdGMtPm1lc3Nh
Z2UpOwo+ID4gKyAgICAgICBpZiAoKCoodGMtPnNldHZhbHVlKSA9PSBpbnZhbGlkX3ZhbHVlKSAm
JiBub3ZhbGlkYXRlX2Jsb2Nrc2l6ZSkgewo+ID4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVENP
TkYsICJLZXJuZWwgZG9lc24ndCB2YWxpZGF0ZSBibG9jayBzaXplLCBza2lwCj4gPiBpbnZhbGlk
IHZhbHVlIHRlc3QiKTsKPiA+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gPiArICAgICAgIH0K
PiA+ICsKPiA+ICAgICAgICAgaWYgKHRjLT5pb2N0bF9mbGFnID09IExPT1BfU0VUX0JMT0NLX1NJ
WkUpIHsKPiA+ICAgICAgICAgICAgICAgICBpZiAoIWF0dGFjaF9mbGFnKSB7Cj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICB0c3RfYXR0YWNoX2RldmljZShkZXZfcGF0aCwgInRlc3QuaW1nIik7
Cj4gPiBAQCAtMTI2LDYgKzEzMiw5IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiAgICAg
ICAgICAgICAgICAgcmV0dXJuOwo+ID4gICAgICAgICB9Cj4gPiAgICAgICAgIGxvb3Bjb25maWcu
ZmQgPSBmaWxlX2ZkOwo+ID4gKwo+ID4gKyAgICAgICBpZiAoKHRzdF9rdmVyY21wKDYsIDExLCAw
KSkgPj0gMCkKPiA+ICsgICAgICAgICAgICAgICBub3ZhbGlkYXRlX2Jsb2Nrc2l6ZSA9IDE7Cj4g
PiAgfQo+ID4KPiA+ICBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gPiAtLQo+ID4gMi40Ni4w
Cj4gPgo+ID4KPiA+IC0tCj4gPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAKPiA+Cj4gPgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgo+
IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
