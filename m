Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A7BC7EE31
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751021394; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=XzeLUl+9cfcxf7NRfAOW3mFaI0Jq6rP7COKFC3JhOaY=;
 b=EQq0Z42fcFp9k+pezvY9WVGLJn26WSTPIhWyjpcwORqTyE1jFLPOken3SIHz685bLEP1G
 2aUdeYgRnCMfpkbY6fuV29N1Pn1XZ2rometQuuia1VumYgca0sGq65dExcf2Ks2RQO4bbJ7
 Uda8wpP9DhEOrPUMmgWljenvlpzuyYU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A65E53C7ABD
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 12:49:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B27993C770A
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:49:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B7C9F1A0035E
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:49:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751021372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJSiAtlrujnDRKaWwTWkVVdbyjJCCNCdc0xdw82vQrc=;
 b=dSskyhyH+5F+HwBjGQNYQuSP9QP0scssWP5xRPX3k2fH+sHxEIR2M65rCmWfIF0PaXLlCt
 zlOn6bIry8X6dhEeFiZdXziM2wj573hn/uwO1ikvc47Qq5J0LXR8WmPVoht+adiXSYbdG+
 TJ7VRFal3wkm11WhX8rPs6Cpr/QVXgU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7KEvfzscOFyos2NUo-CCMQ-1; Fri, 27 Jun 2025 06:49:30 -0400
X-MC-Unique: 7KEvfzscOFyos2NUo-CCMQ-1
X-Mimecast-MFC-AGG-ID: 7KEvfzscOFyos2NUo-CCMQ_1751021369
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-311e7337f26so1719167a91.3
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 03:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751021369; x=1751626169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vJSiAtlrujnDRKaWwTWkVVdbyjJCCNCdc0xdw82vQrc=;
 b=XcB1ZfKxF77S/BG6NNOcikBjzf5iwaLrn3tND8d63hJvowxLd3ROkD4YyFvbcwYMEw
 ClHKVaG9yIjBcr13si4IGWjcSFhc+NZVmJZP7lss1BMTVFEOWpVI7gkdTYYj0RNlm6Vn
 FYiqtkMwHO7G6QsMZZz9DJMH8kPkuzERf2S7PFD52q0r0zaePz3+XItZXZbgOsHy9Cwo
 o0nNFmZPeu1ufPNkQvDrXjf0zjoPdeJbp2Xg6jD5qpgCEQR06MyT4zPMfh1QrsWfz4Wj
 Lek1S8cVNXD1v9OyXj+ECoqS12czFFqEUh3OSV2FVEVK7ePfWBP2BG3n/kxFF87Vp4wH
 MiOw==
X-Gm-Message-State: AOJu0Yy3wgeZ9vSouczfWVA+U/kq33NcrN5UZBL+abLEDJxhMdJe9Q2A
 kdOKoP6+nB3W8ZsZ+iVzV2Xhuknd6jgYb8cHo3SsjEdR1zsdB7WbwbNcIlD0qMCEKBmv6FAkZon
 L4+4Kz1ABDG/aQ9sxZYEag6VuMGqGlf+GxWMQXJvksYH95yCZTRUKg+2hAuubda+Gzas47yKjJX
 w8dT7n+mZk1EwMsLaWS19Px6f/DwY=
X-Gm-Gg: ASbGncuUunIPU1jkIFKFYh8A4A/AFLzM33sdB+C49qH+Pp3XJLXVdtHntdSeEXmuNOL
 6O5uYEeNgJEi3iela0Dfu/eWNEoYt+t6AJdVhc/Tm4oWWkfKzKqPGecSi+5bj64qTbHDF1/6IzY
 aCaPWy
X-Received: by 2002:a17:90b:48c7:b0:313:27cc:69cd with SMTP id
 98e67ed59e1d1-318c9225e47mr4882412a91.12.1751021369190; 
 Fri, 27 Jun 2025 03:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl2tyZojY7k3+nxiIV/GRoO3rUzhPwUeD817jorZ1k7FNfuFdr8ZE3qn/n+i5biUcBLc3zMNKzWZuNiDycGQg=
X-Received: by 2002:a17:90b:48c7:b0:313:27cc:69cd with SMTP id
 98e67ed59e1d1-318c9225e47mr4882377a91.12.1751021368727; Fri, 27 Jun 2025
 03:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250616102619.54254-1-liwang@redhat.com>
 <aF1KmkMhXNWBbUwi@yuki.lan>
 <CAEemH2esWnKqv2q-UM3tHoTRfR6caLp-0yZN1yF6XCk79XSOyA@mail.gmail.com>
 <aF5NFP5KpuebdkwV@yuki.lan>
 <CAEemH2fsxXGfE60UP3EU9s8HzPb7msQSoYMg85h6-R5rvD2JKA@mail.gmail.com>
 <aF5wiX08IWeWYS4v@yuki.lan>
 <CAEemH2fYij1tO0Yfb=pcqc0h_XfP4OonR4dO7PcviGP_vkxf3w@mail.gmail.com>
 <aF513oTFTybxPdys@yuki.lan>
