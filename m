From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Apr 2021 10:46:49 +0200
Subject: [LTP] [PATCH v2 5/5] bpf: Check truncation on 32bit div/mod by
 zero
In-Reply-To: <20210429150510.21585-6-rpalethorpe@suse.com>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
 <20210429150510.21585-6-rpalethorpe@suse.com>
Message-ID: <YIvD+cd3I4ExCIY7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static int load_prog(void)
> +{
> +	struct bpf_insn_buf prog_insn = { 0 };
> +        /* r6 = 1 << 32
> +	 * r7 = -1
> +	 */
> +	const struct bpf_insn set_src_dst_insn[] = {
> +		BPF_LD_IMM64(BPF_REG_6, 1ULL << 32),
> +		BPF_MOV64_IMM(BPF_REG_7, -1LL),
> +	};
> +	/* w7 /= w6 */
> +	const struct bpf_insn div_insn =
> +		BPF_ALU32_REG(BPF_DIV, BPF_REG_7, BPF_REG_6);
> +	/* w7 %= w6 */
> +	const struct bpf_insn mod_insn =
> +		BPF_ALU32_REG(BPF_MOD, BPF_REG_7, BPF_REG_6);
> +	/* exit(0) */
> +	const struct bpf_insn exit_insn[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN()
> +	};
> +
> +	bpf_insn_buf_cat(&prog_insn, set_src_dst_insn, sizeof(set_src_dst_insn));
> +	bpf_insn_buf_cat(&prog_insn, &div_insn, sizeof(div_insn));
> +
> +	bpf_insn_buf_array_set(&prog_insn, map_fd, 0, BPF_REG_6);
> +	bpf_insn_buf_array_set(&prog_insn, map_fd, 1, BPF_REG_7);
> +
> +	bpf_insn_buf_cat(&prog_insn, set_src_dst_insn, sizeof(set_src_dst_insn));
> +	bpf_insn_buf_cat(&prog_insn, &mod_insn, sizeof(mod_insn));
> +
> +	bpf_insn_buf_array_set(&prog_insn, map_fd, 2, BPF_REG_6);
> +	bpf_insn_buf_array_set(&prog_insn, map_fd, 3, BPF_REG_7);
> +
> +	bpf_insn_buf_cat(&prog_insn, exit_insn, sizeof(exit_insn));
> +
> +        bpf_init_prog_attr(attr, prog_insn.insn, prog_insn.byte_len, log, BUFSIZE);

I find this completely unreadable to be honest, the array with
instructions is much better.

-- 
Cyril Hrubis
chrubis@suse.cz
