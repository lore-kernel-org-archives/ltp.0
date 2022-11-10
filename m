Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA44EC433FE
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 08:38:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0E013CD520
	for <ltp@archiver.kernel.org>; Fri, 11 Nov 2022 09:38:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A56E3CAD10
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 00:04:45 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C67C310006C1
 for <ltp@lists.linux.it>; Fri, 11 Nov 2022 00:04:44 +0100 (CET)
Received: by mail-pj1-x102f.google.com with SMTP id
 z5-20020a17090a8b8500b00210a3a2364fso6692244pjn.0
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 15:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=8PxXXft/nkkyC+qO3NZ0NZRsgWMaldSAxbQ9lxvKRGY=;
 b=T6C7YIAMYHacLdrESecsyvPNePaxfqKM6ZzXAgY/O9enpon/fyk4AwNgl21buw2/tg
 xmg6tTuw9bDi37AmyBpjGUQbxADCwvSk8/Cm7Q5ceUWvRAb3jTO8xLahRHhj13EQv2+C
 L8roGgR/WnzAEfbC/SBSxdDo7OjR6NNkhheKPiuQQJxhZhhcVpC60ppB5Uocn9O26SNO
 K7f01Uy0UWye2FRcS/mAfg3t/m/H7du4d81vo66lkm7yS2742p05r2+fFnuwWjSbTWse
 rg/sN8qJQyOgFL/8eTz2ab00JzSmsiBefMNT6JbZs1bpZmwEKonlZa0TS0beQpAeJ0Eg
 a1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PxXXft/nkkyC+qO3NZ0NZRsgWMaldSAxbQ9lxvKRGY=;
 b=k+yC34OEXHYDYQhGLjnVDAPztsg0peyLD4ezS70FC7rmirM3hLs6FpEZss/o7k6m6D
 6HfQsCt/HXM1mmhUO5ZyiT3alA7Vx7sVpMyRcQznSIrLwSBd4EEpQYZ+sRr+bGZ5Uw40
 bVPyjDBxDuqHKSUu8H3z0JBIIzr+IDEpfV0UNu6tYIpiKAgu+k4sc79c5VNRvD+/pfEJ
 ET11Dysa7E0bStcVlEsT5DfRFS3OG5euevp84e4zWdY5IZS4CVksE1sNzFbRAI7L8cxJ
 K5qPBfmOtefobFNIYlvwKosrT5ugWYucqpr9vCr+elXWnJd9+S8rGKatKyKiYVRD+7Xz
 a2gw==
X-Gm-Message-State: ACrzQf2Mx4yLbMfbNMOiKGAyEq8tztc/hrtKZBsd5GNOWmNbnWE490RC
 CiXk+qpX5scpEd77464rb8c=
X-Google-Smtp-Source: AMsMyM4KtyUZ+RLI3SgeEuwc5nKbDYT6Ih/qwJK99ZzTPQW52wv+CeCQTrbrzNKVmuN6P5egPGp+Gg==
X-Received: by 2002:a17:90b:3d8d:b0:212:ccda:88bc with SMTP id
 pq13-20020a17090b3d8d00b00212ccda88bcmr2476638pjb.212.1668121483057; 
 Thu, 10 Nov 2022 15:04:43 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170902710f00b0018875b76945sm185565pll.274.2022.11.10.15.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Nov 2022 15:04:42 -0800 (PST)
Date: Thu, 10 Nov 2022 15:04:40 -0800
From: Minchan Kim <minchan@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y22DiF5Q5EDUIrZE@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com> <Y2l89dt/t8M6+9go@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y2l89dt/t8M6+9go@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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

On Mon, Nov 07, 2022 at 10:47:33PM +0100, Petr Vorel wrote:
> Hi Minchan,
> 
> > On Mon, Nov 07, 2022 at 08:11:35PM +0100, Petr Vorel wrote:
> > > Hi all,
> 
> > > following bug is trying to workaround an error on ppc64le, where
> > > zram01.sh LTP test (there is also kernel selftest
> > > tools/testing/selftests/zram/zram01.sh, but LTP test got further
> > > updates) has often mem_used_total 0 although zram is already filled.
> 
> > Hi, Petr,
> 
> > Is it happening on only ppc64le?
> I haven't seen it on other archs (x86_64, aarch64).
> 
> > Is it a new regression? What kernel version did you use?
> Found on openSUSE kernel, which uses stable kernel releases 6.0.x.
> It's probably much older, first I've seen it some years ago (I'm not able to find kernel version), but it was random. Now it's much more common.
> 
> Test runs on VM (I can give qemu command or whatever you need to know about it)
> I'll try to verify it on some bare metal ppc64le.

Hi Petr and Martin,

Thanks for testing and meaning information.

Could you tell how I could create VM to run ppc64le and run the test?
I'd like to reproduce in my local to debug it.

Thanks!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
