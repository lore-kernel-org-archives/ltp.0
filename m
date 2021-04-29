From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 29 Apr 2021 16:05:07 +0100
Subject: [LTP] [PATCH v2 2/5] bpf: Add map_array helper functions
In-Reply-To: <20210429150510.21585-1-rpalethorpe@suse.com>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
Message-ID: <20210429150510.21585-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We usually just create an array map with standard key and value
size. Then fetch some values from the array. So we can create some
standard functions for this.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.c | 34 ++++++++++++++++
 testcases/kernel/syscalls/bpf/bpf_common.h | 12 +++++-
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 25 +++---------
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 47 +++++-----------------
 testcases/kernel/syscalls/bpf/bpf_prog03.c | 25 +++---------
 testcases/kernel/syscalls/bpf/bpf_prog04.c |  8 +---
 6 files changed, 68 insertions(+), 83 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index fd299b73d..90772815b 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -48,6 +48,40 @@ int bpf_map_create(union bpf_attr *attr)
 	return ret;
 }
 
+int bpf_map_array_create(uint32_t max_entries)
+{
+	union bpf_attr map_attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = 4,
+		.value_size = 8,
+		.max_entries = max_entries,
+		.map_flags = 0
+	};
+
+	return bpf_map_create(&map_attr);
+}
+
+long bpf_map_array_get(const int map_fd,
+		       const uint32_t *const array_indx,
+		       uint64_t *const array_val)
+{
+	union bpf_attr elem_attr = {
+		.map_fd = map_fd,
+		.key = ptr_to_u64(array_indx),
+		.value = ptr_to_u64(array_val),
+		.flags = 0
+	};
+
+	TEST(bpf(BPF_MAP_LOOKUP_ELEM, &elem_attr, sizeof(elem_attr)));
+
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO,
+			"Failed array map lookup: [%"PRIu32, *array_indx);
+	}
+
+	return TST_RET;
+}
+
 void bpf_init_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
 	size_t prog_size, char *log_buf, size_t log_size)
 {
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index d36a2b09f..fb5731c3d 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -6,12 +6,22 @@
 #ifndef LTP_BPF_COMMON_H
 #define LTP_BPF_COMMON_H
 
+#include <sys/types.h>
+#include <inttypes.h>
+
+#include "lapi/bpf.h"
+
 #define BPF_MEMLOCK_ADD (2*1024*1024)
 
 void rlimit_bump_memlock(void);
 int bpf_map_create(union bpf_attr *attr);
+int bpf_map_array_create(uint32_t max_entries);
+long bpf_map_array_get(const int map_fd,
+		       const uint32_t *const array_indx,
+		       uint64_t *const array_val);
+
 void bpf_init_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
-	size_t prog_size, char *log_buf, size_t log_size);
+			size_t prog_size, char *log_buf, size_t log_size);
 int bpf_load_prog(union bpf_attr *attr, const char *log);
 
 #endif
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index 966bf2092..ac57b24b5 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog01.c
@@ -83,14 +83,7 @@ void run(void)
 	uint32_t key = 0;
 	uint64_t val;
 
-	memset(attr, 0, sizeof(*attr));
-	attr->map_type = BPF_MAP_TYPE_ARRAY;
-	attr->key_size = 4;
-	attr->value_size = 8;
-	attr->max_entries = 1;
-
-	map_fd = bpf_map_create(attr);
-
+	map_fd = bpf_map_array_create(1);
 	prog_fd = load_prog(map_fd);
 
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
@@ -99,15 +92,12 @@ void run(void)
 
 	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
 
-	memset(attr, 0, sizeof(*attr));
-	attr->map_fd = map_fd;
-	attr->key = ptr_to_u64(&key);
-	attr->value = ptr_to_u64(&val);
+	SAFE_CLOSE(prog_fd);
+	SAFE_CLOSE(sk[0]);
+	SAFE_CLOSE(sk[1]);
 
