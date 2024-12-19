Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11E5E77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 13:23:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7E763ED420
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:23:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33B693C02D1
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:23:04 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58D8063B713
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 14:23:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734614581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBHccyPkXurUveBP7F5Q6rrevOqLrCilpyeUcRGdoxY=;
 b=Tbxos36Je1UX2BGP4Xq1zb1wU9PFJBrtoZz5ibLIv3YkyTRgsQ7FTpu25F5wJChV4I2sJt
 aWM9x6EC0AXJStQzTDjw8Cwfqc5KtYrSa0eqgeEv+cBSiAQvcU7sJ1kfuTCZz/Q0olQ7rP
 87gfiqzWbLcphriaXKmvVotzce39h6I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-dKFsTia4NimuARB6wpcYiQ-1; Thu, 19 Dec 2024 08:23:00 -0500
X-MC-Unique: dKFsTia4NimuARB6wpcYiQ-1
X-Mimecast-MFC-AGG-ID: dKFsTia4NimuARB6wpcYiQ
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-21655569152so7611225ad.2
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 05:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734614578; x=1735219378;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JBHccyPkXurUveBP7F5Q6rrevOqLrCilpyeUcRGdoxY=;
 b=LQucuIH0Gsk7TugDLVCbzuGOsjIuotilA3sT95JU9pG+Gngmxse/5sS+Wn4AxrrGEo
 WvK7kKY6On3tFEGYS3/8ogL/gw0VE/Mqur8sORdFYphqbJ0zoelsqRpS+ce6g8dK9h88
 vp5oPPCqXj1KsOUJkmIvYr2vz9xQFaqMmGUo0rFcyZxbmbFp29LbBb5Rjjl+ahmfrSlN
 2Yxo7gCWDvef6Rzk5lF+FgeaZ+Do9Lj0XwL2yG4V2lec+yemH+6hb+KD2Tl6aVbalBKM
 LIyWASJIyaZigKUK+2MTsaFG4JK2veHNqB1okmRozTDiaYus88yGUoJCt/UmXZnitkKt
 +pag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDFbcuUOyt402EavTZmX9sroaS/w1SLckvUevbaSmo8gGfxTJ/tuyahrhquzyEiBXOTb0=@lists.linux.it
X-Gm-Message-State: AOJu0YwJXmWiDWe8fQ3fqe9SDpHZOmKqYZbME1lMxrxDBDWWjWlQIuUA
 cjvQR6UDEFWyIwT/LR62NCh5T1AsLC2qAsQmKTffYlYDJlDKcuCCCfTsdrWhTvtvjZjrX4+pj5D
 uVPmNv0yamfZOx+uOm7lWkdsShdGCM7WZWIv+XSwWks/OB9t+AHENccCyfT/tJ1k6qGLQPQpINR
 kGteYgkr16zCSPOYFQS1/lobEGbW8V4uC/Uv8v
X-Gm-Gg: ASbGncuWg7uXa+EK+E80H7NenRogazk/FizorUmH0PZMAo6iqg64poFU5qXDsuUt66J
 Vwf7534YPkK087CuOm4N7cpfJ6y4+pFjNAcEUNB8=
X-Received: by 2002:a17:902:d508:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-218d6fd5ebbmr94783705ad.11.1734614577916; 
 Thu, 19 Dec 2024 05:22:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAUzph7roWdSS9ZEIeD1btfIAE2aEW0A7w5m3RJI0wsMZrhDugsqqxXAuhtNSmpsDRkZyCezbVeoS6cuWmogc=
X-Received: by 2002:a17:902:d508:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-218d6fd5ebbmr94783465ad.11.1734614577637; Thu, 19 Dec 2024
 05:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz>
 <Z2QbRxeekZyxhoCc@yuki.lan>
 <CAEemH2d6_O-JYe1MsDZ4hO5QL+OrDeCESi=GSAYxWVF+1f6J7w@mail.gmail.com>
 <Z2QdUCGAhfPZHDtp@yuki.lan>
