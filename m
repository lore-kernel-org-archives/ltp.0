Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hjia@redhat.com>) id 1Mj8Wb-00032N-T3
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2009 09:22:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mj8Wa-0003kL-VK
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2009 09:22:37 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n839MVuU017995
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Sep 2009 05:22:31 -0400
Message-ID: <4A9F8AE9.300@redhat.com>
Date: Thu, 03 Sep 2009 17:22:49 +0800
From: Hushan Jia <hjia@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] network: Fix iproute test case error
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

Hello,

When I run network test case testcases/network/iproute/ip_tests.sh, some errors shown:
ip01        0  TINFO  :  Test #1: changing mtu size of eth0:1 device.
/mnt/ltp/ltp-full-20090731/testcases/bin/ip_tests.sh: line 198: [: -eq: unary operator expected.

The output of
ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://"
is like:
1500  Metric:1
so should print field 1 instead of field 5.

Thanks&  Regards,
Hushan

---

network: Fix iproute test case error

Signed-off-by: Hushan Jia<hjia@redhat.com>

diff -Nrup ltp-full-20090831-orig/testcases/network/iproute/ip_tests.sh ltp-full-20090831/testcases/network/iproute/ip_tests.sh
--- ltp-full-20090831-orig/testcases/network/iproute/ip_tests.sh	2009-09-03 16:47:56.000000000 +0800
+++ ltp-full-20090831/testcases/network/iproute/ip_tests.sh	2009-09-03 16:51:04.000000000 +0800
@@ -194,7 +194,7 @@ test01()
  			"Test #1: ip command failed. Reason: "
  		return $RC
  	else
-		MTUSZ=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $5}'`
+		MTUSZ=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $1}'`
  		if [ $MTUSZ -eq 300 ]
  		then
  			tst_resm TPASS "Test #1: changing mtu size success"


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
