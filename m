Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YXiMq-0001sZ-PS
	for ltp-list@lists.sourceforge.net; Tue, 17 Mar 2015 03:40:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXiMp-0007J1-Fq
	for ltp-list@lists.sourceforge.net; Tue, 17 Mar 2015 03:40:32 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2H3dQEP019063
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Mar 2015 11:39:26 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Tue, 17 Mar 2015 11:33:16 +0800
Message-ID: <1426563196-10935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] futex: return TCONF if FUTEX_WAIT_BITSET operation is
	not supported
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/futex/futex_wait_bitset.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset.h b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
index 2f8ddb8..73d87da 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset.h
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
@@ -42,6 +42,12 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 		return;
 	}
 
+	if (TEST_ERRNO == EOPNOTSUPP || TEST_ERRNO == ENOSYS) {
+		tst_resm(TCONF, "In this kernel, futex() does not support "
+			 "FUTEX_WAIT_BITSET operation");
+		return;
+	}
+
 	if (TEST_ERRNO != ETIMEDOUT) {
 		tst_resm(TFAIL | TTERRNO, "expected %s",
 		         tst_strerrno(ETIMEDOUT));
-- 
1.8.2.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
