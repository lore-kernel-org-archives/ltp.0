Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC631C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:40:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CC213CAFEB
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:39:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D43523CA2B3
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:39:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5BAD600750
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:39:47 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A418633A5B;
 Mon, 17 Oct 2022 10:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666003186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foPSg1U9AWv8QAJOI1Dn1Y353yxgpXXRb6G9blU9ETU=;
 b=Ary5MzH8457sxITpa7CREZ93Ei2nDHapYbjWvFjuZXZIA2gkZVC0WccfhbmnGxhqTTKCZM
 W0kJyEC7SO1hxBEgXitmLdIo9SE9uLOLYV83qEpcPv6lXxws1d6/spo8Z9yLRnaMaH6oIf
 84vL4Zk8FEq7g6CTmjqF3qa8wizYC8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666003186;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foPSg1U9AWv8QAJOI1Dn1Y353yxgpXXRb6G9blU9ETU=;
 b=8Ey6fvE9G9mQd+1JyjMa2QXw9nDvMa5o/qC2Qz/NGhFQ4pwnbnO8kYsKvfT0+H43uh6ZrK
 vDGu4m8Hoxc4FRAQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 31FCA2C141;
 Mon, 17 Oct 2022 10:39:46 +0000 (UTC)
References: <YipkOjYIeY4NbQuh@pevik>
 <20220902081711.1776943-1-jencce.kernel@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Murphy Zhou <jencce.kernel@gmail.com>
Date: Mon, 17 Oct 2022 10:40:38 +0100
In-reply-to: <20220902081711.1776943-1-jencce.kernel@gmail.com>
Message-ID: <87pmeqohsh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] kernel/fs/fsnotify-stress: fsnotify stress test
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

Murphy Zhou <jencce.kernel@gmail.com> writes:

> This is a stress test that exercises fanotify and inotify interfaces
> while IO going on. It intentionally ignores failures or return values
> of some syscalls to let the stress go on. If the kernel does not panic
> or hang after a certain period of time of testing, test pass.
>
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
> v3 -> v4:
> 	Convert comment to docparse part.
>
>  runtest/fs                                    |   2 +
>  testcases/kernel/fs/fsnotify-stress/Makefile  |   9 +
>  .../fs/fsnotify-stress/fsnotify-stress.c      | 476 ++++++++++++++++++
>  3 files changed, 487 insertions(+)
>  create mode 100644 testcases/kernel/fs/fsnotify-stress/Makefile
>  create mode 100644 testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
>
> diff --git a/runtest/fs b/runtest/fs
> index 1d753e0dd..beb43aae4 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -87,3 +87,5 @@ binfmt_misc01 binfmt_misc01.sh
>  binfmt_misc02 binfmt_misc02.sh
>  
>  squashfs01 squashfs01
> +
> +fsnotify-stress fsnotify-stress
> diff --git a/testcases/kernel/fs/fsnotify-stress/Makefile b/testcases/kernel/fs/fsnotify-stress/Makefile
> new file mode 100644
> index 000000000..451f791f1
> --- /dev/null
> +++ b/testcases/kernel/fs/fsnotify-stress/Makefile
> @@ -0,0 +1,9 @@
> +#
> +#    kernel/fs/fs-notify testcases Makefile.
> +#
> +
> +top_srcdir	?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
> new file mode 100644
> index 000000000..8130f7f12
> --- /dev/null
> +++ b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
> @@ -0,0 +1,476 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> + * Author: Murphy Zhou <jencce.kernel@gmail.com>
> + * Copyright (c) Linux Test Project, 2001-2022
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This is an irregular stress test for Linux kernel fanotify/inotify
> + * interfaces. It calls thoese interfaces with possible best coverage
> + * arguments, in a loop. It ignores some return values in the loop to
> + * let the stress going on. At the same time, it initiates IO traffics
> + * by calling IO syscalls.
> + *
> + * If kernel does no panic or hang after the test, test pass.
> + *
> + * It detected a leak in fsnotify code which was fixed by Amir through
> + * this Linux commit:
> + *     4396a731 fsnotify: fix sb_connectors leak

The problem with stress tests is that they are expensive to run. If they
do fail then it's often difficult to reproduce the errors. Eventually
they just get added to a skip list.

Why not make a reproducer for this bug which executes in the minimum
time necessary?

As well as saving CPU time and avoiding random timeouts this helps
create a better understanding of what really matters in the test.

> + *
> + */
> +
> +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <sys/fanotify.h>
> +#include <sys/inotify.h>
> +#include <sys/time.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +#include "tst_test.h"
> +#include "../../syscalls/fanotify/fanotify.h"
> +#include "../../syscalls/inotify/inotify.h"
> +
> +static int fd0;
> +
> +#define TESTDIR "testdir"
> +#define TESTFILE "testdir/file"
> +
> +static void cleanup(void)
> +{
> +	if (fd0 > 0) {
> +		SAFE_CLOSE(fd0);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR(TESTDIR, 0777);
> +	fd0 = SAFE_OPEN(TESTFILE, O_CREAT|O_RDWR, 0666);
> +}
> +
> +static void fanotify_flushes(char *fn)
> +{
> +	int fd;
> +
> +	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +					   O_RDONLY | O_LARGEFILE);
> +
> +	while (tst_remaining_runtime() > 10) {
> +		/* As a stress test, we ignore the return values here to
> +		 * proceed with the stress.
> +		 */

The LTP style guide forbids inline comments unless they are explaining
something that would be very difficult to understand without them. There
are lots of comments like this in the test.

> +		fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +			  FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> +			  FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> +			  FAN_EVENT_ON_CHILD, -1, fn);
> +

...

> +static void readfiles(char *fn)
> +{
> +	int fd;
> +	char buf[BUFSIZ];
> +
> +	memset(buf, 1, BUFSIZ);
> +	while (tst_remaining_runtime() > 10) {
> +		fd = open(fn, O_RDONLY);

If this fails then what are we stressing? We could just be testing
spinning in a loop.

> +		if (fd == -1)
> +			continue;
> +		read(fd, buf, BUFSIZ);

Also ignoring the result of read results in compiler warnings.

> +
> +static struct tst_test test = {
> +	.tcnt = 1,
> +	.max_runtime = 60,

Does it need 60 seconds to reproduce the bug?
Why does it need this long to achieve the desired coverage?

Without further evidence I'd assume that full coverage (ignoring setup)
is approached after <1 second on a reasonable system.

Also we should limit the number of iterations.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
