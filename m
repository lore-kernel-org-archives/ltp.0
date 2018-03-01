From: Yang Xu <xuyang.jy@cn.fujitsu.com>
Date: Thu, 1 Mar 2018 21:48:58 +0800
Subject: [LTP] [PATCH 1/2] utils/compat_16: Add compat_tst_16.h for new API
Message-ID: <1519912139-18839-1-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: yang xu <xuyang.jy@cn.fujitsu.com>

1) Make sure compat_16.mk can be used by both new API and old API
2) Remove unused TST_COMPAT_16_SYSCALL judgment in compat_16.mk

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/utils/compat_16.mk    |  11 +-
 testcases/kernel/syscalls/utils/compat_tst_16.h | 157 ++++++++++++++++++++++++
 2 files changed, 162 insertions(+), 6 deletions(-)
 create mode 100644 testcases/kernel/syscalls/utils/compat_tst_16.h

diff --git a/testcases/kernel/syscalls/utils/compat_16.mk b/testcases/kernel/syscalls/utils/compat_16.mk
index 3378908..0565dde 100644
--- a/testcases/kernel/syscalls/utils/compat_16.mk
+++ b/testcases/kernel/syscalls/utils/compat_16.mk
@@ -12,9 +12,7 @@
 #  the GNU General Public License for more details.
 #
 #  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
+#  along with this program. If not, see <http://www.gnu.org/licenses/>.
 
 # Author: Masatake YAMATO <yamato@redhat.com>
 # Technique used here is suggested by Ngie Cooper <yaneurabeya@gmail.com>
@@ -56,16 +54,17 @@ SRCS			?= $(wildcard $(abs_srcdir)/*.c)
 
 MAKE_TARGETS		:= $(notdir $(patsubst %.c,%,$(SRCS)))
 MAKE_TARGETS_OBJS_WO_COMPAT_16	:= $(addsuffix .o,$(MAKE_TARGETS))
-
-ifneq ($(TST_COMPAT_16_SYSCALL),no)
 MAKE_TARGETS		+= $(addsuffix _16,$(MAKE_TARGETS))
-endif
 
 # XXX (garrcoop): This code should be put in question as it cannot be applied
 # (no .h file, no TST_USE_NEWER64_SYSCALL def).
 DEF_16			:= TST_USE_COMPAT16_SYSCALL
 
+ifneq ($(COMPAT_TST_16_H),1)
 COMPAT_16_H		:= $(abs_srcdir)/../utils/compat_16.h
+else
+COMPAT_16_H     := $(abs_srcdir)/../utils/compat_tst_16.h
+endif
 
 ifneq ($(wildcard $(COMPAT_16_H)),)
 HAS_COMPAT_16		:= 1
diff --git a/testcases/kernel/syscalls/utils/compat_tst_16.h b/testcases/kernel/syscalls/utils/compat_tst_16.h
new file mode 100644
index 0000000..bb30c6f
--- /dev/null
+++ b/testcases/kernel/syscalls/utils/compat_tst_16.h
@@ -0,0 +1,157 @@
+/*
+ * Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
+ * Author: yang xu <xuyang.jy@cn.fujitsu.com>
+ *
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __LTP_COMPAT_TST_16_H__
+#define __LTP_COMPAT_TST_16_H__
+
+#include <errno.h>
+#include <grp.h>
+#if defined(__GLIBC__) || defined(__ANDROID__)
+#include <sys/fsuid.h>
+#endif
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "compat_gid.h"
+#include "compat_uid.h"
+#include "lapi/syscalls.h"
+
+int setresuid(uid_t ruid, uid_t euid, uid_t suid);
+int setresgid(gid_t rgid, gid_t egid, gid_t sgid);
+
+
+/* If the platform has __NR_sys_name32 defined it
+ * means that __NR_sys_name is a 16-bit version of
+ * sys_name() syscall
+ */
+#ifdef TST_USE_COMPAT16_SYSCALL
+# define TST_CREATE_SYSCALL(sys_name, ...) ({ \
+	if (__NR_##sys_name##32 != __LTP__NR_INVALID_SYSCALL) { \
+		return tst_syscall(__NR_##sys_name, ##__VA_ARGS__); \
+	} else { \
+		tst_brk(TCONF, \
+			"16-bit version of %s() is not supported on your " \
+			"platform", #sys_name); \
+		return -1; \
+	} \
+})
+#else
+# define TST_CREATE_SYSCALL(sys_name, ...) ({\
+	return sys_name(__VA_ARGS__); \
+})
+#endif
+
+#define UID16_CHECK(uid, sys_name) ({ \
+	if (!UID_SIZE_CHECK(uid)) { \
+		tst_brk(TBROK, \
+			"uid %d of %s is too large for testing 16-bit " \
+			"version of %s()", uid, #uid, #sys_name); \
+	} \
+})
+#define GID16_CHECK(gid, sys_name) ({ \
+	if (!GID_SIZE_CHECK(gid)) { \
+		tst_brk(TBROK, \
+			"gid %d of %s is too large for testing 16-bit " \
+			"version of %s()", gid, #gid, #sys_name); \
+	} \
+})
+
+int SETGROUPS(size_t gidsetsize, GID_T *list)
+{
+	TST_CREATE_SYSCALL(setgroups, gidsetsize, list);
+}
+
+int GETGROUPS(size_t gidsetsize, GID_T *list)
+{
+	TST_CREATE_SYSCALL(getgroups, gidsetsize, list);
+}
+
+int SETUID(UID_T uid)
+{
+	TST_CREATE_SYSCALL(setuid, uid);
+}
+
+UID_T GETUID(void)
+{
+	TST_CREATE_SYSCALL(getuid);
+}
+
+int SETGID(GID_T gid)
+{
+	TST_CREATE_SYSCALL(setgid, gid);
+}
+
+GID_T GETGID(void)
+{
+	TST_CREATE_SYSCALL(getgid);
+}
+
+UID_T GETEUID(void)
+{
+	TST_CREATE_SYSCALL(geteuid);
+}
+
+GID_T GETEGID(void)
+{
+	TST_CREATE_SYSCALL(getegid);
+}
+
+int SETFSUID(UID_T uid)
+{
+	TST_CREATE_SYSCALL(setfsuid, uid);
+}
+
+int SETFSGID(GID_T gid)
+{
+	TST_CREATE_SYSCALL(setfsgid, gid);
+}
+
+int SETREUID(UID_T ruid, UID_T euid)
+{
+	TST_CREATE_SYSCALL(setreuid, ruid, euid);
+}
+int SETREGID(GID_T rgid, GID_T egid)
+{
+	TST_CREATE_SYSCALL(setregid, rgid, egid);
+}
+
+int SETRESUID(UID_T ruid, UID_T euid, UID_T suid)
+{
+	TST_CREATE_SYSCALL(setresuid, ruid, euid, suid);
+}
+
+int SETRESGID(GID_T rgid, GID_T egid, GID_T sgid)
+{
+	TST_CREATE_SYSCALL(setresgid, rgid, egid, sgid);
+}
+
+int FCHOWN(unsigned int fd, UID_T owner, GID_T group)
+{
+	TST_CREATE_SYSCALL(fchown, fd, owner, group);
+}
+
+int LCHOWN(const char *path, UID_T owner, GID_T group)
+{
+	TST_CREATE_SYSCALL(lchown, path, owner, group);
+}
+
+int CHOWN(const char *path, UID_T owner, GID_T group)
+{
+	TST_CREATE_SYSCALL(chown, path, owner, group);
+}
+#endif /* __LTP_COMPAT_TST_16_H__ */
-- 
1.8.3.1



