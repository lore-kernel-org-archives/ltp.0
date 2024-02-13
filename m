Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A8C4829E
	for <ltp@archiver.kernel.org>; Tue, 13 Feb 2024 02:03:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F1703CF420
	for <ltp@archiver.kernel.org>; Tue, 13 Feb 2024 03:03:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82B5F3CD1A3
 for <ltp@lists.linux.it>; Tue, 13 Feb 2024 03:03:18 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD552200C0C
 for <ltp@lists.linux.it>; Tue, 13 Feb 2024 03:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707789795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZCHCd0f9VpYTt/zoJMqb24+WMI9fWGvS75IGS5/xBg=;
 b=LD0X0YpMdU0vd1rncFpQh8JOUxQlkuXWtiw05s4t5ZVsm1vBfzEjLktmVzRh9rWSNabOVX
 ygY27jgwtrRr2XMRrNoyXGS8lG5khVwdf+P+/M5jjtRiZu++98AzILP2TNpXYQ6M/vslF9
 qlQ97D7x77gg3xOHSINVIhSqBpvs61M=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-j02glUVWMSWxTwNkPIQK1A-1; Mon, 12 Feb 2024 21:02:43 -0500
X-MC-Unique: j02glUVWMSWxTwNkPIQK1A-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6e0567e4d16so3455512b3a.2
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 18:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707789762; x=1708394562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZCHCd0f9VpYTt/zoJMqb24+WMI9fWGvS75IGS5/xBg=;
 b=tA/iIuErineDUWN+9Qr48f3rX1gFrNqudTKSHfqvyWYgiobVgDZZtoz47QX1zIVTdD
 fwhri8xkP8Fe9dvq3mEZ7DFQB/cCDQ+nBa+yF65P3Eg4ogYsgr+DiX7oTzF34Rnz9LhX
 hRnZxjT1+dp+abI8Xy6xqED4nO0U1XlMm6EZDzV79YMfv8VlPLxXr24Xyb2N3CF/BCra
 +b43TpPJRjAD1mW6imylEN225HwNybodGluPODSzSeZu3qKHAdCWzcsp3q2fiiRoPqUl
 842hbb2lXq7CorUss9rl6maKKIGga/r1Hsh8FbA1BSuJkw4H93mBvX42i9h2nUaCLxE7
 49UQ==
X-Gm-Message-State: AOJu0YzWn0q+CXdVUCeJlXWsgXW8N+jrRLz+2aEbkK+JarjdzSR6ORDZ
 J9xxLNNRTbR0c8gUViFCPIkj5ljvhWI55lsRP+5HkDB74EeZSaxBGuoivW19VrPfukTwpR/wlaW
 eiQ3K3ubpyMPygrIc5TCi0zxxfyUV+1MAbBRBcwlgY08ePHhH3hU/24XxVqc82HsY82q+wt/Pl0
 GhxEOvWWKMDV32mi640lyHZqI=
X-Received: by 2002:a05:6a20:9397:b0:19c:5ae6:4425 with SMTP id
 x23-20020a056a20939700b0019c5ae64425mr6735022pzh.59.1707789762010; 
 Mon, 12 Feb 2024 18:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiBJn77j+XMB2CqC0VB9nZsU4XAAQ2iSTyEextR5CL9ZITBCed7sEhYMx8DY0rIzRE/g8wOYlQnFXqOO4SvzM=
X-Received: by 2002:a05:6a20:9397:b0:19c:5ae6:4425 with SMTP id
 x23-20020a056a20939700b0019c5ae64425mr6734996pzh.59.1707789761557; Mon, 12
 Feb 2024 18:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20240212192612.636901-1-pvorel@suse.cz>
In-Reply-To: <20240212192612.636901-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Feb 2024 10:02:28 +0800
Message-ID: <CAEemH2fvtkSv6PnTOtqfBYNCWGSYr2FK_bymihYRmmFo=WDPzQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] swapon03: swapon() file on mounted filesystem
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

T24gVHVlLCBGZWIgMTMsIDIwMjQgYXQgMzoyNuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gQ2hhbmdlIGluIDAwOWE0MDdhMCBsZWZ0IHRoZSB0ZXN0aW5nIGFjdHVh
bGx5IG9uIFRNUERJUiAoaS5lLiBub3Qgb24KPiBtb3VudGVkIGZpbGVzeXN0ZW1zKSwgYnV0IGl0
IGFsc28gZmFpbGVkIG9uIDYuNy4wIG9wZW5TVVNFIFR1bWJsZXdlZWQKPiBrZXJuZWwgKGl0IHdv
cmtlZCBvbiA2LjguMC1yYzEpOgo+Cj4gICAgICMgLi9zd2Fwb24wMwo+ICAgICB0c3Rfc3VwcG9y
dGVkX2ZzX3R5cGVzLmM6NDk6IFRJTkZPOiBta2ZzIGlzIG5vdCBuZWVkZWQgZm9yIHRtcGZzCj4g
ICAgIHRzdF90ZXN0LmM6MTcwMTogVElORk86ID09PSBUZXN0aW5nIG9uIGV4dDIgPT09Cj4gICAg
IHRzdF90ZXN0LmM6MTExNzogVElORk86IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGV4dDIg
b3B0cz0nJyBleHRyYQo+IG9wdHM9JycKPiAgICAgbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAyMykK
PiAgICAgdHN0X3Rlc3QuYzoxMTMxOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMCB0bwo+IC90
bXAvTFRQX3N3YXFYYzNJSS9tbnRwb2ludCBmc3R5cD1leHQyIGZsYWdzPTAKPiAgICAgdHN0X2lv
Y3RsLmM6MjY6IFRJTkZPOiBGSUJNQVAgaW9jdGwgaXMgc3VwcG9ydGVkCj4gICAgIEZhaWxlZCB0
byBjcmVhdGUgc3dhcGZpbGU6IHN3YXBmaWxlMDIKPiAgICAgc3dhcG9uMDMuYzoxODE6IFRGQUlM
OiBGYWlsZWQgdG8gc2V0dXAgc3dhcHMKPgo+IFdoaWxlIGF0IGl0LCB1c2Ugc25wcmludGYoKSBj
b25zaXN0ZW50bHkgYW5kIHJlbW92ZSBlcnJvciBoYW5kbGluZyAod2UKPiBuZXdlciB1c2UgY2hl
Y2sgZm9yIHNucHJpbnRmKCkpLCB1c2UgVFRFUlJOTy4KPgo+IEZpeGVzOiAwMDlhNDA3YTAgKCJz
d2Fwb24vb2ZmOiBlbmFibGUgYWxsX2ZpbGVzeXN0ZW0gaW4gc3dhcCB0ZXN0IikKPiBTaWduZWQt
b2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUmV2aWV3ZWQtYnk6IExpIFdh
bmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
