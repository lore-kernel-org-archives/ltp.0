Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OV71A-0003e4-K9
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:00:44 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OV719-00031Q-Kh
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:00:44 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o63HrjG4012339
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 11:53:45 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o63I0QYK096934
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 12:00:27 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o63I0QDE023133
	for <ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 12:00:26 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C2D92D3.8070001@linux.vnet.ibm.com>
References: <4C2C8492.503@linux.vnet.ibm.com>
	<1278003985.21642.7.camel@subratamodak.linux.ibm.com>
	<4C2D8672.8030406@linux.vnet.ibm.com>
	<AANLkTiko2hqAdNNyr6RmmE_sQhEmY71PqjdOzSdcoudc@mail.gmail.com>
	<4C2D92D3.8070001@linux.vnet.ibm.com>
Date: Sat, 03 Jul 2010 23:30:19 +0530
Message-Id: <1278180020.7665.17.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] close file descriptors and munmap pages.
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
To: Darshak Shah <darshaks@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2010-07-02 at 12:48 +0530, Darshak Shah wrote: 
> On 07/02/2010 12:07 PM, Garrett Cooper wrote:
> > On Thu, Jul 1, 2010 at 11:25 PM, Darshak Shah
> > <darshaks@linux.vnet.ibm.com>  wrote:
> >    
> >> On 07/01/2010 10:36 PM, Subrata Modak wrote:
> >>      
> >>> Probably, you would need to fix these:
> >>>
> >>> patching file testcases/kernel/syscalls/open/open10.c
> >>> Hunk #1 FAILED at 282.
> >>> Hunk #2 FAILED at 311.
> >>> Hunk #3 FAILED at 359.
> >>> Hunk #4 FAILED at 389.
> >>> Hunk #5 FAILED at 440.
> >>> 5 out of 5 hunks FAILED -- saving rejects to file
> >>> testcases/kernel/syscalls/open/open10.c.rej
> >>> patching file testcases/kernel/syscalls/splice/splice02.c
> >>> patch: **** malformed patch at line 229: Passed");
> >>>        
> >> Dear Subrata,
> >>
> >> I downloaded the latest ltp from
> >> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree
> >> I used the "snapshot" to download the tgz and patched as following.
> >>
> >> The patch seems to apply correctly.
> >>      
> >      Please attach the patch as a file as well as inline. Some MTAs and
> > mail clients (like gmail for me) screw up whitespace and other fuzz in
> > patches when folks include it inline in email.
> > Thanks!
> > -Garrett
> >    
> Attached.

Thanks. Applies fine now.

Regards--
Subrata



------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
