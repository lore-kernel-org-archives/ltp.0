Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QbvXA-0001Ek-Hx
	for ltp-list@lists.sourceforge.net; Wed, 29 Jun 2011 14:14:28 +0000
Date: Wed, 29 Jun 2011 16:14:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110629141444.GA9939@saboteur.suse.cz>
References: <4b2e0e53cb8ba5934df4fa72055d1d29746bffa2.1305557863.git.czhang@redhat.com>
	<ef44f6feaa6d46350761dae93d997c3f6a3a7e9e.1307968048.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef44f6feaa6d46350761dae93d997c3f6a3a7e9e.1307968048.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v2] [syscalls] getrusage03: test ru_maxrss
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		tst_resm(TINFO, "allocate 100MB");
> +		consume(100);
> +
> +		inherit_fork();
> +		inherit_fork2();
> +		fork_malloc();
> +		grandchild_maxrss();
> +		zombie();
> +		sig_ign();
> +		exec_without_fork();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +/* Testcase #01: fork inherit
> + * expect: initial.self ~= child.self */
> +static void inherit_fork(void)
> +{
> +	tst_resm(TINFO, "Testcase #01: fork inherit");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> +	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
> +
> +	switch (pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "fork #1");
> +	case 0:
> +		maxrss_init = ru.ru_maxrss;
> +		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> +		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
> +		exit(is_in_delta(maxrss_init - ru.ru_maxrss));
> +	default:
> +		break;
> +	}
> +
> +	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +	check_return(WEXITSTATUS(status), "initial.self ~= child.self",
> +		    "initial.self !~= child.self");
> +}
> +
> +/* Testcase #02: fork inherit (cont.)
> + * expect: initial.children ~= 100MB, child.children = 0 */
> +static void inherit_fork2(void)
> +{
> +	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> +	if (is_in_delta(ru.ru_maxrss - 102400) == 0)
> +		tst_resm(TPASS, "initial.children ~= 100MB");
> +	else
> +		tst_resm(TFAIL, "initial.children !~= 100MB");
> +
> +	switch (pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "fork #2");
> +	case 0:
> +		SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +		tst_resm(TINFO, "child.children = %ld", ru.ru_maxrss);
> +		exit((ru.ru_maxrss == 0) ? 0 : 1);
> +	default:
> +		break;
> +	}
> +
> +	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +	check_return(WEXITSTATUS(status), "child.children == 0",
> +		    "child.children != 0");
> +}
> +
> +/* Testcase #03: fork + malloc
> + * expect: initial.self + 50MB ~= child.self */
> +static void fork_malloc(void)
> +{
> +	tst_resm(TINFO, "Testcase #03: fork + malloc");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> +	tst_resm(TINFO, "initial.self = %ld", ru.ru_maxrss);
> +
> +	switch (pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "fork #3");
> +	case 0:
> +		maxrss_init = ru.ru_maxrss;
> +		tst_resm(TINFO, "child allocate +50MB");
> +		consume(50);
> +		SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> +		tst_resm(TINFO, "child.self = %ld", ru.ru_maxrss);
> +		exit(is_in_delta(maxrss_init + 51200 - ru.ru_maxrss));
> +	default:
> +		break;
> +	}
> +
> +	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +	check_return(WEXITSTATUS(status), "initial.self + 50MB ~= child.self",
> +		    "initial.self + 50MB !~= child.self");
> +}
> +
> +/* Testcase #04: grandchild maxrss
> + * expect: post_wait.children ~= 300MB */
> +static void grandchild_maxrss(void)
> +{
> +	tst_resm(TINFO, "Testcase #04: grandchild maxrss");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> +
> +	switch (pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "fork #4");
> +	case 0:
> +		retval = system("getrusage03_child -g 300");
> +		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
> +			tst_brkm(TBROK|TERRNO, cleanup, "system");
> +		exit(0);
> +	default:
> +		break;
> +	}
> +
> +	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +	if (WEXITSTATUS(status) != 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "child exit status is not 0");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
> +	if (is_in_delta(ru.ru_maxrss - 307200) == 0)
> +		tst_resm(TPASS, "child.children ~= 300MB");
> +	else
> +		tst_resm(TFAIL, "child.children !~= 300MB");
> +}
> +
> +/* Testcase #05: zombie
> + * expect: initial ~= pre_wait, post_wait ~= 400MB */
> +static void zombie(void)
> +{
> +	tst_resm(TINFO, "Testcase #05: zombie");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> +	maxrss_init = ru.ru_maxrss;
> +
> +	switch (pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK, cleanup, "fork #5");
> +	case 0:
> +		retval = system("getrusage03_child -n 400");
> +		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
> +			tst_brkm(TBROK|TERRNO, cleanup, "system");
> +		exit(0);
> +	default:
> +		break;
> +	}
> +
> +	sleep(1); /* children become zombie */
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "pre_wait.children = %ld", ru.ru_maxrss);
> +	if (is_in_delta(ru.ru_maxrss - maxrss_init) == 0)
> +		tst_resm(TPASS, "initial.children ~= pre_wait.children");
> +	else
> +		tst_resm(TFAIL, "initial.children !~= pre_wait.children");
> +
> +	if (waitpid(pid, &status, WUNTRACED|WCONTINUED) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +	if (WEXITSTATUS(status) != 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "child exit status is not 0");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "post_wait.children = %ld", ru.ru_maxrss);
> +	if (is_in_delta(ru.ru_maxrss - 409600) == 0)
> +		tst_resm(TPASS, "post_wait.children ~= 400MB");
> +	else
> +		tst_resm(TFAIL, "post_wait.children !~= 400MB");
> +}
> +
> +/* Testcase #06: SIG_IGN
> + * expect: initial ~= after_zombie */
> +static void sig_ign(void)
> +{
> +	tst_resm(TINFO, "Testcase #06: SIG_IGN");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> +	signal(SIGCHLD, SIG_IGN);
> +	maxrss_init = ru.ru_maxrss;
> +
> +	switch (pid = fork()) {
> +	case -1:
> +		tst_brkm(TBROK, cleanup, "fork #6");
> +	case 0:
> +		retval = system("getrusage03_child -n 500");
> +		if ((WIFEXITED(retval) && WEXITSTATUS(retval) != 0))
> +			tst_brkm(TBROK|TERRNO, cleanup, "system");
> +		exit(0);
> +	default:
> +		break;
> +	}
> +
> +	sleep(1); /* children become zombie */
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	tst_resm(TINFO, "after_zombie.children = %ld", ru.ru_maxrss);
> +	if (is_in_delta(ru.ru_maxrss - maxrss_init) == 0)
> +		tst_resm(TPASS, "initial.children ~= after_zombie.children");
> +	else
> +		tst_resm(TFAIL, "initial.children !~= after_zombie.children");
> +	signal(SIGCHLD, SIG_DFL);
> +}
> +
> +/* Testcase #07: exec without fork
> + * expect: initial ~= fork */
> +static void exec_without_fork(void)
> +{
> +	char str_maxrss_self[BUFSIZ], str_maxrss_child[BUFSIZ];
> +	long maxrss_self, maxrss_child;
> +
> +	tst_resm(TINFO, "Testcase #07: exec without fork");
> +
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> +	maxrss_self = ru.ru_maxrss;
> +	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +	maxrss_child = ru.ru_maxrss;
> +	tst_resm(TINFO, "initial.self = %ld, initial.children = %ld",
> +		    maxrss_self, maxrss_child);
> +
> +	sprintf(str_maxrss_self, "%ld", maxrss_self);
> +	sprintf(str_maxrss_child, "%ld", maxrss_child);
> +	if (execlp("getrusage03_child", "getrusage03_child", "-v",
> +		    "-s", str_maxrss_self,
> +		    "-l", str_maxrss_child, NULL) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "execlp");
> +}
> +
> +static int is_in_delta(long value)
> +{
> +	return ((value >= -DELTA_MAX && value <= DELTA_MAX) ? 0 : 1);
> +}

