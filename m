Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB5AC61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 10:11:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA3033CAEAF
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 11:11:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97BD13C03AE
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:11:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59791200740
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:11:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 983902267B;
 Mon, 13 Mar 2023 10:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678702279;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VC1ei/dvQp/W/1RxCYGhALA7kQN95Ipm66vKihvrhJM=;
 b=IV/sH8COR/zvE07S94pgXG5CBjmupJAhIiNHuLgqerQQWwHUhK3Sq6Uk73tWqW3qmiRFae
 lPTfeMemYAivKJbM40tUUTYwUmgCETv/ZtEeGTyUvTzLMGOHGJBBAhu12ZpshnebxlieyT
 uCVEb11OE4fh32i3Ib+XLumhGns7lXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678702279;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VC1ei/dvQp/W/1RxCYGhALA7kQN95Ipm66vKihvrhJM=;
 b=BMFIjYwHM/JQwfd3PL8BQzrd7bLrpvGx6XZ/xxlf7JREX7qaO4QJN9DQkWmGYzHUsPE87M
 6nCQxHq5cfTsg7BQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6907A2C141;
 Mon, 13 Mar 2023 10:11:19 +0000 (UTC)
References: <20230228124348.13164-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Mon, 13 Mar 2023 10:04:30 +0000
Organization: Linux Private Site
In-reply-to: <20230228124348.13164-1-andrea.cervesato@suse.com>
Message-ID: <877cvl6jw9.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Remove ltp_clone_quick usage from pidns suite
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

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Replaced ltp_clone_quick with SAFE_CLONE inside the pidns testing
> suite.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/containers/pidns/pidns01.c | 14 ++++++------
>  testcases/kernel/containers/pidns/pidns02.c | 14 ++++++------
>  testcases/kernel/containers/pidns/pidns03.c | 14 ++++++------
>  testcases/kernel/containers/pidns/pidns12.c | 18 +++++++++-------
>  testcases/kernel/containers/pidns/pidns20.c | 24 +++++++++++----------
>  5 files changed, 44 insertions(+), 40 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
> index 5080b6fad..998da7d95 100644
> --- a/testcases/kernel/containers/pidns/pidns01.c
> +++ b/testcases/kernel/containers/pidns/pidns01.c
> @@ -17,7 +17,7 @@
>  #include "tst_test.h"
>  #include "lapi/sched.h"
>  
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>  {
>  	pid_t cpid, ppid;
>  
> @@ -26,20 +26,20 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  
>  	TST_EXP_PASS(cpid == 1);
>  	TST_EXP_PASS(ppid == 0);
> -
> -	return 0;
>  }
>  
>  static void run(void)
>  {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };

At some point CLONE_NEWNS was substituted for CLONE_NEWPID. It still
passes because TST_EXP_PASS expects a zero return val. It should be
TST_EXP_EXPR or similar.

>  
> -	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK | TERRNO, "clone failed");
> +	if (!SAFE_CLONE(&args)) {
> +		child_func();
> +		return;
> +	}
>  }
>  
>  static struct tst_test test = {
>  	.test_all = run,
>  	.needs_root = 1,
> +	.forks_child = 1,

We need to check PID namespaces are supported in the kernel config.

>  };
> diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
> index b8913d3f6..57102f652 100644
> --- a/testcases/kernel/containers/pidns/pidns02.c
> +++ b/testcases/kernel/containers/pidns/pidns02.c
> @@ -16,7 +16,7 @@
>  #include "tst_test.h"
>  #include "lapi/sched.h"
>  
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>  {
>  	pid_t sid, pgid;
>  
> @@ -25,20 +25,20 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  
>  	TST_EXP_PASS(sid == 1);
>  	TST_EXP_PASS(pgid == 1);
> -
> -	return 0;
>  }
>  
>  static void run(void)
>  {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };

Same issue here.

