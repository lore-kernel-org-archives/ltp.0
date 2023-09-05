Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4997C83F2C
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 08:48:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C10A43CC2F8
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 10:48:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C7833CB794
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 10:48:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81336600A33
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 10:48:42 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 819031F750;
 Tue,  5 Sep 2023 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693903722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hvdw0aOzw8MA8Z1JK4zUNSoqCr7Kbr3imdHsrSX4WZs=;
 b=NQTL7o7DgIpX4kS8/ANAqN+SF5z93R+FylbuYmy2pWSTnSNMu3ujLbXBd5ErUeDOr/X5nr
 xqaNyg6jX3zU8Lod5Fya4emzInFuZIbWHKY7f16tAJMrg0VtolydTQrjzEM4/P8BrxmbFt
 nUuNW/kKcyBgcjoTRaLkYts9GtPfVGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693903722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hvdw0aOzw8MA8Z1JK4zUNSoqCr7Kbr3imdHsrSX4WZs=;
 b=SHrtFhGaJ6oIU9p8dvUrWyPtnkM2NDHmMtaatWJJlW/IHA6AueFvoZKPnhPUq/D10/CBCY
 r8nAUwcMFFTcoVDw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D3EB92C142;
 Tue,  5 Sep 2023 08:48:41 +0000 (UTC)
References: <20230902074726.9837-1-wegao@suse.com>
 <20230904085239.18462-1-wegao@suse.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Tue, 05 Sep 2023 09:40:32 +0100
Organization: Linux Private Site
In-reply-to: <20230904085239.18462-1-wegao@suse.com>
Message-ID: <87ledlf1jt.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] clone302: Fix short size test
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

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/sched.h                        | 11 +++++++++++
>  testcases/kernel/syscalls/clone3/clone302.c |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index ac766efc5..f42b8969f 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -60,6 +60,17 @@ struct clone_args {
>  	uint64_t __attribute__((aligned(8))) cgroup;
>  };
>  
> +struct clone_args_minimal {
> +	__aligned_u64 flags;
> +	__aligned_u64 pidfd;
> +	__aligned_u64 child_tid;
> +	__aligned_u64 parent_tid;
> +	__aligned_u64 exit_signal;
> +	__aligned_u64 stack;
> +	__aligned_u64 stack_size;
> +	__aligned_u64 tls;
> +};

These look like kernel types. We have to write uint64_t
__attribute__((aligned(8))) or do our own type def of that.

Also I did say to assert during setup that clone_args_minimal is 64
bytes as expected.

> +
>  static inline int clone3(struct clone_args *args, size_t size)
>  {
>  	return tst_syscall(__NR_clone3, args, size);
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> index b1b4ccebb..bd1038319 100644
> --- a/testcases/kernel/syscalls/clone3/clone302.c
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -34,7 +34,7 @@ static struct tcase {
>  } tcases[] = {
>  	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
>  	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> -	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"short size", &valid_args, sizeof(struct clone_args_minimal) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
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
