Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057A9C5B559
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749204647; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yy5HYpdTV5nXfv/l8xnhU538JYXHXOYklVRk8f2Mpw4=;
 b=PlniU/alLEhe6c7u8qK+zRXPEXw2XLfTb+vRz3jAjjEgr9hVtqohenQMZcxl6op3bNkzH
 J8ahIKTWISnNirTdthaSb43r88wqOOJNsayOhSgYmmuzziLBSO+id4b9XRkP1m9cuZj231B
 t+EJcvuhDX9qQ6D7KTDGYjUMjp9g0iE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27C8A3C9AFF
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 12:10:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09EA83C9A52
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:10:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5C1F3600E30
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749204622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeWlh3O7VDlruFb73KkdzJS6wO5qrHeSyE9AoLlCIiU=;
 b=XkhDqpPmEP1GsPbYzcR0tsgdEwcyEWr6i6dwPAC31+7g6770YgOIun2i6IykIwGEd5o+nH
 R+7iJPLMZelC6Bh8yeW1Uea9lJ6B4DSA5G2C0Ss9YfGr3Lda66TbkDVKbftNQPyDH3zrC1
 cQbzrZKXJ+X357k224bufNpG7i9vA18=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-QyDKPf2DNPyoqDBfX1j7Aw-1; Fri, 06 Jun 2025 06:10:20 -0400
X-MC-Unique: QyDKPf2DNPyoqDBfX1j7Aw-1
X-Mimecast-MFC-AGG-ID: QyDKPf2DNPyoqDBfX1j7Aw_1749204620
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311ef4fb5eeso1827909a91.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 03:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749204619; x=1749809419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TeWlh3O7VDlruFb73KkdzJS6wO5qrHeSyE9AoLlCIiU=;
 b=fUXAMwUFFNkUgsngdRs04mbwDUnw7o4ggRcvX5loPlCnUISXOYy2XXBCybEIo1ZzZA
 /vO4usLIJkX08uXxeIM8uW4Iy8gPzVRdrMNUuG20FVfyMGqUCpI2ok8D84qzFj9pmHqP
 pqqe05bm67zKdU4BaB0UDBTE6BI2TJ79DawoEd0Pg7umf2IW+lPZXmz+h3uEUx5ozh6w
 D07l/flmaoReGkp4WHs+6f352P9n37tfhEjBzdOQnink7yzNsMn3GG9HTdQablGZz5OD
 zFi/vg6KAS2N1+NEHECtz+4mN9B/3FW6yjZP5PAxvuLgXImt8espqpmicDvEbevd7igr
 OkHQ==
X-Gm-Message-State: AOJu0YzWM7PpsebGojLaDzDxhnj/ShWnNV750LCi1xJ+by+GY6lvvi1q
 OLzZwaw2Wgvh7/JY8TyZTlOZ0CR5gf7Bf/SjbIMFUnimMN/nfM0b+AqB/XVc2m/9zYUAxnVKDsF
 ZAwFeOE4wX0kotAmnIAjfpXet8I1Wthg5LIQlxs0t2kpzl257dZq3TjfxxsP8UARrP/iptcAHU5
 Q0mNZIlTtFHmxyCh89yWHzWDF6YoaPFD4Frv6jDw==
X-Gm-Gg: ASbGnctoHfHw/zlU2NgvyJGRCAl1BbmNa866CQ8WD2g/XkcdEIuzMaA/UhEXurMvEcd
 jAe7uM+FXSbo567XUZuhl50p4YmUnWZkQT9swppOurt51Cvq055pjX41xe4jx9O+OAHrhZU7WAP
 hI1pGT
X-Received: by 2002:a17:90b:2ecd:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-3134d023cb2mr2876631a91.16.1749204619265; 
 Fri, 06 Jun 2025 03:10:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiD5moKqiaMSypK19NorwflMx7xDN4j0yi3esWVhVdkD/9Q1+KwrOcZRVcRlCq0P0JtBF70VJWzM5hEnIhry8=
X-Received: by 2002:a17:90b:2ecd:b0:312:e73e:cded with SMTP id
 98e67ed59e1d1-3134d023cb2mr2876598a91.16.1749204618822; Fri, 06 Jun 2025
 03:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250605120702.213048-1-liwang@redhat.com>
 <aEKyXpEg3NoPKLfq@yuki.lan>
 <CAEemH2fKJY+_bSEtugZVMzjYwGOPG3DSnffZp7gBBuSQ8N3nkA@mail.gmail.com>
In-Reply-To: <CAEemH2fKJY+_bSEtugZVMzjYwGOPG3DSnffZp7gBBuSQ8N3nkA@mail.gmail.com>
Date: Fri, 6 Jun 2025 18:10:06 +0800
X-Gm-Features: AX0GCFvvrdEivqkj696KKGs4201_hiYDeKzMRTeEc6JMDMjITBr0aZ6YgCNbIFA
Message-ID: <CAEemH2cVpKAh3aPOzz82Cbvik_gQzpzySu7SsoTePTvKtGZkOA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FTn9VvC6lfWlsc2-Zjc4qUkr5xcB11F8Yt1QNK0fCnc_1749204620
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] tst_atomic: drop legacy inline assembly
 and use __atomic or __sync builtins
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Li Wang <liwang@redhat.com> wrote:


> Also do we need to update fuzzy sync library in the second patch in
>> order not to produce warnings?
>
>
> Good point, also we probably need to check all related atomic operations to
> ensure no new warnings by the type conversion.
>

Or, do you think it's necessary to define a dedicated tst_atomic_t type,
such as:
typedef int32_t tst_atomic_t;
and use it explicitly for all variables that are subject to atomic
operations?

This way, we can clearly declare which values are intended for atomic use,
improving type safety and code clarity.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
