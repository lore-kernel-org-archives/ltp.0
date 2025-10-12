Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21BBCCD184
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 19:10:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDEE83CEA7A
	for <ltp@archiver.kernel.org>; Sun, 12 Oct 2025 21:10:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 813493CE3A2
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:10:16 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CADB6140097E
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 21:10:15 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b456d2dc440so590252766b.0
 for <ltp@lists.linux.it>; Sun, 12 Oct 2025 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760296215; x=1760901015; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dMDyKBCK/SkfpRHEiIy/F7qPG0Nf1WnL6elkDppdH4=;
 b=B3soY1f7GujA5BEcjrjn0VMbaxkYOoQAVXeiFuByBNPU8PxvdTGaCvMh30rJgNdFsX
 whF1eDWuFRx4TmouJLjrgbAwxzFazUeZGTTcfDqin7Dsl6w1eI6CYaLNboA0Wm3lpoh1
 Fy6675B7MHibdOB3mmUmASOGlZk99tg/91XHHKxMJIefoaZ2hupP4kznvNcFUvBGzZ4e
 St8jAok8mszRw8h75zP96gywckcs/4/6TspmBUPHTT24jlvqH7EAvoGjKRzl553YbX76
 l8RV2Y2QXAJ8wmB0tbg3mAKTKlCWrjGQI6JNPUEu9RDlBhId5IHNLFSWx4CbvvR1Ck13
 bRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760296215; x=1760901015;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2dMDyKBCK/SkfpRHEiIy/F7qPG0Nf1WnL6elkDppdH4=;
 b=ucBG5L/RFQHzc7Br2ARXlrrNx20QW6GZRGjG/R0IB3X5dVdY+zXypAC46htsWuGMyk
 4TNuKnK8czxSQVsvr9fnLGp2yKIJXxYxHB+YV3Ad2Ermg4DCRGpR4R6xHvLUkD32EFj7
 z2Xmg1pEv1Zs6n+/RrQ0vXHr9M6/D/NB8aYOuCAdnZHjZQmZDI9FcxWZ3Z0EO5C6ynj8
 zxuY8U1Xx0d11ZFQF2HPZi5nsY8569ze9OlUAfg2WyzJ4cb12rU4o48/Lgfz2bl53sHm
 okrmLlrPQkqxRwfLGR86upYbQ9NqdBHmlDkqKaWWBLoJBIZhgqafgvXhJ4eFU4j8bk1d
 JDCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXsUtm91TKNkeGRpMYOGmNTFyX1SUptOHuUc8k/uhVzO/hcQyu9ezsRLB9GKgJn2Pcbgo=@lists.linux.it
X-Gm-Message-State: AOJu0YxnsAEx+V1QdwLt65YZOqKlOIgUtpSYJf7w2tHzvK2xuEuJ8/sG
 Yt3dmd1ACs+fcwvyuGkug4tk+DVOBUW1U0e9v829tcdIewUQnWcsJa3x
X-Gm-Gg: ASbGncunhVm6hH4ZL1WeIpPR2D+8r/qZVzN2PZM8edPddoR1vSl1+aJ55Jk40L13Vx7
 e5sIqy/dJoKDDHWXkMHtPilht9/1ps1U/luwha1pB178IMDv8Or8ZjidsIGdSof9+wBgG68RpIa
 29wH90MSoLwVCSSULprEu0vGo8c4gs6uq59HDR38Eqez1CUJRIFbADTGX3aImgG/UjtbvWxmEwE
 h6gnOdVT1ESt/fE4wPFmlGhrssaII7P/ziWUJzDFl8TdSR41Ww25OSOFWPuLOvXNpTAphSEfiii
 TOobbHyN/hUd7rDyP2sOxIiWJ2OFDoK8wfKrDlPKA1IWExSXata6eLaWd2i4R/WDdWl236Ej6p0
 2XthDIgI+anNS3T8vqp7ivI/xSFWmf238FCi+btFs5a9VsP/cIpGamANY
X-Google-Smtp-Source: AGHT+IHFccM0/wJkQbaxZ2pvvB24U4iYDwFz9snQko9jqActXJJ8AAp6JOUir/nn1mW/K8ERdivbIw==
X-Received: by 2002:a17:906:6a2a:b0:b3e:151b:849e with SMTP id
 a640c23a62f3a-b50a9d59ab3mr2129087966b.10.1760296214936; 
 Sun, 12 Oct 2025 12:10:14 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cadc61sm747648166b.10.2025.10.12.12.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Oct 2025 12:10:14 -0700 (PDT)
Date: Sun, 12 Oct 2025 21:10:10 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251012191010.GA361831@pevik>
References: <20240611055655.614782-1-raj.khem@gmail.com>
 <Zmg9WZ1TitB7D_RC@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zmg9WZ1TitB7D_RC@yuki>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add __clear_cache declaration for clang
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: Hui Min Mina Chou <minachou@andestech.com>, Khem Raj <raj.khem@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Khem, Cyril,

> Hi!
> > __clear_cache was enabled on RISCV recently with 7352ba02390116f1cd6a9b583860ba28aa0a1b7a
> > however it fails to compile with clang19 on RISCV
> > With this error

> >   hugemmap15.c:51:2: error: call to undeclared function '__clear_cache'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> >       51 |         __clear_cache(p, p + COPY_SIZE);
> >          |         ^

> This sounds like a clnag bug. The __clear_cache() is a pre-defined
> function and as such the signature should be part of the compiler.

> Is the call even supported by clang19 on RISCV?

I think Cyril is correct. IMHO __clear_cache() on riscv64 was added in

https://github.com/llvm/llvm-project/commit/9d469b5988bfb1c2e99533f863b1f9eb5b0c58b7

which was added in llvmorg-20.1.0-rc1.

BTW we have m4 check for __clear_cache(), I'll send a patch.

Kind regards,
Petr

> > Signed-off-by: Khem Raj <raj.khem@gmail.com>
> > Cc: Hui Min Mina Chou <minachou@andestech.com>
> > ---
> >  testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c | 1 +
> >  1 file changed, 1 insertion(+)

> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> > index a84ba6476..856e22ff3 100644
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap15.c
> > @@ -21,6 +21,7 @@

> >  #if defined(__clang__)
> >  	#pragma clang optimize off
> > +	void __clear_cache(void *start, void *end);
> >  #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
