Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9jAV-0007p1-4v
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:17:59 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9jAU-0007EI-1L
	for ltp-list@lists.sourceforge.net; Wed, 05 May 2010 18:17:59 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100505124335.GA11888@linux.vnet.ibm.com>
References: <1273050496.26977.19.camel@lishuang-desktop>
	<20100505124335.GA11888@linux.vnet.ibm.com>
Date: Wed, 05 May 2010 23:47:44 +0530
Message-Id: <1273083465.13463.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ltp sysctl03 testcase failed in version of 20100228
Reply-To: subrata@linux.vnet.ibm.com
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Wed, 2010-05-05 at 18:13 +0530, Rishikesh K Rajak wrote:
> On Wed, May 05, 2010 at 05:08:16PM +0800, Henry xu wrote:
> > Hi,all
> > I test sysctl03 in x86 and ppc platform and product the same fails as
> > below.
> > 
> > 
> > root@z530:/opt/ltp-full/testcases/bin> ./sysctl03 
> > sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
> > sysctl03    2  TFAIL  :  Expected EPERM, got 13
> > 
> 
> Can you try with latest April month LTP ?

Nothing has changed there either:

<<<test_start>>>
tag=sysctl03 stime=1273083251
cmdline="sysctl03"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
sysctl03    1  TFAIL  :  Expected EPERM (1), got 13: Permission denied
sysctl03    2  TFAIL  :  Expected EPERM, got 13
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20100430
        
       ###############################################################"
        
            Done executing testcases."
            LTP Version:  LTP-20100430
       ###############################################################"
       
# uname -a
Linux 2.6.33.1-19.fc13.ppc64 #1 SMP Tue Mar 23 06:32:38 EDT 2010 ppc64
ppc64 ppc64 GNU/Linux

Regards--
Subrata

> 
> > The case expects to return EPERM,however return EACCES.
> > 
> > My kernel version is 2.6.34 .I think it could be caused  by high version
> > kernel .Since in the past kernel of 2.6.27,there is not the fail.And I
> > find the same issue of the case on the internet.It gives a patch,but I
> > find  the patch is not merged in the newest ltp version .
> > 
> > I want to know whether the isuue is known or not.
> > 
> > thanks!
> > 
> > ------------------------------------------------------------------------------
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
