From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jun 2021 13:47:49 +0200
Subject: [LTP] [PATCH 2/3] syscalls/getrusage: Cleanup and bugfix for
 getrusage03
In-Reply-To: <20210616093606.214856-3-xieziyao@huawei.com>
References: <20210616093606.214856-1-xieziyao@huawei.com>
 <20210616093606.214856-3-xieziyao@huawei.com>
Message-ID: <YMnk5QUhwnOHrWLi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
> index 125acfc64..518e8510e 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> @@ -1,353 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * getrusage03 - test ru_maxrss behaviors in struct rusage
> - *
> - * This test program is backported from upstream commit:
> - * 1f10206cf8e945220f7220a809d8bfc15c21f9a5, which fills ru_maxrss
> - * value in struct rusage according to rss hiwater mark. To make sure
> - * this feature works correctly, a series of tests are executed in
> - * this program.
> - *
>   * Copyright (C) 2011  Red Hat, Inc.
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> + * Test ru_maxrss behaviors in struct rusage.
>   *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * This test program is backported from upstream commit: 1f10206cf8e9, which
> + * fills ru_maxrss value in struct rusage according to rss hiwater mark. To
> + * make sure this feature works correctly, a series of tests are executed in
> + * this program.
>   */
> -#include <sys/types.h>
> -#include <sys/mman.h>
> -#include <sys/resource.h>
> -#include <sys/time.h>
> -#include <sys/wait.h>
> -#include <unistd.h>
> -#include <signal.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> 
> -#include "test.h"
> -#include "safe_macros.h"
> +#include <stdlib.h>
> +#include <stdio.h>
> 
> -char *TCID = "getrusage03";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
> +#include "getrusage03.h"
> 
> -#define DELTA_MAX	10240
> +#define TESTBIN "getrusage03_child"
> 
> +static pid_t pid;
> +static int retval;
>  static struct rusage ru;
>  static long maxrss_init;
> -static int retval, status;
> -static pid_t pid;
> 
> -static void inherit_fork(void);
> -static void inherit_fork2(void);
> -static void fork_malloc(void);
> -static void grandchild_maxrss(void);
> -static void zombie(void);
> -static void sig_ign(void);
> -static void exec_without_fork(void);
> -static void check_return(int status, char *pass_msg, char *fail_msg);
> -static int is_in_delta(long value);
> -static void consume(int mega);
> -static void setup(void);
> -static void cleanup(void);
> +static const char *const resource[] = {
> +	TESTBIN,
> +	NULL,
> +};
> 
> -int main(int argc, char *argv[])
> +static void check_result(int result, char *msg)
>  {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		tst_resm(TINFO, "allocate 100MB");
> -		consume(100);
> -
> -		inherit_fork();
> -		inherit_fork2();
> -		fork_malloc();
> -		grandchild_maxrss();
> -		zombie();
> -		sig_ign();
> -		exec_without_fork();
> -	}
> -	cleanup();
> -	tst_exit();
> +	if (result == 1)
> +		tst_res(TPASS, "%s", msg);
> +	else if (result == 0)
> +		tst_res(TFAIL, "%s", msg);
> +	else
> +		tst_res(TFAIL, "unexpected result???%d", result);
>  }

The new test library allows you to report PASS/FAIL from child processes
so we can get rid of this check result function here.

