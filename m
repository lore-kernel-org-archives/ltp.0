Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1TP949-00080m-Vy
	for ltp-list@lists.sourceforge.net; Fri, 19 Oct 2012 09:40:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TP947-0007N2-JV
	for ltp-list@lists.sourceforge.net; Fri, 19 Oct 2012 09:40:29 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9J9eL7q031741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 19 Oct 2012 05:40:21 -0400
Message-ID: <5081208A.7040104@redhat.com>
Date: Fri, 19 Oct 2012 17:42:34 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1350564702.git.jstancek@redhat.com>
	<5f67fbd40c7d3ba98f1bd3f73d915dfb28021342.1350564702.git.jstancek@redhat.com>
In-Reply-To: <5f67fbd40c7d3ba98f1bd3f73d915dfb28021342.1350564702.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/3] new syscall test: migrate_pages01
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

Hi Jan,

On 10/18/2012 08:56 PM, Jan Stancek wrote:
> errno tests for migrate_pages(2).
> Note, that older kernels (~2.6.18) are likely to panic during this test.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   runtest/syscalls                                   |    2 +
>   testcases/kernel/syscalls/migrate_pages/Makefile   |   32 +++
>   .../syscalls/migrate_pages/migrate_pages01.c       |  280 ++++++++++++++++++++
>   .../syscalls/migrate_pages/migrate_pages_common.c  |   62 +++++
>   .../syscalls/migrate_pages/migrate_pages_common.h  |   33 +++
>   5 files changed, 409 insertions(+), 0 deletions(-)
>   create mode 100644 testcases/kernel/syscalls/migrate_pages/Makefile
>   create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
>   create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
>   create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 6973aaa..9daf234 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -517,6 +517,8 @@ memset01 memset01
>   memcmp01 memcmp01
>   memcpy01 memcpy01
>   
> +migrate_pages01 migrate_pages01
> +
>   mlockall01 mlockall01
>   mlockall02 mlockall02
>   mlockall03 mlockall03
> diff --git a/testcases/kernel/syscalls/migrate_pages/Makefile b/testcases/kernel/syscalls/migrate_pages/Makefile
> new file mode 100644
> index 0000000..7168cd6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/migrate_pages/Makefile
> @@ -0,0 +1,32 @@
> +#
> +#  Copyright (C) 2012 Linux Test Project, Inc.
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%,$(wildcard $(abs_srcdir)/*[0-9].c))
> +$(MAKE_TARGETS): %: %.o migrate_pages_common.o
> +
> +ifeq ($(NUMA_LIBS),)
> +CPPFLAGS		+= -Wno-unused
> +endif
> +CPPFLAGS		+= -I$(abs_srcdir)/../utils/
> +
> +include $(top_srcdir)/testcases/kernel/include/lib.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> new file mode 100644
> index 0000000..53ced25
> --- /dev/null
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
> @@ -0,0 +1,280 @@
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
> +
> +/*
> + * errno tests for migrate_pages() syscall
> + */
> +#include <sys/types.h>
> +#include <sys/syscall.h>
> +#include <sys/wait.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#if HAVE_NUMA_H
> +#include <numa.h>
> +#endif
> +#if HAVE_NUMAIF_H
> +#include <numaif.h>
> +#endif
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <pwd.h>
> +#include "config.h"
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "linux_syscall_numbers.h"
> +#include "numa_helper.h"
> +#include "migrate_pages_common.h"
> +
> +char *TCID = "migrate_pages01";
> +int  TST_TOTAL = 1;
> +
> +option_t options[] = {
> +	{ NULL, NULL, NULL }
> +};
> +
> +#if defined(__NR_migrate_pages) && defined(HAVE_NUMA_H)
> +static unsigned long *sane_old_nodes;
> +static unsigned long *sane_new_nodes;
> +static int sane_nodemask_size;
> +static int sane_max_node;
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +static void test_sane_nodes(void)
> +{
> +	tst_resm(TINFO, "test_empty_mask");
> +	TEST(syscall(__NR_migrate_pages, 0, sane_max_node,
> +		sane_old_nodes, sane_new_nodes));
> +	check_ret(0);
> +}
> +
> +static void test_invalid_pid(void)
> +{
> +	const char pid_max[] = "/proc/sys/kernel/pid_max";
> +	FILE *fp;
> +	char buff[512];
> +	pid_t invalid_pid = -1;
> +
> +	tst_resm(TINFO, "test_invalid_pid -1");
> +	TEST(syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
> +		sane_old_nodes, sane_new_nodes));
> +	check_ret(-1);
> +	check_errno(ESRCH);
> +
> +	tst_resm(TINFO, "test_invalid_pid pid_max+1");
> +	fp = fopen(pid_max, "r");
> +	if (fp == NULL)
> +		tst_brkm(TBROK, cleanup,
> +			"Could not open %s", pid_max);
> +	if (!fgets(buff, sizeof(buff), fp))
> +		tst_brkm(TBROK, cleanup,
> +			"Could not read %s", pid_max);
> +	fclose(fp);
> +	invalid_pid = atol(buff) + 1;
> +	TEST(syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
> +		sane_old_nodes, sane_new_nodes));
> +	check_ret(-1);
> +	check_errno(ESRCH);
> +}
> +
> +static void test_invalid_masksize(void)
> +{
> +	tst_resm(TINFO, "test_invalid_masksize");
> +	TEST(syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
> +		sane_new_nodes));
> +	check_ret(-1);
> +	check_errno(EINVAL);
> +}
> +
> +static void test_invalid_mem(void)
> +{
> +	unsigned long *p;
> +
> +	tst_resm(TINFO, "test_invalid_mem -1");
> +	TEST(syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
> +	check_ret(-1);
> +	check_errno(EFAULT);
> +
> +	tst_resm(TINFO, "test_invalid_mem invalid prot");
> +	p = mmap(NULL, getpagesize(), PROT_NONE,
> +		MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
> +	if (p == MAP_FAILED)
> +		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> +	TEST(syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
> +	check_ret(-1);
> +	check_errno(EFAULT);
> +
> +	if (munmap(p, getpagesize()) < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "munmap");
> +	tst_resm(TINFO, "test_invalid_mem unmmaped");
> +	TEST(syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
> +	check_ret(-1);
> +	check_errno(EFAULT);
> +}
> +
> +static void test_invalid_nodes(void)
> +{
> +	int *nodes;
> +	int num_nodes, ret, i;
> +	int invalid_node = 0;
> +	unsigned long *old_nodes, *new_nodes;
> +
> +	tst_resm(TINFO, "test_invalid_nodes");
> +	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
> +	if (ret < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup,
> +			"get_allowed_nodes_arr: %d", ret);
> +
> +	/* get first node which is not in nodes */
> +	for (i = 0; i < num_nodes; i++, invalid_node++)
> +		if (invalid_node != nodes[i])
> +			break;
> +	if (invalid_node < sane_max_node) {
> +		old_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
> +		new_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
> +		memcpy(old_nodes, sane_old_nodes, sane_nodemask_size);
> +		memset(new_nodes, 0, sane_nodemask_size);
> +		set_bit(new_nodes, invalid_node, 1);
> +
> +		TEST(syscall(__NR_migrate_pages, 0, sane_max_node,
> +			old_nodes, new_nodes));
> +		check_ret(-1);
> +		check_errno(EINVAL);
> +		free(old_nodes);
> +		free(new_nodes);
> +	} else {
> +		tst_resm(TCONF, "All possible nodes are present");
> +	}
> +
> +	free(nodes);
> +}
> +
> +static void test_invalid_perm(void)
> +{
> +	char nobody_uid[] = "nobody";
> +	struct passwd *ltpuser;
> +	int status;
> +	pid_t child_pid;
> +	pid_t parent_pid;
> +	int ret = 0;
> +
> +	tst_resm(TINFO, "test_invalid_perm");
> +	parent_pid = getpid();
> +	fflush(stdout);
> +	child_pid = fork();
> +	switch (child_pid) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "fork");
> +		break;
> +	case 0:
> +		ltpuser = getpwnam(nobody_uid);
> +		if (ltpuser == NULL)
> +			tst_brkm(TBROK|TERRNO, NULL,
> +					"getpwnam failed");
> +		if (setuid(ltpuser->pw_uid) == -1)
> +			tst_brkm(TBROK|TERRNO, NULL,
> +					"setuid(%u) failed",
> +					ltpuser->pw_uid);
> +		TEST(syscall(__NR_migrate_pages, parent_pid,
> +			sane_max_node, sane_old_nodes,
> +			sane_new_nodes));
> +		ret |= check_ret(-1);
> +		ret |= check_errno(EPERM);
> +		exit(ret);
> +	default:
> +		if (waitpid(child_pid, &status, 0) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +			tst_resm(TFAIL, "child returns %d", status);
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, options, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		test_sane_nodes();
> +		test_invalid_pid();
> +		test_invalid_masksize();
> +		test_invalid_mem();
> +		test_invalid_nodes();
> +		test_invalid_perm();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	int node, ret;
> +
> +	tst_require_root(NULL);
> +	TEST(syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
> +
> +	if (numa_available() == -1)
> +		tst_brkm(TCONF, NULL, "NUMA not available");
> +
> +	ret = get_allowed_nodes(NH_MEMS, 1, &node);
> +	if (ret < 0)
> +		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes_arr: %d", ret);
> +
> +	sane_max_node = get_max_node();
> +	sane_nodemask_size = sane_max_node/8+1;
> +	sane_old_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
> +	sane_new_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
> +	memset(sane_old_nodes, 0, sane_nodemask_size);
> +	memset(sane_new_nodes, 0, sane_nodemask_size);
> +
> +	set_bit(sane_old_nodes, node, 1);
> +	set_bit(sane_new_nodes, node, 1);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	free(sane_old_nodes);
> +	free(sane_new_nodes);
> +	TEST_CLEANUP;
> +}
> +
> +#else /* __NR_migrate_pages */
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages"
> +			" or libnuma is not available");
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
> new file mode 100644
> index 0000000..00b512a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
> @@ -0,0 +1,62 @@
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
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "migrate_pages_common.h"
> +
> +void set_bit(unsigned long *b, unsigned int n, unsigned int v)
> +{
> +	if (v)
> +		b[n/bitsperlong] |= 1UL << (n % bitsperlong);
> +	else
> +		b[n/bitsperlong] &= ~(1UL << (n % bitsperlong));
> +}
> +
> +int check_ret(long expected_ret)
> +{
> +	if (expected_ret == TEST_RETURN) {
> +		tst_resm(TPASS, "expected ret success - "

here maybe changing it as
                      tst_resm(TPASS, "expected ret success: "
^
looks more friendly:

    e.g:  migrate_pages01   14  TPASS  :  expected ret success: returned 
value = -1


others look good for me, and I tested it on normal, 2/8 NUMA system, 
they are all good.

so Reviewed-by: ZhoupingLiu <zliu@redhat.com>

Thanks,
Zhouping

> +			"returned value = %ld", TEST_RETURN);
> +		return 0;
> +	} else
> +		tst_resm(TFAIL, "unexpected failure - "
> +			"returned value = %ld, expected: %ld",
> +			TEST_RETURN, expected_ret);
> +	return 1;
> +}
> +
> +int check_errno(long expected_errno)
> +{
> +	if (TEST_ERRNO == expected_errno) {
> +		tst_resm(TPASS|TTERRNO, "expected failure");
> +		return 0;
> +	} else if (TEST_ERRNO == 0)
> +		tst_resm(TFAIL, "call succeeded unexpectedly");
> +	else
> +		tst_resm(TFAIL|TTERRNO, "unexpected failure - "
> +			"expected = %ld : %s, actual",
> +			expected_errno, strerror(expected_errno));
> +	return 1;
> +}
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
> new file mode 100644
> index 0000000..d821b07
> --- /dev/null
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
> @@ -0,0 +1,33 @@
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
> +
> +#ifndef MIGRATE_PAGES_COMMON_H
> +#define MIGRATE_PAGES_COMMON_H
> +
> +#define bitsperlong (8 * sizeof(unsigned long))
> +
> +void set_bit(unsigned long *b, unsigned int n, unsigned int v);
> +int check_ret(long expected_ret);
> +int check_errno(long expected_errno);
> +#endif


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
