Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ABEC61DA4
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 19:30:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E0C33CC363
	for <ltp@archiver.kernel.org>; Fri,  3 Feb 2023 20:30:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAD293CB25E
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 20:30:31 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4A9F200C9D
 for <ltp@lists.linux.it>; Fri,  3 Feb 2023 20:30:30 +0100 (CET)
Received: by mail-yb1-xb34.google.com with SMTP id d132so7515629ybb.5
 for <ltp@lists.linux.it>; Fri, 03 Feb 2023 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d2baPGZH3KLQraBfiBU1KM1RDN5sB3ydwpskAQTeGlc=;
 b=s7BQ3YCuO90FMkHvg5yrPfodRMkzG0KTkFnq3LHxirHkBOzkuFTO8XVxlkj8wVDjT1
 lYzJnIk73TawtjCwJAc1g1PdTBcDuu/VW3cbw+Osx98kSfNwkg/Tqsa9ArV/Mg6GP4Fi
 ZeNtN1BzqlkhBozzgmFCU7Ztr/lkTdv1o4qLGukzUp+OU64a3lDZnkmbn46Fzq+Ukc5I
 METMB6iSmme+SO2zPGpHO42XbbVFLrvFkyTI2rWQTFu4Tm8Ho/wQ+pKRxUONgz5PLPqZ
 a3fGSaedpnP2cHeS4f6jVwMeLaGqeMR1uortoXC1s9WTpvwFXyXH+0z2BFXP3tGoGCLp
 jnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d2baPGZH3KLQraBfiBU1KM1RDN5sB3ydwpskAQTeGlc=;
 b=XZFiHoZw1/gbYcUoKan1cWlew0/r3BrGKHbcBJR5trZbghf6/169fw93saC2CEa4cK
 d/9pQ9GEjXMQWrsPoh9aqF249JIid8RcMk+Kl1rL2Aor1e42swZcv6cbNueBkF+DDLHi
 GOeG3C76L09hyNUPOqZEyMbxIWy9oJ8E4nQQhz1yhlsGkltAnmoXCj/doVF4bSYPSDeh
 wOymFB0BCQmUCNlJWGfo99TpkU4Ff5uOX1mmWCgd/9EwOPbSIJr3fb8Cn4xgn9NWW4oi
 eoEszNrGUMHhjHTAoh6RgqUM1anKC+s8QTS8WqDjb850OhAUSQuzAdnv5zmJvTXtz9aU
 B73g==
X-Gm-Message-State: AO0yUKVY8F6DH6woqkvwVBSIr225YYFicte8OmMWVIi/9AeTaJrYXKvj
 tSynBKyq4l8/IAQWly21AW7/T1GYLy/Af1IfA6ph2A==
X-Google-Smtp-Source: AK7set8/2qYEKyH71tyD1anTWhnEKDUk5INUhq5rZm5T705E8aZQYo9GiAVkkVul7//0WcfN8GpFM5yesUzg2EVlwH8=
X-Received: by 2002:a25:d0c2:0:b0:857:8e6a:ee7d with SMTP id
 h185-20020a25d0c2000000b008578e6aee7dmr951474ybg.97.1675452629276; Fri, 03
 Feb 2023 11:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20230131002532.459456-1-edliaw@google.com>
 <Y9paGafh97zKnu/j@pevik>
 <CAG4es9V2773dyVrDwt7fiUq=VkUrn0Tr8icCC=X3xx+RGrbR9A@mail.gmail.com>
 <Y9trG4QnXUEbhBbJ@pevik>
 <CAASaF6xQPu1ZgAFKMLjbLtcP4woq7+uQ_H4phB5TO_6CLsy_kQ@mail.gmail.com>
 <Y9tyNEspOUlHMOGU@pevik>
 <CAG4es9X=_vaE_3oX4JD598BNSX8RmQmAKVJS2kZdE1XzUjRu+A@mail.gmail.com>
 <Y9zfkeF3MdzMeizT@pevik> <Y9zhLO27YMWd6p6n@pevik>
In-Reply-To: <Y9zhLO27YMWd6p6n@pevik>
Date: Fri, 3 Feb 2023 11:30:03 -0800
Message-ID: <CAG4es9Wy8pnEJqr2D2WvL=4kmP_JF+QTGVKYixCrBenv7Lg83A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hey Petr,

We turned on the HAVE_CLOSE_RANGE flag to test the bionic-defined
close_range on Android, but doing so bypasses tst_syscall in
include/lapi/close_range.h.  We don't currently have a way to
configure ltp differently across each kernel version, so I wanted to
use this check as a fallback to gate earlier kernels.

Thanks,
Edward


On Fri, Feb 3, 2023 at 2:25 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> hm, I was too fast to merge it. Looking at older result,
> It looks like this (merged as 7b5ee03899) was not needed,
> because tst_syscall() properly detects missing support:
>
> close_range01.c:134: TINFO: Plain close range
> ../../../../include/lapi/close_range.h:25: TCONF: syscall(436) __NR_close_range not supported on your arch
>
> @Edward: Before we revert it, did you encounter some problem that it's really
> needed? If yes, please share details.
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
