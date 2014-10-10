Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1Xcal9-0000E4-8e
	for ltp-list@lists.sourceforge.net; Fri, 10 Oct 2014 14:01:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xcal8-0007pC-3G
	for ltp-list@lists.sourceforge.net; Fri, 10 Oct 2014 14:01:31 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9AE1NKC003833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Oct 2014 10:01:23 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s9AE1Mxq030135
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Oct 2014 10:01:23 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Fri, 10 Oct 2014 16:01:14 +0200
Message-Id: <1412949674-9702-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH] containers: fixed deadlock in netns/netns_childns.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

In certain situations there was a possibility of deadlock
in a communication over named pipes (FIFO3, FIFO4) between
netns_delchild.sh (executed from netns_parentns.sh)
and netns_rename_net.sh (executed from netns_childns.sh).

The deadlock was caused by failing to start sshd or pinging parent
namespace in netns_childns.sh. In case one of these situations
occured, netns_childns.sh terminated without executing
the netns_rename_net.sh and causing the netns_delchild.sh to wait
endlessly for data from pipes (FIFO3 and FIFO4).

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/kernel/containers/netns/netns_childns.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_childns.sh b/testcases/kernel/containers/netns/netns_childns.sh
index 9ad9190..f691f48 100755
--- a/testcases/kernel/containers/netns/netns_childns.sh
+++ b/testcases/kernel/containers/netns/netns_childns.sh
@@ -71,6 +71,10 @@ else
     status=1
 fi
 
+if [ -f "$childscrpt" ]; then
+    . "$childscrpt"
+fi
+
 if [ $status -eq 0 ] ; then
 
     # checking if parent ns responding
@@ -81,13 +85,8 @@ if [ $status -eq 0 ] ; then
         exit $status
     fi
 
-    if [ -f "$childscrpt" ]; then
-        . "$childscrpt"
-    fi
-
     cleanup $sshpid $vnet1
     debug "INFO: Done with executing child script $0, status is $status"
-
 fi
 
 exit $status
-- 
1.8.3.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
