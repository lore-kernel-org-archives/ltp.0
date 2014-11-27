Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1Xu0oH-0007va-JR
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 15:16:45 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xu0oG-0005CG-1I
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 15:16:45 +0000
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sARFGbTU018386
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Nov 2014 10:16:37 -0500
Date: Thu, 27 Nov 2014 10:16:37 -0500 (EST)
From: Matus Marhefka <mmarhefk@redhat.com>
Message-ID: <942107198.5544680.1417101397640.JavaMail.zimbra@redhat.com>
In-Reply-To: <1412949674-9702-1-git-send-email-mmarhefk@redhat.com>
References: <1412949674-9702-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] containers: fixed deadlock in
 netns/netns_childns.sh
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

Please consider this patch as irrelevant.
I will post a better solution for possible deadlocks
in network namespaces tests by using timeouts on read/write
FIFO operations.

Thanks,
Matus Marhefka

----- Original Message -----
From: "Matus Marhefka" <mmarhefk@redhat.com>
To: ltp-list@lists.sourceforge.net
Sent: Friday, October 10, 2014 4:01:14 PM
Subject: [LTP] [PATCH] containers: fixed deadlock in netns/netns_childns.sh

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

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
