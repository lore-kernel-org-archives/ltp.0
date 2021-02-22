From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Feb 2021 17:02:43 +0100
Subject: [LTP] [PATCH 4/4] semctl09: Add glibc-git tag
In-Reply-To: <20210222160243.507-1-pvorel@suse.cz>
References: <20210222160243.507-1-pvorel@suse.cz>
Message-ID: <20210222160243.507-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also fix formatting:

* remove new line at "to the kernel"
* put glibc info out of docparse (this info is included in glibc-git)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ipc/semctl/semctl09.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index f0c757cdd..8cdadd061 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -23,15 +23,20 @@
  * completely different meaning than their names seems to suggest.
  *
  * We also calling semctl() directly by syscall(), because of a glibc bug:
- * * semctl SEM_STAT_ANY fails to pass the buffer specified by the caller
- * * to the kernel.
- * * https://sourceware.org/bugzilla/show_bug.cgi?id=26637
  *
+ * semctl SEM_STAT_ANY fails to pass the buffer specified by the caller
+ * to the kernel.
+ *
+ * https://sourceware.org/bugzilla/show_bug.cgi?id=26637
+\*/
+
+/*
  * The glibc bug was fixed in:
+ *
  * * commit  574500a108be1d2a6a0dc97a075c9e0a98371aba
  * * Author: Dmitry V. Levin <ldv@altlinux.org>
  * * Date:   Tue, 29 Sep 2020 17:10:20 +0000 (14:10 -0300)
-\*/
+ */
 
 #include <stdio.h>
 #include <pwd.h>
@@ -200,4 +205,8 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tests),
 	.test_variants = 2,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"glibc-git", "574500a108be"},
+		{}
+	}
 };
-- 
2.30.1

