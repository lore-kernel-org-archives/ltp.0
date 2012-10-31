Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TTVCr-0005KL-1Y
	for ltp-list@lists.sourceforge.net; Wed, 31 Oct 2012 10:07:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TTVCk-0003oq-IU
	for ltp-list@lists.sourceforge.net; Wed, 31 Oct 2012 10:07:29 +0000
Message-ID: <5090F86E.1050102@cn.fujitsu.com>
Date: Wed, 31 Oct 2012 18:07:42 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <17bab533f4f5e5c80a676158bfd75cfb1b361228.1351608161.git.jstancek@redhat.com>
In-Reply-To: <17bab533f4f5e5c80a676158bfd75cfb1b361228.1351608161.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] mremap: add new test mremap05
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 10/30/2012 10:47 PM, Jan Stancek wrote:
> New mremap syscall testcase targeting flag MREMAP_FIXED.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/syscalls                            |    1 +
>  testcases/kernel/syscalls/.gitignore        |    1 +
>  testcases/kernel/syscalls/mremap/mremap05.c |  202 +++++++++++++++++++++++++++
>  3 files changed, 204 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/mremap/mremap05.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6973aaa..8f7b5e4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -603,6 +603,7 @@ mremap01 mremap01
>  mremap02 mremap02
>  mremap03 mremap03
>  mremap04 mremap04
> +mremap05 mremap05
>  
>  msgctl01 msgctl01
>  msgctl02 msgctl02
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 7df28c2..2fe7be4 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -541,6 +541,7 @@
>  /mremap/mremap02
>  /mremap/mremap03
>  /mremap/mremap04
> +/mremap/mremap05
>  /msync/msync01
>  /msync/msync02
>  /msync/msync03
> diff --git a/testcases/kernel/syscalls/mremap/mremap05.c b/testcases/kernel/syscalls/mremap/mremap05.c
> new file mode 100644
> index 0000000..b8e1354
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mremap/mremap05.c
> @@ -0,0 +1,202 @@
> +/*
> + * Copyright (C) 2012 Linux Test Project, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +/*
> + * Test Name: mremap05
> + *
> + * Test Description:
> + *  Verify that MREMAP_FIXED fails without MREMAP_MAYMOVE.
> + *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE fails if target address
> + *    is not page aligned.
> + *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE fails if old range
> + *    overlaps with new range.
> + *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE can move mapping to new address.
> + *  Verify that MREMAP_FIXED|MREMAP_MAYMOVE unmaps previous mapping
> + *    at the address range specified by new_address and new_size.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include "test.h"
> +#include "usctest.h"
> +
> +static int pagesize;
> +char *TCID = "mremap05";
> +int TST_TOTAL = 1;
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +static void free_test_area(void *p, int size)
> +{
> +	if (munmap(p, size) < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "get_test_area munmap");

This seems a copy/paste typo?

The reset looks OK.

Thanks,
Wanlong Gao

> +}
> +
> +static void *get_test_area(int size, int free_area)
> +{
> +	void *p;
> +	p = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> +		0, 0);
> +	if (p == MAP_FAILED)
> +		tst_brkm(TBROK|TERRNO, cleanup, "get_test_area mmap");
> +	if (free_area)
> +		free_test_area(p, size);
> +	return p;
> +}
> +
> +static void *test_mremap(void *old_address, size_t old_size, size_t new_size,
> +	int flags, void *new_address, const char *msg, void *exp_ret,
> +	int exp_errno)
> +{
> +	void *ret;
> +
> +	ret = mremap(old_address, old_size, new_size, flags, new_address);
> +	if (ret == exp_ret)
> +		if (ret != MAP_FAILED)
> +			tst_resm(TPASS, "%s", msg);
> +		else
> +			if (errno == exp_errno)
> +				tst_resm(TPASS, "%s", msg);
> +			else
> +				tst_resm(TFAIL|TERRNO, "%s", msg);
> +	else
> +		tst_resm(TFAIL, "%s ret: %p, expected: %p", msg,
> +			ret, exp_ret);
> +	return ret;
> +}
> +
> +static void test_fixed_require_maymove(void)
> +{
> +	char *ret, *p1, *p2;
> +
> +	p1 = get_test_area(pagesize, 0);
> +	p2 = get_test_area(pagesize, 1);
> +	ret = test_mremap(p1, pagesize, pagesize, MREMAP_FIXED, p2,
> +		"MREMAP_FIXED requires MREMAP_MAYMOVE", MAP_FAILED, EINVAL);
> +	if (ret == MAP_FAILED)
> +		free_test_area(p1, pagesize);
> +	else
> +		free_test_area(ret, pagesize);
> +}
> +
> +static void test_new_addr_not_aligned(void)
> +{
> +	char *ret, *p1, *p2;
> +
> +	p1 = get_test_area(pagesize, 0);
> +	p2 = get_test_area(pagesize*2, 1) + 1;
> +	ret = test_mremap(p1, pagesize, pagesize, MREMAP_FIXED|MREMAP_MAYMOVE,
> +		p2, "new_addr has to be page aligned", MAP_FAILED, EINVAL);
> +	if (ret == MAP_FAILED)
> +		free_test_area(p1, pagesize);
> +	else
> +		free_test_area(ret, pagesize);
> +}
> +
> +static void test_old_new_area_overlap(void)
> +{
> +	char *ret, *p1, *p2;
> +
> +	p1 = get_test_area(pagesize*2, 0);
> +	p2 = p1 + pagesize;
> +	ret = test_mremap(p1, pagesize*2, pagesize, MREMAP_FIXED|MREMAP_MAYMOVE,
> +		p2, "old/new area must not overlap", MAP_FAILED, EINVAL);
> +	if (ret == MAP_FAILED)
> +		free_test_area(p1, pagesize*2);
> +	else
> +		free_test_area(ret, pagesize);
> +}
> +
> +static void test_mremap_fixed_maymove(void)
> +{
> +	char *ret, *p1, *p2;
> +
> +	/* mremap to free area */
> +	p1 = get_test_area(pagesize, 0);
> +	p2 = get_test_area(pagesize, 1);
> +	*p1 = 0x1;
> +	ret = test_mremap(p1, pagesize, pagesize, MREMAP_FIXED|MREMAP_MAYMOVE,
> +		p2, "mremap #1", p2, 0);
> +	if (ret == MAP_FAILED) {
> +		free_test_area(p1, pagesize);
> +	} else {
> +		if (*ret == 0x1)
> +			tst_resm(TPASS, "mremap #1 value OK");
> +		else
> +			tst_resm(TFAIL, "mremap #1 value different");
> +		free_test_area(ret, pagesize);
> +	}
> +
> +	/* mremap to occupied area */
> +	p1 = get_test_area(pagesize, 0);
> +	p2 = get_test_area(pagesize, 0);
> +	*p1 = 0x1;
> +	*p2 = 0x2;
> +	ret = test_mremap(p1, pagesize, pagesize, MREMAP_FIXED|MREMAP_MAYMOVE,
> +		p2, "mremap #2", p2, 0);
> +	if (ret == MAP_FAILED) {
> +		free_test_area(p1, pagesize);
> +		free_test_area(p2, pagesize);
> +	} else {
> +		if (*ret == 0x1)
> +			tst_resm(TPASS, "mremap #2 value OK");
> +		else
> +			tst_resm(TFAIL, "mremap #2 value different");
> +		free_test_area(ret, pagesize);
> +	}
> +}
> +
> +int main(int ac, char **av)
> +{
> +	char *msg;
> +	int lc;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	Tst_count = 0;
> +	setup();
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		test_fixed_require_maymove();
> +		test_new_addr_not_aligned();
> +		test_old_new_area_overlap();
> +		test_mremap_fixed_maymove();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	pagesize = getpagesize();
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +}
> 


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
