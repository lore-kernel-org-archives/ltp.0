Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NpcPZ-0001ZW-9U
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 07:02:25 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpcPX-0003KV-WB
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 07:02:25 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2B6mAPk021456
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Mar 2010 01:48:10 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2B72EiB1228972
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Mar 2010 02:02:14 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2B72Efp009453
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Mar 2010 02:02:14 -0500
Date: Thu, 11 Mar 2010 12:32:08 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100311070208.GA9131@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] posix mq namespaces failure with LTP
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
To: Nadia.Derbey@bull.net
Cc: ltp-list@lists.sourceforge.net

Hi Nadia,

I am gettingthe failure w.r.t mq namespace. Can you please help here to find out
a root cause.

[root@ mqns]# ./runmqnstest.sh 
posixmq_namespace_01    0  TINFO  :  Testing posix mq namespaces through
unshare(2).

mq_open: Permission denied
posixmq_namespace_01    1  TFAIL  :  mq_open failed

[root@ mqns]# 

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
