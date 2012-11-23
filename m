Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TbntD-0007BF-La
	for ltp-list@lists.sourceforge.net; Fri, 23 Nov 2012 07:41:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tbnt9-0003QO-3e
	for ltp-list@lists.sourceforge.net; Fri, 23 Nov 2012 07:41:31 +0000
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date: Fri, 23 Nov 2012 15:40:10 +0800
Message-Id: <1353656410-4670-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: [LTP] [PATCH] numa01: fix the wrong method of getting numa nodes
	number
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
To: LTP <ltp-list@lists.sourceforge.net>

Fix the method of getting the number of numa nodes.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 testcases/kernel/numa/numa01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 9790ef4..9b491fc 100644
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -807,7 +807,7 @@ test010()
         fi
 
             col=2                       #column represents node0 in numastat o/p
-        numnodes=$(ls /sys/devices/system/node | wc -l)
+        numnodes=$(ls /sys/devices/system/node | grep -Ec "node?")
         Preferred_node=$[$[$numnodes/2]-1]
         col=$[$Preferred_node+2]
         numastat > $LTPTMP/numalog
-- 
1.8.0


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
