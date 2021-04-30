From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Apr 2021 10:44:25 +0200
Subject: [LTP] [PATCH v2 4/5] bpf: Add bpf_insn_buf,
 map and instruction concatenation helpers
In-Reply-To: <20210429150510.21585-5-rpalethorpe@suse.com>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
 <20210429150510.21585-5-rpalethorpe@suse.com>
Message-ID: <YIvDaQr7WUqn2FjC@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Add helpers for building up programs. Tests before bpf_prog05 have not
> been updated to use this for two reasons.
> 
> 1. Some apply offsets to the map pointer returned or jump to the end
>    of the program instead of just over an immediate exit
>    instruction. Either way modifying them would require testing they
>    still reproduce the bug.
> 
> 2. Some have a lot of comments describing the program which is useful
>    to learn from. These would need to be moved.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/syscalls/bpf/bpf_common.c | 40 ++++++++++++++++++++++
>  testcases/kernel/syscalls/bpf/bpf_common.h | 12 +++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
> index b5337c22a..d80ed91bb 100644
> --- a/testcases/kernel/syscalls/bpf/bpf_common.c
> +++ b/testcases/kernel/syscalls/bpf/bpf_common.c
> @@ -82,6 +82,46 @@ long bpf_map_array_get(const int map_fd,
>  	return TST_RET;
>  }
>  
> +void bpf_insn_buf_cat(struct bpf_insn_buf *const self,
> +		      const struct bpf_insn *const insn_to_cat,
> +		      const size_t insn_to_cat_len)
> +{
> +	memcpy(((char *)self->insn) + self->byte_len,
> +	       insn_to_cat, insn_to_cat_len);
> +	self->byte_len += insn_to_cat_len;
> +}
> +
> +/* map[array_indx] = reg_to_save
> + *
> + * Inserts the following into insn_out.
> + *
> + * r1 = map_fd
> + * r2 = fp
> + * r2 = r2 - 4
> + * r2 = array_indx
> + * call map_lookup_elem(r1, r2)
> + * if r0 != 0 goto pc+1
> + * exit
> + * *r0 = reg_to_save
> + *
> + */
> + void bpf_insn_buf_array_set(struct bpf_insn_buf *const self, const int map_fd,
> +			     const uint32_t array_indx, const uint8_t reg_to_save)
> +{
> +	const struct bpf_insn map_insn[] = {
> +		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
> +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4),
> +		BPF_ST_MEM(BPF_W, BPF_REG_2, 0, array_indx),
> +		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> +		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> +		BPF_EXIT_INSN(),
> +		BPF_STX_MEM(BPF_DW, BPF_REG_0, reg_to_save, 0),
> +	};

I'm wondering if it would be easier to write a macro that would produce
this code, something as:

	#define BPF_ARRAY_STORE(map_fd, arr_idx, reg_to_save) \
		BPF_LD_MAP_FD(BPF_REG_1, map_fd), \
		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10), \
		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), \
		BPF_ST_MEM(BPF_W, BPF_REG_2, 0, arr_indx), \
		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem), \
		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1), \
		BPF_EXIT_INSN(), \
		BPF_STX_MEM(BPF_DW, BPF_REG_0, reg_to_save, 0)


Then we can use this piece as any other macros when constructing the
program, the only difference is that this macro emits 8 instructions
instead of one.

What do you think?

> +	bpf_insn_buf_cat(self, map_insn, sizeof(map_insn));
> +}
> +
>  void bpf_init_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
>  	size_t prog_size, char *log_buf, size_t log_size)
>  {
> diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
> index 9e9935c2c..10b1eee86 100644
> --- a/testcases/kernel/syscalls/bpf/bpf_common.h
> +++ b/testcases/kernel/syscalls/bpf/bpf_common.h
> @@ -13,6 +13,11 @@
>  
>  #define BPF_MEMLOCK_ADD (2*1024*1024)
>  
> +struct bpf_insn_buf {
> +	size_t byte_len;
> +	struct bpf_insn insn[BPF_MAXINSNS];
> +};
> +
>  void rlimit_bump_memlock(void);
>  int bpf_map_create(union bpf_attr *attr);
>  int bpf_map_array_create(uint32_t max_entries);
> @@ -20,6 +25,13 @@ long bpf_map_array_get(const int map_fd,
>  		       const uint32_t *const array_indx,
>  		       uint64_t *const array_val);
>  
> +void bpf_insn_buf_cat(struct bpf_insn_buf *const self,
> +		      const struct bpf_insn *const insn_to_cat,
> +		      const size_t insn_to_cat_len);
> +void bpf_insn_buf_array_set(struct bpf_insn_buf *const self,
> +			    const int map_fd,
> +			    const uint32_t array_indx, const uint8_t reg_to_save);
> +
>  void bpf_init_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
>  			size_t prog_size, char *log_buf, size_t log_size);
>  int bpf_load_prog(union bpf_attr *attr, const char *log);
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
