From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 23 Sep 2020 16:44:22 +0800
Subject: [LTP] [PATCH] syscalls/recvmmsg01.c: Fix a compiler error
Message-ID: <20200923084422.13101-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use correct ts.type to fix the following compiler error:
--------------------------------------------
recvmmsg01.c:86:9: error: request for member ?type? in something not a structure or union
  timeout.type = tv->ts_type;
--------------------------------------------

Fixes: 135af8ededd4 ("syscalls/{send|recv}mmsg: add a test case for timeout and errno test")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
index fe637430b..d3f2df6d9 100644
--- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
+++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
@@ -83,7 +83,7 @@ static void do_test(unsigned int i)
 	memset(rcv1->iov_base, 0, rcv1->iov_len);
 	memset(rcv2->iov_base, 0, rcv2->iov_len);
 
-	timeout.type = tv->ts_type;
+	ts.type = tv->ts_type;
 	tst_ts_set_sec(&ts, tc->tv_sec);
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
 
-- 
2.25.1



