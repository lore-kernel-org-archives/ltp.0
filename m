From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Sep 2019 16:56:37 +0200
Subject: [LTP] [PATCH v3] BPF: Regression test for 64bit arithmetic
In-Reply-To: <20190911095422.11767-1-rpalethorpe@suse.com>
References: <20190911095422.11767-1-rpalethorpe@suse.com>
Message-ID: <20190912145637.GA11776@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
A few minor points below, I guess I can fix these before pushing as
well.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Jan Stancek <jstancek@redhat.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> ---
> 
> V3: Rebased on master and included line numbers in instructions
> 
> Capability patch has not been applied to master at time of rebase.
> 
>  include/lapi/bpf.h                         |  27 +++
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/bpf/.gitignore   |   1 +
>  testcases/kernel/syscalls/bpf/bpf_prog02.c | 182 +++++++++++++++++++++
>  4 files changed, 211 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/bpf/bpf_prog02.c
> 
> diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
> index 122eb5469..03073b45e 100644
> --- a/include/lapi/bpf.h
> +++ b/include/lapi/bpf.h
> @@ -18,7 +18,9 @@
>  /* Start copy from linux/bpf_(common).h */
>  #define BPF_CLASS(code) ((code) & 0x07)
>  #define		BPF_LD		0x00
> +#define		BPF_LDX		0x01
>  #define		BPF_ST		0x02
> +#define		BPF_STX		0x03
>  #define		BPF_JMP		0x05
>  
>  #define BPF_SIZE(code)  ((code) & 0x18)
> @@ -30,6 +32,7 @@
>  
>  #define BPF_OP(code)    ((code) & 0xf0)
>  #define		BPF_ADD		0x00
> +#define		BPF_SUB		0x10
>  
>  #define		BPF_JEQ		0x10
>  
> @@ -432,6 +435,14 @@ enum bpf_func_id {
>  
>  /* Start copy from tools/include/filter.h */
>  
> +#define BPF_ALU64_REG(OP, DST, SRC)				\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_ALU64 | BPF_OP(OP) | BPF_X,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = 0,					\
> +		.imm   = 0 })
> +
>  #define BPF_ALU64_IMM(OP, DST, IMM)				\
>  	((struct bpf_insn) {					\
>  		.code  = BPF_ALU64 | BPF_OP(OP) | BPF_K,	\
> @@ -477,6 +488,22 @@ enum bpf_func_id {
>  		.off   = OFF,					\
>  		.imm   = IMM })
>  
> +#define BPF_LDX_MEM(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = 0 })
> +
> +#define BPF_STX_MEM(SIZE, DST, SRC, OFF)			\
> +	((struct bpf_insn) {					\
> +		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_MEM,	\
> +		.dst_reg = DST,					\
> +		.src_reg = SRC,					\
> +		.off   = OFF,					\
> +		.imm   = 0 })
> +
>  #define BPF_JMP_IMM(OP, DST, IMM, OFF)				\
>  	((struct bpf_insn) {					\
>  		.code  = BPF_JMP | BPF_OP(OP) | BPF_K,		\
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 874ae4d4f..4e6310193 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -34,6 +34,7 @@ bind03 bind03
>  
>  bpf_map01 bpf_map01
>  bpf_prog01 bpf_prog01
> +bpf_prog02 bpf_prog02
>  
>  brk01 brk01
>  
> diff --git a/testcases/kernel/syscalls/bpf/.gitignore b/testcases/kernel/syscalls/bpf/.gitignore
> index 7eb5f7c92..1704f9841 100644
> --- a/testcases/kernel/syscalls/bpf/.gitignore
> +++ b/testcases/kernel/syscalls/bpf/.gitignore
> @@ -1,2 +1,3 @@
>  bpf_map01
>  bpf_prog01
> +bpf_prog02
> diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
> new file mode 100644
> index 000000000..dc8b92f00
> --- /dev/null
> +++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
> + *
> + * Check if eBPF can do arithmetic with 64bits. This targets a specific
> + * regression which only effects unprivileged users who are subject to extra
> + * pointer arithmetic checks during verification.
> + *
> + * Fixed by commit 3612af783cf52c74a031a2f11b82247b2599d3cd.
> + * https://new.blog.cloudflare.com/ebpf-cant-count/
> + *
> + * This test is very similar in structure to bpf_prog01 which is better
> + * annotated.
> + */
> +
> +#include <limits.h>
> +#include <string.h>
> +#include <stdio.h>
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "tst_capability.h"
> +#include "lapi/socket.h"
> +#include "lapi/bpf.h"
> +
> +#define A64INT (((uint64_t)1) << 60)
> +
> +const char MSG[] = "Ahoj!";
> +static char *msg;
> +
> +static char *log;
> +static uint32_t *key;
> +static uint64_t *val;
> +static union bpf_attr *attr;
> +
> +static int load_prog(int fd)
> +{
> +	struct bpf_insn *prog;
> +	struct bpf_insn insn[] = {
> +		BPF_MOV64_IMM(BPF_REG_6, 1),            /* 0: r6 = 1 */
> +
> +		BPF_LD_MAP_FD(BPF_REG_1, fd),	        /* 1: r1 = &fd */
> +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* 3: r2 = fp */
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* 4: r2 = r2 - 8 */
> +		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),    /* 5: *r2 = 0 */
> +		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),/* 6: map_lookup_elem */
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 17), /* 7: if(!r0) goto 25 */
> +		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),    /* 8: r3 = r0 */
> +		BPF_LD_IMM64(BPF_REG_4, A64INT),        /* 9: r4 = 2^61 */
> +		BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_6), /* 11: r4 += r6 */
> +		BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_4, 0), /* 12: *r3 = r4 */
> +
> +		BPF_LD_MAP_FD(BPF_REG_1, fd),	        /* 13: r1 = &fd */
> +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* 15: r2 = fp */
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* 16: r2 = r2 - 8 */
> +		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 1),    /* 17: *r2 = 1 */
> +		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),/* 18: map_lookup_elem */
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),  /* 19: if(!r0) goto 25 */
> +		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),    /* 20: r3 = r0 */
> +		BPF_LD_IMM64(BPF_REG_4, A64INT),        /* 21: r4 = 2^61 */
> +		BPF_ALU64_REG(BPF_SUB, BPF_REG_4, BPF_REG_6), /* 23: r4 -= r6 */
> +		BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_4, 0), /* 24: *r3 = r4 */
> +
> +		BPF_MOV64_IMM(BPF_REG_0, 0),            /* 25: r0 = 0 */
> +		BPF_EXIT_INSN(),		        /* 26: return r0 */
> +	};
> +
> +	/* Leaks memory when -i is specified */
> +	prog = tst_alloc(sizeof(insn));

