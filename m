Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D2AC021AA
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 02:53:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF28B3C5F5F
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 03:53:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1C583C0277
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 03:53:38 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A9DA0654A4C
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 03:53:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740020015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QaxCQXzbe81eEZz70enxmO4eU59SSzuC8u7mxmtct5Y=;
 b=QZb8rl3i4zTSxceQysK4D2zkFRfSwB53DYEfl6OdDbFO01RXbttY4JrcG5Y67FkFu4Lyte
 KP7Qbu0uqCR8VTA/6AaJekfWfuc1NAdSibHYg5IFVhYb009QRx53oi0THmkswswRPMJN+w
 zENSgS+oHEnUZvE8pcOyYVyv95T3l4g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-NsFjPeGGPK-Y9pQCjGBrFg-1; Wed, 19 Feb 2025 21:53:33 -0500
X-MC-Unique: NsFjPeGGPK-Y9pQCjGBrFg-1
X-Mimecast-MFC-AGG-ID: NsFjPeGGPK-Y9pQCjGBrFg_1740020012
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2fc3e239675so1514205a91.0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 18:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740020012; x=1740624812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QaxCQXzbe81eEZz70enxmO4eU59SSzuC8u7mxmtct5Y=;
 b=KjmfQn+oLoN3N1l9XputX4sMQGkCrTceDFXsdpvysgcAc7jpoRiDdb8Sw74MSDLGCN
 lARic4WkwkWSBJ0QjVrrDcqO8PRtUYVdYvTjrxAgGNpDRtTVV7dqjkXP/4KRFfHZU4fm
 oB0Wt4V2iI8teojoperGrKI7ExBrd/AJ2s5I7IXl9LRWHbL0/rXCSWZrJrG5DvVRr1Qp
 VCQuCYazmB7uP/pj5AkLauofKrigjKELm+mG7QTY4EBosJn2eAZEpmJwC0M7/D1EKl0r
 NNkMfelH1XorwIvEgZga16LPnphto0bvRGkxfodqiI15SbrOjdnEzsYxwQxNzY5iGnAm
 8BUg==
X-Gm-Message-State: AOJu0YzDahSo85EQkkknbPBklg1Mhl/IBTDJ+Odcaljqai8EJg77P6Ha
 1ATte+mn41+wlhCwhH4y7As+SoZSSS7p8cJTftcgdUl3qIZFX8vD4Tbmr5+9i5KXTtBncrEG3vI
 mVHiyIQWt8uGTq7gectFzwRt0WguKG2jSZjwduoS4wDSqVNa2uootyQc9uBnmM7em9nsbtoj2SR
 oX8DVmQrRACnmik1xZvq1lFDI=
X-Gm-Gg: ASbGncsx+V7FvKz0JJt2cJMojnmb51u8jfjqcyrgbpERfjZO5sQ4fh+ye2rEzQXOmRQ
 n7y1CYD/90/SDZPkmfMgRPJSi1q1S2EafHx5ouLhCptzW1SHcC5KVHi1kdEjAvTQ=
X-Received: by 2002:a05:6a00:3cd3:b0:732:2850:b184 with SMTP id
 d2e1a72fcca58-732618d0dffmr31647400b3a.18.1740020012593; 
 Wed, 19 Feb 2025 18:53:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFedc8QkqNB9J2ehThkKl8kXCKGE7xjYffzbSawXqzi+dVbojLQ9oVHdktz7utkv18xVPCT9nAyDXbDu7d0JXY=
X-Received: by 2002:a05:6a00:3cd3:b0:732:2850:b184 with SMTP id
 d2e1a72fcca58-732618d0dffmr31647366b3a.18.1740020012139; Wed, 19 Feb 2025
 18:53:32 -0800 (PST)
MIME-Version: 1.0
References: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
In-Reply-To: <59baf41928c498349f41f468e4efdb4908bccc28.1739886583.git.jstancek@redhat.com>
From: Li Wang <liwan@redhat.com>
Date: Thu, 20 Feb 2025 10:53:19 +0800
X-Gm-Features: AWEUYZksQYfF72OlvlFOessP3iQzNpiMTiLPlDxSv0Tk9rrB7y9Rm5uieBg8y0g
Message-ID: <CAEemH2fO46bxZjUVm7+bBUrEnSniOQj9n-7FRK-=oxCj0dPjWg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cHcVs31QH_o_tvm2YSF7QEhfy-Ybfp7BicF9sq5gCEs_1740020012
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] aio-stress: fix memory leak
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

T24gVHVlLCBGZWIgMTgsIDIwMjUgYXQgOTo1NeKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gc2V0dXBfc2hhcmVkX21lbSgpIGN1cnJlbnRseSBydW5zIGFz
IHBhcnQgb2YgcnVuKCkgZnVuY3Rpb24sCj4gYW5kIGlmIGl0IHJ1bnMgZm9yIHRvbyBtYW55IGl0
ZXJhdGlvbnMgaXQgY2FuIGNvbnN1bWUgc28gbXVjaAo+IG1lbW9yeSB0aGF0IE9PTSBraWxscyBp
dC4KPgo+IE1vdmUgc2V0dXBfc2hhcmVkX21lbSgpIGFsb25nIHdpdGggdGhlIDIgY2hlY2tzIGZv
ciBpb19pdGVyIGFuZAo+IG51bV90aHJlYWRzIHRvIHNldHVwKCkuIFRoaXMgd2F5IGl0IHJ1bnMg
b25seSBvbmNlIGFuZCBnZXRzCj4gZnJlZWQgb24gdGVzdCBleGl0Lgo+Cj4gQXMgY29uc2VxdWVu
Y2Ugc2V0dXBfaW91cygpIGFsc28gbmVlZHMgdG8gYmUgbW9kaWZpZWQgdG8gbm8gbG9uZ2VyCj4g
bW9kaWZ5IGdsb2JhbCB2YXJpYWJsZSAnYWxpZ25lZF9idWZmZXInLCBiZWNhdXNlIHdlIGRvbid0
IHJlLWluaXRpYWxpemUKPiBpdCBvbiBldmVyeSBpdGVyYXRpb24uCj4KPiBBbmQgZmluYWxseSwg
YXQgdGhlIGVuZCBvZiBydW4oKSBmdW5jdGlvbiBmcmVlIGFsc28gbWVtb3J5IGFsbG9jYXRlZAo+
IGJ5IHNldHVwX2lvdXMoKS4KPgo+IFNpZ25lZC1vZmYtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNl
a0ByZWRoYXQuY29tPgo+CgpHb29kIGNhdGNoLgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2Fu
Z0ByZWRoYXQuY29tPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
