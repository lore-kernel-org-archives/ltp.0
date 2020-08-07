From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 7 Aug 2020 17:42:06 +0800
Subject: [LTP] [PATCH] lib/tst_cgroup: Reset cgroup.clone_children value
Message-ID: <1596793326-21639-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running cgroup test cases(like cpuset01 or oom05) about cpuset subsystem
firstly, then cpuset_inherit case will fail because the value of
cgroup.clone_children has been changed into 1 on cgroup-v1. Reset this value
when calling tst_cgroupN_umount.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 lib/tst_cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 9459f7ea0..764951afa 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -9,6 +9,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/mount.h>
+#include <fcntl.h>
+#include <unistd.h>
 
 #include "tst_test.h"
 #include "tst_safe_macros.h"
@@ -123,6 +125,7 @@ static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
 	FILE *fp;
 	int fd;
 	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+	char knob_path[PATH_MAX];
 
 	if (!tst_is_mounted(mnt_path))
 		return;
@@ -151,6 +154,11 @@ static void tst_cgroupN_umount(const char *mnt_path, const char *new_path)
 			    != (ssize_t)strlen(value) - 1)
 				tst_res(TWARN | TERRNO, "write %s", s);
 	}
+	if (tst_cg_ver & TST_CGROUP_V1) {
+		sprintf(knob_path, "%s/cgroup.clone_children", mnt_path);
+		if (!access(knob_path, F_OK))
+			SAFE_FILE_PRINTF(knob_path, "%d", 0);
+	}
 	if (fd != -1)
 		close(fd);
 	if (fp != NULL)
-- 
2.23.0



