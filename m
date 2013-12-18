Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Vt9tQ-0007Uw-8M
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 05:42:00 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vt9tN-0006jL-FJ
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 05:42:00 +0000
Message-ID: <1387345302.1664.30.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 18 Dec 2013 13:41:42 +0800
In-Reply-To: <1665679110.4191212.1386865326547.JavaMail.root@redhat.com>
References: <1386848136.1603.22.camel@G08JYZSD130126>
	<1665679110.4191212.1386865326547.JavaMail.root@redhat.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v4 2/2] clone/clone08.c: add new flags
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Thu, 2013-12-12 at 11:22 -0500, Jan Stancek wrote:
> 
> ----- Original Message -----
> > From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> > Sent: Thursday, 12 December, 2013 12:35:36 PM
> > Subject: [PATCH v4 2/2] clone/clone08.c: add new flags
> > 
> > Add new case for clone(2)
> > CLONE_PARENT
> > CLONE_CHILD_SETTID
> > CLONE_PARENT_SETTID
> > CLONE_STOPPED
> > CLONE_THREAD
> > 
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> 
> Hi,
> 
> I sent a patch named "[PATCH v4b 2/2] clone/clone08.c: add new flags"
> few moments ago. It's a re-arranged v4 of your patch.
> 
> I have removed the various "if" checks from main and do_master_child().
> by splitting do_master_child() into separate test_ functions for each testcase.
> I also removed check_clone_thread_terminated() and used same kind of check
> we have in test_clone_stopped().
> 
> Can you have a look if you'd be OK with these changes?
> 

Hi Jan,

    I have reviewed your patch and it looks good, much neater than my patch v4 indeed.
Next I will be more careful to such kinds problems, thanks.
    The link in the comment help me much to understand why to use ltp_syscall in cloned
child thread, :)

in test_clone_parent
-               tst_brkm(TBROK | TERRNO, NULL, "test_clone_parent fork");
+               tst_brkm(TBROK | TERRNO, NULL, "test_clone_thread fork");

Thank you very much.
Zeng

