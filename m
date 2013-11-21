Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VjQBN-0002hH-IL
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 09:04:17 +0000
Date: Thu, 21 Nov 2013 10:03:50 +0100
From: chrubis@suse.cz
Message-ID: <20131121090350.GB1870@rei.nue.novell.com>
References: <528DC2A9.6060105@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <528DC2A9.6060105@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] dup3(2): add EINVAL error number test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/*
> + * Copyright (c) 2013 Fujitsu Ltd.
> + * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +/*
> + * Description:
> + * Verify that,
> + *  1. dup3() fails with -1 return value and sets errno to EINVAL
> + *     if flags contain an invalid value or oldfd was equal to newfd.
> + */
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/types.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "linux_syscall_numbers.h"
> +
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +#define INVALID_FLAG	-1
> +
> +static int old_fd;
> +static int new_fd;
> +
> +static struct test_case_t {
> +	int *oldfd;
> +	int *newfd;
> +	int flags;
> +	int exp_errno;
> +} test_cases[] = {
> +	{&old_fd, &old_fd, O_CLOEXEC, EINVAL},
> +	{&old_fd, &old_fd, 0, EINVAL},
> +	{&old_fd, &new_fd, INVALID_FLAG, EINVAL}
> +};
> +
> +char *TCID = "dup3_02";
> +int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static int exp_enos[] = {EINVAL, 0};
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int i;

Add the standard option parsing code here please.

> +
> +	setup();
> +
> +	TEST_EXP_ENOS(exp_enos);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +			TEST(ltp_syscall(__NR_dup3, *(test_cases[i].oldfd),
> +			     *(test_cases[i].newfd), test_cases[i].flags));
> +
> +			if (TEST_RETURN != -1) {
> +				tst_resm(TFAIL, "dup3 succeeded unexpectedly");
> +				continue;
> +			}
> +
> +			if (TEST_ERRNO == test_cases[i].exp_errno) {
> +				tst_resm(TPASS | TTERRNO,
> +					 "dup3 failed as expected");
> +			} else {
> +				tst_resm(TFAIL | TTERRNO,
> +					 "dup3 failed unexpectedly; expected:",
                                                                              ^
                                         This comma wronlgy passes three
					 arguments to a tst_resm() that
					 ends up with format string with
					 no conversions.

> +					 "%d - %s", test_cases[i].exp_errno,
> +					 strerror(test_cases[i].exp_errno));
> +			}
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	TEST_PAUSE;
> +
> +	old_fd = SAFE_CREAT(cleanup, "testeinval.file", 0644);
> +	new_fd = -1;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	SAFE_CLOSE(cleanup, old_fd);
> +
> +	tst_rmdir();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
