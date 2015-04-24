Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YlSiC-0001dQ-CV
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:24 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YlSiB-0007kc-F2
	for ltp-list@lists.sourceforge.net; Fri, 24 Apr 2015 01:47:24 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t3O1k6Xo025623
	for <ltp-list@lists.sourceforge.net>; Fri, 24 Apr 2015 09:46:06 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 24 Apr 2015 09:46:40 +0800
Message-ID: <1429840001-4970-4-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1429840001-4970-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 4/5] cpuset_cpu_hog: fix memory leak
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
 .../kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
index 7f96d3c..de81f26 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_load_balance_test/cpuset_cpu_hog.c
@@ -316,6 +316,7 @@ int main(int argc, char **argv)
 			ret = EXIT_FAILURE;
 	}
 
+	free(childpids);
 	return ret;
 }
 
-- 
1.9.3


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
