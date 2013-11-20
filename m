Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VjAdP-0005ai-CX
	for ltp-list@lists.sourceforge.net; Wed, 20 Nov 2013 16:28:11 +0000
Date: Wed, 20 Nov 2013 17:27:45 +0100
From: chrubis@suse.cz
Message-ID: <20131120162745.GB4527@rei.nue.novell.com>
References: <5285DA68.5020409@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5285DA68.5020409@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] dup3(2): add EINVAL error number test
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
> add EINVAL error number test
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/syscalls                         |   1 +
>  testcases/kernel/syscalls/.gitignore     |   1 +
>  testcases/kernel/syscalls/dup3/dup3_02.c | 119 +++++++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/dup3/dup3_02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index fa01ff7..e7e8a9a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -118,6 +118,7 @@ dup204 dup204
>  dup205 dup205
>  
>  dup3_01 dup3_01
> +dup3_02 dup3_02
>  
>  epoll_create1_01 epoll_create1_01
>  epoll01 epoll-ltp
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 0130a53..e100dd9 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -96,6 +96,7 @@
>  /dup2/dup204
>  /dup2/dup205
>  /dup3/dup3_01
> +/dup3/dup3_02
>  /epoll/epoll-ltp
>  /epoll_create1/epoll_create1_01
>  /eventfd/eventfd01
> diff --git a/testcases/kernel/syscalls/dup3/dup3_02.c b/testcases/kernel/syscalls/dup3/dup3_02.c
> new file mode 100644
> index 0000000..0394ee7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/dup3/dup3_02.c
> @@ -0,0 +1,119 @@
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
> +static struct test_case_t {
> +	int oldfd;
> +	int newfd;
> +	int flags;
> +	int exp_errno;
> +} test_cases[] = {
> +	{-1, -1, O_CLOEXEC, EINVAL},
> +	{-1, -1, INVALID_FLAG, EINVAL}
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
> +
> +
> +	setup();
> +
> +	TEST_EXP_ENOS(exp_enos);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		for (i = 0; i < TST_TOTAL; i++) {
> +			TEST(ltp_syscall(__NR_dup3, test_cases[i].oldfd,
> +			     test_cases[i].newfd, test_cases[i].flags));
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
> +	int oldfd;
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	TEST_PAUSE;
> +
> +	oldfd = SAFE_CREAT(cleanup, "testeinval.file", 0644);
> +
> +	test_cases[0].oldfd = oldfd;
> +	test_cases[0].newfd = oldfd;
> +
> +	test_cases[1].oldfd = oldfd;

This part is not vell designed. The thing is that code should follow
principle of least surprise and if I read the code from the top to the
bottom I was in an impression that the file descriptors are set to -1
all the times.

One solution is to use a pointer to a variable that is actually
initialized in the setup, such as:

static int test_fd;

struct test {
...
} testcases[] = {
	{&test_fd, &test_fd, ...},
	{&test_fd, -1, ...},
};

...

> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
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
