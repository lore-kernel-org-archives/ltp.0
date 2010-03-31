Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nwpw2-0007oq-6A
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 04:53:46 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nwpvz-0007xB-Es
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 04:53:46 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2V4q5Ou011698
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Mar 2010 22:52:05 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2V4rb95136110
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Mar 2010 22:53:37 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2V4rbgI020438
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Mar 2010 22:53:37 -0600
Date: Wed, 31 Mar 2010 10:23:34 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100331045334.GA3878@linux.vnet.ibm.com>
References: <E0B6230F32558E43951AF1B0DEBF98102119DC54EF@EUSAACMS0714.eamcs.ericsson.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E0B6230F32558E43951AF1B0DEBF98102119DC54EF@EUSAACMS0714.eamcs.ericsson.se>
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


Hi Anthony,

>Hi LTP Team,
>I run test case fcntl16 and get a failure on test case 2 with messages below

I have tested with latest kernel 2.6.32 and i could not face this problem.

Can you let us know about your setup little bit more ?

>
>fcntl16     0  TINFO  :  Entering block 2
>fcntl16     1  TFAIL  :  First parent lock failed
>fcntl16     2  TFAIL  :  Test case 1, errno = 37
>fcntl16     0  TINFO  :  Test case 2: with mandatory record locking FAILED
>
>>I look into the code and think that it is trying to do a lock on the entire file
>with write lock using option F_WRLCK, 0, 0L, 0L, IGNORED.  Is it correct?  Can
>someone
>+elaborate a little more?  What does the errno = 37 mean?

This errno means you are not having any lock available while doing operation
with fcntl, with F_SETLK .

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
