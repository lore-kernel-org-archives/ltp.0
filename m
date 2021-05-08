From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sat, 8 May 2021 10:14:48 +0800
Subject: [LTP] [PATCH v2] syscalls/bind03: Bugfix for running with option
 "-i"
Message-ID: <20210508021448.7390-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When run the test with option "-i 2", test will fail and
report EADDRINUSE.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2:replace unlink() with SAFE_UNLINK()
 testcases/kernel/syscalls/bind/bind03.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind03.c b/testcases/kernel/syscalls/bind/bind03.c
index ebde19591..879ce1bc6 100644
--- a/testcases/kernel/syscalls/bind/bind03.c
+++ b/testcases/kernel/syscalls/bind/bind03.c
@@ -62,16 +62,14 @@ void run(void)
 	 */
 	TST_EXP_FAIL(bind(sock2, (struct sockaddr *)&sun1, sizeof(sun1)),
 	             EADDRINUSE, "bind() with bound pathname");
-}

-static void cleanup(void)
-{
+	SAFE_UNLINK(sun1.sun_path);
+	SAFE_UNLINK(sun2.sun_path);
 	SAFE_CLOSE(sock1);
 	SAFE_CLOSE(sock2);
 }

 static struct tst_test test = {
-	.cleanup = cleanup,
 	.test_all = run,
 	.needs_tmpdir = 1,
 };
--
2.17.1

