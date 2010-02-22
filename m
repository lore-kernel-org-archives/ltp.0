Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NjZEa-0006Yc-Bs
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 14:26:04 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NjZEY-0000MC-Ro
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 14:26:04 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1MEFK4w003915
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 09:15:20 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1MEPuXC094078
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 09:25:56 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1MEPu08012302
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 11:25:56 -0300
Received: from rishikesh.in.ibm.com ([9.77.207.138])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o1MEPtdk012092
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Feb 2010 11:25:56 -0300
Received: from rishikesh.in.ibm.com (rishikesh.in.ibm.com [127.0.0.1])
	by rishikesh.in.ibm.com (Postfix) with ESMTP id 5A7516069D
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Feb 2010 19:55:41 +0530 (IST)
Received: (from rishikesh@localhost)
	by rishikesh.in.ibm.com (8.14.3/8.14.3/Submit) id o1MEPdkG015964
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 19:55:39 +0530
Date: Mon, 22 Feb 2010 19:55:39 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100222142539.GA15818@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] Container Testcase problem with feb intermediate release
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
To: LTP <ltp-list@lists.sourceforge.net>

Hi,

Ran ltp full testcase today with feb ltp intermediate release, but it
hangs at running network namespace testcase.

It is recreatable just after running this:

#./runltp -f containers
====================================================================
...
pidns20     0  TINFO  :  parent: signalled SIGUSR1 to container
Running POSIX message queue tests.
mq_open: Permission denied
posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

posixmq_namespace_01    1  TFAIL  :  mq_open failed

Running netns tests.
--: childns.sh '/opt/ltp': No such file or directory

<------- Stuck here
==================================================================

Let me know if someone is aware about this prob.

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
