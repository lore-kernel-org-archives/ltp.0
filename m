Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MMIMQ-00051i-M5
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 09:13:42 +0000
Received: from [32.97.110.152] (helo=e34.co.us.ibm.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMIMO-0002PS-TV
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 09:13:42 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n628xDoc016913
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 02:59:13 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6292UlY250516
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 03:02:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6292U4K008249
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 03:02:30 -0600
Date: Thu, 2 Jul 2009 02:02:28 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090702090228.GE19135@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090702084828.GC19135@count0.beaverton.ibm.com>
Subject: [LTP] [PATCH 3/4] netns: Fixup non-sh syntax
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

Fixup some non-sh syntax which seems to trigger problems on my fedora 10
KVM image.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Cc: Daniel Lezcano <daniel.lezcano@free.fr>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>
Cc: Sudhir Kumar <skumar@linux.vnet.ibm.com>
Cc: Veerendra C <vechandr@in.ibm.com>
Cc: Munipradeep <mbeeraka@in.ibm.com>
Cc: ltp@list.sourceforge.net
---
 testcases/kernel/containers/netns/parentns.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: ltp/testcases/kernel/containers/netns/parentns.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/parentns.sh
+++ ltp/testcases/kernel/containers/netns/parentns.sh
@@ -56,7 +56,7 @@ status=0
     create_veth
     vnet0=$dev0
     vnet1=$dev1
-    if [[ -z $vnet0 || -z $vnet1 ]] ; then
+    if [ -z $vnet0 -o -z $vnet1 ] ; then
         tst_resm TFAIL  "Error: unable to create veth pair"
         exit -1
     else

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
