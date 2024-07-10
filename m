Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437E2C3DA42
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 06:27:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EF9E3D3841
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:27:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AECE33D381B
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 08:27:40 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A68E1000F23
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 08:27:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720592857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SUrDDOmLcpMkGaMTWlOO494BuQeTU3aFsDl37bDJ6q8=;
 b=N8r481p49qjrVe4E7tQMnJIQwLeMz+tewZajoRav4c+wG7cK5Hce7b0ZFt/Oib+Csc+pkc
 2Rcx/gdbCZRIIlODCpZEjieVkkwjEzcmzm3V/BeLqyZJ3lxHFakfbKXiEtMiJZdRHRcwfO
 6eB/jooEeI8TRuzH5tRkAQiHcQzKSxo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-tfo0ylusPECwdRXc4VFgAw-1; Wed, 10 Jul 2024 02:27:34 -0400
X-MC-Unique: tfo0ylusPECwdRXc4VFgAw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c963f358feso5782135a91.3
 for <ltp@lists.linux.it>; Tue, 09 Jul 2024 23:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720592853; x=1721197653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUrDDOmLcpMkGaMTWlOO494BuQeTU3aFsDl37bDJ6q8=;
 b=uTzabXMv79ULjHi4CMtlGWZN+Z3ZrDe0qPrfYCTgBRTLlj10Pse56I/LsN0hZQ7RPW
 Bfo3A43ysaLjV8Q7TRNyCDWzWEWOF7ZEcVNzU92zWmeprUoWJUTM31Id8aPdDwXrQkSS
 toXp5CDu3erbwiol4LMItIZLyOoKsRtiD70c83qUkHSIjUifAM3P/GrAGC1OM8PLlWAp
 +zwojIzXQf9invC7c6w1s6Y/IE4yVv7WwUJK6ZEY3loxRONdVush8wNh4mrNknoZgkCa
 kQW1NOAOx8o8rRlmKPYefiBSDWLUImCZigk5qu5xGj+Z6SoTUu2dn/72yjCfNiOGRZUs
 zhDw==
X-Gm-Message-State: AOJu0Yx6DMWh+gvABcb+xRLBgLWEEaHzZth9FOqv75do1HQPwZ7nv4lV
 cIRAf4GcmZwlbIrjy+hyg5xRrOLfAq2xvRus9K1a7MorbvzknrJLB5L+Zu9XsQzuaY2RF97D36G
 i2xFKzuyy3p1T8RCe6JR+XgNnOfQtkhNL9rrfy+9hQtKf999rhgBx5uR7lonffusZ8QFVtZG5wI
 Z/X0j7omZkqU8aL1o5E05B4+U=
X-Received: by 2002:a17:90b:3104:b0:2c8:bf72:5389 with SMTP id
 98e67ed59e1d1-2ca35be1c6cmr4408785a91.9.1720592853304; 
 Tue, 09 Jul 2024 23:27:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq56gpsCaxLZR3kIkXdnKHyyMFX3p5Ss4BUsnnI5KaE/jD0Vk3qv2j0TEgfi476LXd6pHRY2UkvqH0whS96l0=
X-Received: by 2002:a17:90b:3104:b0:2c8:bf72:5389 with SMTP id
 98e67ed59e1d1-2ca35be1c6cmr4408779a91.9.1720592852926; Tue, 09 Jul 2024
 23:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240710032434.123315-1-shichen@redhat.com>
 <CAEemH2dKQGDst4074Pzz6b2aQDP4qdeuyVOnwY+ZYMh0BrDD=w@mail.gmail.com>
In-Reply-To: <CAEemH2dKQGDst4074Pzz6b2aQDP4qdeuyVOnwY+ZYMh0BrDD=w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 10 Jul 2024 14:27:20 +0800
Message-ID: <CAEemH2f=PzW68A2NzdfM0BDNKRHX4sfytCkzN4oG-USPHuJk9g@mail.gmail.com>
To: Shizhao Chen <shichen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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

