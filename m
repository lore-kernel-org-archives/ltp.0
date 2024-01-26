Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC850C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 10:35:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 296763D00E4
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 11:35:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 742C03CFA8A
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:34:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9419B1000A44
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706265289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9t5SEqsW0VQSk0xgeny318QSldtM607SD5BgZB31TZ4=;
 b=TBt1E2nPsFUIaHt4JRF1aj0zkWV6BjcF36O1jozG3atC+U97f/R20kw9qpsxrFgG9z2fl0
 /AWVX/9OJWAzYqS2LKCr8EYRsNV9nQemJ7q14kCKQl4pmZF5uR4rSLUTVCgA45gFDmwRvs
 n5bD4UdEMvgQmNbFfRtV8BrRh7fsa70=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-MMpEmTJ-N-e1dQdWZTBFrg-1; Fri, 26 Jan 2024 05:34:45 -0500
X-MC-Unique: MMpEmTJ-N-e1dQdWZTBFrg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bd393ae026so838428b6e.0
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 02:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706265285; x=1706870085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9t5SEqsW0VQSk0xgeny318QSldtM607SD5BgZB31TZ4=;
 b=ltA8oTgS0R65Y7j5tzUTxsxDagtE7zZHa7KjsdfZl7ZHQB11d0OzKPy1PQarVhwhtN
 JQxE7oY/BmvIVxrouLUllvyw24l4OgHfqCcEG2EHimZ5kw5DM09/YSduIRxNLAaF6uwk
 R+cT7zOntvCYclAVxEsCJZqdj94rb5hxyypl8/AT2jd/bkv9nR+jjYwBbknVy6khvjUS
 TqaknlsgYGUdrNqG7AyKampGVqRc9NAgrQbYIjnht5FOPAS8aTRfmuUMRZBfcd6qzeLm
 ccJxcu+o4AqaiC00nEVKvIhjPpyYEyKvLolZYJCABmaZKkLUCBzpOeha/wCaUAnpR7Fv
 c3CA==
X-Gm-Message-State: AOJu0YzXsH3KAzRWQJHRq8K9Vo6d7ra0egvBqYGLBfEVryMKrBOlFI6S
 Y9qlKq9hsDiVktJEJqclACHylW7X0UnJsSSRP4viMbcWRyVgYmGHKWjlLAaHy2sj1hAdRT0kFhz
 yG1GB9nZT444gQiv++jUjF/Go6X/Bx8Tz8l3zvC3yk6KsR2RT7Q4YH6SlhJ1MbMNvPVP82Epq0/
 AmgRowrX0Os9qsqsC4JrDKs9w=
X-Received: by 2002:a05:6808:1644:b0:3bd:ef73:c6c2 with SMTP id
 az4-20020a056808164400b003bdef73c6c2mr518764oib.108.1706265284918; 
 Fri, 26 Jan 2024 02:34:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqXlRpCiENwOQXAx5ODaPXY2RoIjbISscy5+xetXqr6kQ1bcRtILIv75l5F1MaX3a3ctlXmFFV3IhnCvttmkY=
X-Received: by 2002:a05:6808:1644:b0:3bd:ef73:c6c2 with SMTP id
 az4-20020a056808164400b003bdef73c6c2mr518750oib.108.1706265284606; Fri, 26
 Jan 2024 02:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20240124044548.2652626-1-liwang@redhat.com>
 <20240124192251.GB333483@pevik>
 <CAEemH2furScb5PPAFEK+Vq0xyF21B6OekqT-infZDByKUnUe3Q@mail.gmail.com>
 <ZbOD_yAeaj0fRFgW@yuki>
In-Reply-To: <ZbOD_yAeaj0fRFgW@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Jan 2024 18:34:32 +0800
Message-ID: <CAEemH2evCmByMS7GrrXmO2SeQm71Lxn7qQSE1S6Mnj_HCjr_NA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V4 0/6] improvement work on libswap library
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

SGkgQ3lyaWwsCgpPbiBGcmksIEphbiAyNiwgMjAyNCBhdCA2OjA14oCvUE0gQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IFllcywgSSBjYW4gZG8gYWxsIG9m
IHRoYXQgYWZ0ZXIgcmVsZWFzZS4KPiA+Cj4gPiBAQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2Uu
Y3o+IENhbiBJIG1lcmdlIHRoaXMgcGF0Y2ggc2V0IGJlZm9yZQo+IHJlbGVhc2UsCj4gPiBpdCdz
IGJlZW4gZ2V0dGluZyB0ZXN0ZWQgYnkgUGV0ciBhbmQgbWUgYWNyb3NzIGRpc3RyaWJ1dGlvbnMu
Cj4KPiBJIHdpbGwgaGF2ZSBhIGxvb2ssIGhvd2V2ZXIgYXMgd2UgYXJlIGdldHRpbmcgY2xvc2Ug
dG8gdGhlIHJlbGVhc2UgZGF0ZQo+IEkgd291bGQgc2F5IHRoYXQgdGhlIHNhZmUgY2hvaWNlIGlz
IHRvIGF2b2lkIGJpZ2dlciBjaGFuZ2VzLiBJIGhhdmUgYmFkCj4gZXhwZXJpZW5jZXMgd2l0aCBh
IGxhc3QgbWludXRlIGNoYW5nZXMgdGhhdCBjYXVzZWQgdW5leHBlY3RlZCBmYWlsdXJlcwo+IHRo
YXQgd2VyZSBkZXRlY3RlZCB0b28gbGF0ZS4KPgoKVW5kZXJzdGFuZCwgSSBoYXZlIGNvbmZpZGVu
Y2UgYmVjYXVzZSBpdCBvbmx5IGltcGFjdHMgb24Kc3dhcG9uMDEsc3dhcG9mZjAxIGFuZCBib3Ro
IGdldCB2ZXJpZmllZCBvbiB2YXJpb3VzIGRpc3Ryb3MuCgpCdXQgeW91J3JlIHJpZ2h0LCBJIGNh
biB3YWl0IHVudGlsIHRoZSBuZXcgcmVsZWFzZS4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
