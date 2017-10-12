From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu, 12 Oct 2017 18:36:53 +0800
Subject: [LTP] [PATCH] shmctl: enable subtest SHM_LOCK SHM_UNLOCK only if
	kernel < 2.6.9
Message-ID: <1507804613-18349-1-git-send-email-lizhijian@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

from man page, we can know that:
-----------------
EPERM  IPC_SET  or  IPC_RMID  is  attempted, and the effective user ID of the calling process is not that of the creator (found in shm_perm.cuid), or the owner (found in shm_perm.uid), and the
  process was not privileged (Linux: did not have the CAP_SYS_ADMIN capability).
  Or (in kernels before 2.6.9), SHM_LOCK or SHM_UNLOCK was specified, but the process was not privileged (Linux: did not have the CAP_IPC_LOCK capability).  (Since Linux 2.6.9, this error
  can also occur if the RLIMIT_MEMLOCK is 0 and the caller is not privileged.)
-----------------

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl02.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index 563f687..49bf846 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -55,6 +55,7 @@
  *	none
  */
 
+#include <linux/version.h>
 #include "ipcshm.h"
 #include <pwd.h>
 
@@ -90,11 +91,13 @@ struct test_case_t {
 	{
 	&shm_id_2, -1, &buf, EINVAL},
 	    /* EPERM - the command is only valid for the super-user */
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 9)
 	{
 	&shm_id_2, SHM_LOCK, &buf, EPERM},
 	    /* EPERM - the command is only valid for the super-user */
 	{
 	&shm_id_2, SHM_UNLOCK, &buf, EPERM}
+#endif
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
-- 
2.7.4



