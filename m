Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <anthony.ton@ericsson.com>) id 1NxAGo-0000RQ-5l
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 02:36:34 +0000
Received: from imr2.ericy.com ([198.24.6.3])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxAGm-0000Up-3L
	for ltp-list@lists.sourceforge.net; Thu, 01 Apr 2010 02:36:34 +0000
From: Anthony Ton <anthony.ton@ericsson.com>
Date: Wed, 31 Mar 2010 22:33:15 -0400
Message-ID: <E0B6230F32558E43951AF1B0DEBF98102119DC5AA1@EUSAACMS0714.eamcs.ericsson.se>
References: <E0B6230F32558E43951AF1B0DEBF98102119DC54EF@EUSAACMS0714.eamcs.ericsson.se>
	<20100331045334.GA3878@linux.vnet.ibm.com>
In-Reply-To: <20100331045334.GA3878@linux.vnet.ibm.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Rishikesh,
I am running against kernel 2.6.27.18.
I observe that if I running the test suite using runltp, then fcntl16 passes the test.  However, if I run fcntl16 by itself, I get the TFAIL as mentioned in previous email.  Do you know why the results are different if running fcntl16 from runltp vs. runing fcntl16 by itself?
Thanks,
Anthony 

-----Original Message-----
From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com] 
Sent: Tuesday, March 30, 2010 9:54 PM
To: Anthony Ton
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Fcntl16 test case 2 failure


Hi Anthony,

>Hi LTP Team,
>I run test case fcntl16 and get a failure on test case 2 with messages 
>below

I have tested with latest kernel 2.6.32 and i could not face this problem.

Can you let us know about your setup little bit more ?

>
>fcntl16     0  TINFO  :  Entering block 2
>fcntl16     1  TFAIL  :  First parent lock failed
>fcntl16     2  TFAIL  :  Test case 1, errno = 37
>fcntl16     0  TINFO  :  Test case 2: with mandatory record locking FAILED
>
>>I look into the code and think that it is trying to do a lock on the 
>>entire file
>with write lock using option F_WRLCK, 0, 0L, 0L, IGNORED.  Is it 
>correct?  Can someone
>+elaborate a little more?  What does the errno = 37 mean?

This errno means you are not having any lock available while doing operation with fcntl, with F_SETLK .

asm-generic/errno.h:#define	ENOLCK		37	/* No record locks
available */

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
