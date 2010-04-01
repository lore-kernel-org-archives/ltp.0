Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NxGoK-0008WS-NT
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 09:35:36 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxGoG-00012a-Vk
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 09:35:36 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o319SXu8004228
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 03:28:33 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o319ZER4048322
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 03:35:17 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o319ZEc0028872
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 03:35:14 -0600
Date: Thu, 1 Apr 2010 15:05:11 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100401093511.GA25290@linux.vnet.ibm.com>
References: <000001cad173$3c32b200$b4981600$@co.jp>
	<20100401083510.GD13796@linux.vnet.ibm.com>
	<000101cad17c$ee4946d0$cadbd470$@co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <000101cad17c$ee4946d0$cadbd470$@co.jp>
Subject: Re: [LTP] cap_bounds_r.c build failure
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Thu, Apr 01, 2010 at 06:23:03PM +0900, Mitani wrote:
> Hi Rishi,
> 
> 
> "libcap-devel" was not installed in my system.
> 
> ------------
> [root@RHEL4-8 mitani]# rpm -qa | grep libcap
> libcap-1.10-20
> [root@RHEL4-8 mitani]#
> ------------
> 
> I'm trying to install libcap-devel now.

Ok, make sure you configure once again the source code after installing libcap-devel rpm.

-Rishi
> 
> 
> Thanks--
> 
> -Tomonori Mitani
> 
> > -----Original Message-----
> > From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com]
> > Sent: Thursday, April 01, 2010 5:35 PM
> > To: Mitani
> > Cc: ltp-list@lists.sourceforge.net
> > Subject: Re: [LTP] cap_bounds_r.c build failure
> > 
> > Hi  Mitani,
> > 
> > Can you confirm if you have installed libcap-devel ? As i see this is
> > defined
> > under linux/capability.h .
> > 
> > #define CAP_MAC_ADMIN        33
> > 
> > #define CAP_LAST_CAP         CAP_MAC_ADMIN
> > 
> > #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
> > 
> > 
> > Which unltimately is being called by sys/capability.h .
> > 
> > 
> > FYI, I did not get any compilation error on SLES11GA where:
> > 
> > libcap2-2.11-2.15
> > libcap-devel-2.11-2.15
> > 
> > -Rishi
> > 
> > 
> > On Thu, Apr 01, 2010 at 05:13:39PM +0900, Mitani wrote:
> > > Hi,
> > >
> > > I tried to build by using yesterday's git.
> > >  (ltp-dev-02719d6f7e5cb252c0fcbfbaf26208d7196e46f2.tar.gz)
> > > But build failed in "cap_bounds_r.c" with following message.
> > >
> > > ------------
> > > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> > > -I/home/LTP/ltp-dev-20100401/testcases/kernel/include
> > -I../../../../include
> > > -I../../../../include   -L../../../../lib  cap_bounds_r.c
> > -lltp -lcap -o
> > > cap_bounds_r
> > > cap_bounds_r.c: In function `main':
> > > cap_bounds_r.c:46: error: `CAP_LAST_CAP' undeclared (first use in
> > this
> > > function)
> > > cap_bounds_r.c:46: error: (Each undeclared identifier is reported
> > only once
> > > cap_bounds_r.c:46: error: for each function it appears in.)
> > > make[4]: *** [cap_bounds_r] Error 1
> > > ------------
> > >
> > > I tried to today's git, but it failed, too.
> > >  (ltp-dev-44fba94453ca4f446cde4db08b0a760862b55cfa.tar.gz)
> > >
> > >
> > > I referd this source's diff in following URL.
> > >
> > http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=
> > commitdiff
> > > ;h=6e3dd83d9f575d98d76b8b3f642ad6e8793dbdfc
> > >
> > > "CAP_LAST_CAP" definition is deleted with other definitions in this
> > > revision.
> > > But "CAP_LAST_CAP" is still used after edited version.
> > >
> > > "The editor may have deleted too much to make this source simple?"
> > > I think. ;-)
> > >
> > >
> > > There is same problem in "cap_bounds_rw.c", too.
> > >
> > >
> > > How about following patch?
> > >
> > >
> > > Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> > >
> > > Index: ./testcases/kernel/security/cap_bound/cap_bounds_r.c
> > > ============
> > > --- ./testcases/kernel/security/cap_bound/cap_bounds_r.c
> > 2010-03-31
> > > 22:44:52.000000000 +0900
> > > +++ ./testcases/kernel/security/cap_bound/cap_bounds_r.c.new
> > 2010-04-01
> > > 15:43:01.000000000 +0900
> > > @@ -32,6 +32,13 @@
> > >  #include <sys/prctl.h>
> > >  #include <test.h>
> > >
> > > +#if HAVE_SYS_CAPABILITY_H
> > > +#ifndef CAP_LAST_CAP
> > > +#warning out-of-date capability.h does not define CAP_LAST_CAP
> > > +#define CAP_LAST_CAP 28  /* be ultra-conservative */
> > > +#endif
> > > +#endif
> > > +
> > >  char *TCID = "cap_bounds_r";
> > >  int TST_TOTAL=1;
> > >
> > > ============
> > >
> > > Index: ./testcases/kernel/security/cap_bound/cap_bounds_rw.c
> > > ============
> > > --- ./testcases/kernel/security/cap_bound/cap_bounds_rw.c
> > 2010-03-31
> > > 22:44:52.000000000 +0900
> > > +++ ./testcases/kernel/security/cap_bound/cap_bounds_rw.c.new
> > 2010-04-01
> > > 15:44:39.000000000 +0900
> > > @@ -31,6 +31,13 @@
> > >  #include <sys/prctl.h>
> > >  #include <test.h>
> > >
> > > +#if HAVE_SYS_CAPABILITY_H
> > > +#ifndef CAP_LAST_CAP
> > > +#warning out-of-date capability.h does not define CAP_LAST_CAP
> > > +#define CAP_LAST_CAP 28  /* be ultra-conservative */
> > > +#endif
> > > +#endif
> > > +
> > >  char *TCID = "cap_bounds_rw";
> > >  int TST_TOTAL=1;
> > >
> > > ============
> > >
> > >
> > > Regards--
> > >
> > > -Tomonori Mitani
> > >
> > >
> > >
> > >
> > ------------------------------------------------------------------
> > ------------
> > > Download Intel&#174; Parallel Studio Eval
> > > Try the new software tools for yourself. Speed compiling, find bugs
> > > proactively, and fine-tune applications for parallel performance.
> > > See why Intel Parallel Studio got high marks during beta.
> > > http://p.sf.net/sfu/intel-sw-dev
> > > _______________________________________________
> > > Ltp-list mailing list
> > > Ltp-list@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> > --
> > Thanks & Regards
> > Rishi
> > LTP Maintainer
> > IBM, LTC, Bangalore
> > Please join IRC #ltp @ irc.freenode.net
> 

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
