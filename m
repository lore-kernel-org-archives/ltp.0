From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Mon,  2 Aug 2021 19:06:20 +0300
Subject: [LTP] [PATCH v2] shmget02: check if CONFIG_HUGETLBFS enabled in
 kernel
Message-ID: <20210802160620.9544-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Two tests call shmget with a flag SHM_HUGETLB, trying to
allocate the segment using "huge" pages. The hugetlbpage
support needs to be enabled in kernel (CONFIG_HUGETLBFS),
otherwise shmget returns EINVAL.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 .../kernel/syscalls/ipc/shmget/shmget02.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 66a4b94ee..7616178be 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -32,10 +32,13 @@
 #include <sys/shm.h>
 #include <grp.h>
 #include "tst_safe_sysv_ipc.h"
+#include "tst_kconfig.h"
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "lapi/shm.h"
 
+#define CONFIG_HUGETLBFS "CONFIG_HUGETLBFS"
+
 static int shm_id = -1;
 static key_t shmkey, shmkey1;
 static struct passwd *pw;
@@ -60,6 +63,17 @@ static struct tcase {
 	{&shmkey1, SHM_SIZE, IPC_CREAT | SHM_HUGETLB, 0, 0, ENOMEM}
 };
 
+static int hugetlbfs_supported()
+{
+	struct tst_kconfig_var kconfig = {
+		.id = CONFIG_HUGETLBFS,
+		.id_len = sizeof(CONFIG_HUGETLBFS)-1,
+	};
+
+	tst_kconfig_read(&kconfig, 1);
+	return kconfig.choice == 'y';
+}
+
 static void do_test(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -94,6 +108,16 @@ static void setup(void)
 	SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &rl);
 	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL);
 	pw = SAFE_GETPWNAM("nobody");
+	
+	if (! hugetlbfs_supported()) {
+
+		tst_res(TINFO, "SHM_HUGETLB not supported by kernel");
+
+		for (int i = 0; i < ARRAY_SIZE(tcases); i++) {
+				if (tcases[i].flags & SHM_HUGETLB)
+						tcases[i].exp_err = EINVAL;
+		}
+	}
 }
 
 static void cleanup(void)
-- 
2.32.0

