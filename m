Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EF9C021B3
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 08:24:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A76CD3C7D23
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 09:24:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 498893C239D
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:24:39 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 03F5A1A001B7
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 09:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740126277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdbqVKqPRbuhFMXHiVCkBcxM2EQPPwWaER2pu/Xwbww=;
 b=Tb+gZJzVSJ74xAS1dp0FTP73XxvDFmeV3QP1xNjjIrvPYrp0Uc5yKArm34Rp+4hdoN4YP0
 9kZxKr71n6wr/87aNJ8xj+FcnybVOZ++shMFHykYyEiCEzggbqyfQp914M8z5VGtPeIQoc
 Z9zKZ/S74k95TQvtseaXPaSSJRYHm6o=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-C8XTFHHbMu-EVpIOiWKsUw-1; Fri, 21 Feb 2025 03:24:35 -0500
X-MC-Unique: C8XTFHHbMu-EVpIOiWKsUw-1
X-Mimecast-MFC-AGG-ID: C8XTFHHbMu-EVpIOiWKsUw_1740126275
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4be16bebebdso397375137.0
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 00:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740126275; x=1740731075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdbqVKqPRbuhFMXHiVCkBcxM2EQPPwWaER2pu/Xwbww=;
 b=uONU1FPOTZLfaf6vSWO14IJiB4ANJqJEjejc+gfHXQMbi9c9ZH+y/6HJRIO6auc9GI
 S0Va3uNxOPV/ZxArm213eH9QivSGzgyaKdQoCFZMDm0WdnEwQlCXxffEeX07/UfVAtMR
 nBgoG8M3PSzm95Sj7U1af/ivDrJNqxnpOBTgDCwPY8BJ8I7TKWVju+XT2u8o7LrBM0lA
 7txLQVPP0S3dPBL/dgQKUnplaLRFGRYfiY7GNSs5eGwBc4SyDQwdsakC8L+i2U+GJVZV
 RYPtW8Nl3LzOyn1pPeXXXBVV3g3eriCKJ7CJeJPv/Yyghc54crVRRbiTvWs6bQxcWdgr
 GfxA==
X-Gm-Message-State: AOJu0YzGQXLtj3N3SibzUvbOfCXfhWz5s8j8Kcof6C6KgLRH7QO3D9gJ
 DioIvN7qClswCzSGNg9fC0bSK2Z+jK9aU6TJyovGeDQRQoSur9kC2/oI7WWvaoQYzVyF67St/WJ
 tfMvsRCjXkXMWMmVPWcSL5HcCx559GtLTOKhq6J3u1zm1eSoNNTJ74O5B3v3a/WZNlR+UP3+oaC
 Xk0Avte5xWUgaD5IgyDxXk7tI=
X-Gm-Gg: ASbGncuNegjhatzTIyo0/tfLAKe90tFErgoSnorRJa7m877TjwwkAc8ew9Lp+Q08SSM
 C4XzZEApCuFA5LPHrFZAbX/+XC0HQfrT7tjJ6o4Nvkm9vovotbSJvJIXh7pt8xy1/fCvDOA==
X-Received: by 2002:a05:6102:944:b0:4bb:cdc0:5dd7 with SMTP id
 ada2fe7eead31-4bfc01dbb8dmr1315566137.16.1740126275121; 
 Fri, 21 Feb 2025 00:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA3IJ8ylV1BnOsJLZgXtEOtPJ+CjuyuIpNW6MjeTKs7cRgnfETxwk1slSHa3lQ2SKFYgN308McbnILQXxHGpE=
X-Received: by 2002:a05:6102:944:b0:4bb:cdc0:5dd7 with SMTP id
 ada2fe7eead31-4bfc01dbb8dmr1315560137.16.1740126274778; Fri, 21 Feb 2025
 00:24:34 -0800 (PST)
MIME-Version: 1.0
References: <b379b9603036d9d4877f562f750e2d1515dfd962.1740042744.git.jstancek@redhat.com>
 <Z7cPUCOZeJZipmo0@yuki.lan>
 <CAASaF6xatMLYako=PojafDZxEn_GorTcB1NhKtV1kv=BZogsOQ@mail.gmail.com>
