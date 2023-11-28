Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7726CC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 06:19:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5748C3CC998
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 07:19:57 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF1DA3CB7FF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:19:46 +0100 (CET)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ED3DE600C0C
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:19:45 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="141422000"
X-IronPort-AV: E=Sophos;i="6.04,233,1695654000"; d="scan'208";a="141422000"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 15:19:43 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id E03C8D4F51
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:19:40 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D41DD5EA2
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:19:40 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id ACE1F20077831
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:19:39 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 31F861A0070;
 Tue, 28 Nov 2023 14:19:39 +0800 (CST)
Message-ID: <33f133ac-09c9-755b-8ba9-d09f7ea0a611@fujitsu.com>
Date: Tue, 28 Nov 2023 14:19:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <1696915709-6304-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.005
X-TMASE-Result: 10--16.617700-10.000000
X-TMASE-MatchedRID: NuHz/06ZeuaPvrMjLFD6eLxygpRxo4691QQ6Jx/ffla3CLdtdG1oCPy+
 IfkvA3MszjqJngvc26j8LO5wKi8YUqGGOyqBK41vEXjPIvKd74DzWEMQjooUzZjRBDyTGoDMuJE
 UmdYPGSV+CxzcGwLNWGHeuUrtbI8Sk0XqNqzb6vh85pjA/x1xfvNkoMDX+kiu9AkkXGDunirZ6K
 rkcB2NwT1j/s2B86TwHNr29AE+8ymKOc/QAD5CQTe9MF4SNA1+MoS2PLq1B74sTMNBTJAZWbK6G
 mKppGdqN/cuMNJ8Xfbr24MW+ahjh61UpJChTZPBpSXVpBS+ilaOVGny5q72hmFHVj+6F+rIgv4d
 jWvD77Cr+3xFCwdwVEFs75cy28Tl1Yo2Yq2e9TWGp0fwr2DvF7qGBW9J0YqjFug0ityR62L7ng8
 OJEDIuv3eQDUiYD5gHRfAWehAV7BNfs8n85Te8oMbH85DUZXyudR/NJw2JHcNYpvo9xW+mI6HM5
 rqDwqtvn233bGlnlufTifzHLDRQFV0duGZ1SzKz/29iOal2Se69bRj93zzAg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] syscalls/fchownat01: Convert to new API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang

Please rebase the patch set. Thanks.

Best Regards,
Xiao Yang

