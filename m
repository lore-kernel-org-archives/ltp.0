From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Sep 2019 15:23:39 +0200
Subject: [LTP] [PATCH v2] BPF: Regression test for 64bit arithmetic
In-Reply-To: <496221419.11145941.1568120105161.JavaMail.zimbra@redhat.com>
References: <20190905124504.24909-1-rpalethorpe@suse.com>
 <496221419.11145941.1568120105161.JavaMail.zimbra@redhat.com>
Message-ID: <20190910132338.GB29865@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> > +static int load_prog(int fd)
> > +{
> > +	struct bpf_insn *prog;
> > +	struct bpf_insn insn[] = {
> > +		BPF_MOV64_IMM(BPF_REG_6, 1),            /* r6 = 1 */
> > +
> > +		BPF_LD_MAP_FD(BPF_REG_1, fd),	        /* r1 = &fd */
> > +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),   /* r2 = fp */
> > +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),  /* r2 = r2 - 8 */
> > +		BPF_ST_MEM(BPF_DW, BPF_REG_2, 0, 0),    /* *r2 = 0 */
> > +		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> > +		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 17), /* if(!r0) goto exit */
> 
> Patch looks good to me.
> 
> But I keep thinking if there's way to make it more obvious where
> offset (e.g. 17) came from.
> 
> Idea 1: use multiple lines per instruction to denote length 
>   BPF_LD_IMM64(BPF_REG_4,
>                A64INT),
> 
> Idea 2: prefix commented instructions with offset
>         /* 1: r3 = r0 */
>         /* 2: r4 = 2^61 */

I guess I like the Idea 2 better.

Another option would be having eBPF assembler included in the LTP build
system. I guess that it may be useful later on and there seems to be one
written in python:

https://github.com/solarflarecom/ebpf_asm

But for the short term I would go with adding the offset to the
comments.

-- 
Cyril Hrubis
chrubis@suse.cz