In-Reply-To: <CAASaF6xatMLYako=PojafDZxEn_GorTcB1NhKtV1kv=BZogsOQ@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 21 Feb 2025 09:24:18 +0100
X-Gm-Features: AWEUYZlaKGQsVVVO1JgJtJyZE5jiaDal047abP2yiVqhE6fysiPuMcMu1Gh1Cos
Message-ID: <CAASaF6xJkkE8NEnDRwYEqs_abZxJqiuMnou+d=mYxmLRPddNKg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ezotmtKRdu57Jzqu2xSTQmcs_LAzuwJp3BHCFS7p-4s_1740126275
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/utime03: relax the check for 1 second
 difference
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBGZWIgMjAsIDIwMjUgYXQgMjo0NOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgRmViIDIwLCAyMDI1IGF0IDEyOjE34oCvUE0g
Q3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+ID4KPiA+IEhpIQo+ID4gPiBU
aGUgdGVzdCBpcyB1c2luZyB0c3RfZ2V0X2ZzX3RpbWVzdGFtcCgpIHdoaWNoIGlzIHVzaW5nIFJF
QUxUSU1FX0NPQVJTRQo+ID4gPiBjbG9jaywgd2hpY2ggaXMgc2xpZ2h0bHkgbGVzcyBhY2N1cmF0
ZS4gQmFjayBpbiAyMDIyIHdlIGFkZGVkIGV4dHJhIGxvZwo+ID4gPiBtZXNzYWdlIHRvIHByaW50
IGFsc28gbWluIGFuZCBtYXggdGltZS4gSW4gdGhvc2UgcmFyZSBpbnN0YW5jZXMgd2hlcmUKPiA+
ID4gaXQgZmFpbHMgdGhpcyBleHRyYSBsb2cgc2hvd3MgaXQgZmFpbGVkIGJ5IG9uZSBzZWNvbmQg
ZGlmZmVyZW5jZS4KPiA+ID4KPiA+ID4gUmVsYXggdGhlIGNoZWNrIGEgbGl0dGxlLiBUZXN0ZWQg
b24gYWFyY2g2NCBWTXMsIHdoZXJlIGl0J3MgdXN1YWxseQo+ID4gPiByZXByb2R1Y2libGUgYWZ0
ZXIgY291cGxlIGh1bmRyZWQgaXRlcmF0aW9ucy4KPiA+Cj4gPiBBcmVuJ3Qgd2UganVzdCBtYXNr
aW5nIGEga2VybmVsIGJ1ZyBoZXJlPyBCYWNrIHRoZW4gd2UgZGlzY3Vzc2VkIHRoaXMKPiA+IHdp
dGgga2VybmVsIGRldnMgYW5kIHRoZXkgdG9sZCB1cyB0aGF0IGZpbGVzeXN0ZW1zIHVzZSBSRUFM
VElNRV9DT0FSU0UKPiA+IGludGVybmFsbHksIHNvIHRoaXMgc2hvdWxkbid0IHJlYWxseSBmYWls
Lgo+Cj4gSSBzZWUgdGhlIGZhaWx1cmVzIHJlc3VyZmFjaW5nIGFyb3VuZCA2LjEzLXJjMS4KPiBG
cm9tIGNvbW1pdCA0ZTQwZWZmMGI1NzMgKCJmczogYWRkIGluZnJhc3RydWN0dXJlIGZvciBtdWx0
aWdyYWluIHRpbWVzdGFtcHMiKQo+IHRoZSBjb21tZW50IG9uIGN1cnJlbnRfdGltZSgpIG5vdyBz
YXlzICJSZXR1cm4gRlMgdGltZSAocG9zc2libHkgZmluZS1ncmFpbmVkKSIuCgpJdCBpcyB0aGUg
c2VyaWVzIHRoYXQgYWRkcyBtdWx0aWdyYWluIHRpbWVzdGFtcHMuIFNvIHdlIGNvdWxkIG1ha2Ug
dGhlIG1heHRpbWUKdXNlIFJFQUxUSU1FIGNsb2NrIGlmICIrMSIgc2Vjb25kIGZlZWxzIHRvbyBi
cm9hZC4KCj4KPiBNYXliZSB3ZSBoaXQgYSBwb2ludCB3aGVyZSBpbnRlcm5hbHMgY2hhbmdlZD8g
SSdsbCBzZWUgaWYgSSBjYW4gbmFycm93Cj4gaXQgZG93biBmdXJ0aGVyCj4gd2l0aCBiaXNlY3Qu
Cj4KPiA+Cj4gPiBXaGF0IGZpbGVzeXN0ZW0gaXMgdGhpcz8gRG9lcyBpdCwgYnkgY2hhbmNlLCB1
c2UgbW9yZSBncmFudWFsCj4gPiB0aW1lc3RhbXBzPwo+Cj4gSSBzYXcgaXQgZmFpbCBvbiBleHQy
LCBleHQzIGFuZCB4ZnMuCj4KPiA+Cj4gPiAtLQo+ID4gQ3lyaWwgSHJ1YmlzCj4gPiBjaHJ1Ymlz
QHN1c2UuY3oKPiA+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
