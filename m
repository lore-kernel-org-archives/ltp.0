From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 22 Aug 2019 16:17:12 +0200
Subject: [LTP] [PATCH v2 1/2] capability: Introduce capability API
In-Reply-To: <20190808153825.18363-2-rpalethorpe@suse.com>
References: <20190808153825.18363-2-rpalethorpe@suse.com>
Message-ID: <20190822141713.26825-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allow users to easily ensure particular capabilities are either present or not
present during testing without requiring libcap.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

V2:
* Add docs
* Support 64bit capabilities
* Restructure code in various ways
* Only try to change the effective set. Inheritable has too many issues.
* Add tests

It occurred to me that if the user wants to spawn child processes then they
will either need to run as root or we need to do something quite complex. On
my system I am not able to set anything in the inheritable set as a normal
user and I don't know about ambient capabilities. These are set through a
different API, so we should consider carefully if we want to try support
setting those. Especially as it may just fail on most setups.

For the most part this is just useful for dropping CAP_SYS_ADMIN or failing
with a more accurate error message than "needs root".

 doc/test-writing-guidelines.txt |  78 ++++++++++++++++++++++
 include/lapi/capability.h       |  27 ++++++++
 include/tst_capability.h        |  48 ++++++++++++++
 include/tst_test.h              |   6 ++
 lib/tst_capability.c            | 110 ++++++++++++++++++++++++++++++++
 lib/tst_test.c                  |   3 +
 6 files changed, 272 insertions(+)
 create mode 100644 include/lapi/capability.h
 create mode 100644 include/tst_capability.h
 create mode 100644 lib/tst_capability.c

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 573dd08d9..e4463a443 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1699,6 +1699,84 @@ struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+2.2.31 Adding and removing capabilities
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some tests may require the presence or absence of particular
+capabilities. Using the API provided by 'tst_capability.h' the test author can
+try to ensure that some capabilities are either present or absent during the
+test.
+
+For example; below we try to create a raw socket, which requires
+CAP_NET_ADMIN. During setup we should be able to do it, then during run it
+should be impossible. The LTP capability library should drop CAP_NET_RAW
+(assuming we have it) after setup completes.
+
+[source,c]
+--------------------------------------------------------------------------------
+#include "tst_test.h"
+#include "tst_capability.h"
+#include "tst_safe_net.h"
+
+#include "lapi/socket.h"
+
+static void run(void)
+{
+	TEST(socket(AF_INET, SOCK_RAW, 1));
+	if (TST_RET > -1) {
+		tst_res(TFAIL, "Created raw socket");
+	} else if (TST_ERR != EPERM) {
+		tst_res(TBROK | TTERRNO,
+			"Failed to create socket for wrong reason");
+	} else {
+		tst_res(TPASS | TTERRNO, "Didn't create raw socket");
+	}
+}
+
+static void setup(void)
+{
+	TEST(socket(AF_INET, SOCK_RAW, 1));
+	if (TST_RET < 0)
+		tst_brk(TCONF | TTERRNO, "We don't have CAP_NET_RAW to begin with");
+
+	SAFE_CLOSE(TST_RET);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_DROP, CAP_NET_RAW),
+		{}
+	},
+};
+--------------------------------------------------------------------------------
+
+Look at the test struct@the bottom. We have filled in the 'caps' field with
+a NULL terminated array containing a single 'tst_cap'. This indicates to the
+library that we should drop CAP_NET_RAW if we have it. The capability will be
+dropped in between 'setup' and 'run'.
+
+[source,c]
+--------------------------------------------------------------------------------
+static struct tst_test test = {
+	.test_all = run,
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_NET_RAW),
+		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
+		{}
+	},
+};
+--------------------------------------------------------------------------------
+
+Here we request 'CAP_NET_RAW', but drop 'CAP_SYS_ADMIN'. If the capability is
+in the permitted set, but not the effective set, the library will try to
+permit it. If it is not in the permitted set, then it will fail with 'TCONF'.
+
+This API does not require 'libcap' to be installed. However it has limited
+features relative to 'libcap'. It only tries to add or remove capabilities
+from the effective set. This means that tests which need to spawn child
+processes with various capabilities will probably need 'libcap'.
 
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/lapi/capability.h b/include/lapi/capability.h
new file mode 100644
index 000000000..02d7a9fda
--- /dev/null
+++ b/include/lapi/capability.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+#ifndef LAPI_CAPABILITY_H
+#define LAPI_CAPABILITY_H
+
+#include "config.h"
+
+#ifdef HAVE_SYS_CAPABILITY_H
+# include <sys/capability.h>
+#endif
+
+#ifndef CAP_SYS_ADMIN
+# define CAP_SYS_ADMIN        21
+#endif
+
+#ifndef CAP_TO_INDEX
+# define CAP_TO_INDEX(x)     ((x) >> 5)
+#endif
+
+#ifndef CAP_TO_MASK
+# define CAP_TO_MASK(x)      (1 << ((x) & 31))
+#endif
+
+#endif
diff --git a/include/tst_capability.h b/include/tst_capability.h
new file mode 100644
index 000000000..396679f2e
--- /dev/null
+++ b/include/tst_capability.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+/**
+ * @file tst_capability.h
+ *
+ * Limited capability operations without libcap.
+ */
+
+#ifndef TST_CAPABILITY_H
+#define TST_CAPABILITY_H
+
+#include <stdint.h>
+
+#include "lapi/capability.h"
+
+#define TST_CAP_DROP 1
+#define TST_CAP_REQ  1 << 1
+
+#define TST_CAP(action, capability) {action, capability, #capability}
+
+struct tst_cap_user_header {
+	uint32_t version;
+	int pid;
+};
+
+struct tst_cap_user_data {
+	uint32_t effective;
+	uint32_t permitted;
+	uint32_t inheritable;
+};
+
+struct tst_cap {
+	uint32_t action;
+	uint32_t id;
+	char *name;
+};
+
+int tst_capget(struct tst_cap_user_header *hdr,
+	       struct tst_cap_user_data *data);
+int tst_capset(struct tst_cap_user_header *hdr,
+	       const struct tst_cap_user_data *data);
+
+void tst_cap_action(struct tst_cap *cap);
+void tst_cap_setup(struct tst_cap *cap);
+
+#endif
diff --git a/include/tst_test.h b/include/tst_test.h
index 2e07ff16b..6eb558396 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -35,6 +35,7 @@
 #include "tst_path_has_mnt_flags.h"
 #include "tst_sys_conf.h"
 #include "tst_coredump.h"