>  
> -	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK | TERRNO, "clone failed");
> +	if (!SAFE_CLONE(&args)) {
> +		child_func();
> +		return;
> +	}
>  }
>  
>  static struct tst_test test = {
>  	.test_all = run,
>  	.needs_root = 1,
> +	.forks_child = 1,

Also needs config check

>  };
> diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
> index 122ba7891..50e69a9f3 100644
> --- a/testcases/kernel/containers/pidns/pidns03.c
> +++ b/testcases/kernel/containers/pidns/pidns03.c
> @@ -17,7 +17,7 @@
>  
>  #define PROCDIR "proc"
>  
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>  {
>  	char proc_self[10];
>  
> @@ -28,8 +28,6 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  	SAFE_UMOUNT(PROCDIR);
>  
>  	TST_EXP_PASS(strcmp(proc_self, "1"), PROCDIR"/self contains 1:");
> -
> -	return 0;
>  }
>  
>  static void setup(void)
> @@ -45,11 +43,12 @@ static void cleanup(void)
>  
>  static void run(void)
>  {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
>  
> -	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK | TERRNO, "clone failed");
> +	if (!SAFE_CLONE(&args)) {
> +		child_func();
> +		return;
> +	}
>  }
>  
>  static struct tst_test test = {
> @@ -57,5 +56,6 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.needs_root = 1,
> +	.forks_child = 1,
>  	.needs_tmpdir = 1,

Need config check.

>  };
> diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
> index fb1ec90ca..2631a7451 100644
> --- a/testcases/kernel/containers/pidns/pidns12.c
> +++ b/testcases/kernel/containers/pidns/pidns12.c
> @@ -25,7 +25,7 @@ static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LT
>  	sig_pid = si->si_pid;
>  }
>  
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>  {
>  	struct sigaction sa;
>  
> @@ -41,21 +41,22 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
>  	TST_EXP_EQ_LI(sig_pid, 0);
> -
> -	return 0;
>  }
>  
>  static void run(void)
>  {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
> +	int pid;
>  
> -	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK | TERRNO, "clone failed");
> +	pid = SAFE_CLONE(&args);
> +	if (!pid) {
> +		child_func();
> +		return;
> +	}
>  
>  	TST_CHECKPOINT_WAIT(0);
>  
> -	SAFE_KILL(ret, SIGUSR1);
> +	SAFE_KILL(pid, SIGUSR1);
>  
>  	TST_CHECKPOINT_WAKE(0);
>  }
> @@ -63,5 +64,6 @@ static void run(void)
>  static struct tst_test test = {
>  	.test_all = run,
>  	.needs_root = 1,
> +	.forks_child = 1,
>  	.needs_checkpoints = 1,

Needs config check

>  };
> diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
> index 9f369699a..c3d63d125 100644
> --- a/testcases/kernel/containers/pidns/pidns20.c
> +++ b/testcases/kernel/containers/pidns/pidns20.c
> @@ -26,7 +26,7 @@ static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LT
>  	signals++;
>  }
>  
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>  {
>  	struct sigaction sa;
>  	sigset_t newset;
> @@ -37,7 +37,7 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  
>  	if (cpid != 1 || ppid != 0) {
>  		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
> -		return 0;
> +		return;
>  	}
>  
>  	SAFE_SIGEMPTYSET(&newset);
> @@ -56,30 +56,31 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  
>  	if (signals != 1) {
>  		tst_res(TFAIL, "Received %d signals", signals);
> -		return 0;
> +		return;
>  	}
>  
>  	if (last_signo != SIGUSR1) {
>  		tst_res(TFAIL, "Received %s signal", tst_strsig(last_signo));
> -		return 0;
> +		return;
>  	}
>  
>  	tst_res(TPASS, "Received SIGUSR1 signal after unblock");
> -
> -	return 0;
>  }
>  
>  static void run(void)
>  {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWPID, SIGCHLD };
> +	int pid;
>  
> -	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK | TERRNO, "clone failed");
> +	pid = SAFE_CLONE(&args);
> +	if (!pid) {
> +		child_func();
> +		return;
> +	}
>  
>  	TST_CHECKPOINT_WAIT(0);
>  
> -	SAFE_KILL(ret, SIGUSR1);
> +	SAFE_KILL(pid, SIGUSR1);
>  
>  	TST_CHECKPOINT_WAKE(0);
>  }
> @@ -87,5 +88,6 @@ static void run(void)
>  static struct tst_test test = {
>  	.test_all = run,
>  	.needs_root = 1,
> +	.forks_child = 1,
>  	.needs_checkpoints = 1,

Needs config check

>  };
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
