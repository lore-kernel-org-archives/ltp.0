Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UHnG7-0002PP-1A
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 03:30:43 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UHnG4-0003nX-Rd
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 03:30:43 +0000
Date: Mon, 18 Mar 2013 23:30:31 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1616407140.10102780.1363663831341.JavaMail.root@redhat.com>
In-Reply-To: <5147D723.2060001@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3 4/7] mm/oom0[3|4]: added 'OOM for CPUSET' and
 moved 'OOM with MEMCG & numa' to oom03
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Tuesday, March 19, 2013 11:10:27 AM
> Subject: Re: [LTP] [PATCH v3 4/7] mm/oom0[3|4]: added 'OOM for CPUSET' and moved 'OOM with MEMCG & numa' to oom03
> 
> On 03/18/2013 12:14 PM, Zhouping Liu wrote:
> > OOM with the combination of memcg & numa was moved to oom03,
> > and oom04 is re-design to be used to test 'OOM with CPUSET'.
> > 
> > also used is_numa() instead of the old method.
> > 
> > Signed-off-by: Zhouping Liu <zliu@redhat.com>
> > ---
> >  testcases/kernel/mem/oom/oom02.c |  6 ++--
> >  testcases/kernel/mem/oom/oom03.c | 20 ++++++++++++++
> >  testcases/kernel/mem/oom/oom04.c | 60
> >  +++++++++++++++-------------------------
> >  3 files changed, 46 insertions(+), 40 deletions(-)
> > 
> > diff --git a/testcases/kernel/mem/oom/oom02.c
> > b/testcases/kernel/mem/oom/oom02.c
> > index 31ec73f..3bc8567 100644
> > --- a/testcases/kernel/mem/oom/oom02.c
> > +++ b/testcases/kernel/mem/oom/oom02.c
> > @@ -35,6 +35,7 @@
> >  #include <errno.h>
> >  #include <fcntl.h>
> >  #include <stdio.h>
> > +#include "numa_helper.h"
> >  #include "test.h"
> >  #include "usctest.h"
> >  #include "mem.h"
> > @@ -44,7 +45,6 @@ int TST_TOTAL = 1;
> >  
> >  #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> >  	&& HAVE_MPOL_CONSTANTS
> > -#include <numaif.h>
> >  
> >  int main(int argc, char *argv[])
> >  {
> > @@ -83,8 +83,8 @@ void setup(void)
> >  	tst_sig(FORK, DEF_HANDLER, cleanup);
> >  	TEST_PAUSE;
> >  
> > -	/* Judge a NUMA system through get_a_numa_node */
> > -	get_a_numa_node(NULL);
> > +	if (!is_numa(NULL))
> > +		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
> >  
> >  	overcommit = get_sys_tune("overcommit_memory");
> >  	set_sys_tune("overcommit_memory", 1, 1);
> > diff --git a/testcases/kernel/mem/oom/oom03.c
> > b/testcases/kernel/mem/oom/oom03.c
> > index 95e34d5..c2171fd 100644
> > --- a/testcases/kernel/mem/oom/oom03.c
> > +++ b/testcases/kernel/mem/oom/oom03.c
> > @@ -33,6 +33,7 @@
> >  #include <errno.h>
> >  #include <fcntl.h>
> >  #include <stdio.h>
> > +#include "numa_helper.h"
> >  #include "test.h"
> >  #include "usctest.h"
> >  #include "mem.h"
> > @@ -40,6 +41,9 @@
> >  char *TCID = "oom03";
> >  int TST_TOTAL = 1;
> >  
> > +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> > +	&& HAVE_MPOL_CONSTANTS
> > +
> >  int main(int argc, char *argv[])
> >  {
> >  	char *msg;
> > @@ -76,6 +80,14 @@ int main(int argc, char *argv[])
> >  			write_file(MEMCG_SW_LIMIT, mem);
> >  			testoom(0, 1, 0);
> >  		}
> > +
> > +		/* OOM for MEMCG with mempolicy */
> > +		if (is_numa(cleanup)) {
> > +			tst_resm(TINFO, "OOM on MEMCG & mempolicy...");
> > +			testoom(MPOL_BIND, 0, 1);
> > +			testoom(MPOL_INTERLEAVE, 0, 1);
> > +			testoom(MPOL_PREFERRED, 0, 1);
> > +		}
> >  	}
> >  	cleanup();
> >  	tst_exit();
> > @@ -99,3 +111,11 @@ void cleanup(void)
> >  
> >  	TEST_CLEANUP;
> >  }
> > +
> > +#else
> > +int main(void)
> > +{
> > +	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
> > +}
> > +#endif
> > +
> 
> Here added a new line at EOF, if you want to just modify the patch,
> please remove this line, and change "@@ -99,3 +111,11" to "@@ -99,3
> +111,10".
> 

Wanlong, thanks for your reviewing, I will prepare V4.

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
