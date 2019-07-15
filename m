From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 15 Jul 2019 13:53:38 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/acct02: Add note about acct()
 kernel bug
Message-ID: <20190715115338.15884-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test is actually accidental regression test for:

commit 4d9570158b6260f449e317a5f9ed030c2504a615
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Thu Jan 4 16:17:49 2018 -0800

    kernel/acct.c: fix the acct->needcheck check in check_free_space()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Christian Amann <camann@suse.com>
---
 testcases/kernel/syscalls/acct/acct02.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index 0b2608c71..c2c20668e 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -16,6 +16,9 @@
  * that only the command issued by this test gets written into the accounting
  * file, the contents get parsed until the correct entry is found, or EOF
  * is reached.
+ *
+ * This is also accidental regression test for:
+ * 4d9570158b626 kernel/acct.c: fix the acct->needcheck check in check_free_space()
  */
 
 #include <sys/stat.h>
-- 
2.21.0

