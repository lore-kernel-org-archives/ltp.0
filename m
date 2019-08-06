From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue,  6 Aug 2019 11:47:50 +0200
Subject: [LTP] [PATCH v3 2/4] BPF: Sanity check creating and updating maps
In-Reply-To: <20190806094752.9794-1-rpalethorpe@suse.com>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190806094752.9794-1-rpalethorpe@suse.com>
Message-ID: <20190806094752.9794-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/bpf/.gitignore  |   1 +
 testcases/kernel/syscalls/bpf/Makefile    |  10 ++
 testcases/kernel/syscalls/bpf/bpf_map01.c | 140 ++++++++++++++++++++++
 4 files changed, 153 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bpf/.gitignore
 create mode 100644 testcases/kernel/syscalls/bpf/Makefile
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_map01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index a68a4c9d0..9d48285b8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -32,6 +32,8 @@ bind01 bind01
 bind02 bind02
 bind03 bind03
 
+bpf_map01 bpf_map01
+
 brk01 brk01
 
 capget01 capget01
diff --git a/testcases/kernel/syscalls/bpf/.gitignore b/testcases/kernel/syscalls/bpf/.gitignore
new file mode 100644
index 000000000..f33532484
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/.gitignore
@@ -0,0 +1 @@
+bpf_map01
diff --git a/testcases/kernel/syscalls/bpf/Makefile b/testcases/kernel/syscalls/bpf/Makefile
new file mode 100644
index 000000000..990c8c83c
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Linux Test Project
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+CFLAGS			+= -D_GNU_SOURCE
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
new file mode 100644
index 000000000..c5ddd8aad
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * Trivial Extended Berkeley Packet Filter (eBPF) test.
+ *
+ * Sanity check creating and updating maps.
+ */
+
+#include <limits.h>
+#include <string.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/bpf.h"
+
+#define KEY_SZ 8
+#define VAL_SZ 1024
+
+struct map_type {
+	uint32_t id;
+	char *name;
+};
+
+static const struct map_type map_types[] = {
+	{BPF_MAP_TYPE_HASH, "hash"},
+	{BPF_MAP_TYPE_ARRAY, "array"}
+};
+
+static void *key;
+static void *val0;
+static void *val1;
+static union bpf_attr *attr;
+
+void run(unsigned int n)
+{
+	int fd, i;
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_type = map_types[n].id;
+	attr->key_size = n == 0 ? KEY_SZ : 4;
+	attr->value_size = VAL_SZ;
+	attr->max_entries = 1;
+
+	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		if (TST_ERR == EPERM) {
+			tst_brk(TCONF | TTERRNO,
+				"bpf() requires CAP_SYS_ADMIN on this system");
+		} else {
+			tst_brk(TFAIL | TTERRNO, "Failed to create %s map",
+				map_types[n].name);
+		}
+	}
+	tst_res(TPASS, "Created %s map", map_types[n].name);
+	fd = TST_RET;
+
+	if (n == 0)
+		memcpy(key, "12345678", KEY_SZ);
+	else
+		memset(key, 0, 4);
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_fd = fd;
+	attr->key = ptr_to_u64(key);
+	attr->value = ptr_to_u64(val1);
+
+	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
+	if (n == 0) {
+		if (TST_RET != -1 || TST_ERR != ENOENT) {
+			tst_res(TFAIL | TTERRNO,
+				"Empty hash map lookup should fail with ENOENT");
+		} else {
+			tst_res(TPASS | TTERRNO, "Empty hash map lookup");
+		}
+	} else if (TST_RET != -1) {
+		for (i = 0;;) {
+			if (*(char *) val1 != 0) {
+				tst_res(TFAIL,
+					"Preallocated array map val not zero");
+			} else if (++i >= VAL_SZ) {
+				tst_res(TPASS,
+					"Preallocated array map lookup");
+				break;
+			}
+		}
+	} else {
+		tst_res(TFAIL | TERRNO, "Prellocated array map lookup");
+	}
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_fd = fd;
+	attr->key = ptr_to_u64(key);
+	attr->value = ptr_to_u64(val0);
+	attr->flags = BPF_ANY;
+
+	TEST(bpf(BPF_MAP_UPDATE_ELEM, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		tst_brk(TFAIL | TTERRNO,
+			"Update %s map element",
+			map_types[n].name);
+	} else {
+		tst_res(TPASS,
+			"Update %s map element",
+			map_types[n].name);
+	}
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_fd = fd;
+	attr->key = ptr_to_u64(key);
+	attr->value = ptr_to_u64(val1);
+
+	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"%s map lookup missing",
+			map_types[n].name);
+	} else if (memcmp(val0, val1, (size_t) VAL_SZ)) {
+		tst_res(TFAIL,
+			"%s map lookup returned different value",
+			map_types[n].name);
+	} else {
+		tst_res(TPASS, "%s map lookup", map_types[n].name);
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.tcnt = 2,
+	.test = run,
+	.min_kver = "3.18",
+	.bufs = (struct tst_buffers []) {
+		{&key, .size = KEY_SZ},
+		{&val0, .size = VAL_SZ},
+		{&val1, .size = VAL_SZ},
+		{&attr, .size = sizeof(*attr)},
+		{NULL},
+	},
+};
-- 
2.22.0

