From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 05 Feb 2020 12:48:42 +0100
Subject: [LTP] [PATCH 2/2] Fix BPF test program loading issues
In-Reply-To: <20200203113956.13176-2-mdoucha@suse.cz>
References: <20200203113956.13176-1-mdoucha@suse.cz>
 <20200203113956.13176-2-mdoucha@suse.cz>
Message-ID: <87pnetgspx.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

This looks like a considerable improvement, but a few comments below.

Martin Doucha <mdoucha@suse.cz> writes:

> BPF programs require locked memory which will be released asynchronously.
> If a BPF program gets loaded too many times too quickly, memory allocation
> may fail due to race condition with asynchronous cleanup.
>
> Wrap the bpf() test calls in a retry loop to fix the issue.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/syscalls/bpf/Makefile     |  3 +
>  testcases/kernel/syscalls/bpf/bpf_common.c | 89 ++++++++++++++++++++
>  testcases/kernel/syscalls/bpf/bpf_common.h | 42 ++--------
>  testcases/kernel/syscalls/bpf/bpf_prog01.c | 97 +++++++---------------
>  testcases/kernel/syscalls/bpf/bpf_prog02.c | 28 +------
>  testcases/kernel/syscalls/bpf/bpf_prog03.c | 20 ++---
>  6 files changed, 136 insertions(+), 143 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/bpf/bpf_common.c
>
> diff --git a/testcases/kernel/syscalls/bpf/Makefile b/testcases/kernel/syscalls/bpf/Makefile
> index 990c8c83c..2241bce9b 100644
> --- a/testcases/kernel/syscalls/bpf/Makefile
> +++ b/testcases/kernel/syscalls/bpf/Makefile
> @@ -5,6 +5,9 @@ top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> +FILTER_OUT_MAKE_TARGETS	:= bpf_common
>  CFLAGS			+= -D_GNU_SOURCE
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +$(MAKE_TARGETS): %: %.o bpf_common.o
> diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
> new file mode 100644
> index 000000000..8e61b3a74
> --- /dev/null
> +++ b/testcases/kernel/syscalls/bpf/bpf_common.c
> @@ -0,0 +1,89 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2019-2020 Linux Test Project
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "lapi/bpf.h"
> +#include "bpf_common.h"
> +
> +void rlimit_bump_memlock(void)
> +{
> +	struct rlimit memlock_r;
> +
> +	SAFE_GETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
> +	memlock_r.rlim_cur += BPF_MEMLOCK_ADD;
> +	tst_res(TINFO, "Raising RLIMIT_MEMLOCK to %ld",
> +		(long)memlock_r.rlim_cur);
> +
> +	if (memlock_r.rlim_cur <= memlock_r.rlim_max) {
> +		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
> +	} else if ((geteuid() == 0)) {
> +		memlock_r.rlim_max += BPF_MEMLOCK_ADD;
> +		SAFE_SETRLIMIT(RLIMIT_MEMLOCK, &memlock_r);
> +	} else {
> +		tst_res(TINFO, "Can't raise RLIMIT_MEMLOCK, test may fail "
> +			"due to lack of max locked memory");
> +	}
> +}
> +
> +int bpf_map_create(union bpf_attr *attr)
> +{
> +	TST_SPIN_TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));

We should use exponential backoff on all of these. Unless you have some
reason to think it will cause problems?

> +	if (TST_RET == -1) {
> +		if (TST_ERR == EPERM) {
> +			tst_res(TCONF, "Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled");
> +			tst_brk(TCONF | TTERRNO,
> +				"bpf() requires CAP_SYS_ADMIN on this system");
> +		} else {
> +			tst_brk(TBROK | TTERRNO, "Failed to create array map");
> +		}
> +	}
> +
> +	return TST_RET;
> +}
> +
> +void prepare_bpf_prog_attr(union bpf_attr *attr, const struct
> bpf_insn *prog,

How about just init_bpf_prog_attr?

> +	size_t prog_size, char *log_buf, size_t log_size)
> +{
> +	static struct bpf_insn *buf;
> +	static size_t buf_size;
> +	size_t prog_len = prog_size / sizeof(*prog);
> +
> +	/* all guarded buffers will be free()d automatically by LTP library */
> +	if (!buf || prog_size > buf_size) {
> +		buf = tst_alloc(prog_size);
> +		buf_size = prog_size;
> +	}
> +
> +	memcpy(buf, prog, prog_size);
> +	memset(attr, 0, sizeof(*attr));
> +	attr->prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
> +	attr->insns = ptr_to_u64(buf);
> +	attr->insn_cnt = prog_len;
> +	attr->license = ptr_to_u64("GPL");
> +	attr->log_buf = ptr_to_u64(log_buf);
> +	attr->log_size = log_size;
> +	attr->log_level = 1;
> +}
> +
> +int load_bpf_prog(union bpf_attr *attr, const char *log)

Probably best to always put bpf at the begining so that someone can
simply search "bpf_" to get all the library functions related to that.

> +{
> +	TST_SPIN_TEST(bpf(BPF_PROG_LOAD, attr, sizeof(*attr)));

Same here for exponential backoff.

-- 
Thank you,
Richard.
