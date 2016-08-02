From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 3 Aug 2016 05:23:22 +0800
Subject: [LTP] [PATCH] syscalls/madvise06: Exclude other factor that leading
	to failure
Message-ID: <1470173002-19754-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make sure that madvise(MADV_WILLNEED) supports swap prefetch. We
can't distinguish between kernel bug and unsupported swap, because
the same error happens on RHEL6.8GA which madvise(MADV_WILLNEED)
doesn't support swap prefetch. This feature has been pushed since
kernel 3.10.0.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index ddd1814..e040b6f 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -182,6 +182,7 @@ static struct tst_test test = {
 	.test_all = test_advice_willneed,
 	.setup = setup,
 	.cleanup = cleanup,
+	.min_kver = "3.10.0",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 };
-- 
1.8.3.1



