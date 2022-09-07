Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EBFECAAD3
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 07:05:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 134233CA9CA
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 09:05:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90EE63C0475
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 09:05:39 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A9261000A5B
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 09:05:39 +0200 (CEST)
Received: by mail-qk1-x734.google.com with SMTP id w18so9842009qki.8
 for <ltp@lists.linux.it>; Wed, 07 Sep 2022 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=rZKDUM1hFHWs1yJgr80UlpWrB098BSurmECVLIlNn60=;
 b=M9RWosx871Ja6nM7aDUHgVBOce7pcLU3gX+N6BFA+iJJNu/2SlU46+9WRoMnGWhUiI
 k7XmfSeI0uIV4JiLRCy+MLd8Ah9nZ2+bm6FXVKWHxy/N/rAJfpXgfn6UP5TAb2HfrLbn
 wcrwtG6kmsPH0lm4YJAU2mOewmTxASIaLzodKSNE4S8gqWWLw4RMq2ZZOYyBfxjuL5/N
 DH/fmK3UocFBncw03Qw6icx5Z/P6arflQLN3KSQ/92uMO5STbNLqa0jMk6GOWI3w7Zbm
 UquSVgk0XPp8pCX3VoAUIzwl7FLAhwN0IY3ABgCYGH2YEDH5/45CgyoK7MyV79ulV3tp
 2ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=rZKDUM1hFHWs1yJgr80UlpWrB098BSurmECVLIlNn60=;
 b=qWvaME49q0gCRIvyIR7F8WIEc5sgFQuuRGt8OgHZhq8YsWDl+hhksaFOP6jLvYdHwh
 mlxNiUMi8TvZv7aKM/6wOMKF8aHs7uoF5UyXIMvtNIam17d+3StPlTOhWrT/7w0eSrqr
 a3PzCO5d05jKF95Ru30cmPoN4M5ynG66nALaaVRmmbdzd/0+C048HCT11cbs6O/CUwu4
 DvRU3lU3L2LQQB7QhbNCIA/VAtoYMYZFd1ffWCBapkgZNOa85aQKfaK+KCryzsZpG43y
 RAz8OtEaw6MG3hDY15T6kYaTEmuxyQlVoMU5ktq+nnZsvwt5GGWoIiAvyYGni0ygS949
 dVEg==
X-Gm-Message-State: ACgBeo0R/P9tdum+FnWFjQbJgqx/kKykplwBwSLlvCGqSKRg8zwNBjS+
 oUFo8l1HSzFCUSS6W1sHAQ+NjQ==
X-Google-Smtp-Source: AA6agR49MawU/4O+X6OCNaeefe15DWpFgdQB40CpPqUEOazl7SHZYN1E9vsNwQDx6ARDgPwp5+TRlQ==
X-Received: by 2002:a05:620a:1357:b0:6ba:e661:f91a with SMTP id
 c23-20020a05620a135700b006bae661f91amr1646747qkl.744.1662534337637; 
 Wed, 07 Sep 2022 00:05:37 -0700 (PDT)
Received: from google.com (123.178.145.34.bc.googleusercontent.com.
 [34.145.178.123]) by smtp.gmail.com with ESMTPSA id
 hf9-20020a05622a608900b00342fb07944fsm10908862qtb.82.2022.09.07.00.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 00:05:37 -0700 (PDT)
Date: Wed, 7 Sep 2022 07:05:33 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YxhCvWE5AaO/hve2@google.com>
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220906092615.15116-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify20: Simplify code
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 06, 2022 at 11:26:14AM +0200, Petr Vorel wrote:
> * replace do_test() content with TST_EXP_FD_ERRNO() macro
> * rename variables (shorten, use LTP common names)
> * remove tc->want_err (not needed)
> * add macro FLAGS_DESC (stringify)
> * don't print number of tests (not needed for just 2 tests)
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Awesome simplification!

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 81 +++++--------------
>  1 file changed, 19 insertions(+), 62 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index de0fdb782..badc4c369 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2021 Google. All Rights Reserved.
> + * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
>   *
>   * Started by Matthew Bobrowski <repnop@google.com>
>   */
> @@ -25,26 +26,21 @@
>  #include "fanotify.h"
>  
>  #define MOUNT_PATH	"fs_mnt"
> +#define FLAGS_DESC(x) .flags = x, .desc = #x

I'm wondering whether it makes sense to move this out into fanotify.h,
so that if the same test approach is ever used, we can simply recycle
this macro definition.

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
