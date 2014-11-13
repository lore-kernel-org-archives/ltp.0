Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1Xp65s-0006EZ-2p
	for ltp-list@lists.sourceforge.net; Fri, 14 Nov 2014 01:54:36 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xp65r-0007Ip-0K
	for ltp-list@lists.sourceforge.net; Fri, 14 Nov 2014 01:54:36 +0000
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Thu, 13 Nov 2014 18:54:29 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
	(b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 20F333E4003B
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Nov 2014 18:48:16 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id sAE1sQBw52232272
	for <ltp-list@lists.sourceforge.net>; Fri, 14 Nov 2014 02:54:26 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id sAE1sP17016502
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Nov 2014 18:54:25 -0700
Received: from localhost.localdomain ([9.77.182.67])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sAE1sPwR016481
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Nov 2014 18:54:25 -0700
Date: Thu, 13 Nov 2014 15:13:24 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141113071324.GA2809@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] NUMA system and get_a_numa_node()
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
To: ltp-list@lists.sourceforge.net

Hey there,

We have a system which only has one NUMA node. When trying to run ksm02
on it, becase the code calling get_allowed_nodes() with a count 2 as
below:

 972 /* Warning: *DO NOT* use this function in child */
 973 unsigned int get_a_numa_node(void (*cleanup_fn) (void))
 974 {              
 975         unsigned int nd1, nd2;
 976         int ret; 
 977                        
 978         ret = get_allowed_nodes(0, 2, &nd1, &nd2);
 979         switch (ret) { 
 980         case 0:
 981                 break;
 982         case -3:
 983                 tst_brkm(TCONF, cleanup_fn, "requires a NUMA system.");

it always failed with "requires a NUMA system.".

I think a NUMA system may have only one node, right? If so, could we
change the count to 1?

Thanks in advance!


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
