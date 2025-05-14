Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6E1C3ABCC
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747226679; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DSzL5RWf1rsmsglqpefmkjISsL5ky6DgkA2wYnkAHn4=;
 b=LsVXBpwIF3ZXE1Ts94AGqbjM6OIgXZ7h7aecixJjeKujpn2FxqwA58xoHR46BZ4QpWLcY
 +MGPKr6jY0yh4SxGlcpWWnLB58UNIEIvjZT0tJU/GoUHr1TeF+OLSK7EcUhaUe5U42LuSob
 YUriJDBtIp1mrTdTqerKgRifRnLVtLE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ED103CC3B2
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 14:44:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4B073CB86F
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:44:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D91168044F
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747226655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lB7Uu2WTasiK4M1GJNg8zTuu7dM8D1UUPhHtBMLeDL0=;
 b=Dhw++4rGaxTsW19eddTZXPHuYjlM+CcKGrF+9vvtAv+wWVXUqEQ3aMwwmv3YtSotdHpY+X
 ShAWugHeYMcplwYa32nuhoSJ6kMY88wkun5lu+nGZZVIzvYCH55qXv3oBs7HjXW0NY3jxe
 oZNGrgCabQEKo48x1exP6E7gvIvQacc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-r9zzHTyUMYypKiRTH9GdrA-1; Wed, 14 May 2025 08:44:14 -0400
X-MC-Unique: r9zzHTyUMYypKiRTH9GdrA-1
X-Mimecast-MFC-AGG-ID: r9zzHTyUMYypKiRTH9GdrA_1747226653
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e50a45d73so70291645ad.3
 for <ltp@lists.linux.it>; Wed, 14 May 2025 05:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747226653; x=1747831453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lB7Uu2WTasiK4M1GJNg8zTuu7dM8D1UUPhHtBMLeDL0=;
 b=hiKG6yuEuI1YZMSjhu8vlz+BurS6wuo2zKiTV+iy2XE9ZA6DHXQrjRTyOevHzpCdHh
 o80Gh1GHeU/xMiuMjiCgFsWhNsmgvrAfo5CA6i+IpzmaIr6AQcThkqPU/RhXqsKfA5av
 CNWsf2guUDBcj2eRyGaE7anVXa8Y0L9oSp6okhtc9dO1h0JTicTPKle56XhekqFCG+a0
 kCmOoFyxeokmklWaoejfnir70f2Xd8VnxlNrxYkpsITShcgt0YoXCLHPx4xtNxkrJj6G
 h6KF8nzKuECE/lFfce+QK7D5QeWvZFfaXCIriKutxRF8TPHomXgkCf6WOq3OFOiocCtw
 08NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf0x+Oug+1Nd2umGVZaW8zfz6xlymMSk/2wp80RpIjgIvYgR/ZDQj8kZb0jRyVu4vL5YY=@lists.linux.it
X-Gm-Message-State: AOJu0YwqhbDj7+ytfj4H904q3dSrbJ4yrdqr05ZSx2eHegZFEmFB96HO
 9qOPS7TUMcI51uJrRSTx0AzmhTPPCZ+vRib1Gf8icv3MOf7sNSR7H5hZ+Su3+xcz+c04xngiNDL
 TDIk+WNY7EpHoM8YnaFA2x+zMoaWf5eIKnzLdJFxnR5iV2awewVeMgdONYaw0obr/t45cR/9B9F
 DJwQfLLTmg89+mpdMNyoBwN8g=
X-Gm-Gg: ASbGncsTQwnRi98tTngt6WzgxLwhVeNiUAkMC2Dn90R9A4xxlXg3s5eFTBfdEldqk9l
 hlB8U22n0NEZCJvmJGKC2kb3veB2zDXNpeZ+CA0iiMQCnnaIt+sjAnM0Cu4bnRbN9n55xjg==
X-Received: by 2002:a17:902:f70e:b0:22e:421b:49a9 with SMTP id
 d9443c01a7336-23198114478mr49546915ad.2.1747226653029; 
 Wed, 14 May 2025 05:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnke20LP+mqDupBkEKQGEcPVp36PNCMTRrdEhYJyFPXt8O02CZqx5RrllaoULgk1FMtkcemmYTRgtpqsQ2vzE=
X-Received: by 2002:a17:902:f70e:b0:22e:421b:49a9 with SMTP id
 d9443c01a7336-23198114478mr49546635ad.2.1747226652685; Wed, 14 May 2025
 05:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
 <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
 <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
 <CAEemH2dWyGyHXngTSghnAUmyF+DS0GNvKatVR9CuTpMEZc-rPQ@mail.gmail.com>
 <CAASaF6xNg8AeQMRscHY_gsqQGxw=wPhYiwquuHVKLSgZEYDoFA@mail.gmail.com>
 <CAEemH2fFUdjmqsNvFBk5mRjn+2xm62HJZx48Qug4jMdVBJNnsA@mail.gmail.com>
 <CAASaF6zONvCb8p_ATDTS2Ma1rs=ZvHA03i3=xqLHbKH2ZOCPWw@mail.gmail.com>
In-Reply-To: <CAASaF6zONvCb8p_ATDTS2Ma1rs=ZvHA03i3=xqLHbKH2ZOCPWw@mail.gmail.com>
Date: Wed, 14 May 2025 20:44:00 +0800
X-Gm-Features: AX0GCFtUkfBJYS48LQwS5ko6BU8DeK9Jdnd-7LECf_AGkNnO-LXxLsXA7yh9fnM
Message-ID: <CAEemH2c7KTkJUh40D=Hn55u5_E8g-+p2XR+Fc5WehekxhFSA2Q@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _TNXwqpwYNR8uNtk8Kjk2-1mvTcBib3IJGd4Tw3xhgU_1747226653
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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

Jan Stancek <jstancek@redhat.com> wrote:

> > > I'll have a closer look and try manually. At first glance at test, I
> > > suspect compiler
> > > doing something clever for:
> > >                 for (;;)
> > >                         *(char *)malloc(page_size) = 'B';
> >
> > Probably,  -O2 is the default in LTP compiling.
> >
> > Or, you could also try disabling KSM when testing mmap22.c to see if it helps.
>
> In case of my VM, it looks like it's able to swap faster than what's
> needed to drop the allocation.
> With this I get PASS right away:
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap22.c
> b/testcases/kernel/syscalls/mmap/mmap22.c
> index 0e589dfab..56fe412d1 100644
> --- a/testcases/kernel/syscalls/mmap/mmap22.c
> +++ b/testcases/kernel/syscalls/mmap/mmap22.c
> @@ -32,6 +32,7 @@ static void test_mmap(void)
>
>         cg_child = tst_cg_group_mk(tst_cg, "child");
>         SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
> +       SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", 1);

Why not set it to 0 to disable it completely?

I guess we need to do it separately for both Cgroup v1 and v2.
  - Cgroup-v1: set it to MEM_LIMIT.
  - Cgroup-v2: set it to 0.
FYI: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/oom/oom03.c#L33

Anyway, testing will be much faster with this patch.

--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