> -/* Testcase #01: fork inherit
> - * expect: initial.self ~= child.self */
> -static void inherit_fork(void)
> +static void inherit_fork1(void)
>  {
> -	tst_resm(TINFO, "Testcase #01: fork inherit");
> -
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> -	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
> +	SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
> +	maxrss_init = ru.ru_maxrss;
> 
> -	switch (pid = fork()) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
> -	case 0:
> -		maxrss_init = ru.ru_maxrss;
> -		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> -		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
> -		exit(is_in_delta(maxrss_init - ru.ru_maxrss));
> -	default:
> -		break;
> +	if ((pid = SAFE_FORK()) == 0) {

We do not use the pid value for anything so this can be just:

	if (!SAFE_FORK()) {
		...

> +		SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
> +		exit(!is_in_delta(maxrss_init - ru.ru_maxrss));

Here we should do:

		if (is_in_delta(maxrss_init - ru.ru_maxrss)) {
			tst_res(TPASS, "ru_maxrrs inheritted correctly");
		} else {
			tst_res(TFAIL, "ru_maxrss = %li, expected %li",
			        ru.ru_maxrss, maxrss_init);
		}

>  	}
> 
> -	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
> -	check_return(WEXITSTATUS(status), "initial.self ~= child.self",
> -		     "initial.self !~= child.self");
> +	tst_reap_children();
> +	tst_res(TPASS, "check that initial.self ~= child.self");

And all that has to be done here is tst_reap_children();

>  }
> 
> -/* Testcase #02: fork inherit (cont.)
> - * expect: initial.children ~= 100MB, child.children = 0 */
>  static void inherit_fork2(void)
>  {
> -	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
> -
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> -	if (is_in_delta(ru.ru_maxrss - 102400))
> -		tst_resm(TPASS, "initial.children ~= 100MB");
> -	else
> -		tst_resm(TFAIL, "initial.children !~= 100MB");
> -
> -	switch (pid = fork()) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork #2");
> -	case 0:
> -		SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -		tst_resm(TINFO, "child.children = %ld", ru.ru_maxrss);
> -		exit(ru.ru_maxrss == 0);
> -	default:
> -		break;
> -	}
> -
> -	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
> -	check_return(WEXITSTATUS(status), "child.children == 0",
> -		     "child.children != 0");
> -}
> -
> -/* Testcase #03: fork + malloc
> - * expect: initial.self + 50MB ~= child.self */
> -static void fork_malloc(void)
> -{
> -	tst_resm(TINFO, "Testcase #03: fork + malloc");
> -
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> -	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +	check_result(is_in_delta(ru.ru_maxrss - 102400), "check that initial.children ~= 100MB");

Can we just do the check here instead? I.e.

	if (is_in_delta(ru.ru_maxrss - 102400))
		tst_res(TPASS, "Initial ru.ru_maxrss ~= 100MB");
	else
		tst_res(TFAIL, "Initial ru.ru_maxrss = %liB", ru.ru_maxrss);

> -	switch (pid = fork()) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork #3");
> -	case 0:
> -		maxrss_init = ru.ru_maxrss;
> -		tst_resm(TINFO, "child allocate +50MB");
> -		consume(50);
> -		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> -		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
> -		exit(is_in_delta(maxrss_init + 51200 - ru.ru_maxrss));
> -	default:
> -		break;
> +	if ((pid = SAFE_FORK()) == 0) {

Here as well just if (!SAFE_FORK()) {

> +		SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +		exit(ru.ru_maxrss);

Here as well, we should report the result here.

>  	}
> 
> -	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
> -	check_return(WEXITSTATUS(status), "initial.self + 50MB ~= child.self",
> -		     "initial.self + 50MB !~= child.self");
> +	tst_reap_children();
> +	tst_res(TPASS, "check that child.children == 0");

And only reap the child process here.

>  }
> 
> -/* Testcase #04: grandchild maxrss
> - * expect: post_wait.children ~= 300MB */
>  static void grandchild_maxrss(void)
>  {
> -	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
> -
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> -
> -	switch (pid = fork()) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork #4");
> -	case 0:
> -		retval = system("getrusage03_child -g 300");
> +	if ((pid = SAFE_FORK()) == 0) {

	Here as well.

> +		retval = tst_system("getrusage03_child grand_consume 300");

We have already forked so there is no point in using system(). All that
we have to do here is execve() as:

		const char *argv[] = {"getrusage03_child", "grand_consume", "300", NULL};

		execve(argv[0], argv[], environ);

		tst_brk(TBROK | TERRNO, "execve() failed");

>  		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
> -			tst_brkm(TBROK | TERRNO, cleanup, "system");
> +			tst_brk(TBROK, "system(\"getrusage03_child grand_consume 300\")");
>  		exit(0);
> -	default:
> -		break;
>  	}
> 
> -	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
> -	if (WEXITSTATUS(status) != 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "child exit status is not 0");
> -
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
> -	if (is_in_delta(ru.ru_maxrss - 307200))
> -		tst_resm(TPASS, "child.children ~= 300MB");
> -	else
> -		tst_resm(TFAIL, "child.children !~= 300MB");
> +	tst_reap_children();
> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +	check_result(is_in_delta(ru.ru_maxrss - 307200), "check that child.children ~= 300MB");
>  }
> 
> -/* Testcase #05: zombie
> - * expect: initial ~= pre_wait, post_wait ~= 400MB */
>  static void zombie(void)
>  {
> -	tst_resm(TINFO, "Testcase #05: zombie");
> -
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
>  	maxrss_init = ru.ru_maxrss;
> 
> -	switch (pid = fork()) {
> -	case -1:
> -		tst_brkm(TBROK, cleanup, "fork #5");
> -	case 0:
> -		retval = system("getrusage03_child -n 400");
> +	if ((pid = SAFE_FORK()) == 0) {
> +		retval = tst_system("getrusage03_child consume 400");
>  		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
> -			tst_brkm(TBROK | TERRNO, cleanup, "system");
> +			tst_brk(TBROK, "system(\"getrusage03_child consume 400\")");
>  		exit(0);
> -	default:
> -		break;
>  	}

Here as well, just use execve().

> -	sleep(1);		/* children become zombie */
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "pre_wait.children = %ld", ru.ru_maxrss);
> -	if (is_in_delta(ru.ru_maxrss - maxrss_init))
> -		tst_resm(TPASS, "initial.children ~= pre_wait.children");
> -	else
> -		tst_resm(TFAIL, "initial.children !~= pre_wait.children");
> -
> -	SAFE_WAITPID(cleanup, pid, &status, WUNTRACED | WCONTINUED);
> -	if (WEXITSTATUS(status) != 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "child exit status is not 0");
> +	TST_PROCESS_STATE_WAIT(pid, 'Z', 0);
> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +	check_result(is_in_delta(ru.ru_maxrss - maxrss_init),
> +		     "check that initial.children ~= pre_wait.children");

Here as well, just print TPASS/TFAIL messages rather than using the
check_result() function.

> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
> -	if (is_in_delta(ru.ru_maxrss - 409600))
> -		tst_resm(TPASS, "post_wait.children ~= 400MB");
> -	else
> -		tst_resm(TFAIL, "post_wait.children !~= 400MB");
> +	tst_reap_children();
> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +	check_result(is_in_delta(ru.ru_maxrss - 409600), "check that post_wait.children ~= 400MB");

And here as well.

>  }
> 
> -/* Testcase #06: SIG_IGN
> - * expect: initial ~= after_zombie */
>  static void sig_ign(void)
>  {
> -	tst_resm(TINFO, "Testcase #06: SIG_IGN");
> -
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> -	signal(SIGCHLD, SIG_IGN);
> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
>  	maxrss_init = ru.ru_maxrss;
> +	SAFE_SIGNAL(SIGCHLD, SIG_IGN);
> 
> -	switch (pid = fork()) {
> -	case -1:
> -		tst_brkm(TBROK, cleanup, "fork #6");
> -	case 0:
> -		retval = system("getrusage03_child -n 500");
> +	if ((pid = SAFE_FORK()) == 0) {
> +		retval = tst_system("getrusage03_child consume 500");
>  		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
> -			tst_brkm(TBROK | TERRNO, cleanup, "system");
> +			tst_brk(TBROK, "system(\"getrusage03_child consume 500\")");
>  		exit(0);
> -	default:
> -		break;
>  	}


And here as well.

> -	sleep(1);		/* children become zombie */
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	tst_resm(TINFO, "after_zombie.children = %ld", ru.ru_maxrss);
> -	if (is_in_delta(ru.ru_maxrss - maxrss_init))
> -		tst_resm(TPASS, "initial.children ~= after_zombie.children");
> -	else
> -		tst_resm(TFAIL, "initial.children !~= after_zombie.children");
> -	signal(SIGCHLD, SIG_DFL);
> +	TST_PROCESS_RELEASE_WAIT(pid, 0);

Why can't we use the TST_PROCESS_STATE_WAIT(pid, 'Z', 0) here as well? I
fail to see how this is different from the previous test.

> +	SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +	check_result(is_in_delta(ru.ru_maxrss - maxrss_init),
> +		     "check that initial.children ~= after_zombie.children");
> +	SAFE_SIGNAL(SIGCHLD, SIG_DFL);
>  }
> 
> -/* Testcase #07: exec without fork
> - * expect: initial ~= fork */
> -static void exec_without_fork(void)
> +static void inherit_exec(void)
>  {
> -	char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];
> -	long maxrss_self, maxrss_child;
> +	int status;
> 
> -	tst_resm(TINFO, "Testcase #07: exec without fork");
> +	if ((pid = SAFE_FORK()) == 0) {
> +		char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];
> 
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> -	maxrss_self = ru.ru_maxrss;
> -	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -	maxrss_child = ru.ru_maxrss;
> -	tst_resm(TINFO, "initial.self = %ld, initial.children = %ld",
> -		 maxrss_self, maxrss_child);
> +		SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
> +		sprintf(str_maxrss_self, "%ld", ru.ru_maxrss);
> +		SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +		sprintf(str_maxrss_child, "%ld", ru.ru_maxrss);
> 
> -	sprintf(str_maxrss_self, "%ld", maxrss_self);
> -	sprintf(str_maxrss_child, "%ld", maxrss_child);
> -	if (execlp("getrusage03_child", "getrusage03_child", "-v",
> -		   "-s", str_maxrss_self, "-l", str_maxrss_child, NULL) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "execlp");
> -}
> +		SAFE_EXECLP("getrusage03_child", "getrusage03_child", "compare",
> +			    str_maxrss_self, str_maxrss_child, NULL);
> +	}
> 
> -static int is_in_delta(long value)
> -{
> -	return (value >= -DELTA_MAX && value <= DELTA_MAX);
> +	SAFE_WAITPID(pid, &status, 0);
> +	check_result(WIFEXITED(status) && WEXITSTATUS(status) == 0,
> +		     "check that initial.self ~= exec.self, initial.children ~= exec.children");

In this case the check is done in the child. All the parent has to do is
to reap the children to make sure that it did exit with 0 and the child
should report the result instead.

As the child calls tst_reinit() it can report results directly to the
main test process without need to propagate anything via return values.

>  }
> 
> -static void check_return(int status, char *pass_msg, char *fail_msg)
> +static void run(void)
>  {
> -	switch (status) {
> -	case 1:
> -		tst_resm(TPASS, "%s", pass_msg);
> -		break;
> -	case 0:
> -		tst_resm(TFAIL, "%s", fail_msg);
> -		break;
> -	default:
> -		tst_resm(TFAIL, "child exit status is %d", status);
> -		break;
> -	}
> -}
> -
> -static void consume(int mega)
> -{
> -	size_t sz;
> -	void *ptr;
> -
> -	sz = mega * 1024 * 1024;
> -	ptr = SAFE_MALLOC(cleanup, sz);
> -	memset(ptr, 0, sz);
> +	inherit_fork1();
> +	inherit_fork2();
> +	grandchild_maxrss();
> +	zombie();
> +	sig_ign();
> +	inherit_exec();

Can we split these into a several tests?

Have a look at snd_seq01.c and testfunc_list array how this is done.

>  }
> 
>  static void setup(void)
>  {
> -	/* Disable test if the version of the kernel is less than 2.6.32 */
> -	if ((tst_kvercmp(2, 6, 32)) < 0) {
> -		tst_resm(TCONF, "This ru_maxrss field is not supported");
> -		tst_brkm(TCONF, NULL, "before kernel 2.6.32");
> -	}
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	consume(100);
>  }
> 
> -static void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.child_needs_reinit = 1,
> +	.resource_files = resource,
> +	.min_kver = "2.6.32",
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "1f10206cf8e9"},
> +	},
> +	.setup = setup,
> +	.test_all = run,
> +};
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.h b/testcases/kernel/syscalls/getrusage/getrusage03.h
> new file mode 100644
> index 000000000..5fbf57272
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.h
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2011  Red Hat, Inc.
> + * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
> + */
> +
> +#ifndef LTP_GETRUSAGE03_H
> +#define LTP_GETRUSAGE03_H
> +
> +#include "tst_test.h"
> +
> +#define DELTA_MAX 20480
> +
> +static void consume(int consume_nr)
               ^
	       This should be called consume_mb() so that it's clear
	       that the parameter is in megabytes.
