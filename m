Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0039C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 13:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4645C3D386E
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 15:17:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB59F3D3818
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 15:17:12 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=shichen@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 116286014F6
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 15:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720617430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5V2RyIXLrTL1uj6+ffFXs+tcASIbnYk9yxCZgq6VyU=;
 b=OUVtUxZw+1EtcvFgeVPV+0grw2dpUV5ZVB/2LzjhjTocZp1zL11NMYit99jYXA3kfEOJI5
 LllBM4OQ1A4Z44ymx/I7igtmbv0n4lsfAR2WX0KN9KhBpFdCnd1D6TsQ5iyXjA9MHX+vyx
 PnnFqRQBj5uqN0TNa584bDPUGG0pKMg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-aOIUK05qP_-N0_6pElJFnw-1; Wed, 10 Jul 2024 09:17:08 -0400
X-MC-Unique: aOIUK05qP_-N0_6pElJFnw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52ea64b7903so756657e87.0
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 06:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720617427; x=1721222227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5V2RyIXLrTL1uj6+ffFXs+tcASIbnYk9yxCZgq6VyU=;
 b=q3XCX7cpSIaFvx3tDwb4omY09sH2YXk9dgLJxcEyd65Uh/2Q9RlvWBHxQhs5loHQ63
 lvJmfxTJCfgrtfSkY9ewEmCuY7wT/X8ToPZJazI6+KQCTx0uQ8VBynd231LYPXxLPXRq
 QopoHoZLwMO7HYbX7zbi/DHs6XfCAjSyxAcNhnYC5Qz9IIu7Dr2GH7PzmRHXe0tSKaaK
 KGUo0pB7kpYilylVG5NeGSOZUIOlhDy74EAlGVCxPmp0LD0bbdpSuOdotYGK0YPDoyGT
 uJfEoXIYrvKe2PUz83tZQoyfZST0VGgB+NMfMqoWKVathNAGB8haFJgFhUzVk2UmM9u9
 PKAA==
X-Gm-Message-State: AOJu0Yxi9wp2yFe3H/tkfPSMuT4ZPxfiDbjrqPvSYv3RrDRuXGTx1u3L
 /FdBNESUDrKZvQZHcBUd4oLEaNZFWKrxTGp1b62Gg94F2ebFzhyCaB3uyxm+MAYUO9U1nBm6Lv8
 S3CqqgakbWJfxJLtpDViyWwIREB3E5CoekHuVQQzuLuz6O8kMYgBpEgLmc9+Hfk1k3WWk07w16u
 D46ADhEpILf+768Lm3jLKFAbM=
X-Received: by 2002:a05:6512:3c81:b0:52c:ebf6:9a7f with SMTP id
 2adb3069b0e04-52eb9d3c743mr2108548e87.11.1720617427434; 
 Wed, 10 Jul 2024 06:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEbEWwnGBfULPwL9wJLlXYFsIAHis3t4CfPgzDlEVp2N6wtEY+umP5V1zSngc+GEjhk99/YhZWQ6IX8z36WVc=
X-Received: by 2002:a05:6512:3c81:b0:52c:ebf6:9a7f with SMTP id
 2adb3069b0e04-52eb9d3c743mr2108537e87.11.1720617427003; Wed, 10 Jul 2024
 06:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240710032434.123315-1-shichen@redhat.com>
 <CAEemH2dKQGDst4074Pzz6b2aQDP4qdeuyVOnwY+ZYMh0BrDD=w@mail.gmail.com>
 <CAEemH2f=PzW68A2NzdfM0BDNKRHX4sfytCkzN4oG-USPHuJk9g@mail.gmail.com>
