Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E61CC64EC7
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 11:28:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C47E93CDDDC
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 12:28:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99C353CB465
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 12:27:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3EEB565308B
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 12:27:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2A2641FDC1;
 Tue, 28 Feb 2023 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677583668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1iipBKUSMflc5sWwc6HOt7aeyxRn1yIYI02T642sn+E=;
 b=OZ1AhdKMvwjob7DNJT/h+fsKm2wZuGcXtWPioQQMR5irAftMISfs3Dc6vD+QX6hkbzZzRM
 XZuka9Cs6f7KJGWfTG5pcj5R2+MyZJ6VAQlClpSmsr8NDYGxflqjRtG19q0uWAf9KalPOc
 LZ9e6/YHqMEtqTN4Y0Vc7OR+AobIBXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677583668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1iipBKUSMflc5sWwc6HOt7aeyxRn1yIYI02T642sn+E=;
 b=6qEI2EnyErIBqUmCIc29dMa87LyDwXId2bMiurrfzmYI7LugG1NEYWsfqRwwuVdhwBo34q
 jw/jQicfdWLPGOBA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F08542C141;
 Tue, 28 Feb 2023 11:27:47 +0000 (UTC)
References: <20230215101615.27534-1-andrea.cervesato@suse.com>
 <20230215101615.27534-8-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 28 Feb 2023 11:23:13 +0000
Organization: Linux Private Site
In-reply-to: <20230215101615.27534-8-andrea.cervesato@suse.com>
Message-ID: <87o7pet4gd.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 07/10] Refactor userns07 test
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

All merged, thanks!

This one I made some changes to, please see below.

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/containers/userns/userns07.c | 67 +++++++++++--------
>  1 file changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
> index 4659de636..3a693b8e3 100644
> --- a/testcases/kernel/containers/userns/userns07.c
> +++ b/testcases/kernel/containers/userns/userns07.c
> @@ -16,80 +16,89 @@
>  #include <sys/wait.h>
>  #include "common.h"
>  #include "tst_test.h"
> +#include "lapi/sched.h"
>  
>  #define MAXNEST 32
>  
> -static void setup(void)
> -{
> -	check_newuser();
> -}
> +static int *level;

AFAICT we do not need this variable and to use mmap. We can just pass an
int to child_fn1.

Unless you wanted to check at the end of the test that level == 32?
However you weren't doing that, so I just removed it.

>  
> -static int child_fn1(void *arg)
> +static void child_fn1(void)
>  {
> -	pid_t cpid1;
> -	long level = (long)arg;
> -	int status;
> +	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
> +	pid_t cpid;
>  	int parentuid;
>  	int parentgid;
> +	int status;
>  
>  	TST_CHECKPOINT_WAIT(0);
>  
> -	if (level == MAXNEST) {
> +	if (*level == MAXNEST) {
>  		tst_res(TPASS, "nested all children");
> -		return 0;
> +		return;
>  	}
>  
> -	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)(level + 1));
> -	if (cpid1 < 0) {
> -		tst_res(TFAIL | TERRNO, "level %ld, unexpected error", level);
> -		return 1;
> +	cpid = SAFE_CLONE(&args);
> +	if (!cpid) {
> +		*level += 1;
> +		child_fn1();
> +		return;
>  	}
>  
>  	parentuid = geteuid();
>  	parentgid = getegid();
>  
> -	updatemap(cpid1, UID_MAP, 0, parentuid);
> -	updatemap(cpid1, GID_MAP, 0, parentgid);
> +	updatemap(cpid, UID_MAP, 0, parentuid);
> +	updatemap(cpid, GID_MAP, 0, parentgid);
>  
>  	TST_CHECKPOINT_WAKE(0);
>  
> -	SAFE_WAITPID(cpid1, &status, 0);
> -
> -	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -		tst_brk(TBROK, "child %s", tst_strstatus(status));
> -
> -	return 0;
> +	SAFE_WAITPID(cpid, &status, 0);

replaced with tst_reap_children.

>  }
>  
>  static void run(void)
>  {
> -	pid_t cpid1;
> +	const struct tst_clone_args args = { CLONE_NEWUSER, SIGCHLD };
> +	pid_t cpid;
>  	int parentuid;
>  	int parentgid;
>  	char path[BUFSIZ];
>  
> -	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)0);
> -	if (cpid1 < 0)
> -		tst_brk(TBROK | TTERRNO, "clone failed");
> +	cpid = SAFE_CLONE(&args);
> +	if (!cpid) {
> +		child_fn1();
> +		return;
> +	}
>  
>  	parentuid = geteuid();
>  	parentgid = getegid();
>  
>  	if (access("/proc/self/setgroups", F_OK) == 0) {
> -		sprintf(path, "/proc/%d/setgroups", cpid1);
> +		sprintf(path, "/proc/%d/setgroups", cpid);
>  		SAFE_FILE_PRINTF(path, "deny");
>  	}
>  
> -	updatemap(cpid1, UID_MAP, 0, parentuid);
> -	updatemap(cpid1, GID_MAP, 0, parentgid);
> +	updatemap(cpid, UID_MAP, 0, parentuid);
> +	updatemap(cpid, GID_MAP, 0, parentgid);
>  
>  	TST_CHECKPOINT_WAKE(0);
>  }
>  
> +static void setup(void)
> +{
> +	level = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(level, sizeof(int));
> +}
> +
>  static struct tst_test test = {
>  	.setup = setup,
> +	.cleanup = cleanup,
>  	.test_all = run,
>  	.needs_root = 1,
> +	.forks_child = 1,
>  	.needs_checkpoints = 1,
>  	.needs_kconfigs = (const char *[]) {
>  		"CONFIG_USER_NS",
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