> +{
> +	void* ptr;
> +	size_t size;
> +	unsigned long vmswap_size;
> +
> +	size = consume_nr * 1024 * 1024;
> +	ptr = SAFE_MALLOC(size);
> +	memset(ptr, 0, size);
> +
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmSwap: %lu", &vmswap_size);
> +	if (vmswap_size > 0)
> +		tst_brk(TBROK, "VmSwap is not zero");
> +	tst_res(TINFO, "allocate %dMB", consume_nr);
> +}
> +
> +static int is_in_delta(long value)
> +{
> +	return (value >= -DELTA_MAX && value <= DELTA_MAX);
> +}
> +
> +#endif //LTP_GETRUSAGE03_H
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
> index 972c38e4e..58da481cb 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03_child.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
> @@ -1,168 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * getrusage03_child.c - a child program executed by getrusage03
> - *
>   * Copyright (C) 2011  Red Hat, Inc.
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * Copyright (c) 2021 Xie Ziyao <xieziyao@huawei.com>
>   */
> -#include <sys/types.h>
> -#include <sys/resource.h>
> -#include <sys/time.h>
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <limits.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> 
> -char *TCID = "getrusage03_child";
> -int TST_TOTAL = 1;
> -
> -#define DELTA_MAX	10240
> +/*\
> + * [Description]
> + *
> + * Child program executed by getrusage03.
> + */
> 
> -static int opt_consume, opt_grand, opt_show, opt_self, opt_child;
> -static char *consume_str, *grand_consume_str, *self_str, *child_str;
> +#define TST_NO_DEFAULT_MAIN
> 
> -option_t child_options[] = {
> -	{"n:", &opt_consume, &consume_str},
> -	{"g:", &opt_grand, &grand_consume_str},
> -	{"v", &opt_show, NULL},
> -	{"s:", &opt_self, &self_str},
> -	{"l:", &opt_child, &child_str},
> -	{NULL, NULL, NULL}
> -};
> +#include <stdlib.h>
> 
> -static void usage(void);
> -static void consume(int mega);
> -static void setup(void);
> -static void cleanup(void);
> +#include "tst_test.h"
> +#include "getrusage03.h"
> 
>  int main(int argc, char *argv[])
>  {
> -	int lc;
> +	if (argc < 3)
> +		tst_brk(TFAIL, "argc is %d, expected more", argc);

This is TBROK and also the message could be more clear such as:

	"expected at least two parameters"

>  	pid_t pid;
> -	long maxrss_self, maxrss_children, delta;
> +	long maxrss_self, maxrss_children;
>  	long consume_nr, grand_consume_nr, self_nr, child_nr;
>  	struct rusage ru;
> 
> -	tst_parse_opts(argc, argv, child_options, usage);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		if (opt_consume) {
> -			consume_nr = SAFE_STRTOL(cleanup,
> -						 consume_str, 0, LONG_MAX);
> -			tst_resm(TINFO, "child allocate %ldMB", consume_nr);
> -			consume(consume_nr);
> -		}
> +	tst_reinit();
> 
> -		if (opt_grand) {
> -			grand_consume_nr = SAFE_STRTOL(cleanup,
> -						       grand_consume_str, 0,
> -						       LONG_MAX);
> -			tst_resm(TINFO, "grandchild allocate %ldMB",
> -				 grand_consume_nr);
> -			switch (pid = fork()) {
> -			case -1:
> -				tst_brkm(TBROK, cleanup, "fork");
> -			case 0:
> -				consume(grand_consume_nr);
> -				exit(0);
> -			default:
> -				break;
> -			}
> -			while (waitpid(-1, &pid, WUNTRACED | WCONTINUED) > 0)
> -				if (WEXITSTATUS(pid) != 0)
> -					tst_brkm(TBROK | TERRNO, cleanup,
> -						 "child exit status is not 0");
> +	if (!strcmp(argv[1], "consume")) {
> +		consume_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);
> +		consume(consume_nr);
> +	}
> +	else if (!strcmp(argv[1], "grand_consume")) {

The else has to be on the same line as }

> +		grand_consume_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);
> +
> +		pid = fork();
> +		if (pid == -1)
> +			tst_brk(TBROK, "fork failed");
> +		else if (pid == 0) {
> +			consume(grand_consume_nr);
> +			exit(0);
>  		}

