Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1O4B1T-0007iC-Ri
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 10:49:43 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4B1S-0008SM-St
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 10:49:43 +0000
Date: Tue, 20 Apr 2010 06:49:36 -0400 (EDT)
From: Caspar ZHANG <czhang@redhat.com>
Message-ID: <2135164550.562871271760576282.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <239293073.562841271760559982.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_21910_854512966.1271760576281"
Subject: Re: [LTP] [PATCH] Fix MSGCTL10() to avoid un-necessary cluttering
 of whole system with all PIDs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

------=_Part_21910_854512966.1271760576281
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


----- "Rishikesh K Rajak" <risrajak@linux.vnet.ibm.com> wrote:

> On Tue, Apr 20, 2010 at 06:00:13AM -0400, Caspar ZHANG wrote:
> > 
> > 
> > ----- "Subrata Modak" <subrata@linux.vnet.ibm.com> wrote:
> > 
> > > Hi,
> > > 
> > > msgctl10() un-necessarily eats up all the PIDs of the system
> leading
> > > to
> > > system becoming un-responsive. The changed no.s would better do
> the
> > > job.
> > 
> > Hi, I see this patch is not included in ltp-full-20100331, will it
> be 
> > accepted in the future? 
> 
> Thanks for testing this patch. can you put your Acked-By / Tested-By
> ?
> 
> After that it will be included in master branch immediately.

Sure, add Acked-by info in the attached patch.

Thanks,
Caspar

> 
> -Rishi
> > 
> > I tested msgctl10 testcase on RHEL5(2.6.18) and RHEL6(>2.6.31),
> > Since /proc/sys/kernel/msgmni has increased from 10 (RHEL5) to 
> > thousands (RHEL6), the testing time will be several hours long.
> > Applied this patch, the testing time can be lowed down to minutes.
> > 
> > Thanks,
> > Caspar
> > 
> > > 
> > > Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
> > > ---
> > > 
> > > ---
> > >
> ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c.orig
> > > 2010-02-19 17:59:23.000000000 +0530
> > > +++
> ltp-full-20100131/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
> > > 2010-02-19 18:01:13.000000000 +0530
> > > @@ -65,12 +65,8 @@ extern int Tst_count;		/* Test Case coun
> > >  
> > >  int exp_enos[] = { 0 };		/* List must end with 0 */
> > >  
> > > -#ifndef CONFIG_COLDFIRE
> > > -#define MAXNPROCS	1000000	/* This value is set to an arbitrary
> high
> > > limit. */
> > > -#else
> > > -#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
> > > -#endif
> > > -#define MAXNREPS	100000
> > > +#define MAXNPROCS	10000 	/*These should be sufficient*/
> > > +#define MAXNREPS	10000	/*Else they srewup the system
> > > un-necessarily*/
> > >  #define FAIL		1
> > >  #define PASS		0
> > >  
> > > 
> > > ---
> > > Regards--
> > > Subrata

-- 
Kernel Associate Quality Engineer
Red Hat Inc. (Beijing R&D Branch)

Red Hat China R&D Branch Unit 907, North Tower C, 
  Raycom Infotech Park, No.2 Kexueyuan Nanlu, 
  Haidian District, Beijing 100190

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_21910_854512966.1271760576281
Content-Type: text/x-patch; name=syscalls-msgctl10-decrease-proc-num.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=syscalls-msgctl10-decrease-proc-num.patch

Hi,

	msgctl10() un-necessarily eats up all the PIDs of the system leading to
	system becoming un-responsive. The changed no.s would better do the job.

	Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>
	Acked-by: Caspar Zhang<czhang@redhat.com>

---
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c	2010-04-15 18:55:19.857267414 +0800
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c	2010-04-15 18:56:53.943358977 +0800
@@ -65,12 +65,8 @@
 
 int exp_enos[] = { 0 };		/* List must end with 0 */
 
-#ifndef CONFIG_COLDFIRE
-#define MAXNPROCS	1000000	/* This value is set to an arbitrary high limit. */
-#else
-#define MAXNPROCS	 100000	/* Coldfire can't deal with 1000000 */
-#endif
-#define MAXNREPS	100000
+#define MAXNPROCS	10000	/* These should be sufficient */
+#define MAXNREPS	10000	/* Else they screw up the system un-necessarily */
 #define FAIL		1
 #define PASS		0
 

------=_Part_21910_854512966.1271760576281
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
------=_Part_21910_854512966.1271760576281
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_21910_854512966.1271760576281--

