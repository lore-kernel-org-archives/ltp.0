Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F66C5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 12:46:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33C593D2743
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 14:46:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D61993D20F7
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:46:08 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D1631000D28
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 14:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724676366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HXRmo44XRZoepm7ALb2xKw0VwrUi4xgkfCapxf+BKlU=;
 b=MUN39T/Cvmh3ZjICygj/B30qus8+d1EBuhyD7hLHPldX8tLFeGXSdIbLs5w3A9MFrfBvsb
 1aA7IZdYb1+CfkdUW057OrjKVXGGBLOmjSyaKt5WcyH43DEIOuNNGxJ+QU5LnHHkTLOb2e
 mh6acNHkpaxwfwH0dKUdfveT5PyMGlw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Y-vRZMu-OTSaranZYzxfaQ-1; Mon, 26 Aug 2024 08:46:05 -0400
X-MC-Unique: Y-vRZMu-OTSaranZYzxfaQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2d432914cc7so3786577a91.0
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 05:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724676363; x=1725281163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXRmo44XRZoepm7ALb2xKw0VwrUi4xgkfCapxf+BKlU=;
 b=IuA7xY8lB3XA5v8yCv5aRHQUPRJFYAh+ycBkrlf8VPvxlFDAUMeuEpSFEn0LLQuJ9Z
 BuPa/jcOyRMtdEtslVmtGCMJv1fv76qy83QTUlUB+mA3AYfnGCKVSKXeAeU41n/RlchS
 I9HupH55Fnsx/hzVHYGTIavVdZ7biJvTq3UXmRI6K7DupGGaS3k/omZjF2kRsxYjXXHV
 aEPzEga5g+M6+cm13uySxVEYXWW89BqKzfa8bULuV1jE8+GeMiCBTj8EvKQdIpYKFsHu
 fEryKy7PI7MoZhGONa+16Naryjem5r+fGVq/g7N8AzumYq/E9ULIk+wKkFdnSPdsJAcL
 kfxQ==
X-Gm-Message-State: AOJu0YwBcq1Gxn7mYfaM2G1DuCyGCG5xSoH/0UfVlI1KiiUExUGgPt3u
 u1bPrQ4zt02VIvTc+IcxrQnwy0Tiuwcyi7YZnVebl5Qckjj4zz/ZD8rUZ6KTTqtqyf/yiTyBLjF
 dfYrF/pqSvzve+ZXpQWepZRNkdCsI6ZL0LZzVWxt/nukI4XUMhXXdBXRVIlmetfxA85Hj2/0GOo
 gpm5yUvVnvJIeC5SJGI3WuotRrA+IyQ0g=
X-Received: by 2002:a17:90a:fa49:b0:2d4:902e:ca3f with SMTP id
 98e67ed59e1d1-2d644af820emr16024401a91.19.1724676362783; 
 Mon, 26 Aug 2024 05:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1igh7p7PmmYrxlqd9E9SLGS6mfpRAxAOYfTaARflx00drGljhsPwXnXHkeiEszY/saaMGrawFaDxo9DyBZD0=
X-Received: by 2002:a17:90a:fa49:b0:2d4:902e:ca3f with SMTP id
 98e67ed59e1d1-2d644af820emr16024362a91.19.1724676362312; Mon, 26 Aug 2024
 05:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240826120205.5506-1-liwang@redhat.com>
In-Reply-To: <20240826120205.5506-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Aug 2024 20:45:49 +0800
Message-ID: <CAEemH2dYB3tyG4xjE_b1rGBRqtCDOwByq5ZdA0VUxvL3nqW0Vw@mail.gmail.com>
To: ltp@lists.linux.it, John Garry <john.g.garry@oracle.com>, 
 Damien Le Moal <dlemoal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQWxsLAoKT24gTW9uLCBBdWcgMjYsIDIwMjQgYXQgODowMuKAr1BNIExpIFdhbmcgPGxpd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKCj4gU2luY2UgY29tbWl0IDk0MjNjNjUzZmU2MTEwICgibG9v
