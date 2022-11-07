Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF05C4332F
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 08:38:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22C823CD520
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 09:38:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1EF13CDA43
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 22:25:21 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E226F1400547
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 22:25:20 +0100 (CET)
Received: by mail-pj1-x1030.google.com with SMTP id k5so11815640pjo.5
 for <ltp@lists.linux.it>; Mon, 07 Nov 2022 13:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=8wNv+1Bf4cquI/EHzjAENJoFB1/c9LVYJtIsCgpVko8=;
 b=Jw6IIZMnJN8JA5mVqxvAC/JS5MSwwZq9MH1YW0YXr+YI0Rn6aZf1ylYXIhcjfGpccl
 OnVT9b1yKNxTh+141tJniQkx5kDbL8zOpBv/yMPmWyshQfk7LWXZlbtDaFYtvo4yli6P
 FUeV920E7vf0PUFor8tH/A4oRy2wFuwbOJNsCtXsBJv/12VxaLKNU1EHFvhkfK5UrpG/
 LgrybxTGYFB6O04yCAKoC5C2gqQoyWiK+l2CP0N0bCfGC03iZT09c4Sf51xAAJyOQfBo
 NqCjOnKXglh04J9KD7ui9eoSmj+50jYivPazBST1fT0HFTzn+qUcQAvCi1RiI75GHVbm
 yi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wNv+1Bf4cquI/EHzjAENJoFB1/c9LVYJtIsCgpVko8=;
 b=qVp/GuDBposZVDb5cFqlmtoTM84K5YYO0PjM1M6Y7irYiLaYfuQWVjSSJ55kl7hBME
 StQ1Hs4uT1900fhp5+UBWIEeAED+kUlzM8BYaqjDd/Lnk4PaTDYR/jtYZ5GOb6P5nEjt
 gAausTTXHLRjqLqlbumMiLdvWPPHPqjY3NWFsUgBEdVINRc8k0JEcYu+0FhGiRri3/ln
 fQVk5N5sSQR6k5r/bJt5ifEvh/FZrcruJE886Yk9+L6YZ43EIKLXB85X7UBsIv+m5vm6
 8EKWQqgs/mf1P3AdioyySTOHgXdKURAHK/hJtRQ+gIfee9kD9uiqF2A0RzC9fYdmOpSf
 ZV1w==
X-Gm-Message-State: ACrzQf0LLGC0bdH1U9H158HVF4NSfiE91T937S+A26iDUq5dbfeNSMXn
 FtftN/vytrgsZW2Ufpb8QPw=
X-Google-Smtp-Source: AMsMyM6pg7jfZjs5E3oG1Xo6bI3H420NG+af23uX8ad0Qpws6uAeEJnrSoNhYF1g+EVi5zjcrRskjg==
X-Received: by 2002:a17:90a:7e10:b0:213:9e81:87e2 with SMTP id
 i16-20020a17090a7e1000b002139e8187e2mr56152275pjl.1.1667856319181; 
 Mon, 07 Nov 2022 13:25:19 -0800 (PST)
Received: from google.com ([2620:15c:211:201:594a:f636:e461:590b])
 by smtp.gmail.com with ESMTPSA id
 h20-20020aa796d4000000b00560a25fae1fsm4887216pfq.206.2022.11.07.13.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 13:25:18 -0800 (PST)
Date: Mon, 7 Nov 2022 13:25:16 -0800
From: Minchan Kim <minchan@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y2l3vJb1y2Jynf50@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221107191136.18048-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 11 Nov 2022 09:38:05 +0100
Subject: Re: [LTP] [PATCH 0/1] Possible bug in zram on ppc64le on vfat
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
Cc: Jens Axboe <axboe@kernel.dk>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, ltp@lists.linux.it,
 linux-kselftest@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> Hi all,
> 
> following bug is trying to workaround an error on ppc64le, where
> zram01.sh LTP test (there is also kernel selftest
> tools/testing/selftests/zram/zram01.sh, but LTP test got further
> updates) has often mem_used_total 0 although zram is already filled.

Hi, Petr,

Is it happening on only ppc64le?

Is it a new regression? What kernel version did you use?

Actually, mem_used_total indicates how many *physical memory* were
currently used to keep original data size.

However, if the test data is repeated pattern of unsigned long
(https://github.com/torvalds/linux/blob/master/drivers/block/zram/zram_drv.c#L210)
zram doesn't allocate the physical memory but just mark the unsigned long's value
in meta area for decompression later.

Not sure you hit the this case.

> 
> Patch tries to repeatedly read /sys/block/zram*/mm_stat for 1 sec,
> waiting for mem_used_total > 0. The question if this is expected and
> should be workarounded or a bug which should be fixed.
> 
> REPRODUCE THE ISSUE
> Quickest way to install only zram tests and their dependencies:
> make autotools && ./configure && for i in testcases/lib/ testcases/kernel/device-drivers/zram/; do cd $i && make -j$(getconf _NPROCESSORS_ONLN) && make install && cd -; done
> 
> Run the test (only on vfat)
> PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=vfat zram01.sh
> 
> Petr Vorel (1):
>   zram01.sh: Workaround division by 0 on vfat on ppc64le
> 
>  .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> -- 
> 2.38.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
