Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC094C77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751020162; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dggA6nnuodOcukWXysRjRPj7mbG2gOyA2m0dr6ZVJ24=;
 b=atPoEXGF9JV4bWs42wZLPd9wbXU6hlHTJjgKwlHNyjCbUOP+MskqfnRaIBm8Lrc2Yx5/N
 p5aFnbLHKOA/0ZUyaD7x0rFFCfo4eavjN3cC2ELg6//1nKOAmWzCkm+jPxBks0RRG1dihHv
 758q71wSGo78d0sb96ws22/IHWP/mfI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A6A83C7B3E
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 12:29:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF3973C681B
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:29:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28610200270
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 12:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751020138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBoaGDtLoKjv3AkfllYuufqg5UABn9R5EE+BMUJVBys=;
 b=KwSs4G2/xtMfxzjVtTUVWGFOqlr7ICK2ooG2pXKIkLr7tGIK8RjCBJRNGM3YfEh9mmUmY/
 9T2LrOTKAO0ODL93nvi3RrEaC51L3acuwlxshgBL5/NpDGVofTAQb7NxpenbCgnGg10rPo
 BGX1zV5LZNy936HhJuufk2bEViWsvSw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-1tXBomFHNnOtFoVwM5aiZg-1; Fri, 27 Jun 2025 06:28:56 -0400
X-MC-Unique: 1tXBomFHNnOtFoVwM5aiZg-1
X-Mimecast-MFC-AGG-ID: 1tXBomFHNnOtFoVwM5aiZg_1751020136
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b31bc3128fcso2562557a12.0
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 03:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751020135; x=1751624935;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBoaGDtLoKjv3AkfllYuufqg5UABn9R5EE+BMUJVBys=;
 b=oz+Szl549zV15UqTqxOcKkKiS4PHRtNqD5nttFm43BvwykLGFe0OxkLn+mOmjxt4qz
 8kGVxGtqQj7Kssc4r+fyxHEADyMZtjU3EPf5LweiemeQhtVG6S2r8t/hhmlzr/WhlMaE
 qk/3ZrPbGpj0GjnfNmHMH9+gynusYKh5OBXJ/D8V5n0PAQm0qvqqX2rOtVK0j6+uLx6o
 7ZCxwT6dTYHhVp+KvyAGW3iTxH3LJ2sy2UPVFKmHLh4AOGwjPjXRvxdeOLaOwI/LeAiD
 kveKGL9z8SsMkLrYWfJywgWAzBDuAFhDFKuTUkNQDGy7FX9tD6l5gfKSbEA1ZEw99OJf
 IKng==
X-Gm-Message-State: AOJu0YwRIMMXb1RpW/wRHyG4b+sEQBRPr3bJQoiHFOuMFYenO0Mh7koK
 E8oS4iF+jxIblPqrj+H2OhQoM5+W9gKOdIhlo2mFpdSWcbcIGdNeMNlviVJLB0ECcBt3y84UaH1
 MTfZisCwOIFnuoWYCEYtKdtG/bwVkFpezz6ugxXiZJIt37qpBie0IyWimZ/5Ak86nUb+SVOmNIQ
 LHtz1oj3N2selLwGHbhqihxAwDaYduCbsYoMC+zw==
X-Gm-Gg: ASbGncubvfj4zj+63FRaEneB5pwGwO1qXHEfTHd3hIn3XyTor+gi37WDDk77ARVQ++p
 GOY5XrMQB7F7d2HIs6jP1xBqxn7F33nsQ67+2BfbmF8NGUwiFefwkw1OJantJfiw57IKDS+gol2
 mu7Sn5
X-Received: by 2002:a17:90b:3d0d:b0:311:df4b:4b94 with SMTP id
 98e67ed59e1d1-318c8eccfd1mr3447117a91.4.1751020134655; 
 Fri, 27 Jun 2025 03:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFszpYMwlCZasQtSLvM/fyInxispsy2ROJmDVtYbKXr6Rat94AJmC9RRc2a+VYcfmOOAuYUwaHKViMbA3mTXKI=
X-Received: by 2002:a17:90b:3d0d:b0:311:df4b:4b94 with SMTP id
 98e67ed59e1d1-318c8eccfd1mr3447094a91.4.1751020134189; Fri, 27 Jun 2025
 03:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250616102619.54254-1-liwang@redhat.com>
 <aF1KmkMhXNWBbUwi@yuki.lan>
 <CAEemH2esWnKqv2q-UM3tHoTRfR6caLp-0yZN1yF6XCk79XSOyA@mail.gmail.com>
 <aF5NFP5KpuebdkwV@yuki.lan>
 <CAEemH2fsxXGfE60UP3EU9s8HzPb7msQSoYMg85h6-R5rvD2JKA@mail.gmail.com>
 <aF5wiX08IWeWYS4v@yuki.lan>
In-Reply-To: <aF5wiX08IWeWYS4v@yuki.lan>
Date: Fri, 27 Jun 2025 18:28:42 +0800
X-Gm-Features: Ac12FXyP_ewFs21lqu354QfbSgLXx4-gDZzwIVpedXPjHpJAiMIWsGzQ_ALDI-4
Message-ID: <CAEemH2fYij1tO0Yfb=pcqc0h_XfP4OonR4dO7PcviGP_vkxf3w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kQWHt2Fx0ed27GolbbWU4CPc00mUPyx6VdV3jIbmlqI_1751020136
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
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

T24gRnJpLCBKdW4gMjcsIDIwMjUgYXQgNjoyMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBTbywgd2lsbCB5b3Ugc2VuZCBhIG5ldyBwYXRjaCAo
b3IgSSBkbyB0aGF0IGluIG15IG5leHQgdmVyc2lvbik/Cj4KPiBJIHdpbGwgc2VuZCB0aGUgcGF0
Y2hzZXQuCj4KClRoYW5rcyEgQW5kIG9uZSBtb3JlIHF1ZXN0aW9uOgoKVGhlIHRzdF9jaGVja3Bv
aW50X2luaXQoKSBpbiB0c3RfY2hlY2twb2ludC5jIGlzIG5vdCB1c2VkIGJ5IGFueSB0ZXN0CmFu
ZCBsaWJyYXJ5LCBzaG91bGQgd2UgZGVsZXRlIGl0IChhbmQgZGVjbGFyZSB0aGF0IHRoZSBJUEMg
b25seSBpbml0L3JlaW5pdApieSB0aGUgdHN0X3Rlc3QuYyBmdW5jdGlvbik/CgotLSAKUmVnYXJk
cywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
