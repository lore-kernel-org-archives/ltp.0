From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 19 Feb 2016 17:38:45 +0800
Subject: [LTP] [PATCH] input: add kernel version check
Message-ID: <1455874725-31499-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In this test case, the functionality of input has been improved by
following patch:
'commit 4369c64c79a2 ("Input: Send events one packet at a time")'.
So it's not appropriate for testing on kernels that are lower than
3.7.0 anymore.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/input/input04.c | 5 +++++
 testcases/kernel/input/input05.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
index 4b16ca7..153a47f 100644
--- a/testcases/kernel/input/input04.c
+++ b/testcases/kernel/input/input04.c
@@ -75,6 +75,11 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	if ((tst_kvercmp(3, 7, 0)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can run successfully on "
+			 "kernels that are 3.7.0 and higher");
+	}
+
 	tst_require_root();
 
 	fd = open_uinput();
diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
index 5ca01d8..6769e95 100644
--- a/testcases/kernel/input/input05.c
+++ b/testcases/kernel/input/input05.c
@@ -79,6 +79,11 @@ int main(int ac, char **av)
 
 static void setup(void)
 {
+	if ((tst_kvercmp(3, 7, 0)) < 0) {
+		tst_brkm(TCONF, NULL, "This test can run successfully on "
+			 "kernels that are 3.7.0 and higher");
+	}
+
 	tst_require_root();
 
 	fd = open_uinput();
-- 
1.8.3.1