Why not just declare the prog static? Then we could do:

	if (!prog)
		prog = tst_alloc(sizeof(insn));

> +	memcpy(prog, insn, sizeof(insn));
> +
> +	memset(attr, 0, sizeof(*attr));
> +	attr->prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
> +	attr->insns = ptr_to_u64(prog);
> +	attr->insn_cnt = ARRAY_SIZE(insn);
> +	attr->license = ptr_to_u64("GPL");
> +	attr->log_buf = ptr_to_u64(log);
> +	attr->log_size = BUFSIZ;
> +	attr->log_level = 1;
> +
> +	TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		if (log[0] != 0) {
> +			tst_res(TINFO, "Verification log:");
> +			fputs(log, stderr);

I guess that we can do tst_res(TINFO, "Verification log:\n%s", log); instead.

> +			tst_brk(TBROK | TTERRNO, "Failed verification");
> +		} else {
> +			tst_brk(TBROK | TTERRNO, "Failed to load program");
> +		}
> +	}
> +
> +	return TST_RET;
> +}
> +
> +static void setup(void)
> +{
> +	memcpy(msg, MSG, sizeof(MSG));
> +}
> +
> +static void run(void)
> +{
> +	int map_fd, prog_fd;
> +	int sk[2];
> +
> +	memset(attr, 0, sizeof(*attr));
> +	attr->map_type = BPF_MAP_TYPE_ARRAY;
> +	attr->key_size = 4;
> +	attr->value_size = 8;
> +	attr->max_entries = 2;
> +
> +	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EPERM) {
> +			tst_brk(TCONF | TTERRNO,
> +				"bpf() requires CAP_SYS_ADMIN on this system");
> +		} else {
> +			tst_brk(TBROK | TTERRNO, "Failed to create array map");
> +		}
> +	}
> +	map_fd = TST_RET;
> +
> +	prog_fd = load_prog(map_fd);
> +
> +	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
> +	SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF,
> +			&prog_fd, sizeof(prog_fd));
> +
> +	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
> +
> +	memset(attr, 0, sizeof(*attr));
> +	attr->map_fd = map_fd;
> +	attr->key = ptr_to_u64(key);
> +	attr->value = ptr_to_u64(val);
> +	*key = 0;
> +
> +	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "array map lookup");
> +	} else if (*val != A64INT + 1) {
> +		tst_res(TFAIL,
> +			"val = %lu, but should be val = %lu + 1",
> +			*val, A64INT);
> +        } else {
> +	        tst_res(TPASS, "val = %lu + 1", A64INT);
> +	}

Wrong indentation, also I do not fancy this if else maze. I guess that
we can can safely do goto exit; if map lookup fails that would point
right before the SAFE_CLOSE() block.

> +	*key = 1;
> +
> +	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "array map lookup");
> +	} else if (*val != A64INT - 1) {
> +		tst_res(TFAIL,
> +			"val = %lu, but should be val = %lu - 1",
> +			*val, A64INT);
> +        } else {
> +	        tst_res(TPASS, "val = %lu - 1", A64INT);
> +	}


Here as well.

> +	SAFE_CLOSE(prog_fd);
> +	SAFE_CLOSE(map_fd);
> +	SAFE_CLOSE(sk[0]);
> +	SAFE_CLOSE(sk[1]);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.min_kver = "3.18",
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_DROP, CAP_SYS_ADMIN),
> +		{}
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&key, .size = sizeof(*key)},
> +		{&val, .size = sizeof(*val)},
> +		{&log, .size = BUFSIZ},
> +		{&attr, .size = sizeof(*attr)},
> +		{&msg, .size = sizeof(MSG)},
> +		{},
> +	}
> +};
> -- 
> 2.22.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