T24gV2VkLCBKdWwgMTAsIDIwMjQgYXQgMjoxM+KAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gSGkgU2hpemhhbywKPgo+IE9uIFdlZCwgSnVsIDEwLCAyMDI0IGF0IDEx
OjI04oCvQU0gU2hpemhhbyBDaGVuIDxzaGljaGVuQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4+IEJ5
IGRlZmF1bHQgdGhlIHRlc3Qgc3RhcnRzIE4tMSBidXN5IHRocmVhZHMgdG8gbW9ub3BvbGl6ZSBO
LTEgYXZhaWxhYmxlCj4+IENQVXMsCj4+IHdoZXJlIE4gaXMgdGhlIG51bWJlciBvZiBhbGwgYXZh
aWxhYmxlIENQVXMuIEhvd2V2ZXIsIHdoZW4gQ1BVIGlzb2xhdGlvbgo+PiBpcwo+PiBhcHBsaWVk
LCB0aGlzIHdpbGwgbGVhZCB0byBhIGhhbmcgc2NlbmFyaW8gd2hlcmUgYWxsIGhvdXNla2VlcGlu
ZyBDUFVzIGFyZQo+PiBob2dnZWQgYXMgaXNvbGF0ZWQgQ1BVcyBkbyBub3Qgc2hhcmUgdGhlIE4t
MSBidXN5IHRocmVhZHMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNoaXpoYW8gQ2hlbiA8c2hpY2hl
bkByZWRoYXQuY29tPgo+PiAtLS0KPj4gIC4uLi9yZWFsdGltZS9mdW5jL3ByaW8tcHJlZW1wdC9w
cmlvLXByZWVtcHQuYyAgfCAxOCArKysrKysrKysrKysrKystLS0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL3JlYWx0aW1lL2Z1bmMvcHJpby1wcmVlbXB0L3ByaW8tcHJlZW1wdC5jCj4+IGIvdGVz
dGNhc2VzL3JlYWx0aW1lL2Z1bmMvcHJpby1wcmVlbXB0L3ByaW8tcHJlZW1wdC5jCj4+IGluZGV4
IDliZDVlN2FkOC4uNzlkMjExNWE3IDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMvcmVhbHRpbWUv
ZnVuYy9wcmlvLXByZWVtcHQvcHJpby1wcmVlbXB0LmMKPj4gKysrIGIvdGVzdGNhc2VzL3JlYWx0
aW1lL2Z1bmMvcHJpby1wcmVlbXB0L3ByaW8tcHJlZW1wdC5jCj4+IEBAIC01OSw2ICs1OSw3IEBA
Cj4+ICAgKgo+Pgo+PiAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KPj4KPj4gKyNkZWZpbmUgX0dOVV9T
T1VSQ0UKPj4gICNpbmNsdWRlIDxzdGRpby5oPgo+PiAgI2luY2x1ZGUgPHN0ZGxpYi5oPgo+PiAg
I2luY2x1ZGUgPHNpZ25hbC5oPgo+PiBAQCAtMjg3LDYgKzI4OCwxNyBAQCB2b2lkICptYXN0ZXJf
dGhyZWFkKHZvaWQgKmFyZykKPj4gICAgICAgICByZXR1cm4gTlVMTDsKPj4gIH0KPj4KPj4gK2lu
dCBnZXRfbnVtY3B1cyh2b2lkKQo+PiArewo+PiArICAgICAgIGNwdV9zZXRfdCBtYXNrOwo+PiAr
ICAgICAgIENQVV9aRVJPKCZtYXNrKTsKPj4gKwo+PiArICAgICAgIC8qIEdldCB0aGUgbnVtYmVy
IG9mIGNwdXMgYWNjZXNzaWJsZSB0byB0aGUgY3VycmVudCBwcm9jZXNzICovCj4+ICsgICAgICAg
c2NoZWRfZ2V0YWZmaW5pdHkoZ2V0cGlkKCksIHNpemVvZihtYXNrKSwgJm1hc2spOwo+PiArCj4+
ICsgICAgICAgcmV0dXJuIENQVV9DT1VOVCgmbWFzayk7Cj4+ICt9Cj4KPiArCj4+ICBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+PiAgewo+PiAgICAgICAgIGludCBwcmlfYm9vc3Qs
IG51bWNwdXM7Cj4+IEBAIC0yOTUsMTAgKzMwNywxMCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQo+PiAgICAgICAgIHBhc3NfY3JpdGVyaWEgPSBDSEVDS19MSU1JVDsKPj4gICAg
ICAgICBydF9pbml0KCJoaW46IiwgcGFyc2VfYXJncywgYXJnYywgYXJndik7Cj4+Cj4+IC0gICAg
ICAgbnVtY3B1cyA9IHN5c2NvbmYoX1NDX05QUk9DRVNTT1JTX09OTE4pOwo+PiArICAgICAgIG51
bWNwdXMgPSBnZXRfbnVtY3B1cygpOwo+Pgo+Cj4gTWF5YmUgd2UgY291bGQgbWFrZSB1c2Ugb2Yg
TFRQIGxpYiBmdW5jdGlvbiB0c3RfbmNwdXNfYXZhaWxhYmxlIGRpcmVjdGx5Pwo+IFNlZW1zIHRo
ZSBuZXcgZ2V0X251bWNwdXMoKSBkaWQgYSBkdXAgd29yayBvbiB0aGF0Lgo+CgpPb3BzLCBzZWVt
cyB0aGUgcmVhbC10aW1lIHRlc3RzIGRvZXMgbm90IGluY2x1ZGUgbHRwIGxpYnJhcnkuClNvIHlv
dSBwYXRjaCBtYWtlIHNlbnNlIGZyb20gdGhpcyBwb2ludCwgYnV0IG1heWJlIHdlCm5lZWQgdG8g
cmVmaW5lIHRoZSBmdW5jdGlvbiB0byBjb25zaWRlciBtb3JlIHNpdHVhdGlvbnMuCgplLmcuIHVz
ZXMgYSBmaXhlZC1zaXplIGNwdV9zZXRfdCBzdHJ1Y3R1cmUsIHdoaWNoIG1pZ2h0IG5vdCBiZQpz
dWZmaWNpZW50IG9uIHN5c3RlbXMgd2l0aCBhIGxhcmdlIG51bWJlciBvZiBDUFVzLgoKCgo+Cj4g
T3RoZXJ3aXNlLCBsb29rcyBnb29kIHRvIG1lLgo+Cj4KPj4gLSAgICAgICAvKiBNYXggbm8uIG9m
IGJ1c3kgdGhyZWFkcyBzaG91bGQgYWx3YXlzIGJlIGxlc3MgdGhhbi9lcXVhbCB0aGUKPj4gbm8u
IG9mIGNwdXMKPj4gLSAgICAgICAgICBPdGhlcndpc2UsIHRoZSBib3ggd2lsbCBoYW5nICovCj4+
ICsgICAgICAgLyogTWF4IG5vLiBvZiBidXN5IHRocmVhZHMgc2hvdWxkIGFsd2F5cyBiZSBsZXNz
IHRoYW4vZXF1YWwgdGhlCj4+IG5vLiBvZgo+PiArICAgICAgICAgIGhvdXNla2VlcGluZyBjcHVz
LiBPdGhlcndpc2UsIHRoZSBib3ggd2lsbCBoYW5nICovCj4+Cj4+ICAgICAgICAgaWYgKHJ0X3Ro
cmVhZHMgPT0gLTEgfHwgcnRfdGhyZWFkcyA+IG51bWNwdXMpIHsKPj4gICAgICAgICAgICAgICAg
IHJ0X3RocmVhZHMgPSBudW1jcHVzOwo+PiAtLQo+PiAyLjQ1LjIKPj4KPj4KPgo+IC0tCj4gUmVn
YXJkcywKPiBMaSBXYW5nCj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
