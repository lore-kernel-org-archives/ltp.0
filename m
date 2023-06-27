Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A406EB64D7
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 01:27:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 228063CE1A4
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 03:27:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F6DA3C99BA
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 03:26:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93056600714
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 03:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687829214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Afz2Rhxk1CWuqI7uFC5PjDu0KIvmYbLVUed5tStnbFY=;
 b=cXyYhooEBmHPMqKGiUJLzGuDegigRhEwP+vhw/iXr5xF0CYmEbfOImrSX8Yxp/h2Gb7wHT
 Gpb0N8cAj+KvSiSavSjmSm+L0AeCT5i08QFzzBVYWYX+XCurok4vd9xOiZyp23gfTlOsQk
 ZC5slY6s5H4r9Z3pR0s9tqEuVqF+ziA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-n9_AEeyDMZqUPIiyffijOQ-1; Mon, 26 Jun 2023 21:26:52 -0400
X-MC-Unique: n9_AEeyDMZqUPIiyffijOQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b69de8fb27so16936741fa.3
 for <ltp@lists.linux.it>; Mon, 26 Jun 2023 18:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687829211; x=1690421211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Afz2Rhxk1CWuqI7uFC5PjDu0KIvmYbLVUed5tStnbFY=;
 b=GR/eWwlC8bQjPh1jlrNx8mk2/46cV+U3NzCTAa6DnTSiGLFD5aSLwm9PO9UgwYVzVL
 CnKH3gDInAGaDjULv5bGFR6GaIHzc+NXhI8euOQt+OOdA7/hUNJ7KHJZ5GuhQLTUCiDM
 PjVJyuYvmvDzD9v4VKu+1Ukw00kHKEeq84Z+S05fW5DiVR8++O8ecOj7lJzSnjClJpP5
 lLcErcowdMoRbhWkLcFi9KQfpUpQtvzCIcLd7MDzU8wl8bmdzFIIUNEOw638Cjrq3dpY
 PKuvDUSjcJODAVTrKuzhGU719oBSL5Lpy78rrrMaXq8cDB/2/8N880MpjkTlv2HyaWSW
 2mIQ==
X-Gm-Message-State: AC+VfDwb+mw+TG6atm7cdHrgzTxcEp0j+iAczbjposNkuiU4Zo7wkYrG
 JKahcKIWCh7HQxrlo/5VfnoW2ZANfYbZ6ZBtyM0DWyXo/WJZEQu2sOdNKopAaMNG1lgf7bphY4V
 V6VY8XnTZ2ApbsjZpSDVsW+ikFyo=
X-Received: by 2002:a2e:80d0:0:b0:2b5:9f54:e290 with SMTP id
 r16-20020a2e80d0000000b002b59f54e290mr4597441ljg.0.1687829210927; 
 Mon, 26 Jun 2023 18:26:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nY9SEw19v+Poc0s0LuoY3b9/E21AF0VPZDMaQ3fEBDv1hQYVG795LxndUsR/EAhep6nlw1vYeuTRvcLgWaIY=
X-Received: by 2002:a2e:80d0:0:b0:2b5:9f54:e290 with SMTP id
 r16-20020a2e80d0000000b002b59f54e290mr4597433ljg.0.1687829210547; Mon, 26 Jun
 2023 18:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
 <ZJlZD2fVXaVM3X5i@yuki>
In-Reply-To: <ZJlZD2fVXaVM3X5i@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Jun 2023 09:26:38 +0800
Message-ID: <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: minachou@andestech.com, tim609@andestech.com, x5710999x@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMjYsIDIwMjMgYXQgNToyMuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBZb3UgcG9pbnRlZCB0aGUgc2VnbWVudCBmYXVsdCBv
bmx5IGV4aXN0cyBvbiAzMmJpdCB3aGVuIHVzZQo+ID4gbGliYyB3cmFwcGVyLCBidXQgdGhpcyBj
b25kaXRpb24gc2tpcHMgZm9yIGJvdGggNjRhbmQzMiBiaXRzLAo+ID4gaXNuJ3QgaXQ/Cj4gPgo+
ID4gSSBndWVzcyB0aGUgc3RyaWN0IGNvbmRpdGlvbiBzaG91bGQgYmUgYXMgYmVsb3c/Cj4gPgo+
ID4gICAgIGlmICh0Y2FzZXNbaV0uZXJyb3IgPT0gRUZBVUxUICYmIHR2LT5zaG1jdGwgPT0gbGli
Y19zaG1jdGwgJiYKPiA+IHRzdF9rZXJuZWxfYml0cygpID09IDMyKSB7Cj4gPiAgICAgLi4uCj4g
PiAgICAgfQo+Cj4gQWN0dWFsbHkgSSB0aGluayB0aGF0IGl0IG1heSBiZSBzYWZlciB0byBza2lw
IGxpYmMgdmVyc2lvbiByZWdhcmRsZXNzLAo+IGFzIGxvbmcgYXMgd2UgaGF2ZSB0aGUgcmF3IHN5
c2NhbGwgdGVzdCBpbiBwbGFjZSB3ZSBhcmUgbm90IGdldHRpbmcgYW55Cj4gbW9yZSBjb3ZlcmFn
ZSBmcm9tIHBhc3NpbmcgaW52YWxpZCBhZGRyZXNzIHRvIHRoZSBsaWJjIGNhbGwsIHNpbmNlCj4g
ZWl0aGVyIHRoZSBsaWJjIGNhbGwgaXMgdGhpbiB3cmFwcGVyLCBpLmUuIGVxdWl2YWxlbnQgdG8g
dGhlIHN5c2NhbGwoKQo+IGNhbGwgd2hpY2ggd2UgYWxyZWFkeSB0ZXN0LCBvciBpdCBkb2VzIHNv
bWV0aGluZyB0byB0aGUgYXJndW1lbnRzLCBpbgo+IHdoaWNoIGNhc2UgaXQncyBwb3NzaWJsZSB0
byB0cmlnZ2VyIHNlZ2ZhdWx0LCBpZiBub3Qgbm93IGluIHNvbWUgZnV0dXJlCj4gbGliYyB2ZXJz
aW9ucy4KPgoKT2theSwgc291bmRzIHJlYXNvbmFibGUuIEkgYWdyZWUgd2l0aCB0aGlzLgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