cDogRG9uJ3QgYm90aGVyIHZhbGlkYXRpbmcgYmxvY2tzaXplIikKPiBrZXJuZWwKPiBkcm9wIHZh
bGlkYXRpbmcgYmxvY2tzaXplIGZvciBib3RoIGxvb3BfY29uZmlndXJlIGFuZCBsb29wX3NldF9i
bG9ja19zaXplCj4gc28KPiB0aGF0IHNldCBsYXJnZSBibG9jayBzaXplIHN1Y2NlZWRzLgo+Cj4g
RXJyb3IgbG9nOgo+ICAgMTIgaW9jdGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBVc2luZyBMT09QX1NF
VF9CTE9DS19TSVpFIHdpdGggYXJnID4KPiBQQUdFX1NJWkUKPiAgIDEzIGlvY3RsX2xvb3AwNi5j
OjU5OiBURkFJTDogU2V0IGJsb2NrIHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPiAgIC4uLgo+
ICAgMTggaW9jdGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBVc2luZyBMT09QX0NPTkZJR1VSRSB3aXRo
IGJsb2NrX3NpemUgPgo+IFBBR0VfU0laRQo+ICAgMTkgaW9jdGxfbG9vcDA2LmM6NTk6ICBURkFJ
TDogU2V0IGJsb2NrIHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPgoKSG1tLCBtYXliZSBJIHdh
cyB3cm9uZyBoZXJlLCB0aGUgY29tbWl0IHNheXMKCiAgIlRoZSBibG9jayBxdWV1ZSBsaW1pdHMg
dmFsaWRhdGlvbiBkb2VzIHRoaXMgZm9yIHVzIG5vdy4iCgp3aGljaCBpbmRpY2F0ZXMgdGhlIHZh
bGlkYXRpb24gaXMgc3RpbGwgb24uCgpTbyB0aGUgdGVzdCBmYWlsdXJlIHByb2JhYmx5IG1lYW5z
IGEga2VybmVsIGJ1ZyBidXQgbm90IGEgdGVzdCBwcm9ibGVtLgoKQ0MgYmxvY2sgZGV2cyB0byBn
aXZlIHNvbWUgYWR2aWNlLgoKCgo+Cj4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJl
ZGhhdC5jb20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxf
bG9vcDA2LmMgfCA5ICsrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9s
b29wMDYuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9sb29wMDYu
Ywo+IGluZGV4IDMxN2Y2OTNhMC4uNGFhY2QyODRhIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxfbG9vcDA2LmMKPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX2xvb3AwNi5jCj4gQEAgLTIzLDYgKzIzLDcgQEAgc3Rh
dGljIGNoYXIgZGV2X3BhdGhbMTAyNF07Cj4gIHN0YXRpYyBpbnQgZGV2X251bSwgZGV2X2ZkLCBm
aWxlX2ZkLCBhdHRhY2hfZmxhZywgbG9vcF9jb25maWd1cmVfc3VwID0gMTsKPiAgc3RhdGljIHVu
c2lnbmVkIGludCBpbnZhbGlkX3ZhbHVlLCBoYWxmX3ZhbHVlLCB1bmFsaWduX3ZhbHVlOwo+ICBz
dGF0aWMgc3RydWN0IGxvb3BfY29uZmlnIGxvb3Bjb25maWc7Cj4gK3N0YXRpYyBpbnQgbm92YWxp
ZGF0ZV9ibG9ja3NpemUgPSAwOwo+Cj4gIHN0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ICAgICAgICAg
dW5zaWduZWQgaW50ICpzZXR2YWx1ZTsKPiBAQCAtNzQsNiArNzUsMTEgQEAgc3RhdGljIHZvaWQg
cnVuKHVuc2lnbmVkIGludCBuKQo+ICAgICAgICAgc3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNb
bl07Cj4KPiAgICAgICAgIHRzdF9yZXMoVElORk8sICIlcyIsIHRjLT5tZXNzYWdlKTsKPiArICAg
ICAgIGlmICgoKih0Yy0+c2V0dmFsdWUpID09IGludmFsaWRfdmFsdWUpICYmIG5vdmFsaWRhdGVf
YmxvY2tzaXplKSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYsICJLZXJuZWwgZG9l
c24ndCB2YWxpZGF0ZSBibG9jayBzaXplLCBza2lwCj4gaW52YWxpZCB2YWx1ZSB0ZXN0Iik7Cj4g
KyAgICAgICAgICAgICAgIHJldHVybjsKPiArICAgICAgIH0KPiArCj4gICAgICAgICBpZiAodGMt
PmlvY3RsX2ZsYWcgPT0gTE9PUF9TRVRfQkxPQ0tfU0laRSkgewo+ICAgICAgICAgICAgICAgICBp
ZiAoIWF0dGFjaF9mbGFnKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdHN0X2F0dGFjaF9k
ZXZpY2UoZGV2X3BhdGgsICJ0ZXN0LmltZyIpOwo+IEBAIC0xMjYsNiArMTMyLDkgQEAgc3RhdGlj
IHZvaWQgc2V0dXAodm9pZCkKPiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+ICAgICAgICAgfQo+
ICAgICAgICAgbG9vcGNvbmZpZy5mZCA9IGZpbGVfZmQ7Cj4gKwo+ICsgICAgICAgaWYgKCh0c3Rf
a3ZlcmNtcCg2LCAxMSwgMCkpID49IDApCj4gKyAgICAgICAgICAgICAgIG5vdmFsaWRhdGVfYmxv
Y2tzaXplID0gMTsKPiAgfQo+Cj4gIHN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPiAtLQo+IDIu
NDYuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
