Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E8EC4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 05:32:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 535823CFBC9
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 07:32:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3ED3CF673
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 07:32:35 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF00A1401229
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 07:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713418353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDwJM0oejgTmAwzaK8ZraJYgturaFJRUdbTnbK3x8p8=;
 b=JNWFNAI4gqg+wXsElobw9WNwmcOl5+B6fYwfeDnay0HoIxQCJaYnr+sdlnnK4ut2twwniw
 8RMIurXGpRl3Hpn9pweGlHHIVYK0IomWigtGMq+Th3639kHVAewWijREg6sn0hv1ht+12G
 Hz0o+TPrkksg07zbOS4/IuTI/GlRh04=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-4zRDDecOOyOR1bndXZNkcw-1; Thu, 18 Apr 2024 01:32:31 -0400
X-MC-Unique: 4zRDDecOOyOR1bndXZNkcw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6ed2e00aa22so705532b3a.0
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 22:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713418350; x=1714023150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDwJM0oejgTmAwzaK8ZraJYgturaFJRUdbTnbK3x8p8=;
 b=G5gtbB0J0xyeoiN2tICD0e5u5VpPE9F+CATGiDRv+wSZQanKKTFxUQo1Fi/EwklaKb
 GJtBzYzlkKfbZM1Q7XFW49LKA17NODSkTrsnPSMHQdLSH8fGqzAfqKtmzxGaleRLv/e/
 /FUW66Gc4tfPwgThBNgcpA70pwwkS3F+ibq2OEbE8wPr/h613I8kQmWpi1LUz1Je3YmJ
 Ud6zSEn80Ee7LKAIbC3szj9GCPS8LWBIMz0BRr3d1v/smdLZweqtFhtf0XszgwoCbdaW
 VSq4irBWD/F8icxhf8L7wmvyTu+a1yGJheEX+fD4A72FqewhKX3VSEgMJ6JOgHzNZrlk
 JFkw==
X-Gm-Message-State: AOJu0YwcX2tslfhlrphY9O1KzxjBs5KYytesFWpdAU6QsRaAJMt+mnVC
 t7nxd5cRKEbYoj9/RLOdnTjgEWsYD/gadzaK23fJar/GHD4hnQi2DXSR6iV2n7utSSMRmuecVQe
 J608uBkKo3vXKs05Ul3IvdNIVyP4G6qUqwiG6dvAPPNaLcX1KFWCkKCUZCGFzcYCIrF9IVQpoja
 xNLlNx56c8491XIK8cHrGS73o=
X-Received: by 2002:a05:6a21:27a2:b0:1a9:852f:6acf with SMTP id
 rn34-20020a056a2127a200b001a9852f6acfmr2108712pzb.11.1713418350084; 
 Wed, 17 Apr 2024 22:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLblEUiM1Ky1HsPSuYhnenXuy748xHediAPxjSpvNEw3gHBRuHKfcMdAWcgYIdhUde65YCNF2RIpYK+QOdTDM=
X-Received: by 2002:a05:6a21:27a2:b0:1a9:852f:6acf with SMTP id
 rn34-20020a056a2127a200b001a9852f6acfmr2108704pzb.11.1713418349731; Wed, 17
 Apr 2024 22:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240417123113.731780-1-pvorel@suse.cz>
In-Reply-To: <20240417123113.731780-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Apr 2024 13:32:17 +0800
Message-ID: <CAEemH2cJtxroUfnRjX3mvOPrc6nFM2PXokWpKCy33Hfiz-aaGw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] libswap: Move file & line macros to macros
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

