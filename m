Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3097BC02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:13:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8C673C7BD7
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 13:13:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D339C3C7BCF
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:13:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 38AE16396F7
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:13:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737029598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Zwwa44e/GUClgycDiqSsTLF4hhJhvuM8NK8dEQmaOg=;
 b=GW8x2ZUzr2KhLPtLj71ASD/KIbKNxIpu7gwM7Ww6rgaQxb8Qw2UPBQFGVo3xfguXmZrhJa
 CcWKIVsB9oWGEcplJif3PD43BAtF/BS8orfL/f0DukGLtygC6wQCiLidsw34SRTCzq/rNK
 4ykUU88Nqyik7gakHQ3FzITHN1tFNyE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-FMwhP46sOJeRONbxJAEFDg-1; Thu, 16 Jan 2025 07:13:16 -0500
X-MC-Unique: FMwhP46sOJeRONbxJAEFDg-1
X-Mimecast-MFC-AGG-ID: FMwhP46sOJeRONbxJAEFDg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef8c7ef51dso1958596a91.1
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 04:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737029596; x=1737634396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Zwwa44e/GUClgycDiqSsTLF4hhJhvuM8NK8dEQmaOg=;
 b=s8D08v8Mkd3W0b8SzvqJvG1ydB2V4LBc5kTWpoVbio9i1+z8N7XgREzQZJKxhJl457
 m1LjeqZlV1TfQp5EZyEfcKNbIUS/LUmOJmExXPNJjIYakC1ueYb6VY2B4TrXZe3YPxas
 AEjD0LzQHUr3iSu15+NxOSMTkszv2TZZklFZjU4R4wFK6aGQZslEnu+aD9QBOJy0KBa8
 06GV3h7pYVmzh3peCS6G8hTMtO7kx7w0ErM5q3KXboEFYQ+jkt/1kcOtRchFCdMHrhf+
 9OCDqYzipFIXXIajVVTHRqULTcHatGtNuprZQM67IdMAB4Mf8juhFwxxp6kp7cY52lM/
 NfeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc9A/4tRWipl56+QaNlKM0BXoBkbOKXmF6jCiFwOR86mKHVAJRBkJ0MAY2z57pjJml8hI=@lists.linux.it
X-Gm-Message-State: AOJu0YwZUwma54X+/WR7RM7ZLFBZFFAaVuUMtgokdr4ODxbqQulKqKe9
 1IPlwXKsiVzTAmOE7lOgFAP+OB6paycZgwFrM+eSOskhKcegA60qm6ASyqmbi22fnkuVFCpO2pp
 Ch710FKI9dmwWs9Mic16vkGjfX0aoWwC88a69sZRKyNMAPHkaiwV8K0ADRoSzSkyGST94XwYbLT
 Uk8PDKl+bka5PbigCbb34m+wU=
X-Gm-Gg: ASbGncucaXVtzYikNMzN2dyMhSLj9R8U6eyjduVY5ZZcJLfRwrRWFVSmtgesGzTe8SN
 vwOBPfyl3LC2VgXRkt1B1TpYBj63MQIhaRGUP7H8=
X-Received: by 2002:a17:90b:33cc:b0:2ee:e2f6:8abc with SMTP id
 98e67ed59e1d1-2f728dd4184mr10060494a91.10.1737029594741; 
 Thu, 16 Jan 2025 04:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq0WIG6ILgFDKNqYrrMmTHGJ9eKzzej4I70JFWkTnOXj0YMYd8gKhHrHEhSrQf5royxDFbjburyDg0aYDLX9k=
X-Received: by 2002:a17:90b:33cc:b0:2ee:e2f6:8abc with SMTP id
 98e67ed59e1d1-2f728dd4184mr10060341a91.10.1737029593005; Thu, 16 Jan 2025
 04:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
 <20250116083812.GB670376@pevik>
 <CAEemH2d6RJ8yd4TcLt-z49fmNKt7eAGg=VhdASkNtE=7cR7bgg@mail.gmail.com>
In-Reply-To: <CAEemH2d6RJ8yd4TcLt-z49fmNKt7eAGg=VhdASkNtE=7cR7bgg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jan 2025 20:13:01 +0800
X-Gm-Features: AbW1kvaOy9qx-5OvrAmmwS88ca0mrKM2DuTWJE7zIVDl_lSfITKd_O-mHFhoRMk
Message-ID: <CAEemH2c5jkRW77RG5QY0FsE4VuzQsch5V9rzH04igXNnr62qiQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 08EKnHfGKbw008dG4xRjXodzS4GgUFVXuAF4QGF3Nvc_1737029596
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [REGRESSION] Broken tests using tst_net.sh by 893ca0abe7
 (was: [PATCH 1/2] lib: multiply the timeout if detect slow kconfigs)
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgODoxMOKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4KPgo+IE9uIFRodSwgSmFuIDE2LCAyMDI1IGF0IDQ6MzjigK9QTSBQZXRy
IFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPj4gLi4uCj4+ID4gPiBpbml0X2x0cF9u
ZXRzcGFjZSgpCj4+ID4gPiB7Cj4+ID4gPiAgICAgICAgIC4uLgo+PiA+ID4gICAgICAgICAgICAg
ICAgIHBpZD0iJChST0QgdHN0X25zX2NyZWF0ZSBuZXQsbW50KSIKPj4gPiA+ICAgICAgICAgLi4u
Cj4+ID4gPiAgICAgICAgIGV4cG9ydCBMVFBfTkVUTlM9IiR7TFRQX05FVE5TOi10c3RfbnNfZXhl
YyAkcGlkIG5ldCxtbnR9Igo+Pgo+PiA+ID4gSSB3aWxsIHByb2JhYmx5IHNvbHZlIGl0IGJ5IGFk
ZGluZyB5ZXQgYW5vdGhlciBwYXJhbWV0ZXIgdG8KPj4gPiA+IHRzdF9yaG9zdF9ydW4oKSwKPj4g
PiA+IHdoaWNoIGlnbm9yZXMgc3RkZXJyIGFuZCB1c2UgaXQgZm9yIHRzdF9uc197Y3JlYXRlLGV4
ZWN9LiBCdXQgbWF5YmUKPj4gdGhlcmUKPj4gPiA+IGlzCj4+ID4gPiBhbm90aGVyIHNvbHV0aW9u
IChvciBhbm90aGVyIHByb2JsZW0pLgo+Pgo+Pgo+PiA+IE9yLCBhbm90aGVyIHdheSBpcyBqdXN0
IHRvIHNldCAndHN0X3Rlc3QtPnRpbWVvdXQgPT0KPj4gVFNUX1VOTElNSVRFRF9USU1FT1VUJwo+
PiA+IGluIHRob3NlIHRlc3RjYXNlL2xpYiB0b29scy4KPj4KPj4gT3IsIHdlIGNvdWxkIGhhdmUg
eWV0IGFub3RoZXIgZmxhZyBUU1RfU0tJUF9TTE9XX0RFVEVDVElPTiB3aGljaCBjb3VsZCBiZQo+
PiB1c2VkCj4+IGZvciB0aGVzZSB0b29scy4KPj4KPgo+IFNvdW5kcyBiZXR0ZXIuIEJ1dCBtYXli
ZSBuYW1lIGl0IFRTVF9OT19TTE9XX0NPTkZJR19DSEVDSyA/Cj4KCkFoLCB0eXBvIHdpdGggbWlz
c2luZyAnSycuCgpzL1RTVF9OT19TTE9XX0NPTkZJR19DSEVDSy9UU1RfTk9fU0xPV19LQ09ORklH
X0NIRUNLCgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
