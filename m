Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F69C433EF
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:12:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D8DA3CA0A8
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 14:12:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFB253C5F90
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 14:12:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1F15600212
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 14:12:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA21321763;
 Wed, 16 Feb 2022 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645017120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygpg0o5ERs4/b8ObALIkGGt90eE0QyslDHdRc56+OoU=;
 b=G95RcMN5qCALIRmCPhZnUM7oviyJe5v2Q3C3dHhi5FKlMQV4tAyVThAKcEmo71cZT311Th
 kvUZxulrNEsAI2llqk6fSvoy3IaW/PXUanoUtDfW54yWHpDUPB17J514DJ0U072C4hgivs
 BpM35Cy8JzbF6SDe9oQDp9eBcHRC09w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645017120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ygpg0o5ERs4/b8ObALIkGGt90eE0QyslDHdRc56+OoU=;
 b=UQR5Pedmszdgo+1UaLZyCGjjxQIofwWsU6BKjMlBP2JWeyQon2zfNgg5ZG/A40bCxlEL1X
 YN2rFGgK+7hbhZCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2A6B13B0A;
 Wed, 16 Feb 2022 13:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zWVHKiD4DGKJZgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 16 Feb 2022 13:12:00 +0000
Date: Wed, 16 Feb 2022 14:11:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Ygz4FlU4MGGLqixH@rei>
References: <20220128084409.21708-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220128084409.21708-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactoring setpgid03.c test using new LTP API
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
> +	child_pid = SAFE_FORK();
> +	if (!child_pid) {
> +		do_child();
> +		return;
>  	}
>  
> -	cleanup();
> -	tst_exit();
> -}
> +	TST_CHECKPOINT_WAIT(0);
>  
> -static void do_child(void)
> -{
> -	if (setsid() < 0) {
> -		printf("CHILD: setsid() failed, errno: %d\n", errno);
> -		exit(2);
> -	}
> +	TEST(setpgid(child_pid, getppid()));
> +	if (TST_RET == -1 && TST_ERR == EPERM)
> +		tst_res(TPASS, "setpgid failed with EPERM");
> +	else
> +		tst_res(TFAIL, "retval %ld, errno %s, expected EPERM", TST_RET,
> +			tst_strerrno(TST_ERR));

Make use of the TST_EXP_FAIL() please.

> -	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> +	TST_CHECKPOINT_WAKE(0);
>  
> -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	if (wait(&status) < 0)
> +		tst_res(TFAIL, "wait() for child 1 failed");
>  
> -	exit(0);
> -}
> +	if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
> +		tst_res(TFAIL, "child 1 failed with status %d",
> +			WEXITSTATUS(status));

No need to wait for the child here, just let the test library collect
it.

> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	/* child after exec() we are no longer allowed to set pgid */
> +	child_pid = SAFE_FORK();
> +	if (!child_pid)
> +		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
>  
> -	tst_tmpdir();
> +	TST_CHECKPOINT_WAIT(0);
>  
> -	TST_CHECKPOINT_INIT(tst_rmdir);
> +	TEST(setpgid(child_pid, getppid()));
> +	if (TST_RET == -1 && TST_ERR == EACCES)
> +		tst_res(TPASS, "setpgid failed with EACCES");
> +	else
> +		tst_res(TFAIL, "retval %ld, errno %s, expected EACCES", TST_RET,
> +			tst_strerrno(TST_ERR));

Here as well.

> -	umask(0);
> +	TST_CHECKPOINT_WAKE(0);
>  
> -	TEST_PAUSE;
> -}
> +	if (wait(&status) < 0)
> +		tst_res(TFAIL, "wait() for child 2 failed");
>  
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> +	if (!(WIFEXITED(status)) || (WEXITSTATUS(status) != 0))
> +		tst_res(TFAIL, "child 2 failed with status %d",
> +			WEXITSTATUS(status));
>  }

And here as well.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +};
> diff --git a/testcases/kernel/syscalls/setpgid/setpgid03_child.c b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> index 2657422a6..fdb22f24d 100644
> --- a/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> +++ b/testcases/kernel/syscalls/setpgid/setpgid03_child.c
> @@ -1,32 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software Foundation,
> - * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>  
> -#include "test.h"
> -
> -char *TCID = "setpgid03_child";
> -
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
>  
>  int main(void)
>  {
> -	TST_CHECKPOINT_INIT(NULL);
> -
> -	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> -	TST_SAFE_CHECKPOINT_WAIT(NULL, 0);
> +	tst_reinit();
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
