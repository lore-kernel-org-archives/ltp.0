Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hjia@redhat.com>) id 1Mlw0t-0002HD-Qn
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 02:37:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mlw0h-0004NG-IW
	for ltp-list@lists.sourceforge.net; Fri, 11 Sep 2009 02:37:22 +0000
Message-ID: <4AA9AEB5.3020905@redhat.com>
Date: Fri, 11 Sep 2009 09:58:13 +0800
From: Hushan Jia <hjia@redhat.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] network: Fix ip_tests error 2
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

Repost the ip tests patch:

1. Test #4:
ip tools now print nud state as follows:
REACHABLE, STALE, FAILED, etc.

2. Test #3, #4, #5:
If delete entry succefully, grep will return 1,
indicating test PASS, so return code RC should be set to 0.

Thanks & Regards,
Hushan

---

network: Fix iproute test case error 2

Signed-off-by: Hushan Jia <hjia@redhat.com>


--- ltp/testcases/network/iproute/ip_tests.sh.orig	2009-09-09 18:31:31.000000000 +0800
+++ ltp/testcases/network/iproute/ip_tests.sh	2009-09-09 18:32:43.000000000 +0800
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
 
 		cat > $LTPTMP/tst_ip.exp <<-EOF
-		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 nud reachable
+		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
 		EOF
 
 		ip neigh show 127.0.0.1 | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
@@ -384,12 +386,14 @@ test04()
 				"Test #4: ip neigh del command failed return = $RC. Reason: "
 			return $RC
 		else
-			ip neigh show | grep 127.0.0.1 grep -v "nud failed$" >$LTPTMP/tst_ip.err 2>&1 || RC=$?
+			ip neigh show | grep 127.0.0.1 | grep -v " FAILED$" >$LTPTMP/tst_ip.err 2>&1 || RC=$?
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
