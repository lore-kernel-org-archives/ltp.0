Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WmMU5-0003Qs-B2
	for ltp-list@lists.sourceforge.net; Mon, 19 May 2014 12:16:01 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WmMU4-0002Gr-2d
	for ltp-list@lists.sourceforge.net; Mon, 19 May 2014 12:16:01 +0000
Date: Mon, 19 May 2014 08:15:45 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2020736027.7623534.1400501745312.JavaMail.zimbra@redhat.com>
In-Reply-To: <53796394.8030906@cn.fujitsu.com>
References: <1400463915-15572-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1400463915-15572-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<53796394.8030906@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3 2/2] setpgid/setpgid01.c: add pid = 0 and pgid
 = 0 test
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
Cc: LTP <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Xiaoguang Wang" <wangxg.fnst@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "LTP" <ltp-list@lists.sourceforge.net>
> Sent: Monday, 19 May, 2014 3:51:16 AM
> Subject: Re: [PATCH v3 2/2] setpgid/setpgid01.c: add pid = 0 and pgid = 0 test
> 
> Hi Jan,
> 
>     Thanks for your reviewing.
>     I have added the possible error message output in this patch v3.

Hi,

looks good to me.

Reviewed-by: Jan Stancek <jstancek@redhat.com>

>    Would you like to commit it, thanks.

Let's give it a day or two in case someone else wants to comment as well.

Regards,
Jan

> 
> Regards,
> Xiaoguang Wang
> 
> On 05/19/2014 09:45 AM, Xiaoguang Wang wrote:
> > Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> > ---
> >  testcases/kernel/syscalls/setpgid/setpgid01.c | 54
> >  ++++++++++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c
> > b/testcases/kernel/syscalls/setpgid/setpgid01.c
> > index 700e573..00e895b 100644
> > --- a/testcases/kernel/syscalls/setpgid/setpgid01.c
> > +++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
> > @@ -36,12 +36,14 @@
> >   * Description:
> >   * Verify that:
> >   *   1. Basic functionality test for setpgid(2).
> > + *   2. Check functioning of setpgid(2) with pid = 0 and pgid = 0.
> >   */
> >  
> >  #include <errno.h>
> >  #include <string.h>
> >  #include <signal.h>
> >  #include <stdlib.h>
> > +#include <sys/wait.h>
> >  #include "test.h"
> >  #include "usctest.h"
> >  
> > @@ -51,7 +53,8 @@ static void cleanup(void);
> >  char *TCID = "setpgid01";
> >  
> >  static void setpgid_test1(void);
> > -static void (*testfunc[])(void) = { setpgid_test1};
> > +static void setpgid_test2(void);
> > +static void (*testfunc[])(void) = { setpgid_test1, setpgid_test2};
> >  int TST_TOTAL = ARRAY_SIZE(testfunc);
> >  
> >  int main(int ac, char **av)
> > @@ -91,9 +94,56 @@ static void setpgid_test1(void)
> >  	}
> >  }
> >  
> > +static int wait4child(pid_t child)
> > +{
> > +	int status;
> > +
> > +	if (waitpid(child, &status, 0) == -1)
> > +		tst_resm(TBROK|TERRNO, "waitpid");
> > +	if (WIFEXITED(status))
> > +		return WEXITSTATUS(status);
> > +	else
> > +		return status;
> > +}
> > +
> > +static void setpgid_test2(void)
> > +{
> > +	int ret;
> > +	pid_t pgid, pid;
> > +
> > +	pid = FORK_OR_VFORK();
> > +	if (pid == -1)
> > +		tst_brkm(TBROK | TERRNO, cleanup, "fork()");
> > +
> > +	if (pid != 0) {
> > +		ret = wait4child(pid);
> > +	} else {
> > +		pid = getpid();
> > +		TEST(setpgid(0, 0));
> > +		pgid = getpgrp();
> > +		if (TEST_RETURN == -1) {
> > +			fprintf(stderr, "setpgid(0, 0) fails in "
> > +				"child process: %s\n", strerror(TEST_ERRNO));
> > +			exit(1);
> > +		} else if (pgid != pid) {
> > +			fprintf(stderr, "setpgid(0, 0) fails to make PGID"
> > +				"equal to PID\n");
> > +			exit(1);
> > +		} else {
> > +			exit(0);
> > +		}
> > +	}
> > +
> > +	if (ret == 0)
> > +		tst_resm(TPASS, "test setpgid(0, 0) success");
> > +	else
> > +		tst_resm(TFAIL, "test setpgid(0, 0) fail");
> > +}
> > +
> > +
> >  static void setup(void)
> >  {
> > -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > +	tst_sig(FORK, DEF_HANDLER, cleanup);
> >  
> >  	TEST_PAUSE;
> >  }
> 
> 

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
