Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NxEVf-0004Oi-CM
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 07:08:11 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxEVd-0002dZ-9e
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 07:08:11 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3171AU5002672
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 01:01:10 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o31782Us098362
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 01:08:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o31781Ol008046
	for <ltp-list@lists.sourceforge.net>; Thu, 1 Apr 2010 01:08:02 -0600
Date: Thu, 1 Apr 2010 12:37:58 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100401070758.GB13796@linux.vnet.ibm.com>
References: <E0B6230F32558E43951AF1B0DEBF98102119DC54EF@EUSAACMS0714.eamcs.ericsson.se>
	<20100331045334.GA3878@linux.vnet.ibm.com>
	<E0B6230F32558E43951AF1B0DEBF98102119DC5AA5@EUSAACMS0714.eamcs.ericsson.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E0B6230F32558E43951AF1B0DEBF98102119DC5AA5@EUSAACMS0714.eamcs.ericsson.se>
Subject: Re: [LTP] Fcntl16 test case 2 failure
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
To: Anthony Ton <anthony.ton@ericsson.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Wed, Mar 31, 2010 at 10:39:31PM -0400, Anthony Ton wrote:
> I Rishikesh,
> My mistake, both of them fail.  But one with error code 5 (runltp), while fcntl16 run by itself with error code 37.
> Regards,
> Anthony
> 
> -----Original Message-----
> From: Anthony Ton 
> Sent: Wednesday, March 31, 2010 7:33 PM
> To: 'Rishikesh K Rajak'
> Cc: ltp-list@lists.sourceforge.net
> Subject: RE: [LTP] Fcntl16 test case 2 failure
> 
> Hi Rishikesh,
> I am running against kernel 2.6.27.18.


Gave a try on 2.6.27 kernel and i did not get any failure in both way as you
tried.

:/opt/ltp/testcases/bin # ./fcntl16
fcntl16     0  TINFO  :  Entering block 1
fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
fcntl16     0  TINFO  :  Exiting block 1
fcntl16     0  TINFO  :  Entering block 2
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking PASSED
fcntl16     0  TINFO  :  Exiting block 2
fcntl16     0  TINFO  :  Entering block 3
fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY PASSED
fcntl16     0  TINFO  :  Exiting block 3
:/opt/ltp/testcases/bin # ./fcntl16_64 
fcntl16     0  TINFO  :  Entering block 1
fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
fcntl16     0  TINFO  :  Exiting block 1
fcntl16     0  TINFO  :  Entering block 2
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking PASSED
fcntl16     0  TINFO  :  Exiting block 2
fcntl16     0  TINFO  :  Entering block 3
fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY PASSED
fcntl16     0  TINFO  :  Exiting block 3
:/opt/ltp/testcases/bin # uname -a
Linux xxx 2.6.27.19-5-default #1 SMP 2009-02-28 04:40:21 +0100 x86_64 x86_64
x86_64 GNU/Linux
:/opt/ltp/testcases/bin # 

-Rishi



> I observe that if I running the test suite using runltp, then fcntl16 passes the test.  However, if I run fcntl16 by itself, I get the TFAIL as mentioned in previous email.  Do you know why the results are different if running fcntl16 from runltp vs. runing fcntl16 by itself?
> Thanks,
> Anthony 
> 
> -----Original Message-----
> From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com]
> Sent: Tuesday, March 30, 2010 9:54 PM
> To: Anthony Ton
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Fcntl16 test case 2 failure
> 
> 
> Hi Anthony,
> 
> >Hi LTP Team,
> >I run test case fcntl16 and get a failure on test case 2 with messages 
> >below
> 
> I have tested with latest kernel 2.6.32 and i could not face this problem.
> 
> Can you let us know about your setup little bit more ?
> 
> >
> >fcntl16     0  TINFO  :  Entering block 2
> >fcntl16     1  TFAIL  :  First parent lock failed
> >fcntl16     2  TFAIL  :  Test case 1, errno = 37
> >fcntl16     0  TINFO  :  Test case 2: with mandatory record locking FAILED
> >
> >>I look into the code and think that it is trying to do a lock on the 
> >>entire file
> >with write lock using option F_WRLCK, 0, 0L, 0L, IGNORED.  Is it 
> >correct?  Can someone
> >+elaborate a little more?  What does the errno = 37 mean?
> 
> This errno means you are not having any lock available while doing operation with fcntl, with F_SETLK .
> 
> asm-generic/errno.h:#define	ENOLCK		37	/* No record locks
> available */
> 
> --
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net

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
