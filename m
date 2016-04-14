From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 14 Apr 2016 16:04:25 +0800
Subject: [LTP] [PATCH] waitid/waitid01: break test if fork() failed
Message-ID: <20160414080425.GA10586@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Or a lot of processes will be killed when -1 passed as pid to kill().

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitid/waitid01.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/waitid/waitid01.c b/testcases/kernel/syscalls/waitid/waitid01.c
index c19f0da..1729aa3 100644
--- a/testcases/kernel/syscalls/waitid/waitid01.c
+++ b/testcases/kernel/syscalls/waitid/waitid01.c
@@ -130,6 +130,10 @@ int main(int ac, char **av)
 		for (testno = 0; testno < TST_TOTAL; ++testno) {
 
 			TEST(fork());
+			if (TEST_RETURN < 0)
+				tst_brkm(TBROK | TTERRNO, NULL,
+					"fork() failed");
+
 			if (TEST_RETURN == 0) {
 				exit(123);
 			} else {
@@ -143,6 +147,10 @@ int main(int ac, char **av)
 			}
 
 			TEST(fork());
+			if (TEST_RETURN < 0)
+				tst_brkm(TBROK | TTERRNO, NULL,
+					"fork() failed");
+
 			if (TEST_RETURN == 0) {
 				int a, b = 0;
 				a = 1 / b;
@@ -157,6 +165,10 @@ int main(int ac, char **av)
 			}
 
 			TEST(pid = fork());
+			if (TEST_RETURN < 0)
+				tst_brkm(TBROK | TTERRNO, NULL,
+					"fork() failed");
+
 			if (TEST_RETURN == 0) {
 				TEST(sleep(10));
 				tst_exit();
-- 
1.9.3