+#include "tst_capability.h"
 
 /*
  * Reports testcase result.
@@ -200,6 +201,11 @@ struct tst_test {
 	 * test.
 	 */
 	const char *const *needs_kconfigs;
+
+	/*
+	 * NULL-terminated array of capability settings
+	 */
+	struct tst_cap *caps;
 };
 
 /*
diff --git a/lib/tst_capability.c b/lib/tst_capability.c
new file mode 100644
index 000000000..7e6c56e1d
--- /dev/null
+++ b/lib/tst_capability.c
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ */
+
+#include <string.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_capability.h"
+
+#include "lapi/syscalls.h"
+
+/**
+ * Get the capabilities as decided by hdr.
+ *
+ * Note that the memory pointed to by data should be large enough to store two
+ * structs.
+ */
+int tst_capget(struct tst_cap_user_header *hdr,
+	       struct tst_cap_user_data *data)
+{
+	return tst_syscall(__NR_capget, hdr, data);
+}
+
+/**
+ * Set the capabilities as decided by hdr and data
+ *
+ * Note that the memory pointed to by data should be large enough to store two
+ * structs.
+ */
+int tst_capset(struct tst_cap_user_header *hdr,
+	       const struct tst_cap_user_data *data)
+{
+	return tst_syscall(__NR_capset, hdr, data);
+}
+
+static void do_cap_drop(uint32_t *set, uint32_t mask, const struct tst_cap *cap)
+{
+	if (*set & mask) {
+		tst_res(TINFO, "Dropping %s(%d)", cap->name, cap->id);
+		*set &= ~mask;
+	}
+}
+
+static void do_cap_req(uint32_t *set, uint32_t mask, const struct tst_cap *cap)
+{
+	if (!(*set & mask))
+		tst_brk(TCONF, "Need %s(%d)", cap->name, cap->id);
+
+	if (!(*set & mask)) {
+		tst_res(TINFO, "Permitting %s(%d)", cap->name, cap->id);
+		*set |= mask;
+	}
+}
+
+/**
+ * Add, check or remove capabilities
+ *
+ * Takes a NULL terminated array of structs which describe whether some
+ * capabilities are needed or not.
+ *
+ * It will attempt to drop or add capabilities to the effective set. It will
+ * try to detect if this is needed and whether it can or can't be done. If it
+ * clearly can not add a privilege to the effective set then it will return
+ * TCONF. However it may fail for some other reason and return TBROK.
+ *
+ * This only tries to change the effective set. Some tests may need to change
+ * the inheritable and ambient sets, so that child processes retain some
+ * capability.
+ */
+void tst_cap_action(struct tst_cap *cap)
+{
+	struct tst_cap_user_header hdr = {
+		.version = 0x20080522,
+		.pid = tst_syscall(__NR_gettid),
+	};
+	struct tst_cap_user_data cur[2] = { {0} };
+	struct tst_cap_user_data new[2] = { {0} };
+	uint32_t act = cap->action;
+	uint32_t *set = &new[CAP_TO_INDEX(cap->id)].effective;
+	uint32_t mask = CAP_TO_MASK(cap->id);
+
+	if (tst_capget(&hdr, cur))
+		tst_brk(TBROK | TTERRNO, "tst_capget()");
+
+	memcpy(new, cur, sizeof(new));
+
+	switch (act) {
+	case TST_CAP_DROP:
+		do_cap_drop(set, mask, cap);
+		break;
+	case TST_CAP_REQ:
+		do_cap_req(set, mask, cap);
+		break;
+	default:
+		tst_brk(TBROK, "Unrecognised action %d", cap->action);
+	}
+
+	if (memcmp(cur, new, sizeof(new)) && tst_capset(&hdr, new))
+		tst_brk(TBROK | TERRNO, "tst_capset(%s)", cap->name);
+}
+
+void tst_cap_setup(struct tst_cap *caps)
+{
+	struct tst_cap *cap;
+
+	for (cap = caps; cap->action; cap++)
+		tst_cap_action(cap);
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 245e287fa..8d5fbd1f9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -888,6 +888,9 @@ static void do_test_setup(void)
 
 	if (main_pid != getpid())
 		tst_brk(TBROK, "Runaway child in setup()!");
+
+	if (tst_test->caps)
+		tst_cap_setup(tst_test->caps);
 }
 
 static void do_cleanup(void)
-- 
2.22.0

