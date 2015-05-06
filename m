Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YpwQI-00020q-8R
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 10:19:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YpwQH-0004T5-26
	for ltp-list@lists.sourceforge.net; Wed, 06 May 2015 10:19:26 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t46AHvbt016853
	for <ltp-list@lists.sourceforge.net>; Wed, 6 May 2015 18:17:57 +0800
From: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 6 May 2015 18:18:21 +0800
Message-ID: <1430907502-30493-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] kernel/syscalls/fallocate: specify size needs
	check
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

Compare size_t size elements with file data and check
if it's excpeted.
This patch depends on bff5968.

Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate04.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
index a6d1159..2da0bcd 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate04.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
@@ -174,7 +174,7 @@ static void test02(void)
 	fill_tst_buf(exp_buf);
 	memset(exp_buf + block_size, 0, block_size);
 
-	check_file_data(exp_buf);
+	check_file_data(exp_buf, sizeof(exp_buf)/sizeof(exp_buf[0]));
 
 	tst_resm(TPASS, "test-case succeeded");
 }
@@ -214,7 +214,7 @@ static void test03(void)
 	fill_tst_buf(exp_buf);
 	memset(exp_buf + block_size - 1, 0, block_size + 2);
 
-	check_file_data(exp_buf);
+	check_file_data(exp_buf, sizeof(exp_buf)/sizeof(exp_buf[0]));
 
 	tst_resm(TPASS, "test-case succeeded");
 }
@@ -250,7 +250,7 @@ static void test04(void)
 	memcpy(exp_buf, tmp_buf, block_size);
 	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
 
-	check_file_data(exp_buf);
+	check_file_data(exp_buf, sizeof(exp_buf)/sizeof(exp_buf[0]));
 
 	tst_resm(TPASS, "test-case succeeded");
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