On 2023/10/10 13:28, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   .../kernel/syscalls/fchownat/fchownat01.c     | 155 ++++++------------
>   1 file changed, 54 insertions(+), 101 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
> index 3b29f1e75..7bed555e7 100644
> --- a/testcases/kernel/syscalls/fchownat/fchownat01.c
> +++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
> @@ -1,134 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
> - *   Copyright (c) International Business Machines  Corp., 2006
> - *   AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
> + * Copyright (c) International Business Machines  Corp., 2006
> + * Copyright (c) Linux Test Project, 2003-2023
> + * Author: Yi Yang <yyangcdl@cn.ibm.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * Check the basic functionality of the faccessat() system call.
>    *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> + * - fchownat() passes if dir_fd is file descriptor to the directory
> + *   where the file is located and pathname is relative path of the file.
>    *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software Foundation,
> - *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -/*
> - * DESCRIPTION
> - *	This test case will verify basic function of fchownat
> - *	added by kernel 2.6.16 or up.
> + * - fchownat() passes if pathname is absolute, then dirfd is ignored.
> + *
> + * - fchownat() passes if pathname is relative and dirfd is the special
> + *   value AT_FDCWD.
> + *
> + * - fchownat() passes if pathname is an empty string, operate on the file
> + *   referred to by dirfd.
>    */
>   
>   #define _GNU_SOURCE
>   
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <unistd.h>
>   #include <stdlib.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <signal.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "fchownat.h"
> -#include "lapi/fcntl.h"
> +#include "tst_test.h"
>   
>   #define TESTFILE	"testfile"
>   
> -static void setup(void);
> -static void cleanup(void);
> -
>   static int dir_fd;
> -static int fd;
> -static int no_fd = -1;
>   static int cu_fd = AT_FDCWD;
> +static char *testfile;
> +static char *abspath;
> +static char *empty = "";
>   
> -static struct test_case_t {
> -	int exp_ret;
> -	int exp_errno;
> -	int flag;
> +static struct tcase {
>   	int *fds;
> -	char *filenames;
> -} test_cases[] = {
> -	{0, 0, 0, &dir_fd, TESTFILE},
> -	{-1, ENOTDIR, 0, &fd, TESTFILE},
> -	{-1, EBADF, 0, &no_fd, TESTFILE},
> -	{-1, EINVAL, 9999, &dir_fd, TESTFILE},
> -	{0, 0, 0, &cu_fd, TESTFILE},
> +	char **filenames;
> +	int flag;
> +} tcases[] = {
> +	{&dir_fd, &testfile, 0},
> +	{&dir_fd, &abspath, 0},
> +	{&cu_fd, &testfile, 0},
> +	{&cu_fd, &empty, AT_EMPTY_PATH}
>   };
>   
> -char *TCID = "fchownat01";
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static void fchownat_verify(const struct test_case_t *);
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		for (i = 0; i < TST_TOTAL; i++)
> -			fchownat_verify(&test_cases[i]);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> -
>   static void setup(void)
>   {
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
>   
> -	tst_tmpdir();
> +	SAFE_TOUCH(TESTFILE, 0600, NULL);
>   
> -	dir_fd = SAFE_OPEN(cleanup, "./", O_DIRECTORY);
> +	char *tmpdir = tst_get_tmpdir();
>   
> -	SAFE_TOUCH(cleanup, TESTFILE, 0600, NULL);
> -
> -	fd = SAFE_OPEN(cleanup, "testfile2", O_CREAT | O_RDWR, 0600);
> +	abspath = tst_aprintf("%s/" TESTFILE, tmpdir);
> +	free(tmpdir);
>   }
>   
> -static void fchownat_verify(const struct test_case_t *test)
> +static void fchownat_verify(unsigned int i)
>   {
> -	TEST(fchownat(*(test->fds), test->filenames, geteuid(),
> -		      getegid(), test->flag));
> -
> -	if (TEST_RETURN != test->exp_ret) {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() returned %ld, expected %d, errno=%d",
> -			 TEST_RETURN, test->exp_ret, test->exp_errno);
> -		return;
> -	}
> +	struct tcase *tc = &tcases[i];
>   
> -	if (TEST_ERRNO == test->exp_errno) {
> -		tst_resm(TPASS | TTERRNO,
> -			 "fchownat() returned the expected errno %d: %s",
> -			 test->exp_ret, strerror(test->exp_errno));
> -	} else {
> -		tst_resm(TFAIL | TTERRNO,
> -			 "fchownat() failed unexpectedly; expected: %d - %s",
> -			 test->exp_errno, strerror(test->exp_errno));
> -	}
> +	TST_EXP_PASS(fchownat(*tc->fds, *tc->filenames, geteuid(), getegid(),
> +		     tc->flag), "fchownat(%d, %s, %d, %d, %d)",
> +		     *tc->fds, *tc->filenames, geteuid(), getegid(), tc->flag);
>   }
>   
>   static void cleanup(void)
>   {
> -	if (fd > 0)
> -		close(fd);
> -
> -	if (dir_fd > 0)
> +	if (dir_fd > -1)
>   		close(dir_fd);
> -
> -	tst_rmdir();
>   }
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = fchownat_verify,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.bufs = (struct tst_buffers []) {
> +		{&testfile, .str = TESTFILE},
> +		{&empty, .str = ""},
> +		{},
> +	},
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