-	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "array map lookup");
-	} else if (val != 1) {
+        bpf_map_array_get(map_fd, &key, &val);
+	if (val != 1) {
 		tst_res(TFAIL,
 			"val = %lu, but should be val = 1",
 			val);
@@ -115,10 +105,7 @@ void run(void)
 	        tst_res(TPASS, "val = 1");
 	}
 
-	SAFE_CLOSE(prog_fd);
 	SAFE_CLOSE(map_fd);
-	SAFE_CLOSE(sk[0]);
-	SAFE_CLOSE(sk[1]);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index eeba16a54..4558153ea 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -81,14 +81,7 @@ static void run(void)
 	int map_fd, prog_fd;
 	int sk[2];
 
-	memset(attr, 0, sizeof(*attr));
-	attr->map_type = BPF_MAP_TYPE_ARRAY;
-	attr->key_size = 4;
-	attr->value_size = 8;
-	attr->max_entries = 2;
-
-	map_fd = bpf_map_create(attr);
-
+	map_fd = bpf_map_array_create(2);
 	prog_fd = load_prog(map_fd);
 
 	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
@@ -97,49 +90,31 @@ static void run(void)
 
 	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
 
-	memset(attr, 0, sizeof(*attr));
-	attr->map_fd = map_fd;
-	attr->key = ptr_to_u64(key);
-	attr->value = ptr_to_u64(val);
-	*key = 0;
-
-	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "array map lookup");
-		goto exit;
-	}
+	SAFE_CLOSE(prog_fd);
+	SAFE_CLOSE(sk[0]);
+	SAFE_CLOSE(sk[1]);
 
+        *key = 0;
+	bpf_map_array_get(map_fd, key, val);
 	if (*val != A64INT + 1) {
 		tst_res(TFAIL,
 			"val = %"PRIu64", but should be val = %"PRIu64" + 1",
 			*val, A64INT);
-		goto exit;
+	} else {
+		tst_res(TPASS, "val = %"PRIu64" + 1", A64INT);
 	}
 
-	tst_res(TPASS, "val = %"PRIu64" + 1", A64INT);
-
 	*key = 1;
-
-	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "array map lookup");
-		goto exit;
-	}
-
+	bpf_map_array_get(map_fd, key, val);
 	if (*val != A64INT - 1) {
 		tst_res(TFAIL,
 			"val = %"PRIu64", but should be val = %"PRIu64" - 1",
 			*val, A64INT);
-		goto exit;
+	} else {
+		tst_res(TPASS, "val = %"PRIu64" - 1", A64INT);
 	}
 
-	tst_res(TPASS, "val = %"PRIu64" - 1", A64INT);
-
-exit:
-	SAFE_CLOSE(prog_fd);
 	SAFE_CLOSE(map_fd);
-	SAFE_CLOSE(sk[0]);
-	SAFE_CLOSE(sk[1]);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
index 5b8a394e8..1195ddc2c 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog03.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -119,13 +119,7 @@ static void run(void)
 	int map_fd, prog_fd;
 	int sk[2];
 
-	memset(attr, 0, sizeof(*attr));
-	attr->map_type = BPF_MAP_TYPE_ARRAY;
-	attr->key_size = 4;
-	attr->value_size = 8;
-	attr->max_entries = 32;
-
-	map_fd = bpf_map_create(attr);
+	map_fd = bpf_map_array_create(32);
 
 	memset(attr, 0, sizeof(*attr));
 	attr->map_fd = map_fd;
@@ -148,22 +142,13 @@ static void run(void)
 			&prog_fd, sizeof(prog_fd));
 
 	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
-
-	memset(attr, 0, sizeof(*attr));
-	attr->map_fd = map_fd;
-	attr->key = ptr_to_u64(key);
-	attr->value = ptr_to_u64(val);
-	*key = 0;
-
-	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
-	if (TST_RET == -1)
-		tst_res(TFAIL | TTERRNO, "array map lookup");
-	else
-		tst_res(TINFO, "Pointer offset was 0x%"PRIx64, *val);
-
 	SAFE_CLOSE(sk[0]);
 	SAFE_CLOSE(sk[1]);
 	SAFE_CLOSE(prog_fd);
+
+	*key = 0;
+	bpf_map_array_get(map_fd, key, val);
+	tst_res(TINFO, "Pointer offset was 0x%"PRIx64, *val);
 exit:
 	SAFE_CLOSE(map_fd);
 }
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog04.c b/testcases/kernel/syscalls/bpf/bpf_prog04.c
index 799fcb52d..1a1ee0f04 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog04.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog04.c
@@ -94,13 +94,7 @@ static void run(void)
 	int map_fd, prog_fd;
 	int sk[2];
 
-	memset(attr, 0, sizeof(*attr));
-	attr->map_type = BPF_MAP_TYPE_ARRAY;
-	attr->key_size = 4;
-	attr->value_size = 8;
-	attr->max_entries = 1;
-
-	map_fd = bpf_map_create(attr);
+	map_fd = bpf_map_array_create(1);
 	prog_fd = load_prog(map_fd);
 
 	if (prog_fd >= 0) {
-- 
2.31.1

