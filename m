Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YYBW0-0004WM-Sw
	for ltp-list@lists.sourceforge.net; Wed, 18 Mar 2015 10:47:56 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YYBVz-0000TI-MX
	for ltp-list@lists.sourceforge.net; Wed, 18 Mar 2015 10:47:56 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2IAkVxV017128
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Mar 2015 18:46:31 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 18 Mar 2015 18:40:25 +0800
Message-ID: <1426675225-29334-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <ltp-list@lists.sourceforge.net>
References: <ltp-list@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] futex: return TCONF if FUTEX_WAIT_BITSET operation
	is not supported
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

There still exist some linux distributions whose kernel are old and
do not support futex(2)'s FUTEX_WAIT_BITSET operation, e.g. RHEL5.11GA,
so we should catch the ENOSYS error and return TCONF rather than TFAIL.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/futex/futex_wait_bitset.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/futex/futex_wait_bitset.h b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
index 2f8ddb8..f5e1fde 100644
--- a/testcases/kernel/syscalls/futex/futex_wait_bitset.h
+++ b/testcases/kernel/syscalls/futex/futex_wait_bitset.h
@@ -42,6 +42,12 @@ static void verify_futex_wait_bitset(long long wait_us, clock_t clk_id)
 		return;
 	}
 
+	if (TEST_ERRNO == ENOSYS) {
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
