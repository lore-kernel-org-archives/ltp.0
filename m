From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Sep 2020 11:46:25 +0200
Subject: [LTP] [PATCH 1/1] recvmmsg01: Fix compilation
Message-ID: <20200923094625.30601-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

void* cannot be directly used, it must be pointing to the struct.

recvmmsg01.c:86:9: error: request for member ?type? in something not a
structure or union
  timeout.type = tv->ts_type;

Fixes: 135af8ede ("syscalls/{send|recv}mmsg: add a test case for timeout
and errno test")

Reported-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
index fe637430b..a16a78f9b 100644
--- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
+++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
@@ -65,7 +65,8 @@ static void do_test(unsigned int i)
 {
 	struct time64_variants *tv = &variants[tst_variant];
 	struct test_case *tc = &tcase[i];
-	void *rcv_msgvec, *timeout;
+	struct tst_ts t;
+	void *rcv_msgvec, *timeout = &t;
 
 	tst_res(TINFO, "case %s", tc->desc);
 
@@ -83,7 +84,7 @@ static void do_test(unsigned int i)
 	memset(rcv1->iov_base, 0, rcv1->iov_len);
 	memset(rcv2->iov_base, 0, rcv2->iov_len);
 
-	timeout.type = tv->ts_type;
+	((struct tst_ts*)timeout)->type = tv->ts_type;
 	tst_ts_set_sec(&ts, tc->tv_sec);
 	tst_ts_set_nsec(&ts, tc->tv_nsec);
 
-- 
2.28.0

