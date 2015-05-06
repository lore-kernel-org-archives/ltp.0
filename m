Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1Yptjd-0004n6-Ij
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:13 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yptjc-0002S6-Ng
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 07:27:13 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t467Po6r004593
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 15:25:50 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 6 May 2015 15:26:15 +0800
Message-ID: <1430897176-16486-4-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1430897176-16486-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 4/5] kernel/syscalls/dup2: free fildes to avoid memory
	leak
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
 testcases/kernel/syscalls/dup2/dup205.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup205.c
index 14218dd..a77ae0d 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup205.c
@@ -111,6 +111,7 @@ int main(int ac, char *av[])
 		unlink(pfilname);
 		for (ifile = fildes[0]; ifile < min + 10; ifile++)
 			close(fildes[ifile]);
+		free(fildes);
 		if (local_flag == PASSED) {
 			tst_resm(TPASS, "Test passed.");
 		} else {
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