> Regards,
> Jan
> 
> > ---
> >  runtest/ltplite                           |   1 +
> >  runtest/stress.part3                      |   1 +
> >  runtest/syscalls                          |   1 +
> >  testcases/kernel/syscalls/.gitignore      |   1 +
> >  testcases/kernel/syscalls/clone/clone08.c | 350
> >  ++++++++++++++++++++++++++++++
> >  5 files changed, 354 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/clone/clone08.c
> > 
> > diff --git a/runtest/ltplite b/runtest/ltplite
> > index 2382dec..fe6cb04 100644
> > --- a/runtest/ltplite
> > +++ b/runtest/ltplite
> > @@ -127,6 +127,7 @@ clone04 clone04
> >  clone05 clone05
> >  clone06 clone06
> >  clone07 clone07
> > +clone08 clone08
> >  
> >  close01 close01
> >  close02 close02
> > diff --git a/runtest/stress.part3 b/runtest/stress.part3
> > index 16247e9..16b08a7 100644
> > --- a/runtest/stress.part3
> > +++ b/runtest/stress.part3
> > @@ -68,6 +68,7 @@ clone04 clone04
> >  clone05 clone05
> >  clone06 clone06
> >  clone07 clone07
> > +clone08 clone08
> >  
> >  close01 close01
> >  close02 close02
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 717342e..a17fec7 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -85,6 +85,7 @@ clone04 clone04
> >  clone05 clone05
> >  clone06 clone06
> >  clone07 clone07
> > +clone08 clone08
> >  
> >  close01 close01
> >  close02 close02
> > diff --git a/testcases/kernel/syscalls/.gitignore
> > b/testcases/kernel/syscalls/.gitignore
> > index bbefb25..91cf0f1 100644
> > --- a/testcases/kernel/syscalls/.gitignore
> > +++ b/testcases/kernel/syscalls/.gitignore
> > @@ -65,6 +65,7 @@
> >  /clone/clone05
> >  /clone/clone06
> >  /clone/clone07
> > +/clone/clone08
> >  /close/close01
> >  /close/close02
> >  /close/close08
> > diff --git a/testcases/kernel/syscalls/clone/clone08.c
> > b/testcases/kernel/syscalls/clone/clone08.c
> > new file mode 100644
> > index 0000000..19b47c8
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/clone/clone08.c
> > @@ -0,0 +1,350 @@
> > +/*
> > + * Copyright (c) 2013 Fujitsu Ltd.
> > + * Author: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of version 2 of the GNU General Public License as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it would be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + */
> > +
> > +#include <errno.h>
> > +#include <linux/sched.h>
> > +#include <sched.h>
> > +#include <sys/wait.h>
> > +#include "test.h"
> > +#include "usctest.h"
> > +#include "clone_platform.h"
> > +#include "safe_macros.h"
> > +#include "linux_syscall_numbers.h"
> > +
> > +#define BUFSIZE 512
> > +
> > +static pid_t parent_ppid;
> > +static pid_t ptid, ctid;
> > +static pid_t tgid;
> > +static void *child_stack;
> > +static int tst_result;
> > +
> > +static void setup(void);
> > +static void cleanup(void);
> > +
> > +static void do_master_child_setup(void);
> > +static void do_master_child(int i);
> > +static void wait_child(pid_t child, int index);
> > +
> > +static int child_clone_parent(void);
> > +
> > +static int child_clone_child_settid(void);
> > +static int child_clone_parent_settid(void);
> > +
> > +static int child_clone_thread(void);
> > +static int check_clone_thread_terminated(pid_t tgid);
> > +static int get_threas_num(pid_t tgid);
> > +
> > +#ifdef CLONE_STOPPED
> > +static int stopped_flag;
> > +static void test_clone_stopped(int tid);
> > +static int child_clone_stopped(void);
> > +#endif
> > +
> > +static struct test_case {
> > +	char *name;
> > +	int flags;
> > +	void (*testfunc)(int);
> > +	int (*do_child)();
> > +} test_cases[] = {
> > +	{"CLONE_PARENT", CLONE_PARENT | SIGCHLD, NULL, child_clone_parent},
> > +	{"CLONE_CHILD_SETTID", CLONE_CHILD_SETTID | CLONE_VM | SIGCHLD, NULL,
> > +	 child_clone_child_settid},
> > +	{"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | CLONE_VM | SIGCHLD, NULL,
> > +	 child_clone_parent_settid},
> > +#ifdef CLONE_STOPPED
> > +	{"CLONE_STOPPED", CLONE_STOPPED | CLONE_VM | SIGCHLD,
> > +	 test_clone_stopped, child_clone_stopped},
> > +#endif
> > +	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM | SIGCHLD,
> > +	 NULL, child_clone_thread},
> > +};
> > +
> > +char *TCID = "clone08";
> > +int TST_TOTAL = ARRAY_SIZE(test_cases);
> > +
> > +int main(int ac, char **av)
> > +{
> > +	int lc;
> > +	char *msg;
> > +	int i;
> > +	pid_t child;
> > +
> > +	msg = parse_opts(ac, av, NULL, NULL);
> > +	if (msg != NULL)
> > +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> > +
> > +	setup();
> > +
> > +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > +
> > +		tst_count = 0;
> > +
> > +		for (i = 0; i < TST_TOTAL; i++) {
> > +
> > +			fflush(stdout);
> > +
> > +			child = FORK_OR_VFORK();
> > +			if (child < 0) {
> > +				tst_brkm(TBROK, cleanup, "Fork failed");
> > +			} else if (child == 0) {
> > +				do_master_child(i);
> > +			} else {
> > +				wait_child(child, i);
> > +				/*
> > +				 * for CLONE_PARENT, we need to wait twice and
> > +				 * ignore CLONE_PARENT thread return status.
> > +				 */
> > +				if (test_cases[i].flags & CLONE_PARENT)
> > +					wait_child(child, i);
> > +			}
> > +		}
> > +	}
> > +
> > +	cleanup();
> > +
> > +	tst_exit();
> > +}
> > +
> > +static void do_master_child_setup(void)
> > +{
> > +	parent_ppid = getppid();
> > +
> > +	tgid = ltp_syscall(__NR_getpid);
> > +
> > +	tst_result = TFAIL;
> > +
> > +#ifdef CLONE_STOPPED
> > +	stopped_flag = 0;
> > +#endif
> > +}
> > +
> > +static void do_master_child(int i)
> > +{
> > +	int status;
> > +
> > +	do_master_child_setup();
> > +
> > +	TEST(ltp_clone(test_cases[i].flags, test_cases[i].do_child, NULL,
> > +		       CHILD_STACK_SIZE, child_stack, &ptid, NULL, &ctid));
> > +
> > +	if (TEST_RETURN == -1)
> > +		exit(TBROK);
> > +
> > +	if (test_cases[i].testfunc != NULL)
> > +		test_cases[i].testfunc(TEST_RETURN);
> > +
> > +	if (test_cases[i].flags & CLONE_PARENT) {
> > +		/*
> > +		 * parent process will wait CLONE_PARENT thread to
> > +		 * get test result.
> > +		 */
> > +		exit(0);
> > +	} else if (test_cases[i].flags & CLONE_THREAD) {
> > +		int ret;
> > +
> > +		ret = check_clone_thread_terminated(tgid);
> > +		if (ret == 0) {
> > +			fprintf(stderr,
> > +				"CLONE_THREAD thread does't terminated in "
> > +				"time\n");
> > +			exit(TBROK);
> > +		}
> > +	} else {
> > +		if (wait(&status) == -1) {
> > +			fprintf(stderr, "%s wait failed in do_master_child\n",
> > +				test_cases[i].name);
> > +			exit(TBROK);
> > +		}
> > +	}
> > +
> > +	exit(tst_result);
> > +}
> > +
> > +void show_test_result(int status, int index)
> > +{
> > +	int ret;
> > +
> > +	if (WIFEXITED(status)) {
> > +		ret = WEXITSTATUS(status);
> > +		if (ret == TPASS || ret == TFAIL) {
> > +			tst_resm(ret, "test %s %s", test_cases[index].name,
> > +				 ret ? "failed" : "success");
> > +		} else {
> > +			tst_brkm(TBROK, cleanup, "test %s failed",
> > +				 test_cases[index].name);
> > +		}
> > +	} else {
> > +		tst_brkm(TBROK, cleanup, "%s clone() exit abnormally",
> > +			 test_cases[index].name);
> > +	}
> > +}
> > +
> > +static void wait_child(pid_t child, int index)
> > +{
> > +	int status;
> > +	pid_t exit_pid;
> > +
> > +	exit_pid = wait(&status);
> > +	if (exit_pid == -1) {
> > +		tst_brkm(TBROK | TERRNO, cleanup, "%s wait failed",
> > +			 test_cases[index].name);
> > +	} else if (test_cases[index].flags & CLONE_PARENT) {
> > +		if (exit_pid != child)
> > +			show_test_result(status, index);
> > +	} else {
> > +		show_test_result(status, index);
> > +	}
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	tst_sig(FORK, DEF_HANDLER, cleanup);
> > +
> > +	TEST_PAUSE;
> > +
> > +	tst_tmpdir();
> > +
> > +	child_stack = SAFE_MALLOC(NULL, CHILD_STACK_SIZE);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	free(child_stack);
> > +
> > +	tst_rmdir();
> > +
> > +	TEST_CLEANUP;
> > +}
> > +
> > +static int child_clone_parent(void)
> > +{
> > +	if (parent_ppid == getppid())
> > +		tst_result = TPASS;
> > +	else
> > +		tst_result = TFAIL;
> > +	exit(tst_result);
> > +}
> > +
> > +static int child_clone_child_settid(void)
> > +{
> > +	if (ctid == getpid())
> > +		tst_result = TPASS;
> > +	else
> > +		tst_result = TFAIL;
> > +
> > +	exit(tst_result);
> > +}
> > +
> > +static int child_clone_parent_settid(void)
> > +{
> > +	if (ptid == getpid())
> > +		tst_result = TPASS;
> > +	else
> > +		tst_result = TFAIL;
> > +
> > +	exit(tst_result);
> > +}
> > +
> > +#ifdef CLONE_STOPPED
> > +static void test_clone_stopped(int tid)
> > +{
> > +	int i;
> > +
> > +	/* give the kernel scheduler chance to run the CLONE_STOPPED thread*/
> > +	for (i = 0; i < 100; i++) {
> > +		sched_yield();
> > +		usleep(1000);
> > +	}
> > +	/*
> > +	 * if stopped_flag is not changed in the above time interval,
> > +	 * we think the CLONE_STOPPED thread is stopped.
> > +	 */
> > +	if (stopped_flag == 1)
> > +		tst_result = TFAIL;
> > +	else
> > +		tst_result = TPASS;
> > +
> > +	if (kill(tid, SIGCONT) != 0) {
> > +		fprintf(stderr, "kill SIGCONT failed\n");
> > +		tst_result = TBROK;
> > +	}
> > +}
> > +
> > +static int child_clone_stopped(void)
> > +{
> > +	stopped_flag = 1;
> > +	exit(tst_result);
> > +}
> > +#endif
> > +
> > +/* check whether CLONE_THREAD thread was terminated */
> > +static int check_clone_thread_terminated(pid_t tgid)
> > +{
> > +	int i;
> > +	int num;
> > +
> > +	for (i = 0; i < 5000; i++) {
> > +		num = get_threas_num(tgid);
> > +		if (num == 1)
> > +			return 1;
> > +		sched_yield();
> > +		usleep(1000);
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int get_threas_num(pid_t tgid)
> > +{
> > +	FILE *fp;
> > +	int ret;
> > +	char com[BUFSIZE];
> > +	int thread_nums;
> > +
> > +	ret = sprintf(com, "ls /proc/%d/task/ | wc -l", tgid);
> > +	if (ret < 0) {
> > +		fprintf(stderr, "sprintf failed\n");
> > +		exit(TBROK);
> > +	}
> > +
> > +	fp = popen(com, "r");
> > +	if (!fp) {
> > +		fprintf(stderr, "run:ls /proc/%d/task/ | wc -l failed\n", tgid);
> > +		exit(TBROK);
> > +	}
> > +
> > +	ret = fscanf(fp, "%d", &thread_nums);
> > +	if (ret != 1) {
> > +		fprintf(stderr,
> > +			"could not get the numbers of threads in current "
> > +			"thread group\n");
> > +		exit(TBROK);
> > +	}
> > +	pclose(fp);
> > +	return thread_nums;
> > +}
> > +
> > +static int child_clone_thread(void)
> > +{
> > +	if (tgid == ltp_syscall(__NR_getpid))
> > +		tst_result = TPASS;
> > +	else
> > +		tst_result = TFAIL;
> > +
> > +	ltp_syscall(__NR_exit, 0);
> > +	return 0;
> > +}
> > --
> > 1.8.3.1
> > 
> > 
> > 
> > 



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
