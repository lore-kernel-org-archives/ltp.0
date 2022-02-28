Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B07C433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 15:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AB223CA2A4
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 16:40:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76B2D3CA21C
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 16:40:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B95B2200C3F
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 16:40:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D7F031F3A3;
 Mon, 28 Feb 2022 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646062826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pjw7rilz/uhLIJ5LleG/gKe6Bp9frDebrHWbNz/Q3ok=;
 b=M7xI539tZ0CfR+XG8N4bxFpdUumYwZxcNeVNFaKedUv4FtshVv6ToYcU/4t1U8Lgx3is+K
 pfCkj7uPH7O+JljmoxEK/wji4uzwiwQCVciKvZuQr14p/Kk164GP0iVlLZScOLPMuZjY/8
 MO3X4664SLF4uElWl8y3aPTDEoGj1c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646062826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pjw7rilz/uhLIJ5LleG/gKe6Bp9frDebrHWbNz/Q3ok=;
 b=OtmuaUus03tw0YepVX6c9JIFjwgrlGcm6X19M0ej0s2WahQeyHlKv+n7I+/xu/cys13bXe
 CKFtA1qpKc4KrzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C46C313C4F;
 Mon, 28 Feb 2022 15:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eQyLLursHGJqfAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 28 Feb 2022 15:40:26 +0000
Date: Mon, 28 Feb 2022 16:42:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yhztdezj+WVzfved@yuki>
References: <20220228133256.12763-1-andrea.cervesato@suse.de>
 <20220228133256.12763-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220228133256.12763-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] Rewrite mountns01 test using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2014 Red Hat, Inc.
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>   *
>   * Tests a shared mount: shared mount can be replicated to as many
>   * mountpoints and all the replicas continue to be exactly same.
> - * Description:
> + *
> + * [Algorithm]
> + *
>   * 1. Creates directories "A", "B" and files "A/A", "B/B"
>   * 2. Unshares mount namespace and makes it private (so mounts/umounts
>   *    have no effect on a real system)
> @@ -25,125 +20,110 @@
>   * 5. Clones a new child process with CLONE_NEWNS flag
>   * 6. There are two test cases (where X is parent namespace and Y child
>   *    namespace):
> - *    1)
> + * 1)
>   *	X: bind mounts "B" to "A"
>   *	Y: must see "A/B"
>   *	X: umounts "A"
> - *    2)
> + * 2)
>   *	Y: bind mounts "B" to "A"
>   *	X: must see "A/B"
>   *	Y: umounts "A"

This does not render as lists in asciidoc at all, please fix.

> -#define _GNU_SOURCE
>  #include <sys/wait.h>
>  #include <sys/mount.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include "mountns_helper.h"
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID	= "mountns01";
> -int TST_TOTAL	= 2;
> +#include "mountns.h"
> +#include "tst_test.h"
>  
> -#if defined(MS_SHARED) && defined(MS_PRIVATE) && defined(MS_REC)
> -
> -int child_func(void *arg LTP_ATTRIBUTE_UNUSED)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
>  	int ret = 0;
>  
> -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	TST_CHECKPOINT_WAIT(0);
>  
> -	if (access(DIRA"/B", F_OK) == -1)
> +	if (access(DIRA "/B", F_OK) < 0)
>  		ret = 2;
>  
> -	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	/* bind mounts DIRB to DIRA making contents of DIRB visible
> -	 * in DIRA */
> -	if (mount(DIRB, DIRA, "none", MS_BIND, NULL) == -1) {
> -		perror("mount");
> -		return 1;
> -	}
> +	/* bind mounts DIRB to DIRA making contents of DIRB visible in DIRA */
> +	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
>  
> -	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(NULL, 0);
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
> +
> +	SAFE_UMOUNT(DIRA);
>  
> -	umount(DIRA);
>  	return ret;
>  }
>  
> -static void test(void)
> +static void run(void)
>  {
> -	int status;
> +	int status, ret;
>  
>  	/* unshares the mount ns */
> -	if (unshare(CLONE_NEWNS) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "unshare failed");
> +	SAFE_UNSHARE(CLONE_NEWNS);
> +
>  	/* makes sure parent mounts/umounts have no effect on a real system */
> -	SAFE_MOUNT(cleanup, "none", "/", "none", MS_REC|MS_PRIVATE, NULL);
> +	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);
>  
>  	/* bind mounts DIRA to itself */
> -	SAFE_MOUNT(cleanup, DIRA, DIRA, "none", MS_BIND, NULL);
> +	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
>  
>  	/* makes mount DIRA shared */
> -	SAFE_MOUNT(cleanup, "none", DIRA, "none", MS_SHARED, NULL);
> +	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
>  
> -	if (do_clone_tests(CLONE_NEWNS, child_func, NULL, NULL, NULL) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "clone failed");
> +	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
> +	if (ret < 0)
> +		tst_brk(TBROK, "clone failed");
>  
> -	/* bind mounts DIRB to DIRA making contents of DIRB visible
> -	 * in DIRA */
> -	SAFE_MOUNT(cleanup, DIRB, DIRA, "none", MS_BIND, NULL);
> +	/* bind mounts DIRB to DIRA making contents of DIRB visible in DIRA */
> +	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
>  
> -	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 0);
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	SAFE_UMOUNT(cleanup, DIRA);
> +	SAFE_UMOUNT(DIRA);
>  
> -	TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 0);
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	if (access(DIRA"/B", F_OK) == 0)
> -		tst_resm(TPASS, "shared mount in child passed");
> +	if (access(DIRA "/B", F_OK) == 0)
> +		tst_res(TPASS, "shared mount in child passed");
>  	else
> -		tst_resm(TFAIL, "shared mount in child failed");
> +		tst_res(TFAIL, "shared mount in child failed");
>  
> -	TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> +	TST_CHECKPOINT_WAKE(0);
>  
> +	SAFE_WAIT(&status);
>  
> -	SAFE_WAIT(cleanup, &status);
>  	if (WIFEXITED(status)) {
>  		if ((WEXITSTATUS(status) == 0))
> -			tst_resm(TPASS, "shared mount in parent passed");
> +			tst_res(TPASS, "shared mount in parent passed");
>  		else
> -			tst_resm(TFAIL, "shared mount in parent failed");
> +			tst_res(TFAIL, "shared mount in parent failed");
>  	}

Again there is no need to propagate results via exit value like this,
the tst_res() function will work in the child just fine.

>  	if (WIFSIGNALED(status)) {
> -		tst_resm(TBROK, "child was killed with signal %s",
> -			 tst_strsig(WTERMSIG(status)));
> -		return;
> +		tst_brk(TBROK, "child was killed with signal %s",
> +			tst_strsig(WTERMSIG(status)));
>  	}

And the segfault will be caught by the test library, so no need to wait
for the child here as well.

> -	SAFE_UMOUNT(cleanup, DIRA);
> +	SAFE_UMOUNT(DIRA);
>  }
>  
> -int main(int argc, char *argv[])
> +static void setup(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++)
> -		test();
> -
> -	cleanup();
> -	tst_exit();
> +	check_newns();
> +	create_folders();
>  }
>  
> -#else
> -int main(void)
> +static void cleanup(void)
>  {
> -	tst_brkm(TCONF, NULL, "needed mountflags are not defined");
> +	umount_folders();
>  }
> -#endif
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +};
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
