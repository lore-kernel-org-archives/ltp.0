Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D61EE14DE
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 11:11:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5D513CE9C1
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 13:11:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D5673CB579
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:11:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9C30602F6C
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 13:11:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3AAF71F8A6;
 Thu,  7 Sep 2023 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694085085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLPwzwJO/kOcO9NT2X/kuHPf6ewpJaAnv6I6u4A3Rvk=;
 b=BbazeP9ngkgB1QZ9tQN/prvMScZ582BD/99zUHGs52KMDn5L0apUwThtqtDshzI7cGYDfQ
 rXpwW+Yt54itcj9K23x49+X1MOD0d/xd3Oi0GIuiORAPDv7kuGSjemWmd0Jgub4Gu6PLFT
 yNoW5h8ZNdE9UQllJfiIvpcK7ZctxDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694085085;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLPwzwJO/kOcO9NT2X/kuHPf6ewpJaAnv6I6u4A3Rvk=;
 b=dYHVVMSFrTu6FYSSgJG9JQRKeXv5I2gQRm29vl8X9EHiBV5r9UJtWKG/EVPj2zK8oJwkBq
 mQFPdcdyFxRlA5CA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8BB692C142;
 Thu,  7 Sep 2023 11:11:24 +0000 (UTC)
References: <20230905101444.3365-1-wegao@suse.com>
 <20230907100149.12090-1-wegao@suse.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Thu, 07 Sep 2023 12:11:14 +0100
Organization: Linux Private Site
In-reply-to: <20230907100149.12090-1-wegao@suse.com>
Message-ID: <87il8mdyqu.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] clone302: Fix short size test
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

Pushed!

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/sched.h                        | 11 +++++++++++
>  testcases/kernel/syscalls/clone3/clone302.c |  5 ++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index ac766efc5..26fdb628d 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -60,6 +60,17 @@ struct clone_args {
>  	uint64_t __attribute__((aligned(8))) cgroup;
>  };
>  
> +struct clone_args_minimal {
> +	uint64_t __attribute__((aligned(8))) flags;
> +	uint64_t __attribute__((aligned(8))) pidfd;
> +	uint64_t __attribute__((aligned(8))) child_tid;
> +	uint64_t __attribute__((aligned(8))) parent_tid;
> +	uint64_t __attribute__((aligned(8))) exit_signal;
> +	uint64_t __attribute__((aligned(8))) stack;
> +	uint64_t __attribute__((aligned(8))) stack_size;
> +	uint64_t __attribute__((aligned(8))) tls;
> +};
> +
>  static inline int clone3(struct clone_args *args, size_t size)
>  {
>  	return tst_syscall(__NR_clone3, args, size);
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> index b1b4ccebb..48b831554 100644
> --- a/testcases/kernel/syscalls/clone3/clone302.c
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -12,6 +12,7 @@
>  #define _GNU_SOURCE
>  
>  #include <stdlib.h>
> +#include <assert.h>
>  
>  #include "tst_test.h"
>  #include "lapi/sched.h"
> @@ -34,7 +35,7 @@ static struct tcase {
>  } tcases[] = {
>  	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
>  	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> -	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"short size", &valid_args, sizeof(struct clone_args_minimal) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
>  	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
>  	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, SIGCHLD, 0, 0, 0, EINVAL},
>  	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> @@ -59,6 +60,8 @@ static void setup(void)
>  {
>  	clone3_supported_by_kernel();
>  
> +	TST_EXP_EQ_SZ(sizeof(struct clone_args_minimal), 64);
> +
>  	void *p = tst_get_bad_addr(NULL);
>  
>  	invalid_args = p;
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
