From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 12 Oct 2018 16:10:54 +0300
Subject: [LTP] [PATCH V2 2/5] Rename CVE 2012-0957, 2016-4997, 2017-5669,
	2017-6951 tests
In-Reply-To: <1539349857-10633-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1539349857-10633-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1539349857-10633-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 - moved source files to corresponding directories

 runtest/cve                                        |    8 +-
 runtest/syscalls                                   |    8 +-
 testcases/cve/.gitignore                           |    4 -
 testcases/cve/cve-2012-0957.c                      |   94 --------------
 testcases/cve/cve-2016-4997.c                      |  129 --------------------
 testcases/cve/cve-2017-5669.c                      |  113 -----------------
 testcases/cve/cve-2017-6951.c                      |   46 -------
 testcases/kernel/syscalls/ipc/shmat/.gitignore     |    1 +
 testcases/kernel/syscalls/ipc/shmat/shmat03.c      |  113 +++++++++++++++++
 testcases/kernel/syscalls/request_key/.gitignore   |    1 +
 .../kernel/syscalls/request_key/request_key05.c    |   46 +++++++
 testcases/kernel/syscalls/setsockopt/.gitignore    |    1 +
 .../kernel/syscalls/setsockopt/setsockopt03.c      |  129 ++++++++++++++++++++
 testcases/kernel/syscalls/uname/.gitignore         |    1 +
 testcases/kernel/syscalls/uname/Makefile           |    2 +
 testcases/kernel/syscalls/uname/uname04.c          |   94 ++++++++++++++
 16 files changed, 396 insertions(+), 394 deletions(-)
 delete mode 100644 testcases/cve/cve-2012-0957.c
 delete mode 100644 testcases/cve/cve-2016-4997.c
 delete mode 100644 testcases/cve/cve-2017-5669.c
 delete mode 100644 testcases/cve/cve-2017-6951.c
 create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat03.c
 create mode 100644 testcases/kernel/syscalls/request_key/request_key05.c
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt03.c
 create mode 100644 testcases/kernel/syscalls/uname/uname04.c

diff --git a/runtest/cve b/runtest/cve
index b38fb35..4fc67ce 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -2,13 +2,13 @@
 cve-2011-0999 thp01 -I 120
 cve-2011-2183 ksm05 -I 10
 cve-2011-2496 vma03
-cve-2012-0957 cve-2012-0957
+cve-2012-0957 uname04
 cve-2014-0196 cve-2014-0196
 cve-2015-0235 gethostbyname_r01
 cve-2015-7550 keyctl02
 cve-2016-4470 keyctl01.sh
 cve-2015-3290 cve-2015-3290
-cve-2016-4997 cve-2016-4997
+cve-2016-4997 setsockopt03
 cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
@@ -16,8 +16,8 @@ cve-2016-9604 keyctl08
 cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
 cve-2017-2671 cve-2017-2671
-cve-2017-5669 cve-2017-5669
-cve-2017-6951 cve-2017-6951
+cve-2017-5669 shmat03
+cve-2017-6951 request_key05
 cve-2017-7308 setsockopt02
 cve-2017-7472 keyctl04
 cve-2017-12192 keyctl07
diff --git a/runtest/syscalls b/runtest/syscalls
index 53a4a42..7ad4262 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -960,8 +960,8 @@ renameat202 renameat202 -i 10
 request_key01 request_key01
 request_key02 request_key02
 request_key03 request_key03
-cve-2017-6951 cve-2017-6951
 request_key04 request_key04
+request_key05 request_key05
 
 rmdir01 rmdir01
 rmdir02 rmdir02
@@ -1187,7 +1187,7 @@ setsid01 setsid01
 
 setsockopt01 setsockopt01
 setsockopt02 setsockopt02
-cve-2016-4997 cve-2016-4997
+setsockopt03 setsockopt03
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
@@ -1205,7 +1205,7 @@ setxattr03 setxattr03
 
 shmat01 shmat01
 shmat02 shmat02
-cve-2017-5669 cve-2017-5669
+shmat03 shmat03
 
 shmctl01 shmctl01
 shmctl02 shmctl02
