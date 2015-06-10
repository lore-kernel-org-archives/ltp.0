Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Z2ZvR-00085p-HG
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:49 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z2ZvQ-0003X9-DP
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 06:55:49 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5A6s9ot004883
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Jun 2015 14:54:09 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 10 Jun 2015 14:54:59 +0800
Message-ID: <1433919301-24797-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/4] cpuset/cpuset_lib/cpuinfo.c: fix FILE pointer leak
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

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
index 54fa1e5..c2a60b6 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_lib/cpuinfo.c
@@ -231,11 +231,15 @@ static int get_sched_domains(void)
 			if (!cpus[ci].sched_domain) {
 				cpus[ci].sched_domain =
 				    bitmask_alloc(cpus_nbits);
-				if (!cpus[ci].sched_domain)
+				if (!cpus[ci].sched_domain) {
+					fclose(fp);
 					return -1;
+				}
 			}
-			if (bitmask_parsehex(str2, cpus[ci].sched_domain))
+			if (bitmask_parsehex(str2, cpus[ci].sched_domain)) {
+				fclose(fp);
 				return -1;
+			}
 		}
 	}
 
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
