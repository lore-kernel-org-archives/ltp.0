From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  6 Sep 2021 10:35:45 +0200
Subject: [LTP] [PATCH] ftruncate04: require CONFIG_MANDATORY_FILE_LOCKING=y
Message-ID: <77a5903b5ddf8b63c1acc6c24e4d3195590e8628.1630917312.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commit f7e33bdbd6d1 ("fs: remove mandatory file locking support")
removed mandatory file locking support, but mount option
is still allowed and produces no error. There's a warning
in dmesg but it's pr_warn_once() so we can't rely to always
find it there.

Make the test check also for CONFIG_MANDATORY_FILE_LOCKING=y.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ftruncate/ftruncate04.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index ad5c7bbb90ef..c832ceaa659d 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -168,6 +168,10 @@ static void setup(void)
 }
 
 static struct tst_test test = {
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_MANDATORY_FILE_LOCKING=y",
+		NULL
+	},
 	.test_all = verify_ftruncate,
 	.setup = setup,
 	.needs_checkpoints = 1,
-- 
2.27.0