@@ -1400,7 +1400,7 @@ umask01 umask01
 uname01 uname01
 uname02 uname02
 uname03 uname03
-cve-2012-0957 cve-2012-0957
+uname04 uname04
 
 unlink01 symlink01 -T unlink01
 unlink05 unlink05
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index b05c0de..01a3e4c 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -1,14 +1,10 @@
-cve-2012-0957
 cve-2014-0196
 cve-2015-3290
-cve-2016-4997
 cve-2016-7042
 cve-2016-7117
 cve-2016-10044
 cve-2017-2618
 cve-2017-2671
-cve-2017-6951
-cve-2017-5669
 meltdown
 stack_clash
 cve-2017-17052
diff --git a/testcases/cve/cve-2012-0957.c b/testcases/cve/cve-2012-0957.c
deleted file mode 100644
index e4d9e8f..0000000
--- a/testcases/cve/cve-2012-0957.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- * Copyright (c) 2012, Kees Cook <keescook@chromium.org>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-/*
- * Check that memory after the string terminator in all the utsname fields has
- * been zeroed. cve-2012-0957 leaked kernel memory through the release field
- * when the UNAME26 personality was set.
- *
- * Thanks to Kees Cook for the original proof of concept:
- * http://www.securityfocus.com/bid/55855/info
- */
-
-#include <string.h>
-#include <sys/utsname.h>
-#include "tst_test.h"
-#include "lapi/personality.h"
-
-static struct utsname saved_buf;
-
-static int check_field(char *bytes, char *saved_bytes, size_t length,
-		       char *field)
-{
-	size_t i = strlen(bytes) + 1;
-
-	for (; i < length; i++) {
-		if (bytes[i] && (bytes[i] != saved_bytes[i])) {
-			tst_res(TFAIL, "Bytes leaked in %s!", field);
-			return 1;
-		}
-	}
-	return 0;
-}
-
-
-static void try_leak_bytes(unsigned int test_nr)
-{
-	struct utsname buf;
-
-	memset(&buf, 0, sizeof(buf));
-
-	if (uname(&buf))
-		tst_brk(TBROK | TERRNO, "Call to uname failed");
-
-	if (!test_nr)
-		memcpy(&saved_buf, &buf, sizeof(saved_buf));
-
-#define CHECK_FIELD(field_name) \
-	(check_field(buf.field_name, saved_buf.field_name, \
-		     ARRAY_SIZE(buf.field_name), #field_name))
-
-	if (!(CHECK_FIELD(release) |
-	    CHECK_FIELD(sysname) |
-	    CHECK_FIELD(nodename) |
-	    CHECK_FIELD(version) |
-	    CHECK_FIELD(machine) |
-#ifdef HAVE_STRUCT_UTSNAME_DOMAINNAME
-	    CHECK_FIELD(domainname) |
-#endif
-		    0)) {
-		tst_res(TPASS, "No bytes leaked");
-	}
-#undef CHECK_FIELD
-}
-
-static void run(unsigned int test_nr)
-{
-	if (!test_nr) {
-		tst_res(TINFO, "Calling uname with default personality");
-	} else {
-		SAFE_PERSONALITY(PER_LINUX | UNAME26);
-		tst_res(TINFO, "Calling uname with UNAME26 personality");
-	}
-
-	try_leak_bytes(test_nr);
-}
-
-static struct tst_test test = {
-	.test = run,
-	.tcnt = 2,
-};
diff --git a/testcases/cve/cve-2016-4997.c b/testcases/cve/cve-2016-4997.c
deleted file mode 100644
index 2d99865..0000000
--- a/testcases/cve/cve-2016-4997.c
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- * Based on repro-compatReleaseEntry.c by NCC group
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-/*
- * Test for CVE-2016-4997
- *
- * For a full explanation of how the vulnerability works see:
- * https://github.com/nccgroup/TriforceLinuxSyscallFuzzer/tree/master/crash_reports/report_compatIpt
- *
- * The original vulnerability was present in the 32-bit compatibility system
- * call, so the test should be compiled with -m32 and run on a 64-bit kernel.
- * For simplicities sake the test requests root privliges instead of creating
- * a user namespace.
- */
-
-#include <stdint.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <net/if.h>
-#include <limits.h>
-#include <linux/netfilter_ipv4/ip_tables.h>
-
-#include "tst_test.h"
-#include "tst_safe_net.h"
-#include "tst_kernel.h"
-
-#define TOO_SMALL_OFFSET 74
-#define OFFSET_OVERWRITE 0xFFFF
-#define NEXT_OFFSET (sizeof(struct ipt_entry)		\
-		     + sizeof(struct xt_entry_match)	\
-		     + sizeof(struct xt_entry_target))
-#define PADDING (OFFSET_OVERWRITE - NEXT_OFFSET)
-
-#ifndef HAVE_STRUCT_XT_ENTRY_MATCH
-struct xt_entry_match {
-	union {
-		struct {
-			uint16_t match_size;
-			char name[29];
-			uint8_t revision;
-		} user;
-		struct {
-			uint16_t match_size;
-			void *match;
-		} kernel;
-		uint16_t match_size;
-	} u;
-	unsigned char data[0];
-};
-#endif
-
-#ifndef HAVE_STRUCT_XT_ENTRY_TARGET
-struct xt_entry_target {
-	union {
-		struct {
-			uint16_t target_size;
-			char name[29];
-			uint8_t revision;
-		} user;
-		struct {
-			uint16_t target_size;
-			void *target;
-		} kernel;
-		uint16_t target_size;
-	} u;
-	unsigned char data[0];
-};
-#endif
-
-struct payload {
-	struct ipt_replace repl;
-	struct ipt_entry ent;
-	struct xt_entry_match match;
-	struct xt_entry_target targ;
-	char padding[PADDING];
-	struct xt_entry_target targ2;
-};
-
-static void setup(void)
-{
-	if (tst_kernel_bits() == 32 || sizeof(long) > 4)
-		tst_res(TCONF,
-			"The vulnerability was only present in 32-bit compat mode");
-}
-
-static void run(void)
-{
-	int ret, sock_fd;
-	struct payload p = { 0 };
-
-	sock_fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
-
-	strncpy(p.match.u.user.name, "icmp", sizeof(p.match.u.user.name));
-	p.match.u.match_size = OFFSET_OVERWRITE;
-
-	p.ent.next_offset = NEXT_OFFSET;
-	p.ent.target_offset = TOO_SMALL_OFFSET;
-
-	p.repl.num_entries = 2;
-	p.repl.num_counters = 1;
-	p.repl.size = sizeof(struct payload);
-	p.repl.valid_hooks = 0;
-
-	ret = setsockopt(sock_fd, SOL_IP, IPT_SO_SET_REPLACE,
-			 &p, sizeof(struct payload));
-	tst_res(TPASS | TERRNO, "We didn't cause a crash, setsockopt returned %d", ret);
-}
-
-static struct tst_test test = {
-	.min_kver = "2.6.32",
-	.setup = setup,
-	.test_all = run,
-	.needs_root = 1,
-};
diff --git a/testcases/cve/cve-2017-5669.c b/testcases/cve/cve-2017-5669.c
deleted file mode 100644
index 0834626..0000000
--- a/testcases/cve/cve-2017-5669.c
+++ /dev/null
@@ -1,113 +0,0 @@
-/*
- * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- * Copyright (c) 2017 Fujitsu Ltd. (Xiao Yang <yangx.jy@cn.fujitsu.com>)
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-/*
- * Test for CVE-2017-5669 which allows us to map the nil page using shmat.
- *
- * When the bug is present shmat(..., (void *)1, SHM_RND) will round address
- * 0x1 down to zero and give us the (nil/null) page. With the current bug fix
- * in place, shmat it will return EINVAL instead. We also check to see if the
- * returned address is outside the nil page in case an alternative fix has
- * been applied.
- *
- * In any case we manage to map some memory we also try to write to it. This
- * is just to see if we get an access error or some other unexpected behaviour.
- *
- * See commit 95e91b831f (ipc/shm: Fix shmat mmap nil-page protection)
- *
- * The commit above disallowed SHM_RND maps to zero (and rounded) entirely and
- * that broke userland for cases like Xorg. New behavior disallows REMAPs to
- * lower addresses (0<=PAGESIZE).
- *
- * See commit a73ab244f0da (Revert "ipc/shm: Fix shmat mmap nil-page protect...)
- * See commit 8f89c007b6de (ipc/shm: fix shmat() nil address after round-dow...)
- * See https://github.com/linux-test-project/ltp/issues/319
- *
- * This test needs root permissions or else security_mmap_addr(), from
- * get_unmapped_area(), will cause permission errors when trying to mmap lower
- * addresses.
- */
-
-#include <sys/types.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-
-#include <stdio.h>
-#include <errno.h>
-#include <string.h>
-
-#include "tst_test.h"
-#include "tst_safe_sysv_ipc.h"
-
-static int shm_id;
-static void *shm_addr;
-
-static void setup(void)
-{
-	shm_id = SAFE_SHMGET(IPC_PRIVATE, getpagesize(), 0777);
-}
-
-static void cleanup(void)
-{
-	if (shm_addr)
-		SAFE_SHMDT(shm_addr);
-
-	if (shm_id)
-		SAFE_SHMCTL(shm_id, IPC_RMID, 0);
-}
-
-static void run(void)
-{
-	tst_res(TINFO, "Attempting to attach shared memory to null page");
-	/*
-	 * shmat() for 0 (or < PAGESIZE with RND flag) has to fail with REMAPs
-	 * https://github.com/linux-test-project/ltp/issues/319
-	 */
-	shm_addr = shmat(shm_id, ((void *)1), SHM_RND | SHM_REMAP);
-	if (shm_addr == (void *)-1) {
-		shm_addr = NULL;
-		if (errno == EINVAL) {
-			tst_res(TPASS, "shmat returned EINVAL");
-			return;
-		}
-		tst_brk(TBROK | TERRNO,
-			"The bug was not triggered, but the shmat error is unexpected");
-	}
-
-	tst_res(TINFO, "Mapped shared memory to %p", shm_addr);
-
-	if (!((size_t)shm_addr & (~0U << 16)))
-		tst_res(TFAIL,
-			"We have mapped a VM address within the first 64Kb");
-	else
-		tst_res(TPASS,
-			"The kernel assigned a different VM address");
-
-	tst_res(TINFO,
-		"Touching shared memory to see if anything strange happens");
-	((char *)shm_addr)[0] = 'P';
-
-	SAFE_SHMDT(shm_addr);
-	shm_addr = NULL;
-}
-
-static struct tst_test test = {
-	.needs_root = 1,
-	.setup = setup,
-	.cleanup = cleanup,
-	.test_all = run,
-};
diff --git a/testcases/cve/cve-2017-6951.c b/testcases/cve/cve-2017-6951.c
deleted file mode 100644
index 028e25f..0000000
--- a/testcases/cve/cve-2017-6951.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
-/*
- * Test for CVE-2016-6951, original reproducer can be found here:
- * http://www.spinics.net/lists/keyrings/msg01845.html
- *
- * request_key() is not in glibc, so we just use the syscall directly instead
- * of linking to keyutils.
- */
-
-#include <unistd.h>
-#include <sys/syscall.h>
-
-#include "tst_test.h"
-#include "lapi/syscalls.h"
-
-#define ATTEMPTS 0x100
-
-static void run(void)
-{
-	int i;
-
-	tst_res(TINFO, "Requesting dead key");
-	for (i = 0; i < ATTEMPTS; i++)
-		tst_syscall(__NR_request_key, "dead", "abc", "abc", 0, 0, 0);
-
-	tst_res(TPASS, "No crash after %d attempts", ATTEMPTS);
-}
-
-static struct tst_test test = {
-	.test_all = run,
-};
diff --git a/testcases/kernel/syscalls/ipc/shmat/.gitignore b/testcases/kernel/syscalls/ipc/shmat/.gitignore
index 488abd3..2b972f8 100644
--- a/testcases/kernel/syscalls/ipc/shmat/.gitignore
+++ b/testcases/kernel/syscalls/ipc/shmat/.gitignore
@@ -1,2 +1,3 @@
 /shmat01
 /shmat02
+/shmat03
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat03.c b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
new file mode 100644
index 0000000..0834626
--- /dev/null
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat03.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Copyright (c) 2017 Fujitsu Ltd. (Xiao Yang <yangx.jy@cn.fujitsu.com>)
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/*
+ * Test for CVE-2017-5669 which allows us to map the nil page using shmat.
+ *
+ * When the bug is present shmat(..., (void *)1, SHM_RND) will round address
+ * 0x1 down to zero and give us the (nil/null) page. With the current bug fix
+ * in place, shmat it will return EINVAL instead. We also check to see if the
+ * returned address is outside the nil page in case an alternative fix has
+ * been applied.
+ *
+ * In any case we manage to map some memory we also try to write to it. This
+ * is just to see if we get an access error or some other unexpected behaviour.
+ *
+ * See commit 95e91b831f (ipc/shm: Fix shmat mmap nil-page protection)
+ *
+ * The commit above disallowed SHM_RND maps to zero (and rounded) entirely and
+ * that broke userland for cases like Xorg. New behavior disallows REMAPs to
+ * lower addresses (0<=PAGESIZE).
+ *
+ * See commit a73ab244f0da (Revert "ipc/shm: Fix shmat mmap nil-page protect...)
+ * See commit 8f89c007b6de (ipc/shm: fix shmat() nil address after round-dow...)
+ * See https://github.com/linux-test-project/ltp/issues/319
+ *
+ * This test needs root permissions or else security_mmap_addr(), from
+ * get_unmapped_area(), will cause permission errors when trying to mmap lower
+ * addresses.
+ */
+
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
+
+static int shm_id;
+static void *shm_addr;
+
+static void setup(void)
+{
+	shm_id = SAFE_SHMGET(IPC_PRIVATE, getpagesize(), 0777);
+}
+
+static void cleanup(void)
+{
+	if (shm_addr)
+		SAFE_SHMDT(shm_addr);
+
+	if (shm_id)
+		SAFE_SHMCTL(shm_id, IPC_RMID, 0);
+}
+
+static void run(void)
+{
+	tst_res(TINFO, "Attempting to attach shared memory to null page");
+	/*
+	 * shmat() for 0 (or < PAGESIZE with RND flag) has to fail with REMAPs
+	 * https://github.com/linux-test-project/ltp/issues/319
+	 */
+	shm_addr = shmat(shm_id, ((void *)1), SHM_RND | SHM_REMAP);
+	if (shm_addr == (void *)-1) {
+		shm_addr = NULL;
+		if (errno == EINVAL) {
+			tst_res(TPASS, "shmat returned EINVAL");
+			return;
+		}
+		tst_brk(TBROK | TERRNO,
+			"The bug was not triggered, but the shmat error is unexpected");
+	}
+
+	tst_res(TINFO, "Mapped shared memory to %p", shm_addr);
+
+	if (!((size_t)shm_addr & (~0U << 16)))
+		tst_res(TFAIL,
+			"We have mapped a VM address within the first 64Kb");
+	else
+		tst_res(TPASS,
+			"The kernel assigned a different VM address");
+
+	tst_res(TINFO,
+		"Touching shared memory to see if anything strange happens");
+	((char *)shm_addr)[0] = 'P';
+
+	SAFE_SHMDT(shm_addr);
+	shm_addr = NULL;
+}
+
+static struct tst_test test = {
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
diff --git a/testcases/kernel/syscalls/request_key/.gitignore b/testcases/kernel/syscalls/request_key/.gitignore
index 4c813a8..e8dc1c5 100644
--- a/testcases/kernel/syscalls/request_key/.gitignore
+++ b/testcases/kernel/syscalls/request_key/.gitignore
@@ -2,3 +2,4 @@
 /request_key02
 /request_key03
 /request_key04
+/request_key05
diff --git a/testcases/kernel/syscalls/request_key/request_key05.c b/testcases/kernel/syscalls/request_key/request_key05.c
new file mode 100644
index 0000000..028e25f
--- /dev/null
+++ b/testcases/kernel/syscalls/request_key/request_key05.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/*
+ * Test for CVE-2016-6951, original reproducer can be found here:
+ * http://www.spinics.net/lists/keyrings/msg01845.html
+ *
+ * request_key() is not in glibc, so we just use the syscall directly instead
+ * of linking to keyutils.
+ */
+
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+
+#define ATTEMPTS 0x100
+
+static void run(void)
+{
+	int i;
+
+	tst_res(TINFO, "Requesting dead key");
+	for (i = 0; i < ATTEMPTS; i++)
+		tst_syscall(__NR_request_key, "dead", "abc", "abc", 0, 0, 0);
+
+	tst_res(TPASS, "No crash after %d attempts", ATTEMPTS);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
index 2b24f9f..d8fb0f3 100644
--- a/testcases/kernel/syscalls/setsockopt/.gitignore
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -1,2 +1,3 @@
 /setsockopt01
 /setsockopt02
+/setsockopt03
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
new file mode 100644
index 0000000..2d99865
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Based on repro-compatReleaseEntry.c by NCC group
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/*
+ * Test for CVE-2016-4997
+ *
+ * For a full explanation of how the vulnerability works see:
+ * https://github.com/nccgroup/TriforceLinuxSyscallFuzzer/tree/master/crash_reports/report_compatIpt
+ *
+ * The original vulnerability was present in the 32-bit compatibility system
+ * call, so the test should be compiled with -m32 and run on a 64-bit kernel.
+ * For simplicities sake the test requests root privliges instead of creating
+ * a user namespace.
+ */
+
+#include <stdint.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <net/if.h>
+#include <limits.h>
+#include <linux/netfilter_ipv4/ip_tables.h>
+
+#include "tst_test.h"
+#include "tst_safe_net.h"
+#include "tst_kernel.h"
+
+#define TOO_SMALL_OFFSET 74
+#define OFFSET_OVERWRITE 0xFFFF
+#define NEXT_OFFSET (sizeof(struct ipt_entry)		\
+		     + sizeof(struct xt_entry_match)	\
+		     + sizeof(struct xt_entry_target))
+#define PADDING (OFFSET_OVERWRITE - NEXT_OFFSET)
+
+#ifndef HAVE_STRUCT_XT_ENTRY_MATCH
+struct xt_entry_match {
+	union {
+		struct {
+			uint16_t match_size;
+			char name[29];
+			uint8_t revision;
+		} user;
+		struct {
+			uint16_t match_size;
+			void *match;
+		} kernel;
+		uint16_t match_size;
+	} u;
+	unsigned char data[0];
+};
+#endif
+
+#ifndef HAVE_STRUCT_XT_ENTRY_TARGET
+struct xt_entry_target {
+	union {
+		struct {
+			uint16_t target_size;
+			char name[29];
+			uint8_t revision;
+		} user;
+		struct {
+			uint16_t target_size;
+			void *target;
+		} kernel;
+		uint16_t target_size;
+	} u;
+	unsigned char data[0];
+};
+#endif
+
+struct payload {
+	struct ipt_replace repl;
+	struct ipt_entry ent;
+	struct xt_entry_match match;
+	struct xt_entry_target targ;
+	char padding[PADDING];
+	struct xt_entry_target targ2;
+};
+
+static void setup(void)
+{
+	if (tst_kernel_bits() == 32 || sizeof(long) > 4)
+		tst_res(TCONF,
+			"The vulnerability was only present in 32-bit compat mode");
+}
+
+static void run(void)
+{
+	int ret, sock_fd;
+	struct payload p = { 0 };
+
+	sock_fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+
+	strncpy(p.match.u.user.name, "icmp", sizeof(p.match.u.user.name));
+	p.match.u.match_size = OFFSET_OVERWRITE;
+
+	p.ent.next_offset = NEXT_OFFSET;
+	p.ent.target_offset = TOO_SMALL_OFFSET;
+
+	p.repl.num_entries = 2;
+	p.repl.num_counters = 1;
+	p.repl.size = sizeof(struct payload);
+	p.repl.valid_hooks = 0;
+
+	ret = setsockopt(sock_fd, SOL_IP, IPT_SO_SET_REPLACE,
+			 &p, sizeof(struct payload));
+	tst_res(TPASS | TERRNO, "We didn't cause a crash, setsockopt returned %d", ret);
+}
+
+static struct tst_test test = {
+	.min_kver = "2.6.32",
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+};
diff --git a/testcases/kernel/syscalls/uname/.gitignore b/testcases/kernel/syscalls/uname/.gitignore
index 1bcf6a4..4f153e7 100644
--- a/testcases/kernel/syscalls/uname/.gitignore
+++ b/testcases/kernel/syscalls/uname/.gitignore
@@ -1,3 +1,4 @@
 /uname01
 /uname02
 /uname03
+/uname04
diff --git a/testcases/kernel/syscalls/uname/Makefile b/testcases/kernel/syscalls/uname/Makefile
index bd617d8..eceaa64 100644
--- a/testcases/kernel/syscalls/uname/Makefile
+++ b/testcases/kernel/syscalls/uname/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+uname04:	CFLAGS += -D_GNU_SOURCE
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/uname/uname04.c b/testcases/kernel/syscalls/uname/uname04.c
new file mode 100644
index 0000000..e4d9e8f
--- /dev/null
+++ b/testcases/kernel/syscalls/uname/uname04.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Copyright (c) 2012, Kees Cook <keescook@chromium.org>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/*
+ * Check that memory after the string terminator in all the utsname fields has
+ * been zeroed. cve-2012-0957 leaked kernel memory through the release field
+ * when the UNAME26 personality was set.
+ *
+ * Thanks to Kees Cook for the original proof of concept:
+ * http://www.securityfocus.com/bid/55855/info
+ */
+
+#include <string.h>
+#include <sys/utsname.h>
+#include "tst_test.h"
+#include "lapi/personality.h"
+
+static struct utsname saved_buf;
+
+static int check_field(char *bytes, char *saved_bytes, size_t length,
+		       char *field)
+{
+	size_t i = strlen(bytes) + 1;
+
+	for (; i < length; i++) {
+		if (bytes[i] && (bytes[i] != saved_bytes[i])) {
+			tst_res(TFAIL, "Bytes leaked in %s!", field);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+
+static void try_leak_bytes(unsigned int test_nr)
+{
+	struct utsname buf;
+
+	memset(&buf, 0, sizeof(buf));
+
+	if (uname(&buf))
+		tst_brk(TBROK | TERRNO, "Call to uname failed");
+
+	if (!test_nr)
+		memcpy(&saved_buf, &buf, sizeof(saved_buf));
+
+#define CHECK_FIELD(field_name) \
+	(check_field(buf.field_name, saved_buf.field_name, \
+		     ARRAY_SIZE(buf.field_name), #field_name))
+
+	if (!(CHECK_FIELD(release) |
+	    CHECK_FIELD(sysname) |
+	    CHECK_FIELD(nodename) |
+	    CHECK_FIELD(version) |
+	    CHECK_FIELD(machine) |
+#ifdef HAVE_STRUCT_UTSNAME_DOMAINNAME
+	    CHECK_FIELD(domainname) |
+#endif
+		    0)) {
+		tst_res(TPASS, "No bytes leaked");
+	}
+#undef CHECK_FIELD
+}
+
+static void run(unsigned int test_nr)
+{
+	if (!test_nr) {
+		tst_res(TINFO, "Calling uname with default personality");
+	} else {
+		SAFE_PERSONALITY(PER_LINUX | UNAME26);
+		tst_res(TINFO, "Calling uname with UNAME26 personality");
+	}
+
+	try_leak_bytes(test_nr);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+};
-- 
1.7.1

