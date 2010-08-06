Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sukadev@linux.vnet.ibm.com>) id 1OhAHd-0004Mc-B5
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 23:55:33 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OhAHZ-0006OK-LR
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 23:55:31 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o75NcJRK032171
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Aug 2010 19:38:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o75NtNsI136174
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Aug 2010 19:55:23 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o75NtNut011321
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Aug 2010 19:55:23 -0400
Date: Thu, 5 Aug 2010 17:00:59 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Message-ID: <20100806000058.GA15483@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] : drop test pidns03 ?
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
To: subrata@vnet.linux.ibm.com
Cc: ltp-list@lists.sourceforge.net


I am not sure about the original intent of pidns03 test case but I think
the test is expected to fail :-(

The header for this test says:

	* Verify that:
	* 1. When parent, clone a process with flag CLONE_NEWPID, see the
	* process id of the parent is existing after mounting /proc

The test passes in the parent-pid from init-pid-ns and looks for that
pid in the child's mount of /proc.

But for the CLONE_NEWPID child, parent process should appear to have a
pid == 0. The pid of the parent in the initial pid namespace must NOT
be visible to the child - in fact a different process can have that pid.

I am not surprised the test fails - I am curious to know the version of
the kernel when this test reliably passed - if at all. I tried this on
2.6.29 and 2.6.34-rc5 and it fails reliably.

I dug through my history and see that this test was part of a 6-patch set,
We did have some comments on the coding style on the set, but we seem to
have missed the intent of this test :-(.

Do we have any other history of this test ? If not, I think we should either
drop the test or modify the test to verify the opposite (i.e.  verify that
the opendir() in the test fails with ENOENT).

Sukadev

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
