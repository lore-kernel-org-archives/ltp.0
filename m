Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MMI8d-0004e0-8g
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 08:59:27 +0000
Received: from [32.97.110.154] (helo=e36.co.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMI8Y-0006Wx-Ar
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 08:59:27 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n628v2JT012996
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 02:57:02 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n628wV1U209060
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 02:58:31 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n628wVrD005660
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Jul 2009 02:58:31 -0600
Date: Thu, 2 Jul 2009 01:58:29 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090702085829.GD19135@count0.beaverton.ibm.com>
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090702084828.GC19135@count0.beaverton.ibm.com>
Subject: [LTP] [PATCH 2/4] netns: Add ip tools check to netns tests.
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

Use ip -V to exclude the network namespace testcases since they require
version  ("snapshot") ss080725 or higher to set the network namespace of
interfaces used for testing.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
Signed-off-by: Sachin P. Sant <sachinp@in.ibm.com>
Cc: Daniel Lezcano <daniel.lezcano@free.fr>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>
Cc: Sudhir Kumar <skumar@linux.vnet.ibm.com>
Cc: Veerendra C <vechandr@in.ibm.com>
Cc: Munipradeep <mbeeraka@in.ibm.com>
Cc: ltp@list.sourceforge.net

---
 testcases/kernel/containers/netns/runnetnstest.sh |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: ltp/testcases/kernel/containers/netns/runnetnstest.sh
===================================================================
--- ltp.orig/testcases/kernel/containers/netns/runnetnstest.sh
+++ ltp/testcases/kernel/containers/netns/runnetnstest.sh
@@ -24,6 +24,27 @@
 
 rc=0
 exit_code=0
+
+# Check the iproute2 version (aka "SnapShot")
+IPROUTEV=`ip -V | cut -d ',' -f 2 | cut -d '-' -f 2 | sed -e 's/^ss//'`
+
+# We need to strip leading 0s else bash thinks we're giving it octal numbers.
+IPROUTEY=$(echo ${IPROUTEV:0:2} | sed -e 's/^0\+//') # Year
+IPROUTEM=$(echo ${IPROUTEV:2:2} | sed -e 's/^0\+//') # Month
+IPROUTED=$(echo ${IPROUTEV:4:2} | sed -e 's/^0\+//') # Day
+
+V=$((${IPROUTEY}*12*32 + ${IPROUTEM}*32 + ${IPROUTED}))
+
+#
+# iproute-ss080725 and later support setting the network namespace of an
+# interface.
+#
+NETNSV=$((8*12*32 + 7*32 + 25))
+if [ ${V} -lt ${NETNSV} ]; then
+	echo "INFO: iproute tools do not support setting network namespaces. Skipping network namespace tests."
+	exit $exit_code
+fi
+
 crtchild
 rc=$?
 if [ $rc -ne 0 ]; then

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