Hmm, this is really confusing. The function name suggests that value is
"value is in delta range" but it actually returns 0 which is same as
false in C.

The 0 == success approach makes sence only for C functions that actually
returns error codes otherwise, but not for functions whose name suggests
boolean return value.

I would drop the ? 0:1 part and remove == 0 from the if() statements
abowe.

> +static void check_return(int status, char *pass_msg, char *fail_msg)
> +{
> +	switch (status) {
> +	case 0:
> +		tst_resm(TPASS, "%s", pass_msg);
> +		break;
> +	case 1:
> +		tst_resm(TFAIL, "%s", fail_msg);
> +		break;
> +	default:
> +		tst_resm(TFAIL, "child exit status is %d", status);
> +		break;
> +	}
> +}
> +
> +static void consume(int mega)
> +{
> +	size_t sz;
> +	void *ptr;
> +
> +	sz  = mega * 1024 * 1024;
> +	ptr = SAFE_MALLOC(cleanup, sz);
> +	if (memset(ptr, 0, sz) == NULL)
> +		tst_brkm(TBROK|TERRNO, cleanup, "memset");
> +}

The memset() can't fail, it just returns pointer to the passed buffer.

> +static void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +}
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03_child.c b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
> new file mode 100644
> index 0000000..6127fd2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03_child.c
> @@ -0,0 +1,183 @@
> +/*
> + * getrusage03_child.c - a child program executed by getrusage03
> + *
> + * Copyright (C) 2011  Red Hat, Inc.
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
> +#include <sys/types.h>
> +#include <sys/resource.h>
> +#include <sys/time.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "getrusage03_child";
> +int TST_TOTAL = 1;
> +
> +#define DELTA_MAX	10240
> +
> +static int opt_consume, opt_grand, opt_show, opt_self, opt_child;
> +static char *consume_str, *grand_consume_str, *self_str, *child_str;
> +
> +option_t child_options[] = {
> +	{ "n:", &opt_consume, &consume_str },
> +	{ "g:", &opt_grand,   &grand_consume_str },
> +	{ "v",  &opt_show,    NULL },
> +	{ "s:", &opt_self,    &self_str },
> +	{ "l:", &opt_child,   &child_str }
> +};
> +
> +static void usage(void);
> +static void consume(int mega);
> +static long get_long(const char *str);
> +static void setup(void);
> +static void cleanup(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	pid_t pid;
> +	long maxrss_self, maxrss_children, delta;
> +	long consume_nr, grand_consume_nr, self_nr, child_nr;
> +	struct rusage ru;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, child_options, usage);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		if (opt_consume) {
> +			consume_nr = get_long(consume_str);
> +			tst_resm(TINFO, "child allocate %ldMB", consume_nr);
> +			consume(consume_nr);
> +		}
> +
> +		if (opt_grand) {
> +			grand_consume_nr = get_long(grand_consume_str);
> +			tst_resm(TINFO, "grandchild allocate %ldMB",
> +				    grand_consume_nr);
> +			switch (pid = fork()) {
> +			case -1:
> +				tst_brkm(TBROK, cleanup, "fork");
> +			case 0:
> +				consume(grand_consume_nr);
> +				exit(0);
> +			default:
> +				break;
> +			}
> +			while (waitpid(-1, &pid, WUNTRACED|WCONTINUED) > 0)
> +				if (WEXITSTATUS(pid) != 0)
> +					tst_brkm(TBROK|TERRNO, cleanup,
> +						"child exit status is not 0");
> +		}
> +
> +		if (opt_show) {
> +			SAFE_GETRUSAGE(cleanup, RUSAGE_SELF, &ru);
> +			maxrss_self = ru.ru_maxrss;
> +			SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> +			maxrss_children = ru.ru_maxrss;
> +			tst_resm(TINFO, "exec.self = %ld, exec.children = %ld",
> +				    maxrss_self, maxrss_children);
> +			if (opt_self) {
> +				self_nr = get_long(self_str);
> +				delta = maxrss_self - self_nr;
> +				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
> +					tst_resm(TPASS,
> +						"initial.self ~= exec.self");
> +				else
> +					tst_resm(TFAIL,
> +						"initial.self !~= exec.self");
> +			}
> +			if (opt_child) {
> +				child_nr = get_long(child_str);
> +				delta = maxrss_children - child_nr;
> +				if (delta >= -DELTA_MAX && delta <= DELTA_MAX)
> +					tst_resm(TPASS,
> +						"initial.children ~= exec.children");
> +				else
> +					tst_resm(TFAIL,
> +						"initial.children !~= exec.children");
> +			}
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void usage(void)
> +{
> +	printf("  -n NUM  consume NUM MB size\n");
> +	printf("  -g NUM  grandchild consume NUM MB size\n");
> +	printf("  -v      verbose mode, show rusage info\n");
> +	printf("  -s NUM  compare rusage_self.maxrss with given NUM\n");
> +	printf("  -l NUM  compare rusage_children.maxrss with given NUM\n");
> +}
> +
> +static void consume(int mega)
> +{
> +	size_t sz;
> +	void *ptr;
> +
> +	sz  = mega * 1024 * 1024;
> +	ptr = SAFE_MALLOC(cleanup, sz);
> +	if (memset(ptr, 0, sz) == NULL)
> +		tst_brkm(TBROK|TERRNO, cleanup, "memset");

Here too.

> +}
> +
> +static long get_long(const char *str)
> +{
> +	long val;
> +	char *endptr;
> +
> +	val = strtol(str, &endptr, 10);
> +	if (((val == LONG_MAX || val == LONG_MIN) && errno == ERANGE) ||
> +		    (errno != 0 && val == 0))
> +		tst_brkm(TBROK|TERRNO, cleanup, "strtol");
> +	if (endptr == str)
> +		tst_brkm(TBROK, cleanup, "No digits were found.");
> +
> +	return val;
> +}

This is not 100% correct. The strtol (for converting whole string into
number) is successfull if the endptr points to the end of string, eg.
*endptr = '\0' and if the value is not LONG_MAX or LONG_MIN both with
errno set to ERANGE. This will accept strings like "256foo".

> +static void setup()

Add void.

> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup()

And here.

> +{
> +	TEST_CLEANUP;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
