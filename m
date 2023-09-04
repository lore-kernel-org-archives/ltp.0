Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046DDC71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 07:55:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 456143CB88D
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:55:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C0EE3CB871
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:55:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA38D2001D5
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 09:55:38 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 111C32187A;
 Mon,  4 Sep 2023 07:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693814138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8Y8B2C9R/BFYm3tRhBo1mhOVKGRvoN1WhfCtX3ubZs=;
 b=ansJ5xr8BplrCzzu9QbL1o8kpYp/6S8EVIRmoubdW9NC82Z2cRzJJ2j0igxk8fW18F1Yrj
 0Z/Aw2bFw14KTtfPc28ihmH218ZCi+ZkN6KK4+jMBTUL2dAT0IkRtm6joXd5Yuj8/V5MA5
 LkzO2qB1JDefr+M7THeMoTkNhk8B6V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693814138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8Y8B2C9R/BFYm3tRhBo1mhOVKGRvoN1WhfCtX3ubZs=;
 b=53qQhzO3rxR61uvRzUv7Cq3nCz1rxeqP60d19vaAR2//j1JN1DNwhG+Eo40TD+q3CCIqxp
 DJjqJSH6xlj/MEBA==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3EFA82C142;
 Mon,  4 Sep 2023 07:55:37 +0000 (UTC)
References: <20230902055638.14256-1-wegao@suse.com>
 <20230902074726.9837-1-wegao@suse.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Mon, 04 Sep 2023 08:48:51 +0100
Organization: Linux Private Site
In-reply-to: <20230902074726.9837-1-wegao@suse.com>
Message-ID: <8734zugyo8.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clone302: Fix short size test
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
Cc: Martin Doucha <mdoucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/sched.h                        | 4 ++++
>  testcases/kernel/syscalls/clone3/clone302.c | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index ac766efc5..f1133ca12 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -46,6 +46,10 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
>  }
>  
>  #ifndef HAVE_CLONE3
> +
> +#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */

I think what Martin meant was to define a minimal struct, which I prefer
for a few reasons.

You can find the original def in commit:
7f192e3cd316ba58c88dfa26796cf77789dd9872

(I found that using Git blame on fork.c)

Then you can assert our struct is == 64 during the test. This is
paranoid, but it checks that the test is compiled correctly and we
defined the structure correctly.

> +#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
> +
>  struct clone_args {
>  	uint64_t __attribute__((aligned(8))) flags;
>  	uint64_t __attribute__((aligned(8))) pidfd;
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> index b1b4ccebb..02ccb3c29 100644
> --- a/testcases/kernel/syscalls/clone3/clone302.c
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -34,7 +34,8 @@ static struct tcase {
>  } tcases[] = {
>  	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
>  	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> -	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"short size", &valid_args, CLONE_ARGS_SIZE_VER0 - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"short size for clone_into_group flag", &valid_args, CLONE_ARGS_SIZE_VER2 - 1, CLONE_INTO_CGROUP, NULL, SIGCHLD, 0, 0, 0, EINVAL},
>  	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
>  	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, SIGCHLD, 0, 0, 0, EINVAL},
>  	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