Just use SAFE_FORK() here.

> -		if (opt_show) {
> -			SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> -			maxrss_self = ru.ru_maxrss;
> -			SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> -			maxrss_children = ru.ru_maxrss;
> -			tst_resm(TINFO, "exec.self = %ld, exec.children = %ld",
> -				 maxrss_self, maxrss_children);
> -			if (opt_self) {
> -				self_nr = SAFE_STRTOL(cleanup,
> -						      self_str, 0, LONG_MAX);
> -				delta = maxrss_self - self_nr;
> -				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
> -					tst_resm(TPASS,
> -						 "initial.self ~= exec.self");
> -				else
> -					tst_resm(TFAIL,
> -						 "initial.self !~= exec.self");
> -			}
> -			if (opt_child) {
> -				child_nr = SAFE_STRTOL(cleanup,
> -						       child_str, 0, LONG_MAX);
> -				delta = maxrss_children - child_nr;
> -				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
> -					tst_resm(TPASS,
> -						 "initial.children ~= exec.children");
> -				else
> -					tst_resm(TFAIL,
> -						 "initial.children !~= exec.children");
> -			}
> -		}
> +		tst_reap_children();
>  	}
> +	else if (!strcmp(argv[1], "compare")) {
> +		self_nr = SAFE_STRTOL(argv[2], 0, LONG_MAX);
> +		child_nr = SAFE_STRTOL(argv[3], 0, LONG_MAX);
> 
> -	cleanup();
> -	tst_exit();
> -}
> -
> -static void usage(void)
> -{
> -	printf("  -n NUM  consume NUM MB size\n");
> -	printf("  -g NUM  grandchild consume NUM MB size\n");
> -	printf("  -v      verbose mode, show rusage info\n");
> -	printf("  -s NUM  compare rusage_self.maxrss with given NUM\n");
> -	printf("  -l NUM  compare rusage_children.maxrss with given NUM\n");
> -}
> -
> -static void consume(int mega)
> -{
> -	size_t sz;
> -	void *ptr;
> +		SAFE_GETRUSAGE(RUSAGE_SELF, &ru);
> +		maxrss_self = ru.ru_maxrss;
> +		SAFE_GETRUSAGE(RUSAGE_CHILDREN, &ru);
> +		maxrss_children = ru.ru_maxrss;
> 
> -	sz = mega * 1024 * 1024;
> -	ptr = SAFE_MALLOC(cleanup, sz);
> -	memset(ptr, 0, sz);
> -}
> -
> -static void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> +		if (!is_in_delta(maxrss_self - self_nr) || !is_in_delta(maxrss_children - child_nr))
> +			tst_brk(TBROK, "check that initial.self ~= exec.self, initial.children ~= exec.children");

This should produce TPASS/TFAIL messages and for each of them
respectivelly as:

		if (is_in_delta(maxrss_self - self_nr))
			tst_res(TPASS, ...);
		else
			tst_res(TFAIL, ...);

		if (is_in_delta(maxrss_children - child_nr))
			tst_res(TPASS, ...);
		else
			tst_res(TFAIL, ...);
	}

	return 0;

> +	}
> 
> -static void cleanup(void)
> -{
> +	return 0;
>  }
> --
> 2.17.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