In-Reply-To: <CAEemH2f=PzW68A2NzdfM0BDNKRHX4sfytCkzN4oG-USPHuJk9g@mail.gmail.com>
From: Shizhao Chen <shichen@redhat.com>
Date: Wed, 10 Jul 2024 21:16:55 +0800
Message-ID: <CADm5pWdEV_G3_A3ekY9m8rWuxns52g7i-vsnyZZQJ7g1d9cbng@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] realtime/prio-preempt: take cpu isolation into
 consideration
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
Cc: Eder Zulian <ezulian@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhhbmtzIGZvciB0aGUgcmV2aWV3ISBJIGp1c3Qgc2VudCBhIHYyIHdoaWNoIGlzIGJhc2ljYWxs
eSBhIG1pbmltaXplZAp2ZXJzaW9uIG9mIHRzdF9uY3B1c19hdmFpbGFibGUuCgpPbiBXZWQsIEp1
bCAxMCwgMjAyNCBhdCAyOjI34oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+Cj4KPgo+IE9uIFdlZCwgSnVsIDEwLCAyMDI0IGF0IDI6MTPigK9QTSBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IEhpIFNoaXpoYW8sCj4+Cj4+IE9uIFdlZCwgSnVs
IDEwLCAyMDI0IGF0IDExOjI04oCvQU0gU2hpemhhbyBDaGVuIDxzaGljaGVuQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pj4KPj4+IEJ5IGRlZmF1bHQgdGhlIHRlc3Qgc3RhcnRzIE4tMSBidXN5IHRocmVh
ZHMgdG8gbW9ub3BvbGl6ZSBOLTEgYXZhaWxhYmxlIENQVXMsCj4+PiB3aGVyZSBOIGlzIHRoZSBu
dW1iZXIgb2YgYWxsIGF2YWlsYWJsZSBDUFVzLiBIb3dldmVyLCB3aGVuIENQVSBpc29sYXRpb24g
aXMKPj4+IGFwcGxpZWQsIHRoaXMgd2lsbCBsZWFkIHRvIGEgaGFuZyBzY2VuYXJpbyB3aGVyZSBh
bGwgaG91c2VrZWVwaW5nIENQVXMgYXJlCj4+PiBob2dnZWQgYXMgaXNvbGF0ZWQgQ1BVcyBkbyBu
b3Qgc2hhcmUgdGhlIE4tMSBidXN5IHRocmVhZHMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogU2hp
emhhbyBDaGVuIDxzaGljaGVuQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+ICAuLi4vcmVhbHRpbWUv
ZnVuYy9wcmlvLXByZWVtcHQvcHJpby1wcmVlbXB0LmMgIHwgMTggKysrKysrKysrKysrKysrLS0t
Cj4+PiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3ByaW8tcHJlZW1wdC9w
cmlvLXByZWVtcHQuYyBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3ByaW8tcHJlZW1wdC9wcmlv
LXByZWVtcHQuYwo+Pj4gaW5kZXggOWJkNWU3YWQ4Li43OWQyMTE1YTcgMTAwNjQ0Cj4+PiAtLS0g
YS90ZXN0Y2FzZXMvcmVhbHRpbWUvZnVuYy9wcmlvLXByZWVtcHQvcHJpby1wcmVlbXB0LmMKPj4+
ICsrKyBiL3Rlc3RjYXNlcy9yZWFsdGltZS9mdW5jL3ByaW8tcHJlZW1wdC9wcmlvLXByZWVtcHQu
Ywo+Pj4gQEAgLTU5LDYgKzU5LDcgQEAKPj4+ICAgKgo+Pj4gICAqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Ki8KPj4+Cj4+PiArI2RlZmluZSBfR05VX1NPVVJDRQo+Pj4gICNpbmNsdWRlIDxzdGRpby5oPgo+
Pj4gICNpbmNsdWRlIDxzdGRsaWIuaD4KPj4+ICAjaW5jbHVkZSA8c2lnbmFsLmg+Cj4+PiBAQCAt
Mjg3LDYgKzI4OCwxNyBAQCB2b2lkICptYXN0ZXJfdGhyZWFkKHZvaWQgKmFyZykKPj4+ICAgICAg
ICAgcmV0dXJuIE5VTEw7Cj4+PiAgfQo+Pj4KPj4+ICtpbnQgZ2V0X251bWNwdXModm9pZCkKPj4+
ICt7Cj4+PiArICAgICAgIGNwdV9zZXRfdCBtYXNrOwo+Pj4gKyAgICAgICBDUFVfWkVSTygmbWFz
ayk7Cj4+PiArCj4+PiArICAgICAgIC8qIEdldCB0aGUgbnVtYmVyIG9mIGNwdXMgYWNjZXNzaWJs
ZSB0byB0aGUgY3VycmVudCBwcm9jZXNzICovCj4+PiArICAgICAgIHNjaGVkX2dldGFmZmluaXR5
KGdldHBpZCgpLCBzaXplb2YobWFzayksICZtYXNrKTsKPj4+ICsKPj4+ICsgICAgICAgcmV0dXJu
IENQVV9DT1VOVCgmbWFzayk7Cj4+PiArfQo+Pj4KPj4+ICsKPj4+ICBpbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqYXJndltdKQo+Pj4gIHsKPj4+ICAgICAgICAgaW50IHByaV9ib29zdCwgbnVtY3B1
czsKPj4+IEBAIC0yOTUsMTAgKzMwNywxMCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJn
dltdKQo+Pj4gICAgICAgICBwYXNzX2NyaXRlcmlhID0gQ0hFQ0tfTElNSVQ7Cj4+PiAgICAgICAg
IHJ0X2luaXQoImhpbjoiLCBwYXJzZV9hcmdzLCBhcmdjLCBhcmd2KTsKPj4+Cj4+PiAtICAgICAg
IG51bWNwdXMgPSBzeXNjb25mKF9TQ19OUFJPQ0VTU09SU19PTkxOKTsKPj4+ICsgICAgICAgbnVt
Y3B1cyA9IGdldF9udW1jcHVzKCk7Cj4+Cj4+Cj4+IE1heWJlIHdlIGNvdWxkIG1ha2UgdXNlIG9m
IExUUCBsaWIgZnVuY3Rpb24gdHN0X25jcHVzX2F2YWlsYWJsZSBkaXJlY3RseT8KPj4gU2VlbXMg
dGhlIG5ldyBnZXRfbnVtY3B1cygpIGRpZCBhIGR1cCB3b3JrIG9uIHRoYXQuCj4KPgo+IE9vcHMs
IHNlZW1zIHRoZSByZWFsLXRpbWUgdGVzdHMgZG9lcyBub3QgaW5jbHVkZSBsdHAgbGlicmFyeS4K
PiBTbyB5b3UgcGF0Y2ggbWFrZSBzZW5zZSBmcm9tIHRoaXMgcG9pbnQsIGJ1dCBtYXliZSB3ZQo+
IG5lZWQgdG8gcmVmaW5lIHRoZSBmdW5jdGlvbiB0byBjb25zaWRlciBtb3JlIHNpdHVhdGlvbnMu
Cj4KPiBlLmcuIHVzZXMgYSBmaXhlZC1zaXplIGNwdV9zZXRfdCBzdHJ1Y3R1cmUsIHdoaWNoIG1p
Z2h0IG5vdCBiZQo+IHN1ZmZpY2llbnQgb24gc3lzdGVtcyB3aXRoIGEgbGFyZ2UgbnVtYmVyIG9m
IENQVXMuCj4KPgo+Pgo+Pgo+PiBPdGhlcndpc2UsIGxvb2tzIGdvb2QgdG8gbWUuCj4+Cj4+Pgo+
Pj4gLSAgICAgICAvKiBNYXggbm8uIG9mIGJ1c3kgdGhyZWFkcyBzaG91bGQgYWx3YXlzIGJlIGxl
c3MgdGhhbi9lcXVhbCB0aGUgbm8uIG9mIGNwdXMKPj4+IC0gICAgICAgICAgT3RoZXJ3aXNlLCB0
aGUgYm94IHdpbGwgaGFuZyAqLwo+Pj4gKyAgICAgICAvKiBNYXggbm8uIG9mIGJ1c3kgdGhyZWFk
cyBzaG91bGQgYWx3YXlzIGJlIGxlc3MgdGhhbi9lcXVhbCB0aGUgbm8uIG9mCj4+PiArICAgICAg
ICAgIGhvdXNla2VlcGluZyBjcHVzLiBPdGhlcndpc2UsIHRoZSBib3ggd2lsbCBoYW5nICovCj4+
Pgo+Pj4gICAgICAgICBpZiAocnRfdGhyZWFkcyA9PSAtMSB8fCBydF90aHJlYWRzID4gbnVtY3B1
cykgewo+Pj4gICAgICAgICAgICAgICAgIHJ0X3RocmVhZHMgPSBudW1jcHVzOwo+Pj4gLS0KPj4+
IDIuNDUuMgo+Pj4KPj4KPj4KPj4gLS0KPj4gUmVnYXJkcywKPj4gTGkgV2FuZwo+Cj4KPgo+IC0t
Cj4gUmVnYXJkcywKPiBMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
