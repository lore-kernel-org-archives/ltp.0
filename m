Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757BFC61DA4
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 11:53:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274983CC6EE
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 12:53:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3E3C3CBF64
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 12:53:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B05660043A
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 12:53:03 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AE24521B3C;
 Tue, 14 Feb 2023 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676375582;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWzOvvh+DTE75VE+bO7zJl7XGCtNEZxW/cywUYGaka4=;
 b=0y7voaiwaeRnjA6ILLO21/j1msIu43Svy2nQaJn4LhNd0uTA27X3MLH1SsLJEwdPSjCCGq
 E1xfXCEP6e7iTio0oEvLbaAQlMZEgQp/YDbRBJqw9LVvNgIg7xGmxstDClwyHibvl+UN4I
 seHysfn6tZXPHyjWoilBoS+PAqlr0BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676375582;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RWzOvvh+DTE75VE+bO7zJl7XGCtNEZxW/cywUYGaka4=;
 b=i9eljoi4FtS3VuLFs65+Ka+NFf1yqwntWt+oTjz1H4WgThvtUjvyOgyZNbWghIzGJy1Z9p
 wKWyUYQhaRV8PmDQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7F49C2C141;
 Tue, 14 Feb 2023 11:53:02 +0000 (UTC)
References: <20230213094703.28746-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 14 Feb 2023 11:50:17 +0000
Organization: Linux Private Site
In-reply-to: <20230213094703.28746-1-andrea.cervesato@suse.com>
Message-ID: <87wn4kmpk3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor pidns32 test using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged with a few changes!

Again we are using waitpid on its own. It will wait the children and
we'll only check the exit status of one of them. So I replaced it with
tst_reap_children.

Also I used tst_atomic to read and write from level. Not sure if that is
necessary, but it looks cleaner.

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Using SAFE_CLONE
> Using TST_EXP_* macros
>
>  testcases/kernel/containers/pidns/pidns32.c | 41 +++++++++++----------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
> index 3f7df788e..c9f8db3e5 100644
> --- a/testcases/kernel/containers/pidns/pidns32.c
> +++ b/testcases/kernel/containers/pidns/pidns32.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) Huawei Technologies Co., Ltd., 2015
> - * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>  
>  /*\
> @@ -12,32 +12,32 @@
>   */
>  
>  #define _GNU_SOURCE
> -
>  #include <sys/mman.h>
>  #include "tst_test.h"
>  #include "lapi/sched.h"
>  
>  #define MAXNEST 32
>  
> +static const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
>  static int *level;
>  
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>  {
>  	pid_t cpid;
>  	int status;
>  
>  	if (*level == MAXNEST)
> -		return 0;
> +		return;
>  
>  	(*level)++;
>  
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
> -	if (cpid < 0)
> -		tst_brk(TBROK | TERRNO, "clone failed");
> +	cpid = SAFE_CLONE(&args);
> +	if (!cpid) {
> +		child_func();
> +		return;
> +	}
>  
>  	SAFE_WAITPID(cpid, &status, 0);
> -
> -	return 0;
>  }
>  
>  static void setup(void)
> @@ -45,28 +45,29 @@ static void setup(void)
>  	level = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }
>  
> -static void run(void)
> +static void cleanup(void)
>  {
> -	int ret, status;
> +	SAFE_MUNMAP(level, sizeof(int));
> +}
>  
> +static void run(void)
> +{
>  	*level = 1;
>  
> -	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
> -	if (ret < 0)
> -		tst_brk(TBROK | TERRNO, "clone failed");
> -
> -	SAFE_WAITPID(ret, &status, 0);
> -
> -	if (*level < MAXNEST) {
> -		tst_res(TFAIL, "Nested containers should be %d, but they are %d", MAXNEST, *level);
> +	if (!SAFE_CLONE(&args)) {
> +		child_func();
>  		return;
>  	}
>  
> -	tst_res(TPASS, "All %d containers have been nested", MAXNEST);
> +	tst_reap_children();
> +
> +	TST_EXP_EQ_LI(*level, MAXNEST);
>  }
>  
>  static struct tst_test test = {
>  	.test_all = run,
>  	.needs_root = 1,
>  	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
>  };
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