In-Reply-To: <aF513oTFTybxPdys@yuki.lan>
Date: Fri, 27 Jun 2025 18:49:17 +0800
X-Gm-Features: Ac12FXzvKtRYoVREPQSVeLaLaaE-tNDA27Uf6-2HUtshXNjzBAJ792CYHUAsliw
Message-ID: <CAEemH2frLtacZWQwo8NQJQnnO3602fHzXDnGoXkZZM4mZxYZFg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r5qJenTbyJHVtEmgyp40s6cT6k0juZyP4ZromhPlNzY_1751021369
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/3] checkpoint: Refactor and unify shell/C reinit
 support
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gMjcsIDIwMjUgYXQgNjo0M+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+ID4gU28sIHdpbGwgeW91IHNlbmQgYSBuZXcgcGF0
Y2ggKG9yIEkgZG8gdGhhdCBpbiBteSBuZXh0IHZlcnNpb24pPwo+ID4gPgo+ID4gPiBJIHdpbGwg
c2VuZCB0aGUgcGF0Y2hzZXQuCj4gPiA+Cj4gPgo+ID4gVGhhbmtzISBBbmQgb25lIG1vcmUgcXVl
c3Rpb246Cj4gPgo+ID4gVGhlIHRzdF9jaGVja3BvaW50X2luaXQoKSBpbiB0c3RfY2hlY2twb2lu
dC5jIGlzIG5vdCB1c2VkIGJ5IGFueSB0ZXN0Cj4gPiBhbmQgbGlicmFyeSwgc2hvdWxkIHdlIGRl
bGV0ZSBpdCAoYW5kIGRlY2xhcmUgdGhhdCB0aGUgSVBDIG9ubHkKPiBpbml0L3JlaW5pdAo+ID4g
YnkgdGhlIHRzdF90ZXN0LmMgZnVuY3Rpb24pPwo+Cj4gVGhlcmUgaXMgYWN0dWFsbHkgYSBkZWZp
bmUgdG8gVFNUX0NIRUNLUE9JTlRfSU5JVCBpbiB0aGUKPiBpbmNsdWRlL29sZC9vbGRfY2hlY2tw
b2ludC5oIGJ1dCBpdCBsb29rcyBsaWtlIHRoZSBsYXN0IHBhcnRzIHdoZXJlIHRoaXMKPiBpcyBj
YWxsZWQgYXJlIG9sZCBsaWJyYXJ5IHRlc3RzIHRoYXQgc2hvdWxkIGJlIHJlbW92ZWQgYWxvbmcg
d2l0aCB0aGF0Lgo+Cj4gQW5kIHRoZSBsYXN0IHRlc3QgdGhhdCB3YXMgdXNpbmcgaXQgYmVmb3Jl
IHJld3JpdGUgd2FzOgo+Cj4gY29tbWl0IGIwNDM3NTFhNjk4NGM0MWRiNjEwNjdlZWJiMGZlZTZl
YmYzMDM5NjAKPiBBdXRob3I6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5kZT4KPiBEYXRlOiAgIEZyaSBNYXIgMjUgMTM6NTQ6NDMgMjAyMiArMDEwMAo+Cj4gICAgIFJl
d3JpdGUgc2htX2NvbW0uYyB1c2luZyBuZXcgTFRQIEFQSQo+Cj4gICAgIFNpZ25lZC1vZmYtYnk6
IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4KPiAgICAgUmV2aWV3
ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+Cj4KPiBTbyB5ZXMgcGxlYXNl
LCBsZXQncyBnZXQgcmlkIG9mIGl0LiBXZSBzaG91bGQgaGF2ZSBkbyBzbyBhY3R1YWxseSB0aHJl
ZQo+IHllYXJzIGFnby4KPgoKVHJ1ZSwgdGhhdCBiZWNhbWUgYSBub2lzZSBmYWN0b3IgaW4gcmVh
ZGluZyB0aGUgY2hlY2twb2ludCBjb2RlLAphbmQgeWVzLCBJIHdpbGwgc2VuZCBhIHBhdGNoIHRv
IGNsZWFuIGl0IHVwLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
