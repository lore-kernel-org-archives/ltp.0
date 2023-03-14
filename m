Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A776AC05027
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 16:55:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0874E3CD511
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 17:55:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A6D03CAD28
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 17:55:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A01E600132
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 17:55:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93F8B1F8A3;
 Tue, 14 Mar 2023 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678812913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNjD/BOLfPf+qOMJTp0ZV61wskSdf767MnMmXZCmwss=;
 b=XHlydEB6swlBrBKC7+c88r6qQSa6EsyVd61w7yUixsxCSw+Uv7vRAR8SuZvdwXzXquxrsB
 cgpaRlH1HzP9ROW6kXf49L3yNsUprpPnKsjLhANfRWhDS7b5zjzKXDE0tx89E1wbyJgUls
 z5sMJ2kLdzboxccPVZGlddH4U++S4Sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678812913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GNjD/BOLfPf+qOMJTp0ZV61wskSdf767MnMmXZCmwss=;
 b=mjGXMO3KGLhYMsdfUZUvRuS2N0kwxryMWpreha5dqX4dianQWTdxfXHtmBcjUTPdM8ojRo
 iyicRWujlN8pKJDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 794BB13A26;
 Tue, 14 Mar 2023 16:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5fiZG/GmEGS4cwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Mar 2023 16:55:13 +0000
Date: Tue, 14 Mar 2023 17:56:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZBCnQeVxNOPDCc+1@yuki>
References: <20230314130027.24108-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314130027.24108-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite eventfd01 using new LTP API
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
> Splitted eventfd01 test into multiple test files using new LTP API.
  ^
  Split

> Now we have 5 more tests.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Use TST_EXP_FD for fd check
> Check CONFIG_EVENTFD for each test
> Description adjustments
> 
>  runtest/syscalls                              |   5 +
>  testcases/kernel/syscalls/eventfd/.gitignore  |   5 +
>  testcases/kernel/syscalls/eventfd/eventfd01.c | 745 +-----------------
>  testcases/kernel/syscalls/eventfd/eventfd02.c |  50 ++
>  testcases/kernel/syscalls/eventfd/eventfd03.c |  54 ++
>  testcases/kernel/syscalls/eventfd/eventfd04.c |  57 ++
>  testcases/kernel/syscalls/eventfd/eventfd05.c |  44 ++
>  testcases/kernel/syscalls/eventfd/eventfd06.c | 171 ++++
>  8 files changed, 412 insertions(+), 719 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/eventfd/eventfd02.c
>  create mode 100644 testcases/kernel/syscalls/eventfd/eventfd03.c
>  create mode 100644 testcases/kernel/syscalls/eventfd/eventfd04.c
>  create mode 100644 testcases/kernel/syscalls/eventfd/eventfd05.c
>  create mode 100644 testcases/kernel/syscalls/eventfd/eventfd06.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9c76d7fe3..2179f8d5b 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -182,6 +182,11 @@ epoll_pwait04 epoll_pwait04
>  epoll_pwait05 epoll_pwait05
>  
>  eventfd01 eventfd01
> +eventfd02 eventfd02
> +eventfd03 eventfd03
> +eventfd04 eventfd04
> +eventfd05 eventfd05
> +eventfd06 eventfd06
>  
>  eventfd2_01 eventfd2_01
>  eventfd2_02 eventfd2_02
> diff --git a/testcases/kernel/syscalls/eventfd/.gitignore b/testcases/kernel/syscalls/eventfd/.gitignore
> index db45c67cf..4f577370c 100644
> --- a/testcases/kernel/syscalls/eventfd/.gitignore
> +++ b/testcases/kernel/syscalls/eventfd/.gitignore
> @@ -1 +1,6 @@
>  /eventfd01
> +/eventfd02
> +/eventfd03
> +/eventfd04
> +/eventfd05
> +/eventfd06
> diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
> index 9b60434a2..8f83378da 100644
> --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> @@ -1,738 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
> - *   Copyright (c) Linux Test Project, 2008-2022
> - *
> - *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
> - *   Original copyright message:
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001

I suppose that we should retain these copyrights as well, since the new
tests are mostly cleaned up code from the original test.

> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>  
>  /*
    ^
Should be /*\

> - * NAME
> - *	eventfd01.c
> - *
> - * DESCRIPTION
> - *      Test cases for eventfd syscall.
> - *
> - * USAGE:  <for command-line>
> - *      eventfd01 [-c n] [-i n] [-I x] [-P x] [-t]
> - *      where,  -c n : Run n copies concurrently.
> - *              -i n : Execute test n times.
> - *              -I x : Execute test for x seconds.
> - *              -P x : Pause for x seconds between iterations.
> + * [Description]
>   *
> - * History
> - *	07/2008 Vijay Kumar
> - *		Initial Version.
> - *
> - * Restrictions
> - *	None
> - */

