Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60057C05027
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 11:45:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B88AF3CBF63
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 12:45:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3F0C3CBF63
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 12:45:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 446631A0067D
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 12:45:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 141041FDE8;
 Tue, 14 Feb 2023 11:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676375110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p0lIl6QMKpb/AW4q0aj+zYCJc5gYrGIe+MeZl9aPMWE=;
 b=WkrPGUIhMEHFz5kp5iAxFdfF1lVvfsT4DCYlTigEpoJHDgIJ5UlZUSP4jkDNmIXdvfNwUR
 F0DQ2myY/xrAh0hDQt1dODTT1F4Jgh+Fd4LK/KPGnoHPi0H335HQls/K0N9z629GvuOXno
 aODz5qE18A39ImWfVlTE1QWKZ+oUpco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676375110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p0lIl6QMKpb/AW4q0aj+zYCJc5gYrGIe+MeZl9aPMWE=;
 b=Xp8djXdSjMP2zJ5yaT8PXgdbTvc27NwZCKrrYcLWudEuuvfmcrTWJGe6/ChyUKTiFwUmLO
 6zrJF3LB8ljNAmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2E9813A21;
 Tue, 14 Feb 2023 11:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SBOSOkV062OiBQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Feb 2023 11:45:09 +0000
Date: Tue, 14 Feb 2023 12:46:36 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y+t0nO08MToOh/jC@yuki>
References: <20230213134619.27486-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230213134619.27486-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] rseq01: basic test rseq
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
> Add basic check for the newly added glibc API in LTP.
> This test references the glibc test case tst-rseq.c.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  runtest/syscalls                          |  2 +
>  testcases/kernel/syscalls/rseq/.gitignore |  1 +
>  testcases/kernel/syscalls/rseq/Makefile   |  7 +++
>  testcases/kernel/syscalls/rseq/rseq01.c   | 74 +++++++++++++++++++++++
>  4 files changed, 84 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/rseq/.gitignore
>  create mode 100644 testcases/kernel/syscalls/rseq/Makefile
>  create mode 100644 testcases/kernel/syscalls/rseq/rseq01.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ae37a1192..f46950b27 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1752,6 +1752,8 @@ copy_file_range01 copy_file_range01
>  copy_file_range02 copy_file_range02
>  copy_file_range03 copy_file_range03
>  
> +rseq01 rseq01
> +
>  statx01 statx01
>  statx02 statx02
>  statx03 statx03
> diff --git a/testcases/kernel/syscalls/rseq/.gitignore b/testcases/kernel/syscalls/rseq/.gitignore
> new file mode 100644
> index 000000000..8a6c7ee36
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rseq/.gitignore
> @@ -0,0 +1 @@
> +/rseq01
> diff --git a/testcases/kernel/syscalls/rseq/Makefile b/testcases/kernel/syscalls/rseq/Makefile
> new file mode 100644
> index 000000000..159d5651c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rseq/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#  Copyright (C) 2012 Linux Test Project, Inc.
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/rseq/rseq01.c b/testcases/kernel/syscalls/rseq/rseq01.c
> new file mode 100644
> index 000000000..ac096471e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rseq/rseq01.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021-2023 Free Software Foundation, Inc.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with the GNU C Library; if not, see
> + * <https://www.gnu.org/licenses/>.

This part that says anything about GNU C Library shouldn't be there, the
copyright itself should be enough to keep the reference where the code
came from.

> + * Restartable Sequences single-threaded tests.
> + * These tests validate that rseq is registered from main in an executable
> + * not linked against libpthread.
> + */

This should be changed into docparse readable description.

> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include "tst_test.h"
> +#include <stdbool.h>
> +
> +#if (__GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 35))
> +# include <sys/rseq.h>
> +#endif
> +
> +#ifdef RSEQ_SIG
> +# include <stdlib.h>
> +# include <string.h>
> +# include <syscall.h>
> +# include <sched.h>
> +
> +static int sys_rseq(struct rseq *rseq_abi, uint32_t rseq_len, int flags, uint32_t sig)
> +{
> +	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
> +}

Can we please add a configure cehck and a fallback header into a lapi/ ?

LTP runs on different libc implmentations and such ifdefs shouldn't be
used at all.

> +static void check_rseq_available(void)
> +{
> +	int rc;
> +
> +	rc = sys_rseq(NULL, 0, 0, 0);
> +	if (rc != -1)
> +		tst_brk(TFAIL | TTERRNO, "Unexpected rseq return value %d ", rc);
> +	switch (errno) {
> +	case ENOSYS:
> +		tst_res(TCONF,
> +				"kernel does not support rseq, skipping test");
> +	case EINVAL:
> +		/* rseq is implemented, but detected an invalid rseq_len parameter.  */
> +		break;
> +	default:
> +		tst_brk(TFAIL | TTERRNO, "Unexpected rseq error ");
> +	}
> +}
> +
> +static void run(void)
> +{
> +	check_rseq_available();
> +
> +	TST_EXP_PASS(!(sched_getcpu() >= 0));
> +}
> +#else /* RSEQ_SIG */
> +
> +static void run(void)
> +{
> +	tst_res(TCONF,
> +		"glibc does not define RSEQ_SIG, skipping test");
> +}
> +
> +#endif /* RSEQ_SIG */
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