In-Reply-To: <Z2QdUCGAhfPZHDtp@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2024 21:22:45 +0800
Message-ID: <CAEemH2ci3i+UTziZZegsQR+C-q_+ri9yHbNZyyGPk8ypAZF3KQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d6BrGYPuYXLHqUiEfYkfsWslS5LDCU9TiBBODOJccRM_1734614579
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

T24gVGh1LCBEZWMgMTksIDIwMjQgYXQgOToxOeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+IFNvdW5kcyBsaWtlIHdlIG5lZWQgdG8gaGF2ZSB0
d28gZGlmZmVyZW50IHJ1bnRpbWUgdmFsdWVzIGluIHRoZSB0ZXN0cywKPiA+ID4gbWF4X3J1bnRp
bWUgd2hpY2ggaXMgdGhlIHRpbWVvdXQgZm9yIHRoZSB0ZXN0IGFuZCBqdXN0IHJ1bnRpbWUgd2hp
Y2ggaXMKPiA+ID4gZm9yIGhvdyBsb25nIHdpbGwgdGhlIHRlc3QgbG9vcC4KPiA+ID4KPiA+Cj4g
PiBBZ3JlZSwgaWYgd2UgZGVmaW5lIHRoZSBsb29waW5nIHJ1bnRpbWUgaW4gYSBzZXBhcmF0ZSB2
YWx1ZSwgdGhhdCB3b3VsZAo+IGJlCj4gPiBoZWxwZnVsLgo+Cj4gVGhlcmUgd2FzIGEgcHJvYmxl
bSB3aXRoIGhhdmluZyB0aGUgdHdvIGRpZmZlcmVudCB2YWx1ZXMgaW4gYSBzaW5nbGUKPiB2YXJp
YWJsZSBiZWZvcmUgYXMgd2VsbC4gV2UgZG8gaGF2ZSB0aGUgTFRQX1JVTlRJTUVfTVVMIHdoaWNo
IG11bHRpcGxpZWQKPiBib3RoIHRoZSB0aW1lb3V0IGFuZCBydW50aW1lLiBUaGVzZSBzaG91bGQg
YmUgc2VwYXJhdGUgbXVsdGlwbGllcnMgYXMKPiB3ZWxsIHdoaWNoIG11bHRpcGxpZWQgYm90aCB0
aGUgdGltZW91dCBhbmQgcnVudGltZS4gVGhlc2Ugc2hvdWxkIGJlCj4gc2VwYXJhdGUgbXVsdGlw
bGllcnMgYXMgd2VsbC4KPgoKSSBub3RpY2VkIHRoYXQgdGVzdHMgdXNpbmcgbWF4X3J1bnRpbWUg
dG8gY29udHJvbCB0aGUgdGVzdCB0aW1lCmFsd2F5cyB1c2UgYW5vdGhlciBmdW5jdGlvbiB0c3Rf
cmVtYWluaW5nX3J1bnRpbWUoKSwgc28gbWF5YmUKd2UgY2FuIHV0aWxpemUgdGhpcyB0byBieXBh
c3MgdGhhdC4KCkxhdGVyIEkgd2lsbCBsb29rIGludG8gZGV0YWlscywgbm93IEkgaGF2ZSBhIG1l
ZXRpbmcgaW4gdGhlIGNvbWluZyAyaC4KCkBQZXRyLCBATWFydGluLCBGZWVsIGZyZWUgdG8gcmV2
ZXJ0IHRoZSB0d28gcGF0Y2hlcyBpZiB5b3UgbmVlZGVkLgoyZGEzMGRmMjRlNjc2ZDVmNGNmY2Yw
YjExNjc0Y2JkZjExYTE5YjhhCjY0ZTExZmVjMDc5NDgwMTc5YWE5NDczYWU1ZTFlOGFkNzhlZjlh
YzMKCgoKPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
