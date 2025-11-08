Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE083CCFA18
	for <ltp@archiver.kernel.org>; Sat,  8 Nov 2025 07:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762586228; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=C60J296gAfDji/o3NpobS2dKN3EnA/Q1m2QR4w09H7Q=;
 b=M7LUFyzvrci+1lfRTG+rgXZh5tE1jTW6q48X94i4qKxwY/NsQeUnuXfxu4eTNhowhJYk8
 6IxVQCv7BPLtCPf8+riyb9NmpvsZr5YyFj93dMeD8zAxbDoKiwbkXviYIPX/OKgqHfapkhV
 vScBPuaEcVsR1cALGLe6MZpLSXL8b9M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7A343CF231
	for <ltp@archiver.kernel.org>; Sat,  8 Nov 2025 08:17:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1E2F3CF15F
 for <ltp@lists.linux.it>; Sat,  8 Nov 2025 08:16:45 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DA744600736
 for <ltp@lists.linux.it>; Sat,  8 Nov 2025 08:16:44 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b72db05e50fso167777766b.0
 for <ltp@lists.linux.it>; Fri, 07 Nov 2025 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762586204; x=1763191004; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wlh8mCq5dGBYDq7RPLTlz52ig0WII4CIcmrJzBZNyK0=;
 b=JnzIKeRt+4JtUKcsK+5Yvzv7vZWwW/otHBD8HYNF8Z8BNUZN34oOezjCYrtFM72JkI
 WwB0M0NeEIW8+AiBgt9Zr9oa+Kzu1wb/oCZTzjMw4ENEgQHmQ2sYVgXSN3iTQr9w3Rw8
 /aYV8gDBAuTKG+VpIwG+pnTEiGZzoDdaynruu23Q/Ke6wECenbOQdmbuNX9uiqwvDyFO
 b4Xt/+8DQS8oTJvT/+EmCjeINCrBCmL7u3dKvho0blLIlinQ9hKZSr1oFa3rigmLZMQf
 6C/YLQkNF4pKGE/sQ+M+JFnE/hCdQEJJ+xSIzWkT1uAlcQkDBmT/cFB5r+e5nOA7R7iA
 x43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762586204; x=1763191004;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlh8mCq5dGBYDq7RPLTlz52ig0WII4CIcmrJzBZNyK0=;
 b=dFl69ljvJnYCZNQIP99ccNpEtsyCYwUbMd6AEvLxqjs6MTIhCw6EMe8MArpqBQUgTa
 uVR1wUhrGB2Ct7IN4KBw9RH1WXL9o6HfWRtq1ODcqOnu0d+TsskWcH8wk8DiUGzcyHiT
 feXQQCtyjID4gTBOuwIO/Kt5kb4a3pRt9ZZd/mtub0nHXrTPPz2kJddlnPkH8amAHV6a
 g150bdr6UEHKdjPACFqGF5xKCdeQaefqIoqkjF7h5NDfqPpgEOpDkXVLvMbJORAzviBa
 LVbyI2H1tYIpFj6lww8urV1ZOlCKkAJocX9RpPFBqU2RfMmtr+BKpB/UfjEXXjE7PWdW
 fCuA==
X-Gm-Message-State: AOJu0YzKkYp3m9S6q8kbYdmiSprHd2UsA1UtHPvcjH7KChmJYrR1auba
 1HsKJIAHOLsFZymdVECDAP7GOvazNLn0jtuxVuo9PZfP6UkUfk0X8BHrLp1UhybTqAodWxMAC80
 ITn8=
X-Gm-Gg: ASbGncvvYarVqQCm1jPjITqSrO6oYLgWNcjJuS8EYiEkRrGOXJA6vRKuuYt8DyTYe1e
 AuFUA6zxPC0PV4WNSMkc5v45U4mhA+tcXNPR3S6zqNZdSgjflKM8uOY7Rc78HqM4KFSFvXCA8i8
 UDG4SZxh2Ec15mU6tXCn/CxIDwkgbzKd31jRfzjdNTFgHCCg0WhY7KOziKygiQ9sHWVoAXpzcI3
 YlBIe8GOgoGL1EssjlzWIDOtCoEwMW2n0FxWfUHHH58l18HnIsLsiRM7g06yyuKHBEmRjT7VLel
 UI/ZXatvhJElEtQf55UB3xEwx9+Bao2XEdQfxj7MKxnJUzPOx1him14RIBbi4xN4hZNnTQy9z34
 FZHWl+1gmILOciok0ZRew7Sjo63EebAC45oI2bAv+sBncIpNlpjHyPAxd1srhNSKpMWQCajPqbt
 3nnTO2jT5xe8vd7axjw7OH4UbcT2i1
X-Google-Smtp-Source: AGHT+IGSAYzHysUg1RV9R4uVHR0HLGs42RO1LKN0hbqgwRKDjjvOczbXnst8X0TU7+hkSlmXTDHB3A==
X-Received: by 2002:a17:906:6a09:b0:b71:1420:3357 with SMTP id
 a640c23a62f3a-b72e055ddcbmr182671266b.45.1762586203758; 
 Fri, 07 Nov 2025 23:16:43 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf312271sm449212566b.19.2025.11.07.23.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 23:16:43 -0800 (PST)
Date: Sat, 8 Nov 2025 07:16:42 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aQ7uWgtQFqoyuuj3@autotest-wegao.qe.prg2.suse.org>
References: <20251107102939.1111074-1-pvorel@suse.cz>
 <20251107102939.1111074-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251107102939.1111074-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/8] tst_test.c: Fix tst_check_cmd() use
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 07, 2025 at 11:29:32AM +0100, Petr Vorel wrote:
> 9bb94efa39 changed tst_check_cmd() from int to bool. But it reverted the
> values (0 became true), which logical (false means not supported) than
> the original return codes from 257394e4e3. But then the only use of
> tst_check_cmd() needs to update to expect false instead of true.
> 
> Also document the return code in tst_private.h.
> 
> Fixes: 9bb94efa39 ("tst_cmd: Change tst_check_cmd() return type to int")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Fixing my own error.
> 
>  include/tst_private.h | 5 +++++
>  lib/tst_test.c        | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_private.h b/include/tst_private.h
> index 87ec8829a1..482b68fba2 100644
> --- a/include/tst_private.h
> +++ b/include/tst_private.h
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) Linux Test Project, 2020-2025
>   * Copyright (c) 2017-2019 Petr Vorel <pvorel@suse.cz>
>   *
>   * Internal helper functions for the shell library. Do not use directly
> @@ -41,9 +42,13 @@ char tst_kconfig_get(const char *confname);
>  /*
>   * If cmd argument is a single command, this function just checks command
>   * whether exists. If not, case breaks if brk_nosupp is defined.
> + *
>   * If cmd argument is a complex string ie 'mkfs.ext4 >= 1.43.0', this
>   * function checks command version whether meets this requirement.
>   * If not, case breaks if brk_nosupp is defined.
> + *
> + * return: true if command presented, optionally with high enough version, false
> + * otherwise.
>   */
>  bool tst_check_cmd(const char *cmd, const int brk_nosupp);
>  
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index da5314c502..bda66c4672 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1960,7 +1960,7 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>  	tst_res(TINFO, "=== Testing on %s ===", fs_type);
>  	tdev.fs_type = fs_type;
>  
> -	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
> +	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
>  		return TCONF;
>  
>  	if (fs->min_kver && check_kver(fs->min_kver, 0))
Reviewed-by: Wei Gao <wegao@suse.com>
> -- 
> 2.51.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
