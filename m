From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Sep 2019 08:55:05 -0400 (EDT)
Subject: [LTP] [PATCH v2] BPF: Regression test for 64bit arithmetic
In-Reply-To: <20190905124504.24909-1-rpalethorpe@suse.com>
References: <20190905124504.24909-1-rpalethorpe@suse.com>
Message-ID: <496221419.11145941.1568120105161.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> +static int load_prog(int fd)
> +{
> +	struct bpf_insn *prog;
> +	struct bpf_insn insn[] = {
> +		BPF_MOV64_IMM(BPF_REG_6, 1),            /* r6 = 1 */
> +
> +		BPF_LD_MAP_FD(BPF_REG_1, fd),	        /* r1 = &fd */
> +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* r2 = fp */
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* r2 = r2 - 8 */
> +		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),    /* *r2 = 0 */
> +		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 17), /* if(!r0) goto exit */

Patch looks good to me.

But I keep thinking if there's way to make it more obvious where
offset (e.g. 17) came from.

Idea 1: use multiple lines per instruction to denote length 
  BPF_LD_IMM64(BPF_REG_4,
               A64INT),

Idea 2: prefix commented instructions with offset
        /* 1: r3 = r0 */
        /* 2: r4 = 2^61 */

> +		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),    /* r3 = r0 */
> +		BPF_LD_IMM64(BPF_REG_4, A64INT),        /* r4 = 2^61 */
> +		BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_6), /* r4 += r6 */
> +		BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_4, 0), /* *r3 = r4 */
> +
> +		BPF_LD_MAP_FD(BPF_REG_1, fd),	        /* r1 = &fd */
> +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* r2 = fp */
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* r2 = r2 - 8 */
> +		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 1),    /* *r2 = 1 */
> +		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 5),  /* if(!r0) goto exit */
> +		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),    /* r3 = r0 */
> +		BPF_LD_IMM64(BPF_REG_4, A64INT),        /* r4 = 2^61 */
> +		BPF_ALU64_REG(BPF_SUB, BPF_REG_4, BPF_REG_6), /* r4 -= r6 */
> +		BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_4, 0), /* *r3 = r4 */
> +
> +		BPF_MOV64_IMM(BPF_REG_0, 0),            /* r0 = 0 */
> +		BPF_EXIT_INSN(),		        /* return r0 */
> +	};
