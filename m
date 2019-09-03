From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Sep 2019 13:15:33 +0200
Subject: [LTP] [PATCH v5 2/4] BPF: Sanity check creating and updating maps
In-Reply-To: <20190903111535.27565-1-chrubis@suse.cz>
References: <20190903111535.27565-1-chrubis@suse.cz>
Message-ID: <20190903111535.27565-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Richard Palethorpe <rpalethorpe@suse.com>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/bpf/.gitignore  |   1 +
 testcases/kernel/syscalls/bpf/Makefile    |  10 ++
 testcases/kernel/syscalls/bpf/bpf_map01.c | 163 ++++++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bpf/.gitignore
 create mode 100644 testcases/kernel/syscalls/bpf/Makefile
 create mode 100644 testcases/kernel/syscalls/bpf/bpf_map01.c

diff --git a/runtest/syscalls b/runtest/syscalls
index d2547b045..3d5f6cf86 100644
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
index 000000000..13dde0b4e
--- /dev/null
+++ b/testcases/kernel/syscalls/bpf/bpf_map01.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * Trivial Extended Berkeley Packet Filter (eBPF) test.
+ *
+ * Sanity check creating and updating maps.
+ */
+/*
+ * If test is executed in a loop and limit for locked memory (ulimit -l) is
+ * too low bpf() call can fail with EPERM due to deffered freeing.
+ */
+
+#include <limits.h>
+#include <string.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "lapi/bpf.h"
+
+#define VAL_SZ 1024
+
+static void *key4;
+static void *key8;
+static char *val_set;
+static char *val_get;
+static union bpf_attr *attr;
+
+struct map_type {
+	uint32_t id;
+	char *name;
+	int key_size;
+	void **key;
+};
+
+static const struct map_type map_types[] = {
+	{BPF_MAP_TYPE_HASH, "hash", 8, &key8},
+	{BPF_MAP_TYPE_ARRAY, "array", 4, &key4}
+};
+
+void run(unsigned int n)
+{
+	int fd, i;
+	void *key = *map_types[n].key;
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_type = map_types[n].id;
+	attr->key_size = map_types[n].key_size;
+	attr->value_size = VAL_SZ;
+	attr->max_entries = 1;
+
+	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		if (TST_ERR == EPERM) {
+			tst_brk(TCONF | TTERRNO,
+				"bpf() requires CAP_SYS_ADMIN on this system");
+		} else {
+			tst_res(TFAIL | TTERRNO, "Failed to create %s map",
+				map_types[n].name);
+			return;
+		}
+	}
+	tst_res(TPASS, "Created %s map", map_types[n].name);
+	fd = TST_RET;
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_fd = fd;
+	attr->key = ptr_to_u64(key);
+	attr->value = ptr_to_u64(val_get);
+
+	memset(val_get, 'x', VAL_SZ);
+
+	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
+
+	switch (map_types[n].id) {
+	case BPF_MAP_TYPE_HASH:
+		if (TST_RET != -1 || TST_ERR != ENOENT) {
+			tst_res(TFAIL | TTERRNO,
+				"Empty hash map lookup should fail with ENOENT");
+		} else {
+			tst_res(TPASS | TTERRNO, "Empty hash map lookup");
+		}
+	break;
+	case BPF_MAP_TYPE_ARRAY:
+		if (TST_RET != -1) {
+			for (i = 0; i < VAL_SZ; i++) {
+				if (val_get[i] != 0) {
+					tst_res(TFAIL,
+						"Preallocated array map val not zero");
+					break;
+				}
+			}
+			if (i < VAL_SZ)
+				tst_res(TPASS, "Preallocated array map lookup");
+		} else {
+			tst_res(TFAIL | TERRNO, "Prellocated array map lookup");
+		}
+	break;
+	}
+
+	memset(attr, 0, sizeof(*attr));
+	attr->map_fd = fd;
+	attr->key = ptr_to_u64(key);
+	attr->value = ptr_to_u64(val_set);
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
+	attr->value = ptr_to_u64(val_get);
+
+	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO,
+			"%s map lookup missing",
+			map_types[n].name);
+	} else if (memcmp(val_set, val_get, (size_t) VAL_SZ)) {
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
+static void setup(void)
+{
+	unsigned int i;
+
+	memcpy(key8, "12345678", 8);
+	memset(key4, 0, 4);
+
+	for (i = 0; i < VAL_SZ; i++)
+		val_set[i] = i % 256;
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(map_types),
+	.test = run,
+	.setup = setup,
+	.min_kver = "3.19",
+	.bufs = (struct tst_buffers []) {
+		{&key4, .size = 4},
+		{&key8, .size = 8},
+		{&val_set, .size = VAL_SZ},
+		{&val_get, .size = VAL_SZ},
+		{&attr, .size = sizeof(*attr)},
+		{},
+	},
+};
-- 
2.21.0

