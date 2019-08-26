From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Aug 2019 13:10:21 +0200
Subject: [LTP] [PATCH v4 1/4] BPF: Essential headers for map creation
In-Reply-To: <20190826111024.19053-1-chrubis@suse.cz>
References: <20190826111024.19053-1-chrubis@suse.cz>
Message-ID: <20190826111024.19053-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Richard Palethorpe <rpalethorpe@suse.com>

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/lapi/bpf.h               | 242 +++++++++++++++++++++++++++++++
 include/lapi/syscalls/aarch64.in |   1 +
 include/lapi/syscalls/i386.in    |   1 +
 include/lapi/syscalls/s390.in    |   1 +
 include/lapi/syscalls/sparc.in   |   1 +
 include/lapi/syscalls/x86_64.in  |   1 +
 6 files changed, 247 insertions(+)
 create mode 100644 include/lapi/bpf.h

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
new file mode 100644
index 000000000..369de0175
--- /dev/null
+++ b/include/lapi/bpf.h
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * Essential Extended Berkeley Packet Filter (eBPF) headers
+ *
+ * Mostly copied/adapted from linux/bpf.h and libbpf so that we can perform
+ * some eBPF testing without any external dependencies.
+ */
+
+#ifndef BPF_H
+# define BPF_H
+
+#include <stdint.h>
+
+#include "lapi/syscalls.h"
+
+/* Start copy from linux/bpf.h */
+enum bpf_cmd {
+	BPF_MAP_CREATE,
+	BPF_MAP_LOOKUP_ELEM,
+	BPF_MAP_UPDATE_ELEM,
+	BPF_MAP_DELETE_ELEM,
+	BPF_MAP_GET_NEXT_KEY,
+	BPF_PROG_LOAD,
+	BPF_OBJ_PIN,
+	BPF_OBJ_GET,
+	BPF_PROG_ATTACH,
+	BPF_PROG_DETACH,
+	BPF_PROG_TEST_RUN,
+	BPF_PROG_GET_NEXT_ID,
+	BPF_MAP_GET_NEXT_ID,
+	BPF_PROG_GET_FD_BY_ID,
+	BPF_MAP_GET_FD_BY_ID,
+	BPF_OBJ_GET_INFO_BY_FD,
+	BPF_PROG_QUERY,
+	BPF_RAW_TRACEPOINT_OPEN,
+	BPF_BTF_LOAD,
+	BPF_BTF_GET_FD_BY_ID,
+	BPF_TASK_FD_QUERY,
+	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
+	BPF_MAP_FREEZE,
+};
+
+enum bpf_map_type {
+	BPF_MAP_TYPE_UNSPEC,
+	BPF_MAP_TYPE_HASH,
+	BPF_MAP_TYPE_ARRAY,
+	BPF_MAP_TYPE_PROG_ARRAY,
+	BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+	BPF_MAP_TYPE_PERCPU_HASH,
+	BPF_MAP_TYPE_PERCPU_ARRAY,
+	BPF_MAP_TYPE_STACK_TRACE,
+	BPF_MAP_TYPE_CGROUP_ARRAY,
+	BPF_MAP_TYPE_LRU_HASH,
+	BPF_MAP_TYPE_LRU_PERCPU_HASH,
+	BPF_MAP_TYPE_LPM_TRIE,
+	BPF_MAP_TYPE_ARRAY_OF_MAPS,
+	BPF_MAP_TYPE_HASH_OF_MAPS,
+	BPF_MAP_TYPE_DEVMAP,
+	BPF_MAP_TYPE_SOCKMAP,
+	BPF_MAP_TYPE_CPUMAP,
+	BPF_MAP_TYPE_XSKMAP,
+	BPF_MAP_TYPE_SOCKHASH,
+	BPF_MAP_TYPE_CGROUP_STORAGE,
+	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+	BPF_MAP_TYPE_QUEUE,
+	BPF_MAP_TYPE_STACK,
+	BPF_MAP_TYPE_SK_STORAGE,
+};
+
+#define BPF_OBJ_NAME_LEN 16U
+
+#define BPF_ANY		0 /* create new element or update existing */
+#define BPF_NOEXIST	1 /* create new element if it didn't exist */
+#define BPF_EXIST	2 /* update existing element */
+#define BPF_F_LOCK	4 /* spin_lock-ed map_lookup/map_update */
+
+#define aligned_uint64_t uint64_t __attribute__((aligned(8)))
+
+union bpf_attr {
+	struct { /* anonymous struct used by BPF_MAP_CREATE command */
+		uint32_t	map_type;	/* one of enum bpf_map_type */
+		uint32_t	key_size;	/* size of key in bytes */
+		uint32_t	value_size;	/* size of value in bytes */
+		uint32_t	max_entries;	/* max number of entries in a map */
+		uint32_t	map_flags;	/* BPF_MAP_CREATE related
+					 * flags defined above.
+					 */
+		uint32_t	inner_map_fd;	/* fd pointing to the inner map */
+		uint32_t	numa_node;	/* numa node (effective only if
+					 * BPF_F_NUMA_NODE is set).
+					 */
+		char	map_name[BPF_OBJ_NAME_LEN];
+		uint32_t	map_ifindex;	/* ifindex of netdev to create on */
+		uint32_t	btf_fd;		/* fd pointing to a BTF type data */
+		uint32_t	btf_key_type_id;	/* BTF type_id of the key */
+		uint32_t	btf_value_type_id;	/* BTF type_id of the value */
+	};
+
+	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+		uint32_t		map_fd;
+		aligned_uint64_t	key;
+		union {
+			aligned_uint64_t value;
+			aligned_uint64_t next_key;
+		};
+		uint64_t		flags;
+	};
+
+	struct { /* anonymous struct used by BPF_PROG_LOAD command */
+		uint32_t		prog_type;	/* one of enum bpf_prog_type */
+		uint32_t		insn_cnt;
+		aligned_uint64_t	insns;
+		aligned_uint64_t	license;
+		uint32_t		log_level;	/* verbosity level of verifier */
+		uint32_t		log_size;	/* size of user buffer */
+		aligned_uint64_t	log_buf;	/* user supplied buffer */
+		uint32_t		kern_version;	/* not used */
+		uint32_t		prog_flags;
+		char		prog_name[BPF_OBJ_NAME_LEN];
+		uint32_t		prog_ifindex;	/* ifindex of netdev to prep for */
+		/* For some prog types expected attach type must be known at
+		 * load time to verify attach type specific parts of prog
+		 * (context accesses, allowed helpers, etc).
+		 */
+		uint32_t		expected_attach_type;
+		uint32_t		prog_btf_fd;	/* fd pointing to BTF type data */
+		uint32_t		func_info_rec_size;	/* userspace bpf_func_info size */
+		aligned_uint64_t	func_info;	/* func info */
+		uint32_t		func_info_cnt;	/* number of bpf_func_info records */
+		uint32_t		line_info_rec_size;	/* userspace bpf_line_info size */
+		aligned_uint64_t	line_info;	/* line info */
+		uint32_t		line_info_cnt;	/* number of bpf_line_info records */
+	};
+
+	struct { /* anonymous struct used by BPF_OBJ_* commands */
+		aligned_uint64_t	pathname;
+		uint32_t		bpf_fd;
+		uint32_t		file_flags;
+	};
+
+	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
+		uint32_t		target_fd;	/* container object to attach to */
+		uint32_t		attach_bpf_fd;	/* eBPF program to attach */
+		uint32_t		attach_type;
+		uint32_t		attach_flags;
+	};
+
+	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
+		uint32_t		prog_fd;
+		uint32_t		retval;
+		uint32_t		data_size_in;	/* input: len of data_in */
+		uint32_t		data_size_out;	/* input/output: len of data_out
+						 *   returns ENOSPC if data_out
+						 *   is too small.
+						 */
+		aligned_uint64_t	data_in;
+		aligned_uint64_t	data_out;
+		uint32_t		repeat;
+		uint32_t		duration;
+		uint32_t		ctx_size_in;	/* input: len of ctx_in */
+		uint32_t		ctx_size_out;	/* input/output: len of ctx_out
+						 *   returns ENOSPC if ctx_out
+						 *   is too small.
+						 */
+		aligned_uint64_t	ctx_in;
+		aligned_uint64_t	ctx_out;
+	} test;
+
+	struct { /* anonymous struct used by BPF_*_GET_*_ID */
+		union {
+			uint32_t		start_id;
+			uint32_t		prog_id;
+			uint32_t		map_id;
+			uint32_t		btf_id;
+		};
+		uint32_t		next_id;
+		uint32_t		open_flags;
+	};
+
+	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
+		uint32_t		bpf_fd;
+		uint32_t		info_len;
+		aligned_uint64_t	info;
+	} info;
+
+	struct { /* anonymous struct used by BPF_PROG_QUERY command */
+		uint32_t		target_fd;	/* container object to query */
+		uint32_t		attach_type;
+		uint32_t		query_flags;
+		uint32_t		attach_flags;
+		aligned_uint64_t	prog_ids;
+		uint32_t		prog_cnt;
+	} query;
+
+	struct {
+		uint64_t name;
+		uint32_t prog_fd;
+	} raw_tracepoint;
+
+	struct { /* anonymous struct for BPF_BTF_LOAD */
+		aligned_uint64_t	btf;
+		aligned_uint64_t	btf_log_buf;
+		uint32_t		btf_size;
+		uint32_t		btf_log_size;
+		uint32_t		btf_log_level;
+	};
+
+	struct {
+		uint32_t		pid;		/* input: pid */
+		uint32_t		fd;		/* input: fd */
+		uint32_t		flags;		/* input: flags */
+		uint32_t		buf_len;	/* input/output: buf len */
+		aligned_uint64_t	buf;		/* input/output:
+						 *   tp_name for tracepoint
+						 *   symbol for kprobe
+						 *   filename for uprobe
+						 */
+		uint32_t		prog_id;	/* output: prod_id */
+		uint32_t		fd_type;	/* output: BPF_FD_TYPE_* */
+		uint64_t		probe_offset;	/* output: probe_offset */
+		uint64_t		probe_addr;	/* output: probe_addr */
+	} task_fd_query;
+} __attribute__((aligned(8)));
+
+/* End copy from linux/bpf.h */
+
+/* Start copy from tools/lib/bpf  */
+inline uint64_t ptr_to_u64(const void *ptr)
+{
+	return (uint64_t) (unsigned long) ptr;
+}
+
+inline int bpf(enum bpf_cmd cmd, union bpf_attr *attr, unsigned int size)
+{
+	return tst_syscall(__NR_bpf, cmd, attr, size);
+}
+/* End copy from tools/lib/bpf */
+
+#endif	/* BPF_H */
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 7db6e281c..0e00641bc 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -258,6 +258,7 @@ process_vm_writev 271
 kcmp 272
 getrandom 278
 memfd_create 279
+bpf 280
 userfaultfd 282
 membarrier 283
 execveat 281
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 02f3955ba..87ab46933 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -340,6 +340,7 @@ sched_getattr 352
 renameat2 354
 getrandom 355
 memfd_create 356
+bpf 357
 execveat 358
 userfaultfd 374
 membarrier 375
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index c304ef4b7..d3f7eb1f6 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -331,6 +331,7 @@ sched_getattr 346
 renameat2 347
 getrandom 349
 memfd_create 350
+bpf 351
 userfaultfd 355
 membarrier 356
 execveat 354
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index ab7204663..94a672428 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -336,6 +336,7 @@ kcmp 341
 renameat2 345
 getrandom 347
 memfd_create 348
+bpf 349
 membarrier 351
 userfaultfd 352
 execveat 350
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index fdb414c10..b1cbd4f2f 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -307,6 +307,7 @@ sched_getattr 315
 renameat2 316
 getrandom 318
 memfd_create 319
+bpf 321
 execveat 322
 userfaultfd 323
 membarrier 324
-- 
2.21.0

