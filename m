From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 18 Mar 2021 17:24:09 +0100
Subject: [LTP] [PATCH] syscalls/semctl09: Skip libc test if SEM_STAT_ANY not
 defined
Message-ID: <20210318162409.9871-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The libc test variant should run only if system headers define SEM_STAT_ANY.
Skip it if we're falling back to the LAPI definition.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 configure.ac                                    | 1 +
 testcases/kernel/syscalls/ipc/semctl/semctl09.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 37bafb93d..136d82d09 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,6 +38,7 @@ AC_PREFIX_DEFAULT(/opt/ltp)
 AC_CHECK_DECLS([IFLA_NET_NS_PID],,,[#include <linux/if_link.h>])
 AC_CHECK_DECLS([MADV_MERGEABLE],,,[#include <sys/mman.h>])
 AC_CHECK_DECLS([PR_CAPBSET_DROP, PR_CAPBSET_READ],,,[#include <sys/prctl.h>])
+AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
     asm/ldt.h \
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index a933cff0e..fb7d49f3d 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -186,6 +186,11 @@ static void setup(void)
 	nobody_uid = ltpuser->pw_uid;
 	root_uid = 0;
 
+#if !HAVE_DECL_SEM_STAT_ANY
+	if (tst_variant == 1)
+		tst_brk(TCONF, "libc does not support semctl(SEM_STAT_ANY)");
+#endif
+
 	sem_id = SAFE_SEMGET(IPC_PRIVATE, 2, IPC_CREAT | 0600);
 	test_info();
 }
-- 
2.30.2