T24gV2VkLCBBcHIgMTcsIDIwMjQgYXQgODozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGF2aW5nIF9fRklMRV9fIGFuZCBfX0xJTkVfXyBpbiBDIGZ1bmN0aW9u
IGRvZXMgbm90IGhlbHAsCj4gdGhleSBtdXN0IGJlIGluIG1hY3JvcyB0byBoZWxwIGlkZW50aWZ5
IHRoZSBjYWxsZXIuCj4KPiBUaGVyZWZvcmUgbWFrZV9zd2FwZmlsZV8oKSB3cmFwcGVyIGlzIG5v
dCBuZWVkZWQuCj4KPiBGaXhlczogZjk4N2ZmZmY1ICgibGlic3dhcDogYWRkIHR3byBtZXRob2Rz
IHRvIGNyZWF0ZSBzd2FwZmlsZSIpCj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgo+
IC0tLQo+ICBpbmNsdWRlL2xpYnN3YXAuaCAgICAgICAgIHwgMTYgKysrKystLS0tLS0tLS0tLQo+
ICBsaWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jIHwgIDIgKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGlic3dhcC5oIGIvaW5jbHVkZS9saWJzd2FwLmgKPiBpbmRleCA5NmU3MTg1NDIuLjg3ZTMyMzI4
ZSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpYnN3YXAuaAo+ICsrKyBiL2luY2x1ZGUvbGlic3dh
cC5oCj4gQEAgLTE5LDQxICsxOSwzNSBAQCBlbnVtIHN3YXBmaWxlX21ldGhvZCB7Cj4gIC8qCj4g
ICAqIENyZWF0ZSBhIHN3YXBmaWxlIG9mIGEgc3BlY2lmaWVkIHNpemUgb3IgbnVtYmVyIG9mIGJs
b2Nrcy4KPiAgICovCj4gLWludCBtYWtlX3N3YXBmaWxlXyhjb25zdCBjaGFyICpmaWxlLCBjb25z
dCBpbnQgbGluZW5vLAo+ICtpbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFyICpmaWxlLCBjb25z
dCBpbnQgbGluZW5vLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnN3YXBm
aWxlLCB1bnNpZ25lZCBpbnQgbnVtLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGludCBzYWZl
LCBlbnVtIHN3YXBmaWxlX21ldGhvZCBtZXRob2QpOwo+Cj4gLXN0YXRpYyBpbmxpbmUgaW50IG1h
a2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqc3dhcGZpbGUsIHVuc2lnbmVkIGludCBudW0sCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgaW50IHNhZmUsIGVudW0gc3dhcGZpbGVfbWV0aG9kIG1ldGhv
ZCkKPiAtewo+IC0gICAgICAgcmV0dXJuIG1ha2Vfc3dhcGZpbGVfKF9fRklMRV9fLCBfX0xJTkVf
Xywgc3dhcGZpbGUsIG51bSwgc2FmZSwKPiBtZXRob2QpOwo+IC19Cj4gLQo+ICAvKioKPiAgICog
TWFjcm8gdG8gY3JlYXRlIHN3YXBmaWxlIHNpemUgaW4gbWVnYWJ5dGVzIChNQikuCj4gICAqLwo+
ICAjZGVmaW5lIE1BS0VfU1dBUEZJTEVfU0laRShzd2FwZmlsZSwgc2l6ZSkgXAo+IC0gICAgbWFr
ZV9zd2FwZmlsZShzd2FwZmlsZSwgc2l6ZSwgMCwgU1dBUEZJTEVfQllfU0laRSkKPiArICAgIG1h
a2Vfc3dhcGZpbGUoX19GSUxFX18sIF9fTElORV9fLCBzd2FwZmlsZSwgc2l6ZSwgMCwgU1dBUEZJ
TEVfQllfU0laRSkKPgo+ICAvKioKPiAgICogTWFjcm8gdG8gY3JlYXRlIHN3YXBmaWxlIHNpemUg
aW4gYmxvY2sgbnVtYmVycy4KPiAgICovCj4gICNkZWZpbmUgTUFLRV9TV0FQRklMRV9CTEtTKHN3
YXBmaWxlLCBibG9ja3MpIFwKPiAtICAgIG1ha2Vfc3dhcGZpbGUoc3dhcGZpbGUsIGJsb2Nrcywg
MCwgU1dBUEZJTEVfQllfQkxLUykKPiArICAgIG1ha2Vfc3dhcGZpbGUoX19GSUxFX18sIF9fTElO
RV9fLCBzd2FwZmlsZSwgYmxvY2tzLCAwLAo+IFNXQVBGSUxFX0JZX0JMS1MpCj4KPiAgLyoqCj4g
ICAqIE1hY3JvIHRvIHNhZmVseSBjcmVhdGUgc3dhcGZpbGUgc2l6ZSBpbiBtZWdhYnl0ZXMgKE1C
KS4KPiAgICogSW5jbHVkZXMgc2FmZXR5IGNoZWNrcyB0byBoYW5kbGUgcG90ZW50aWFsIGVycm9y
cy4KPiAgICovCj4gICNkZWZpbmUgU0FGRV9NQUtFX1NXQVBGSUxFX1NJWkUoc3dhcGZpbGUsIHNp
emUpIFwKPiAtICAgIG1ha2Vfc3dhcGZpbGUoc3dhcGZpbGUsIHNpemUsIDEsIFNXQVBGSUxFX0JZ
X1NJWkUpCj4gKyAgICBtYWtlX3N3YXBmaWxlKF9fRklMRV9fLCBfX0xJTkVfXywgc3dhcGZpbGUs
IHNpemUsIDEsIFNXQVBGSUxFX0JZX1NJWkUpCj4KPiAgLyoqCj4gICAqIE1hY3JvIHRvIHNhZmVs
eSBjcmVhdGUgc3dhcGZpbGUgc2l6ZSBpbiBibG9jayBudW1iZXJzLgo+ICAgKiBJbmNsdWRlcyBz
YWZldHkgY2hlY2tzIHRvIGhhbmRsZSBwb3RlbnRpYWwgZXJyb3JzLgo+ICAgKi8KPiAgI2RlZmlu
ZSBTQUZFX01BS0VfU1dBUEZJTEVfQkxLUyhzd2FwZmlsZSwgYmxvY2tzKSBcCj4gLSAgICBtYWtl
X3N3YXBmaWxlKHN3YXBmaWxlLCBibG9ja3MsIDEsIFNXQVBGSUxFX0JZX0JMS1MpCj4gKyAgICBt
YWtlX3N3YXBmaWxlKF9fRklMRV9fLCBfX0xJTkVfXywgc3dhcGZpbGUsIGJsb2NrcywgMSwKPiBT
V0FQRklMRV9CWV9CTEtTKQo+Cj4gIC8qCj4gICAqIENoZWNrIHN3YXBvbi9zd2Fwb2ZmIHN1cHBv
cnQgc3RhdHVzIG9mIGZpbGVzeXN0ZW1zIG9yIGZpbGVzCj4gZGlmZiAtLWdpdCBhL2xpYnMvbGli
bHRwc3dhcC9saWJzd2FwLmMgYi9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gaW5kZXggMzEz
YTE1ZjI0Li5iNDIzM2JlMGQgMTAwNjQ0Cj4gLS0tIGEvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAu
Ywo+ICsrKyBiL2xpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMKPiBAQCAtMTMzLDcgKzEzMyw3IEBA
IG91dDoKPiAgICAgICAgIHJldHVybiBjb250aWd1b3VzOwo+ICB9Cj4KPiAtaW50IG1ha2Vfc3dh
cGZpbGVfKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4gK2ludCBtYWtlX3N3
YXBmaWxlKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3QgY2hhciAqc3dhcGZpbGUsIHVuc2lnbmVkIGludCBudW0sCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IHNhZmUsIGVudW0gc3dhcGZpbGVfbWV0aG9kIG1ldGhv
ZCkKPiAgewo+IC0tCj4gMi40My4wCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
