Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B170FC7EE2A
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 07:08:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E0583CB6F6
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 09:08:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 310863CAF92
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 09:08:47 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9FA54600055
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 09:08:46 +0200 (CEST)
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-bab8f66d3a2so6583015276.3
 for <ltp@lists.linux.it>; Tue, 06 Jun 2023 00:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686035325; x=1688627325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtFe6St8wtu6b4UZ6954vQwqVIZ5B4oJ4JiGLNr2b9U=;
 b=OGEPVI99mbWeQWDCMhyenEljxQG89ObfL5PkYE83AUNqGzUYR3esErEfI2u4T/RkPJ
 J1C12l+vS/e0P/GRumVVlxGl8SbBMUJeXXMf+y2SlfV2TkPF5wk6xm+IBxmWNbpfbnEy
 N7QTp/WWLKweNHfRlUgXVI0vcJhqoyzHmgMn/Th2OZW+/A5LPfr7JIV4pAeLSp3Q2vkt
 IO7VsuTilFCC9caBHjAJEUOsHzAKMSsPYDC0ma+iMI5WNsA76CToIKVl48NVP5un3DDr
 oz+pZG/czPb5JM91lqCW2l1tNWZdxTgxp+reUiKs6sv/mqEPYsvHp1IQ+kEC9Rtetdcp
 NoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686035325; x=1688627325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtFe6St8wtu6b4UZ6954vQwqVIZ5B4oJ4JiGLNr2b9U=;
 b=J7iaNYu1kocBxGGhOeQikhgEV401p4UK8T5D6/6G3i1wlfsRIgk4P2p4sJpVfoe9Zl
 t/DncZA3t9uZfF20a5tIfvQDHmNsImG2yboobNvktRH2tpdmOOtqKBQT5z5oJ5eSp3Mt
 tPljupnFnkecUt3SudQZ+N1mF1u7x9L5yd/LPwrSzwyGoUCcZ+jiPO4WqC8Rpgd6NsTe
 qFy2PZ1HQup3a4w/m3xm86j4q861sIb7lYwmpZJFc4/USwtTLk44MxNtuFKxvfcrsYvt
 IwCGZQy22FlYdmBuY8P1bcTMIQwOgSW4ko0TmTVJtS3YdrQ2ioEBzdA+eH9Yt7NZMlno
 Fy1w==
X-Gm-Message-State: AC+VfDzEeRhbJuwLDheuW0QJWC66VH00NOwDeArZor9o+1H3Bygm/rRu
 j1q5aA4yYgloIuGtdZZJvqRtcrnOmP8kljXUVzw=
X-Google-Smtp-Source: ACHHUZ5EKXQyeFvkUXrWi8Q9//z2wP281w4c0hEq5X1JrpcumaXXFzOQHbReYh0oRqMGNWgqncPrP3oYuQgjyTNqjtg=
X-Received: by 2002:a0d:d303:0:b0:55a:3ce9:dc3d with SMTP id
 v3-20020a0dd303000000b0055a3ce9dc3dmr1244750ywd.13.1686035325067; Tue, 06 Jun
 2023 00:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230604095117.3543342-1-jencce.kernel@gmail.com>
 <233a0f31-e4de-de65-4752-d43cb1ae3c1f@suse.cz>
 <CAEemH2ftudd3aAjkMYFQLx8Yy5cV4ne=sF2U7_Av5iZ=DxmS3A@mail.gmail.com>
In-Reply-To: <CAEemH2ftudd3aAjkMYFQLx8Yy5cV4ne=sF2U7_Av5iZ=DxmS3A@mail.gmail.com>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Tue, 6 Jun 2023 15:08:34 +0800
Message-ID: <CADJHv_tHs3qs1umAdYkat=HfcF7nAVZJwPsBZ1aLMAX9PYjmAA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] SAFE_MOUNT: print debug info about mounting
 operation
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

