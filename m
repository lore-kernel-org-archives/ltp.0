Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UV1t8-0002Kq-8K
	for ltp-list@lists.sourceforge.net; Wed, 24 Apr 2013 15:45:42 +0000
Date: Wed, 24 Apr 2013 17:46:35 +0200
From: chrubis@suse.cz
Message-ID: <20130424154635.GA11115@rei.suse.cz>
References: <87c63b9c1371d07c7efce77a68ec459d6c51fbdf.1366639814.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87c63b9c1371d07c7efce77a68ec459d6c51fbdf.1366639814.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] setns01: add CLONE_NEWUSER to test
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

Hi!
> This adds user type namespaces to errno test. Noteworthy difference
> is in testcase 4, because re-entering this type of namespace is not
> allowed. Test spawns a child, which will have different user ID than
> parent calling setns().
> 
> CLONE_NEWUSER flag will be used in test only if kernel is compiled
> with CONFIG_USER_NS=y and provides /proc/<pid>/ns/user.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/setns/setns.h   |    3 +
>  testcases/kernel/syscalls/setns/setns01.c |   77 ++++++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
> index 23bdb2e..df64013 100644
> --- a/testcases/kernel/syscalls/setns/setns.h
> +++ b/testcases/kernel/syscalls/setns/setns.h
> @@ -76,6 +76,9 @@ static void init_available_ns(void)
>  #if defined(CLONE_NEWUTS)
>  	init_ns_type(CLONE_NEWUTS, "uts");
>  #endif
> +#if defined(CLONE_NEWUSER)
> +	init_ns_type(CLONE_NEWUSER, "user");
> +#endif
>  }
>  
>  static void close_ns_fds(void)
> diff --git a/testcases/kernel/syscalls/setns/setns01.c b/testcases/kernel/syscalls/setns/setns01.c
> index 74525b9..179f574 100644
> --- a/testcases/kernel/syscalls/setns/setns01.c
> +++ b/testcases/kernel/syscalls/setns/setns01.c
> @@ -28,6 +28,7 @@
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> +#include <sys/wait.h>
>  #include <errno.h>
>  #include <sched.h>
>  #include <pwd.h>
> @@ -42,6 +43,7 @@ char *TCID = "setns01";
>  
>  #if defined(__NR_setns)
>  #include "setns.h"
> +#define CHILD_STACK_SIZE (1024*1024)
>  
>  struct testcase_t {
>  	const char *msg;
> @@ -50,6 +52,9 @@ struct testcase_t {
>  	int exp_ret;
>  	int exp_errno;
>  	int skip;
> +	int child_pid;
> +	void *child_stack;
> +	int pipefd[2];
>  	void (*setup) (struct testcase_t *, int i);
>  	void (*cleanup) (struct testcase_t *);
>  };
> @@ -105,6 +110,17 @@ static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
>  static const char nobody_uid[] = "nobody";
>  static struct passwd *ltpuser;
>  
> +static void wait4child(int child_pid)
> +{
> +	int status;
> +	if (waitpid(child_pid, &status, 0) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +		tst_resm(TFAIL, "child returns %d", status);
> +	else
> +		tst_resm(TPASS, "child finished succesfully");
> +}
> +
>  static void setup0(struct testcase_t *t, int i)
>  {
>  	t->ns_type = ns_types[i];
> @@ -140,19 +156,76 @@ static void setup3(struct testcase_t *t, int i)
>  	t->ns_type = ns_types[(i+1) % ns_total];
>  }
>  
> +static int do_child04(void *arg)
> +{
> +	int dummy;
> +	struct testcase_t *t = (struct testcase_t *) arg;
> +
> +	read(t->pipefd[0], &dummy, 1);
> +	return 0;
> +}
> +
>  static void setup4(struct testcase_t *t, int i)
>  {
> -	if (seteuid(ltpuser->pw_uid) == -1)
> -		tst_brkm(TBROK | TERRNO, NULL, "seteuid failed");
> +	int tmp, ns_user_fd;
>  
>  	t->fd = ns_fds[i];
>  	t->ns_type = ns_types[i];
> +	t->child_stack = NULL;
> +	t->child_pid = 0;
> +
> +#if defined(CLONE_NEWUSER)
> +	/* re-entering same user ns is not allowed, we need new one */
> +	ns_user_fd = get_ns_fd(getpid(), "user");
> +	if (t->ns_type == CLONE_NEWUSER && ns_user_fd != -1) {
> +		t->child_stack = malloc(CHILD_STACK_SIZE);
> +		if (t->child_stack == NULL)
> +			tst_brkm(TBROK, cleanup, "Cannot allocate stack");
> +
> +		if (pipe(t->pipefd) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "pipe");
> +
> +		tmp = ltp_clone(SIGCHLD|CLONE_NEWUSER, do_child04, t,
> +			CHILD_STACK_SIZE, t->child_stack);
> +		if (tmp == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "ltp_clone");
> +		t->child_pid = tmp;
> +
> +		t->fd = get_ns_fd(t->child_pid, "user");
> +		tst_resm(TINFO, "child's ns/user fd %d", t->fd);
> +		if (t->fd == -1) {
> +			write(t->pipefd[1], &tmp, 1);

Passing random variable to the write is little confusing. I would rather
do something as:

write(t->pipefd[1], "", 1);


> +			wait4child(t->child_pid);
> +			tst_brkm(TBROK, cleanup, "could not open child's"
> +				"/proc/pid/ns/user");
> +		}
> +	}
> +	close(ns_user_fd);
> +#endif
> +	if (seteuid(ltpuser->pw_uid) == -1) {
> +		if (t->child_pid) {
> +			tmp = errno;
> +			write(t->pipefd[1], &tmp, 1);
> +			wait4child(t->child_pid);
> +			errno = tmp;
> +		}
> +		tst_brkm(TBROK | TERRNO, cleanup, "seteuid failed");
> +	}
>  }
>  
>  static void cleanup4(struct testcase_t *t)
>  {
>  	if (seteuid(0) == -1)
>  		tst_brkm(TBROK | TERRNO, NULL, "seteuid restore failed");
> +	if (t->child_pid) {
> +		/* signal child to exit */
> +		write(t->pipefd[1], t, 1);

Here as well.

> +		wait4child(t->child_pid);
> +		free(t->child_stack);
> +		close(t->fd);
> +		close(t->pipefd[0]);
> +		close(t->pipefd[1]);
> +	}
>  }

The rest of the code is OK.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
