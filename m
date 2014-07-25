Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XAcGo-00045D-Mk
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 09:58:34 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAcGn-0002xw-4M
	for ltp-list@lists.sourceforge.net; Fri, 25 Jul 2014 09:58:34 +0000
Date: Fri, 25 Jul 2014 05:58:22 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <852230347.15187943.1406282302593.JavaMail.zimbra@redhat.com>
In-Reply-To: <53D216D0.6010706@oracle.com>
References: <428ab3048d90dc9d998143aea2b2a624b43d5220.1406276230.git.jstancek@redhat.com>
	<53D216D0.6010706@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sched_setaffinity01: use ltp_syscall
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
To: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: "Jan Stancek" <jstancek@redhat.com>, ltp-list@lists.sourceforge.net
> Cc: "wangxg fnst" <wangxg.fnst@cn.fujitsu.com>
> Sent: Friday, 25 July, 2014 10:35:28 AM
> Subject: Re: [PATCH] sched_setaffinity01: use ltp_syscall
> 
> 
> 
> On 07/25/2014 12:18 PM, Jan Stancek wrote:
> > Using glibc wrapper on kernel with smaller CONFIG_NR_CPUS (for example
> > 255) leads to segmentation fault in glibc, because it triggers check,
> > which is verifying that there are no bits set beyond size of kernel cpu
> > mask:
> >
> > int
> > __sched_setaffinity_new (pid_t pid, size_t cpusetsize, const cpu_set_t
> > *cpuset)
> >    ...
> >    /* We now know the size of the kernel cpumask_t.  Make sure the user
> >       does not request to set a bit beyond that.  */
> >    for (size_t cnt = __kernel_cpumask_size; cnt < cpusetsize; ++cnt)
> >      if (((char *) cpuset)[cnt] != '\0') --> CRASH HERE
> >
> > Call this syscall directly with ltp_syscall().
> >
> > Reported-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Acked-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Pushed.

Regards,
Jan

> 
> 
> > ---
> >   .../sched_setaffinity/sched_setaffinity01.c        |   11 ++++++++---
> >   1 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> > b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> > index 0ac4478..33a90b8 100644
> > --- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> > +++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
> > @@ -42,6 +42,7 @@
> >   #include "usctest.h"
> >   #include "safe_macros.h"
> >   #include "sched_setaffinity.h"
> > +#include "linux_syscall_numbers.h"
> >
> >   char *TCID = "sched_setaffinity01";
> >
> > @@ -151,9 +152,13 @@ int main(int argc, char *argv[])
> >   	for (lc = 0; TEST_LOOPING(lc); lc++) {
> >   		tst_count = 0;
> >   		for (i = 0; i < TST_TOTAL; i++) {
> > -			TEST(sched_setaffinity(*(test_cases[i].pid),
> > -						*(test_cases[i].mask_size),
> > -						*(test_cases[i].mask)));
> > +			/* Avoid calling glibc wrapper function, as it may
> > +			 * try to read/validate data in cpu mask. This test
> > +			 * is passing invalid pointer on purpose. */
> > +			TEST(ltp_syscall(__NR_sched_setaffinity,
> > +				*(test_cases[i].pid),
> > +				*(test_cases[i].mask_size),
> > +				*(test_cases[i].mask)));
> >
> >   			if (TEST_RETURN != -1)
> >   				tst_resm(TFAIL,
> >
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