...

> --- /dev/null
> +++ b/testcases/kernel/syscalls/eventfd/eventfd02.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +/*\
> + * [Description]
> + *
> + * Verify write operation for eventfd fail with:
> + *
> + * - EAGAIN when counter is zero on non blocking fd
> + * - EINVAL when buffer size is less than 8 bytes, or if an attempt is made to
> + *	write the value 0xffffffffffffffff
> + */
> +
> +#include <stdlib.h>
> +#include <sys/eventfd.h>
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	int fd;
> +	uint64_t val = 12;
> +	uint64_t buf;
> +	uint32_t invalid;
> +
> +	fd = eventfd(0, EFD_NONBLOCK);
> +	TST_EXP_FD(fd);

This produces rather cryptic message:

eventfd02.c:27: TPASS: fd returned fd 3

You are supposed to pass the syscall to the TST_EXP_FD() as:

	TST_EXP_FD(eventfd(0, EFD_NONBLOCK));
	fd = TST_RET;

I suppose that we can as well redesing subset of the TST_EXP_*() macros
so that they return a value with:

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 231c04951..091209558 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -86,13 +86,14 @@ extern void *TST_RET_PTR;
 #define TST_EXP_FD_SILENT(SCALL, ...)  TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__)

 #define TST_EXP_FD(SCALL, ...)                                                 \
-       do {                                                                   \
+       ({                                                                     \
                TST_EXP_POSITIVE_(SCALL, #SCALL, ##__VA_ARGS__);               \
                                                                               \
                if (TST_PASS)                                                  \
                        TST_MSGP_(TPASS, " returned fd %ld", TST_RET,          \
                                #SCALL, ##__VA_ARGS__);                        \
-       } while (0)
+               TST_RET;                                                       \
+       })


Then we can write more simple:

	fd = TST_EXP_FD(eventfd(0, EFD_NONBLOCK));


> +	SAFE_WRITE(0, fd, &val, sizeof(val));
> +	SAFE_READ(0, fd, &buf, sizeof(buf));
> +	TST_EXP_EQ_LI(buf, val);
> +
> +	val = UINT64_MAX - 1;
> +	SAFE_WRITE(0, fd, &val, sizeof(val));
> +	TST_EXP_FAIL(write(fd, &val, sizeof(val)), EAGAIN);
> +	TST_EXP_FAIL(write(fd, &invalid, sizeof(invalid)), EINVAL);
> +
> +	val = 0xffffffffffffffffLL;
> +	TST_EXP_FAIL(write(fd, &val, sizeof(val)), EINVAL);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_EVENTFD",
> +		NULL
> +	},
> +};

...

> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +/*\
> + * [Description]
> + *
> + * Test whether counter overflow is detected and handled correctly.
> + *
> + * It is not possible to directly overflow the counter using the
> + * write() syscall. Overflows occur when the counter is incremented
> + * from kernel space, in an irq context, when it is not possible to
> + * block the calling thread of execution.
> + *
> + * The AIO subsystem internally uses eventfd mechanism for
> + * notification of completion of read or write requests. In this test
> + * we trigger a counter overflow, by setting the counter value to the
> + * max possible value initially. When the AIO subsystem notifies
> + * through the eventfd counter, the counter overflows.
> + *
> + * NOTE: If the counter starts from an initial value of 0, it will
> + * take decades for an overflow to occur. But since we set the initial
> + * value to the max possible counter value, we are able to cause it to
> + * overflow with a single increment.
> + *
> + * When the counter overflows, the following are tested
> + *	1. Check whether POLLERR event occurs in poll() for the eventfd.
> + *	2. Check whether readfd_set/writefd_set is set in select() for the
> + *		eventfd.
> + *	3. The counter value is UINT64_MAX.
> + */

This does not render reasonably, the list does not render as a list at
all, and I would drop the NOTE: as well.

The list should look like:

* When the counter overflows, the following is tested:
*
* - POLLERR event occurs in poll() for the eventfd
* - readfd_set/writefd_set is set in select() for the eventfd
* - the counter value is UINT64_MAX
*/

> +	TEST(io_setup(MAXEVENTS, &ctx));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK, "io_setup() failed: %s", tst_strerrno(-TST_RET));
> +
> +	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 0644);
> +	evfd = eventfd(0, EFD_NONBLOCK);
> +	TST_EXP_FD(evfd);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_CLOSE(evfd);
> +	io_destroy(ctx);
> +}
> +
> +static void run(void)
> +{
> +	test_select();
> +	test_poll();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_EVENTFD",
> +		NULL
> +	},
> +};
> +
> +#else /* HAVE_IO_SET_EVENTFD */
> +TST_TEST_TCONF("eventfd support is not available in AIO subsystem");
> +#endif
> +#else /* HAVE_LIBAIO */
> +TST_TEST_TCONF("libaio is not available");
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
