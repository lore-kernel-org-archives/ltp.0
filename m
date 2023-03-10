Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC7EC64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 12:33:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 543FA3CB7BF
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 13:33:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AFFC3CA7B1
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:33:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E44D600F4F
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 13:33:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87CFD22AB4;
 Fri, 10 Mar 2023 12:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678451603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pE3wqtgmoyJfWVfYwNvaJ1ZOr34zPhgImg2VzStdB6E=;
 b=bLeNEis0yuGcnhSvI/rOBEcyzTyiUvFJ1htYiiuzjmsmZMknPYBEsRCUP0OB/7JgurvI8U
 SZmwNZOr0VnU9Ev+iNHjGw17uuffvywR40PB9QU4qnHVygNK/jn0iXH8uIaq9sfKrkQETk
 WnhPqLnMx7j/K0TEeGz3yH/PmWLc2bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678451603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pE3wqtgmoyJfWVfYwNvaJ1ZOr34zPhgImg2VzStdB6E=;
 b=ig43XBk4xvBEShDCeA3RIB1afvR74DmdI9IoKdL3V4nr+hVOQFxTKPfGLUrtetFmISn8jl
 HtibL7hSInG/gPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73F6A13592;
 Fri, 10 Mar 2023 12:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wW5sG5MjC2ScIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Mar 2023 12:33:23 +0000
Date: Fri, 10 Mar 2023 13:34:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZAsj5ZuaiAQE+Nxq@yuki>
References: <20230309141116.25564-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230309141116.25564-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite eventfd01 using new LTP API
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
> Now we have 5 more tests.

