Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X99WQ-000832-FZ
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:04:38 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X99WO-0000Dc-Ug
	for ltp-list@lists.sourceforge.net; Mon, 21 Jul 2014 09:04:38 +0000
Date: Mon, 21 Jul 2014 05:04:27 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <38788431.12648558.1405933467675.JavaMail.zimbra@redhat.com>
In-Reply-To: <1405419229-4222-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1405419229-4222-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1405419229-4222-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for
 getcwd(2)
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
Cc: ltp-list@lists.sourceforge.net, Artem Savkov <asavkov@redhat.com>




----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 15 July, 2014 12:13:49 PM
> Subject: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for getcwd(2)
> 
> Note: this test has already been in xfstests generic/028 test case,
> I just port it to LTP.
> 
> Kernel commit '232d2d60aa5469bb097f55728f65146bd49c1d25' introduced a race
> condition that causes getcwd(2) to return "/" instead of correct path.
>     232d2d6 dcache: Translating dentry into pathname without
>             taking rename_lock
> 
> And these two kernel commits have fixed this bug:
>   ede4cebce16f5643c61aedd6d88d9070a1d23a68
>      prepend_path() needs to reinitialize dentry/vfsmount/mnt on restarts
>   f6500801522c61782d4990fa1ad96154cb397cd4
>      f650080 __dentry_path() fixes
> 
> This test is to check whether this bug exists in the running kernel,
> or whether this bug has been fixed.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>

Hi,

looks good to me.

> I have run this test case in RHEL7.0GA, Fedora19, v3.11-7758-g232d2d6 and 3.16.0-rc4+.
> RHEL7.0GA has this kernel bug, so this test case fails.

I can confirm this, with note that I've seen it happen only on systems with 2+ CPUs.

> + *
> + */
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "usctest.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +#define TIMEOUT	5
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void do_child(void);
> +static void sigproc(int sig);
> +static volatile sig_atomic_t end;
> +static char init_cwd[PATH_MAX];
> +
> +char *TCID = "getcwd04";
> +int TST_TOTAL = 1;
> +
> +int main(int ac, char **av)
> +{
> +	int status;
> +	const char *msg;
> +	char cur_cwd[PATH_MAX];
> +	pid_t child;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	child = tst_fork();
> +	if (child < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> +
> +	if (child == 0)
> +		do_child();
> +
> +	 while (1) {
> +		SAFE_GETCWD(cleanup, cur_cwd, PATH_MAX);
> +		if (strncmp(init_cwd, cur_cwd, PATH_MAX)) {
> +			tst_resm(TFAIL, "initial current work directory is "
> +				 "%s, now is %s. Bug is reproduced!",
> +				 init_cwd, cur_cwd);
> +			break;
> +		}
> +
> +		if (end) {
> +			tst_resm(TPASS, "Bug is not reproduced!");
> +			break;
> +		}
> +	}
> +
> +	SAFE_KILL(cleanup, child, SIGKILL);
> +	SAFE_WAITPID(cleanup, child, &status, 0);
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	if (signal(SIGALRM, sigproc) == SIG_ERR)
> +		tst_brkm(TBROK | TERRNO, cleanup, "signal(SIGALRM) failed");
> +
> +	alarm(TIMEOUT);
> +
> +	SAFE_MKDIR(cleanup, "testdir", 0755);
> +	SAFE_CHDIR(cleanup, "testdir");

Is this extra dir needed? tst_tmpdir will already make one.

Regards,
Jan

> +
> +	SAFE_GETCWD(cleanup, init_cwd, PATH_MAX);
> +}
> +
> +static void sigproc(int sig)
> +{
> +	end = sig;
> +}
> +
> +static void do_child(void)
> +{
> +	unsigned int i = 0;
> +	char c_name[PATH_MAX] = "testfile", n_name[PATH_MAX];
> +
> +	SAFE_TOUCH(NULL, c_name, 0644, NULL);
> +
> +	while (1) {
> +		snprintf(n_name, PATH_MAX, "testfile%u", i++);
> +		SAFE_RENAME(NULL, c_name, n_name);
> +		strncpy(c_name, n_name, PATH_MAX);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	tst_rmdir();
> +}
> --
> 1.8.2.1
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
