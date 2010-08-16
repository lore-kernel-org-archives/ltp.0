Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Ol0sG-0001aE-KH
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 14:41:16 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ol0sE-0001UF-DV
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 14:41:16 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e39.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7GEV9Cq009809
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 08:31:09 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7GEf7eM177506
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 08:41:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7GEf7pP006292
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 08:41:07 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100806000058.GA15483@us.ibm.com>
References: <20100806000058.GA15483@us.ibm.com>
Date: Mon, 16 Aug 2010 20:11:03 +0530
Message-Id: <1281969663.5120.15.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] : drop test pidns03 ?
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
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: subrata@vnet.linux.ibm.com, ltp-list@lists.sourceforge.net

Dropped.

Regards--
Subrata

commit b47b875e00fbea4bb3398ac2f3ef4b4dd32826f0
Author: Subrata Modak <subratamodak@subratamodak.linux.ibm.com>
Date:   Mon Aug 16 20:08:51 2010 +0530

On Thu, 2010-08-05 at 17:00 -0700, Sukadev Bhattiprolu wrote:
> I am not sure about the original intent of pidns03 test case but I think
> the test is expected to fail :-(
> 
> The header for this test says:
> 
> 	* Verify that:
> 	* 1. When parent, clone a process with flag CLONE_NEWPID, see the
> 	* process id of the parent is existing after mounting /proc
> 
> The test passes in the parent-pid from init-pid-ns and looks for that
> pid in the child's mount of /proc.
> 
> But for the CLONE_NEWPID child, parent process should appear to have a
> pid == 0. The pid of the parent in the initial pid namespace must NOT
> be visible to the child - in fact a different process can have that pid.
> 
> I am not surprised the test fails - I am curious to know the version of
> the kernel when this test reliably passed - if at all. I tried this on
> 2.6.29 and 2.6.34-rc5 and it fails reliably.
> 
> I dug through my history and see that this test was part of a 6-patch set,
> We did have some comments on the coding style on the set, but we seem to
> have missed the intent of this test :-(.
> 
> Do we have any other history of this test ? If not, I think we should either
> drop the test or modify the test to verify the opposite (i.e.  verify that
> the opendir() in the test fails with ENOENT).
> 
> Sukadev
> 
> ------------------------------------------------------------------------------
> This SF.net email is sponsored by 
> 
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
