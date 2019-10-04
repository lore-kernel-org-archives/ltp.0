From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  4 Oct 2019 11:31:22 +0200
Subject: [LTP] [PATCH] bpf_prog02: Correct index on big endian architectures
Message-ID: <20191004093122.25799-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The array index is only 4 bytes, but we store an 8 byte double word on the
stack. This is OK on LE where the upper 4 bytes are ignored. However on BE the
lower 4 bytes are ignored and we therefor get an index of zero each time.

So we have switch to just using a single word (32bits) to store the index.

Idea-by: Gary Ching-Pang Lin <glin@suse.com>
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/bpf.h                         | 1 +
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index 03073b45e..5582e344a 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -24,6 +24,7 @@
 #define		BPF_JMP		0x05
 
 #define BPF_SIZE(code)  ((code) & 0x18)
+#define		BPF_W		0x00    /* 32-bit */
 #define         BPF_DW		0x18	/* double word (64-bit) */
 
 #define BPF_MODE(code)  ((code) & 0xe0)
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index acb28e98e..fb8f3f781 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -43,8 +43,8 @@ static int load_prog(int fd)
 
 		BPF_LD_MAP_FD(BPF_REG_1, fd),	        /* 1: r1 = &fd */
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* 3: r2 = fp */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* 4: r2 = r2 - 8 */
-		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),    /* 5: *r2 = 0 */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),  /* 4: r2 = r2 - 4 */
+		BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 0),     /* 5: *r2 = 0 */
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),/* 6: map_lookup_elem */
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 17), /* 7: if(!r0) goto 25 */
 		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),    /* 8: r3 = r0 */
@@ -54,8 +54,8 @@ static int load_prog(int fd)
 
 		BPF_LD_MAP_FD(BPF_REG_1, fd),	        /* 13: r1 = &fd */
 		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* 15: r2 = fp */
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* 16: r2 = r2 - 8 */
-		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 1),    /* 17: *r2 = 1 */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),  /* 16: r2 = r2 - 4 */
+		BPF_ST_MEM(BPF_W, BPF_REG_2, 0, 1),     /* 17: *r2 = 1 */
 		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),/* 18: map_lookup_elem */
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),  /* 19: if(!r0) goto 25 */
 		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),    /* 20: r3 = r0 */
-- 
2.23.0

