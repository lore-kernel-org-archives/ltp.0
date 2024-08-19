Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D25C5320E
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 13:12:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E25D3D3202
	for <ltp@archiver.kernel.org>; Mon, 19 Aug 2024 15:12:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3219D3C01D4
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 15:11:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3BAE51A00210
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 15:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724073115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONIVu5A3755VlfzGE3C5HNVWEz/5kojyCPJpmgp4Wfc=;
 b=a23eUqv7V1IWlP253w5ZdT4LdEYPJr0p4KZ9y3npNevYCkwY3hfr/fOeHqWe6q0FvwuW5S
 RlAq9PKVVjdpRda7SJTs33MHo7vIDgmR2KbjsCXnH2bWti6W2IhKIC8fIaz0u4+2a6INuO
 dJavymFaZXu/xMpzzHNvijbtecogbhM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-iIJ3rFItMliWtKu4vg9G7Q-1; Mon, 19 Aug 2024 09:11:54 -0400
X-MC-Unique: iIJ3rFItMliWtKu4vg9G7Q-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5d5c3010f9fso3579784eaf.1
 for <ltp@lists.linux.it>; Mon, 19 Aug 2024 06:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724073113; x=1724677913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONIVu5A3755VlfzGE3C5HNVWEz/5kojyCPJpmgp4Wfc=;
 b=frvFb5OfAKDm/PPCbuaRmddIv9Ed4YPGqdHMYEAHab5kkQi7ZLFAlbZyPfWROllyr5
 6pyWZjR2kmS1F70E5aRrpJ5vH77xf1nh80fFT5wdR/M4WejErMaosEN7iHabSkq/KwyR
 ASDBmlBEwS4k4N57yae/YK9ZEaBHNJ1EeKHwwCoiVwexy3hq9x0Tcyzh9lJK/wUejs6M
 90mrDuWujKgTUf6oTqS2EE55NXd0HiqIB0pT+NQ/TJ8XuGahAg9NELLyVFYG8IuU7ksJ
 F88su9raE9iuzzXyyozLjqzKytCjkwK/ycqYqERK5izOnAfx5IJ4ohTrBrb8WOVvZ1a2
 hReQ==
X-Gm-Message-State: AOJu0Yw9LZDPQ+e3mKfxBQLbz1dmXW/HRpHnk93i/djX9vayza9tb1gf
 0YOncOIi555HemevlMkVtRA2sT850QgCBmzq0RVXPYcoyB3Dq9YY48MKHFnGX3W9gWcz9EKhr9e
 oxB17AKXE+/g2CQDu52cw9T0oOkOZJ1DXunOdbAM8CKMDchllyh/m12o0AWELSFIxUmkFIrUx89
 6Jwv4k8N8l0X/NFXJ3YPJqhK4=
X-Received: by 2002:a05:6870:c095:b0:270:4b79:5ed8 with SMTP id
 586e51a60fabf-2704b7962famr2059316fac.2.1724073113421; 
 Mon, 19 Aug 2024 06:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG0z3UKeMGKAyMUXINkbfFt/Pc3MF8jt44ASKJeWmmP1nM0AzYFQ8/NbQrd3Ax/D4tpfvHrTYN11baNuBcOXs=
X-Received: by 2002:a05:6870:c095:b0:270:4b79:5ed8 with SMTP id
 586e51a60fabf-2704b7962famr2059297fac.2.1724073112995; Mon, 19 Aug 2024
 06:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <99d43982e2469b1423701b6772677173b5a53429.1723703723.git.jstancek@redhat.com>
 <20240815072935.GA565878@pevik>
In-Reply-To: <20240815072935.GA565878@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 19 Aug 2024 15:11:33 +0200
Message-ID: <CAASaF6xULS8Xj3GodoCZSf+CuEFDA5mWcq0_KduogjznoL07BA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: make tst_detach_device_by_fd() also close
 dev_fd
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
Cc: liwan@redhat.com, gulam.mohamed@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgOToyOeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+IHRoYW5rcyBhIGxvdCBmb3IgZml4aW5nIHRoaXMh
Cj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gVGVzdGVkLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBDbG9zZXM6IGh0dHBzOi8vZ2l0aHViLmNv
bS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8xMTc1CgpQdXNoZWQuCgo+Cj4gPiBTaW5j
ZSBjb21taXQgMTgwNDhjMWFmNzgzICgibG9vcDogRml4IGEgcmFjZSBiZXR3ZWVuIGxvb3AgZGV0
YWNoIGFuZCBsb29wIG9wZW4iKQo+ID4gZGV0YWNoIG9wZXJhdGlvbiBpcyBkZWZlcnJlZCB0byB0
aGUgbGFzdCBjbG9zZSBvZiB0aGUgZGV2aWNlLgo+Cj4gPiBNYWtlIHRzdF9kZXRhY2hfZGV2aWNl
X2J5X2ZkKCkgYWxzbyBjbG9zZSBkZXZfZmQsIGFuZCBsZWF2ZSBpdCB1cCB0bwo+ID4gY2FsbGVy
IHRvIHJlLW9wZW4gaXQgZm9yIGZ1cnRoZXIgdXNlLgo+Cj4gNi4xMS4wLXJjMy0yLmcwMGFmMGMw
LWRlZmF1bHQKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
