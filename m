Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hjia@redhat.com>) id 1MkcH9-0001yT-U5
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:20:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MkcH5-0002w2-LH
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:20:47 +0000
Received: from int-mx05.intmail.prod.int.phx2.redhat.com
	(int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n87BKaVt012703
	for <ltp-list@lists.sourceforge.net>; Mon, 7 Sep 2009 07:20:36 -0400
Message-ID: <4AA4EC94.6020209@redhat.com>
Date: Mon, 07 Sep 2009 19:20:52 +0800
From: Hushan Jia <hjia@redhat.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] network: Fix ip_tests error
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

Hi,

This patch fix several errors of testcases/network/iproute/ip_test.sh case:

1. Teset #1:
ip01        0  TINFO  :  Test #1: changing mtu size of eth0:1 device.
/mnt/ltp/ltp-full-20090731/testcases/bin/ip_tests.sh: line 198: [: -eq: unary operator expected.

The output of
ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://"
is like:
1500  Metric:1
so should print field 1 instead of field 5.

2. Test #4:
ip tools now print nud state as follows:
REACHABLE, STALE, FAILED, etc.

3. Test #3, #4, #5:
If delete entry successfully, grep will return 1,
indicating test PASS, so return code RC should be set to 0.

Thanks&  Regards,
Hushan

---

network: Fix ip_tests test case error

Signed-off-by: Hushan Jia<hjia@redhat.com>

--- ltp-full-20090831/testcases/network/iproute/ip_tests.sh.orig	2009-09-07 15:20:29.000000000 +0800
+++ ltp-full-20090831/testcases/network/iproute/ip_tests.sh	2009-09-07 15:32:43.000000000 +0800
@@ -194,7 +194,7 @@ test01()
  			"Test #1: ip command failed. Reason: "
  		return $RC
  	else
-		MTUSZ=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $5}'`
+		MTUSZ=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" | awk '{print $1}'`
  		if [ $MTUSZ -eq 300 ]
  		then
  			tst_resm TPASS "Test #1: changing mtu size success"
@@ -310,7 +310,9 @@ test03()
  				tst_res TFAIL $LTPTMP/tst_ip.err \
  				"Test #3: ip addr del command failed. Reason: "
  				return $(($RC+1))
-		fi
+			else
+				RC=0
+			fi
  		
  		tst_resm TPASS \
  			"Test #3: ip addr command tests successful"
@@ -354,7 +356,7 @@ test04()
  		 "Test #4: ip neigh show - shows all neighbour entries in arp tables."

  		cat>  $LTPTMP/tst_ip.exp<<-EOF
-		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 nud reachable
+		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
  		EOF

  		ip neigh show 127.0.0.1 | head -n1>$LTPTMP/tst_ip.out 2>&1 || RC=$?
@@ -384,12 +386,14 @@ test04()
  				"Test #4: ip neigh del command failed return = $RC. Reason: "
  			return $RC
  		else
-			ip neigh show | grep 127.0.0.1 grep -v "nud failed$">$LTPTMP/tst_ip.err 2>&1 || RC=$?
+			ip neigh show | grep 127.0.0.1 | grep -v " FAILED$">$LTPTMP/tst_ip.err 2>&1 || RC=$?
  			if [ $RC -eq 0 ]
  			then
  				tst_res TFAIL $LTPTMP/tst_ip.err \
  				"Test #4: 127.0.0.1 still listed in arp. ip cmd Error Message:"
  				return $(($RC+1))
+			else
+				RC=0
  			fi
  		fi
  		
@@ -482,6 +486,8 @@ test05()
  				tst_res TFAIL $LTPTMP/tst_ip.err \
  				"Test #5: route not deleted. ip route show:"
  				return $(($RC+1))
+			else
+				RC=0
  			fi
  		fi
  		
@@ -570,6 +576,8 @@ test06()
  				tst_res TFAIL $LTPTMP/tst_ip.err \
  				"Test #6: 66:66:00:00:00:66 is not deleted. Details:"
  				return $(($RC+1))
+			else
+				RC=0
  			fi
  		fi
  		



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
