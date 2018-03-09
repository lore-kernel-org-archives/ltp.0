From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  9 Mar 2018 11:01:03 +0100
Subject: [LTP] [PATCH] mallocstress: extend test time on arm
Message-ID: <981e2a8523db8616a4ed442635a493928376489d.1520589632.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Arm systems with lot of memory and THP enabled are
hitting a timeout at ~5 minute mark as reported here:
  mallocstress poor performance with THP on arm64 system
  https://marc.info/?l=linux-mm&m=151864950330870&w=2

Extend the timeout to 10m (only for arm).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mtest07/mallocstress.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/mem/mtest07/mallocstress.c b/testcases/kernel/mem/mtest07/mallocstress.c
index 2e900adac28b..fc3bfe7c4e20 100644
--- a/testcases/kernel/mem/mtest07/mallocstress.c
+++ b/testcases/kernel/mem/mtest07/mallocstress.c
@@ -243,6 +243,14 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
+/*
+ * extend test time on arm due to:
+ * "mallocstress poor performance with THP on arm64 system"
+ * https://marc.info/?l=linux-mm&m=151864950330870&w=2
+ */
+#if defined(__arm__) || defined(__aarch64__)
+	.timeout = 600,
+#endif
 	.needs_checkpoints = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
1.8.3.1