Generally looks good, a few comments below.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                              |   5 +
>  testcases/kernel/syscalls/eventfd/.gitignore  |   5 +
>  testcases/kernel/syscalls/eventfd/eventfd01.c | 743 +-----------------
>  testcases/kernel/syscalls/eventfd/eventfd02.c |  42 +
>  testcases/kernel/syscalls/eventfd/eventfd03.c |  49 ++
>  testcases/kernel/syscalls/eventfd/eventfd04.c |  52 ++
>  testcases/kernel/syscalls/eventfd/eventfd05.c |  39 +
>  testcases/kernel/syscalls/eventfd/eventfd06.c | 166 ++++
>  8 files changed, 379 insertions(+), 722 deletions(-)
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
> index 9b60434a2..5cdf6155b 100644
> --- a/testcases/kernel/syscalls/eventfd/eventfd01.c
> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> @@ -1,738 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
> - *   Copyright (c) Linux Test Project, 2008-2022
> - *
> - *   Based on testcases/kernel/syscalls/waitpid/waitpid01.c
> - *   Original copyright message:
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
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
> - */
> -
> -/*
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
> - *
> - * History
> - *	07/2008 Vijay Kumar
> - *		Initial Version.
> - *
> - * Restrictions
> - *	None
> - */
> -
> -#include "config.h"
> -
> -#include <sys/types.h>
> -#include <sys/select.h>
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <inttypes.h>
> -#include <poll.h>
> -#include <signal.h>
> -#include <stdint.h>
> -#include <string.h>
> -#include <unistd.h>
> -
> -#include "test.h"
> -#define CLEANUP cleanup
> -#include "lapi/syscalls.h"
> -
> -TCID_DEFINE(eventfd01);
> -int TST_TOTAL = 15;
> -
> -#ifdef HAVE_LIBAIO
> -#include <libaio.h>
> -
> -static void setup(void);
> -
> -static int myeventfd(unsigned int initval, int flags)
> -{
> -	/* eventfd2 uses FLAGS but eventfd doesn't take FLAGS. */
> -	return tst_syscall(__NR_eventfd, initval);
> -}
> -
> -/*
> - * clear_counter() - clears the counter by performing a dummy read
> - * @fd: the eventfd
> - *
> - * RETURNS:
> - * 0 on success, and -1 on failure
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
> -static int clear_counter(int fd)
> -{
> -	uint64_t dummy;
> -	int ret;
> -
> -	ret = read(fd, &dummy, sizeof(dummy));
> -	if (ret == -1) {
> -		if (errno != EAGAIN) {
> -			tst_resm(TINFO | TERRNO, "error clearing counter");
> -			return -1;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * set_counter() - sets the count to specified value
> - * @fd: the eventfd
> - * @val: the value to be set
> - *
> - * Clears the counter and sets the counter to @val.
> +/*\
> + * [Description]
>   *
> - * RETURNS:
> - * 0 on success, -1 on failure
> - */
> -static int set_counter(int fd, uint64_t val)
> -{
> -	int ret;
> -
> -	ret = clear_counter(fd);
> -	if (ret == -1)
> -		return -1;
> -
> -	ret = write(fd, &val, sizeof(val));
> -	if (ret == -1) {
> -		tst_resm(TINFO | TERRNO, "error setting counter value");
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * Test whether the current value of the counter matches @required.
> + * Verify read operation for eventfd file descriptor. The test will check for
> + * counter read at startup and errors.
>   */

This does sound too generic to me. I would tend to describe what
exeactly the test does.

/*
 * [Description]
 *
 * Verify read operation for eventfd fail with:
 *
 * - EAGAIN when counter is zero on non blocking fd
 * - EINVAL when buffer size is less than 8 bytes
 */

> -static void read_test(int fd, uint64_t required)
> -{
> -	int ret;
> -	uint64_t val;
>  
> -	ret = read(fd, &val, sizeof(val));
> -	if (ret == -1) {
> -		tst_resm(TBROK | TERRNO, "error reading eventfd");
> -		return;
> -	}
> +#include <stdlib.h>
> +#include <sys/eventfd.h>
> +#include "tst_test.h"
>  
> -	if (val == required)
> -		tst_resm(TPASS, "counter value matches required");
> -	else
> -		tst_resm(TFAIL, "counter value mismatch: "
> -			 "required: %" PRIu64 ", got: %" PRIu64, required, val);
> -}
> +#define EVENT_COUNT 10
>  
> -/*
> - * Test whether read returns with error EAGAIN when counter is at 0.
> - */
> -static void read_eagain_test(int fd)
> +static void run(void)
>  {
> -	int ret;
> -	uint64_t val;
> -
> -	ret = clear_counter(fd);
> -	if (ret == -1) {
> -		tst_resm(TBROK, "error clearing counter");
> -		return;
> -	}
> -
> -	ret = read(fd, &val, sizeof(val));
> -	if (ret == -1) {
> -		if (errno == EAGAIN)
> -			tst_resm(TPASS, "read failed with EAGAIN as expected");
> -		else
> -			tst_resm(TFAIL | TERRNO, "read failed (wanted EAGAIN)");
> -	} else
> -		tst_resm(TFAIL, "read returned with %d", ret);
> -}
> -
> -/*
> - * Test whether writing to counter works.
> - */
> -static void write_test(int fd)
> -{
> -	int ret;
> -	uint64_t val;
> -
> -	val = 12;
> -
> -	ret = set_counter(fd, val);
> -	if (ret == -1) {
> -		tst_resm(TBROK, "error setting counter value to %" PRIu64, val);
> -		return;
> -	}
> -
> -	read_test(fd, val);
> -}
> -
> -/*
> - * Test whether write returns with error EAGAIN when counter is at
> - * (UINT64_MAX - 1).
> - */
> -static void write_eagain_test(int fd)
> -{
> -	int ret;
> +	int fd;
>  	uint64_t val;
> -
> -	ret = set_counter(fd, UINT64_MAX - 1);
> -	if (ret == -1) {
> -		tst_resm(TBROK, "error setting counter value to UINT64_MAX-1");
> -		return;
> -	}
> -
> -	val = 1;
> -	ret = write(fd, &val, sizeof(val));
> -	if (ret == -1) {
> -		if (errno == EAGAIN)
> -			tst_resm(TPASS, "write failed with EAGAIN as expected");
> -		else
> -			tst_resm(TFAIL, "write failed (wanted EAGAIN)");
> -	} else
> -		tst_resm(TFAIL, "write returned with %d", ret);
> -}
> -
> -/*
> - * Test whether read returns with error EINVAL, if buffer size is less
> - * than 8 bytes.
> - */
> -static void read_einval_test(int fd)
> -{
>  	uint32_t invalid;
> -	int ret;
>  
> -	ret = read(fd, &invalid, sizeof(invalid));
> -	if (ret == -1) {
> -		if (errno == EINVAL)
> -			tst_resm(TPASS, "read failed with EINVAL as expected");
> -		else
> -			tst_resm(TFAIL | TERRNO, "read failed (wanted EINVAL)");
> -	} else
> -		tst_resm(TFAIL, "read returned with %d", ret);
> -}
> +	fd = eventfd(EVENT_COUNT, EFD_NONBLOCK);

This will actually break on kernels without the CONFIG_EVENTFD,
previously the tst_syscall() would catch ENOSYS and break the test with
TCONF.

I suppose that we either add .needs_kconfig for CONFIG_EVENTFD for all
the tests, or we have to handle -1 and ENOSYS in each of them.

Also you should really check the fd you got here, ideally with
TST_EXP_FD().


And the same applies to the rest of the tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