T24gTW9uLCBKdW4gNSwgMjAyMyBhdCA1OjU34oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4KPgo+IE9uIE1vbiwgSnVuIDUsIDIwMjMgYXQgNDo0MOKAr1BNIE1hcnRp
biBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4gd3JvdGU6Cj4+Cj4+IEhpLAo+Pgo+PiBPbiAwNC4g
MDYuIDIzIDExOjUxLCBNdXJwaHkgWmhvdSB3cm90ZToKPj4gPiBTaWduZWQtb2ZmLWJ5OiBNdXJw
aHkgWmhvdSA8amVuY2NlLmtlcm5lbEBnbWFpbC5jb20+Cj4+ID4gLS0tCj4+ID4gICBsaWIvc2Fm
ZV9tYWNyb3MuYyB8IDE3ICsrKysrKysrKysrKysrKysrCj4+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MTcgaW5zZXJ0aW9ucygrKQo+PiA+Cj4+ID4gZGlmZiAtLWdpdCBhL2xpYi9zYWZlX21hY3Jvcy5j
IGIvbGliL3NhZmVfbWFjcm9zLmMKPj4gPiBpbmRleCBhZjZkZDA3MTYuLmE2NjI4NWEwZSAxMDA2
NDQKPj4gPiAtLS0gYS9saWIvc2FmZV9tYWNyb3MuYwo+PiA+ICsrKyBiL2xpYi9zYWZlX21hY3Jv
cy5jCj4+ID4gQEAgLTg5OCw3ICs4OTgsMjQgQEAgaW50IHNhZmVfbW91bnQoY29uc3QgY2hhciAq
ZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9pZCAoKmNsZWFudXBfZm4pKHZvaWQpLAo+PiA+ICAg
ICAgICAgICAgICBjb25zdCB2b2lkICpkYXRhKQo+PiA+ICAgewo+PiA+ICAgICAgIGludCBydmFs
ID0gLTE7Cj4+ID4gKyAgICAgY2hhciBjZGlyW1BBVEhfTUFYXSwgbXBhdGhbUEFUSF9NQVhdOwo+
PiA+Cj4+ID4gKyAgICAgaWYgKCFnZXRjd2QoY2RpciwgUEFUSF9NQVgpKSB7Cj4+ID4gKyAgICAg
ICAgICAgICB0c3RfcmVzbShUV0FSTiB8IFRFUlJOTywgIkZhaWxlZCB0byBmaW5kIGN1cnJlbnQg
ZGlyZWN0b3J5Iik7Cj4+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsKPj4KPj4gWW91IHJldHVy
biBzdWNjZXNzIHdoZW4gbm90aGluZyB3YXMgbW91bnRlZC4gVGhhdCBpcyBjbGVhcmx5IHdyb25n
Lgo+PiBFaXRoZXIgY2FsbCB0c3RfYnJrbV8oLi4uIFRCUk9LIC4uLikgaWYgdGhlIGZhaWx1cmUg
aXMgc28gc2VyaW91cyB0aGF0Cj4+IHRoZSB0ZXN0IGNhbm5vdCBjb250aW51ZSwgb3IgZG9uJ3Qg
cmV0dXJuIGF0IGFsbC4KPj4KPj4gPiArICAgICB9Cj4+ID4gKwo+PiA+ICsgICAgIHJ2YWwgPSBz
bnByaW50ZihtcGF0aCwgUEFUSF9NQVgsICIlcy8lcyIsIGNkaXIsIHRhcmdldCk7Cj4+Cj4+IFRo
ZSBDIGxpYnJhcnkgaGFzIGEgZnVuY3Rpb24gZm9yIHJlc29sdmluZyBwYXRoczogcmVhbHBhdGgo
KS4gUGxlYXNlIHVzZQo+PiB0aGF0Lgo+Cj4KPgo+ICsxLCBnb29kIHBvaW50LiByZWFscGF0aCgp
IGlzIG1vcmUgY29udmVuaWVudCwgd2UgZG9uJ3QKPiBuZWVkIHRvIGFkZGl0aW9uYWxseSBjb3B5
IHN0cmluZyB0byB0aGUgYWJzb2x1dGUgcGF0aC4KPgo+IEBNdXJwaHksIGlnbm9yZSBteSBwcmV2
aW91cyBjb21tZW50cyBwbHouCgpBbGwgdmVyeSBnb29kIGNhdGNoZXMhIFRoYW5rcyBmb3IgcmV2
aWV3aW5nIQoKQ29va2luZyBWMi4KCk11cnBoeQo+Cj4KPj4KPj4KPj4gPiArICAgICBpZiAocnZh
bCA8IDAgfHwgcnZhbCA+PSBQQVRIX01BWCkgewo+PiA+ICsgICAgICAgICAgICAgdHN0X3Jlc20o
VFdBUk4gfCBURVJSTk8sCj4+ID4gKyAgICAgICAgICAgICAgICAgICAgICAic25wcmludGYoKSBz
aG91bGQgaGF2ZSByZXR1cm5lZCAlZCBpbnN0ZWFkIG9mICVkIiwKPj4gPiArICAgICAgICAgICAg
ICAgICAgICAgIFBBVEhfTUFYLCBydmFsKTsKPj4gPiArICAgICAgICAgICAgIHJldHVybiAwOwo+
Pgo+PiBSZXR1cm5pbmcgaGVyZSBpcyBhbHNvIHdyb25nLgo+Pgo+PiA+ICsgICAgIH0KPj4gPiAr
Cj4+ID4gKyAgICAgdHN0X3Jlc21fKGZpbGUsIGxpbmVubywgVElORk8sCj4+ID4gKyAgICAgICAg
ICAgICAiTW91bnRpbmcgJXMgdG8gJXMgZnN0eXA9JXMgZmxhZ3M9JXgiLAo+PiA+ICsgICAgICAg
ICAgICAgc291cmNlLCBtcGF0aCwgZmlsZXN5c3RlbXR5cGUsIG1vdW50ZmxhZ3MpOwo+PiA+ICAg
ICAgIC8qCj4+ID4gICAgICAgICogRG9uJ3QgdHJ5IHVzaW5nIHRoZSBrZXJuZWwncyBOVEZTIGRy
aXZlciB3aGVuIG1vdW50aW5nIE5URlMsIHNpbmNlCj4+ID4gICAgICAgICogdGhlIGtlcm5lbCdz
IE5URlMgZHJpdmVyIGRvZXNuJ3QgaGF2ZSBwcm9wZXIgd3JpdGUgc3VwcG9ydC4KPj4KPj4gLS0K
Pj4gTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jego+PiBTVyBRdWFsaXR5IEVuZ2luZWVy
Cj4+IFNVU0UgTElOVVgsIHMuci5vLgo+PiBDT1JTTyBJSWEKPj4gS3Jpemlrb3ZhIDE0OC8zNAo+
PiAxODYgMDAgUHJhZ3VlIDgKPj4gQ3plY2ggUmVwdWJsaWMKPj4KPj4KPj4gLS0KPj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4+Cj4KPgo+
IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
