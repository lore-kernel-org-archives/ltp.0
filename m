From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Nov 2020 14:08:10 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/acct02: Decleare kconfigs inline
Message-ID: <20201120130810.14995-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So that it's picked up correctly by the docparser.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/acct/acct02.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index fbcde0bcb..aee96e365 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -254,14 +254,12 @@ static void cleanup(void)
 	acct(NULL);
 }
 
-static const char *kconfigs[] = {
-	"CONFIG_BSD_PROCESS_ACCT",
-	NULL
-};
-
 static struct tst_test test = {
 	.test_all = run,
-	.needs_kconfigs = kconfigs,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_BSD_PROCESS_ACCT",
+		NULL
+	},
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_tmpdir = 1,
-- 
2.26.2

