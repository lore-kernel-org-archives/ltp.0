From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 27 Jul 2021 16:39:29 +0100
Subject: [LTP] [PATCH] Add set_mempolicy05, CVE-2017-7616
In-Reply-To: <YQALVdEAGOVa+g4H@yuki>
References: <20210726154605.7828-1-rpalethorpe@suse.com>
 <YQALVdEAGOVa+g4H@yuki>
Message-ID: <878s1rlqa6.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> --- a/testcases/kernel/syscalls/set_mempolicy/Makefile
>> +++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
>> @@ -8,4 +8,7 @@ include $(top_srcdir)/include/mk/testcases.mk
>>  LDLIBS  += $(NUMA_LIBS)
>>  LTPLDLIBS = -lltpnuma
>>  
>> +set_mempolicy05: LDLIBS=-lltp
>> +set_mempolicy05: LTPLDLIBS=
>
> This is rather ugly hack this should be done with:
>
> diff --git a/testcases/kernel/syscalls/set_mempolicy/Makefile b/testcases/kernel/syscalls/set_mempolicy/Makefile
> index e6e699808..370a9a85f 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/Makefile
> +++ b/testcases/kernel/syscalls/set_mempolicy/Makefile
> @@ -5,7 +5,9 @@ LTPLIBS = ltpnuma
>
>  include $(top_srcdir)/include/mk/testcases.mk
>
> -LDLIBS  += $(NUMA_LIBS)
> -LTPLDLIBS = -lltpnuma
> +NEEDS_LIBS=set_mempolicy01 set_mempolicy02 set_mempolicy03 set_mempolicy04
> +
> +$(NEEDS_LIBS): LDLIBS += $(NUMA_LIBS)
> +$(NEEDS_LIBS): LTPLDLIBS = -lltpnuma

+1

>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>
>
>>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
>> new file mode 100644
>> index 000000000..86f6a95dc
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
>> + */
>> +/*\
>> + *
>> + * [Description]
>> + *
>> + * This will reproduce an information leak in the set_mempolicy 32-bit
>> + * compat syscall. The catch is that the 32-bit compat syscall is not
>> + * used in x86_64 upstream. So at the time of writing, 32-bit programs
>> + * on large x86_64 numa systems will be broken if they use
>> + * set_mempolicy. OTOH they could not have been exploited either.
>> + *
>> + * On other architectures the compat syscall is connected. Including
>> + * PowerPC which has also been included as well. It is possible some
>> + * vendors connected the x86_64 compat call in their kernel branch.
>> + *
>> + * The kernel allocates memory from the user's stack as a temporary
>> + * work area. Allowing it to copy the node array of 32-bit fields to
>> + * 64-bit fields. It uses user memory so that it can share the
>> + * non-compatability syscall functions which use copy_from_user()
>> + * internally.
>> + *
>> + * Originally the compat call would copy a chunk of the
>> + * uninitialized kernel stack to the user stack before checking the
>> + * validation result. This meant when the user passed in an invalid
>> + * node_mask_ptr. They would get kernel stack data somewhere below
>> + * their stack pointer.
>> + *
>> + * So we allocate and set an array on the stack (larger than any
>> + * redzone). Then move the stack pointer to the beginning of the
>> + * array. Then move it back after the syscall. We can then check to
>> + * see if the array has been modified.
>> + */
>> +
>> +#include "config.h"
>> +#include "tst_test.h"
>> +
>> +#if defined(__i386__) || defined(__powerpc__)
>> +
>> +#include <string.h>
>> +
>> +static unsigned int i;
>> +static int sys_ret;
>> +#ifdef __i386__
>> +static const int sys_num = 276;
>> +static const int mode;
>> +static const int node_mask_ptr = UINT_MAX;
>> +static const int node_mask_sz = UINT_MAX;
>> +#endif
>> +static volatile char *stack_ptr;
>> +
>> +static void run(void)
>> +{
>> +#ifdef __powerpc__
>> +	register long sys_num __asm__("r0");
>> +	register long mode __asm__("r3");
>> +	register long node_mask_ptr __asm__("r4");
>> +	register long node_mask_sz __asm__("r5");
>> +#endif
>> +	char stack_pattern[0x400];
>> +
>> +	stack_ptr = stack_pattern;
>> +	memset(stack_pattern, 0xA5, sizeof(stack_pattern));
>> +	tst_res(TINFO, "stack pattern is in %p-%p", stack_ptr, stack_ptr + 0x400);
>> +
>> +#ifdef __powerpc__
>> +	sys_num = 261;
>> +	mode = 0;
>> +	node_mask_ptr = ~0UL;
>> +	node_mask_sz = ~0UL;
>> +	asm volatile (
>> +		"addi 1,1,1024\n\t"
>> +		"sc\n\t"
>> +		"addi 1,1,-1024\n\t" :
>> +		"+r"(sys_num), "+r"(mode), "+r"(node_mask_ptr), "+r"(node_mask_sz) :
>> +		:
>> +		"memory", "cr0", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
>> +	sys_ret = mode;
>> +#else /* __i386__ */
>> +	asm volatile (
>> +		"add $0x400, %%esp\n\t"
>> +		"int $0x80\n\t"
>> +		"sub $0x400, %%esp\n\t" :
>> +		"=a"(sys_ret) :
>> +		"a"(sys_num), "b"(mode), "c"(node_mask_ptr), "d"(node_mask_sz) :
>> +		"memory");
>> +	sys_ret = -sys_ret;
>> +#endif
>
> I guess that we are doing this so that a call to a syscall() does not
> clobber the stack we have initialized to the pattern. I guess that if
> more tests that need this arise we may as well add the magic macros
> glibc uses to generate these into lapi/ somewhere...

Sort of the opposite, we want the syscall to allocate in the area where
the pattern is. Usually syscalls do not push anything onto the user
stack AFAICT. The stack segment is changed by the interrupt. It seems
the kernel may then change the stack segment again on entry to a per
CPU/thread kernel stack. At any rate, nothing is written after the stack
pointer unless the bug is present. At least on newer kernels and CPUS of
course.

>
> Also it may make sense to write a more generic test that calls different
> syscalls and scans stack for any data leakage, which should be far more
> useful than this.

The problem is identifying sensitive data. Compat syscalls will write to
the user stack. I suppose it will usually be the same data passed in,
but marshalled to 64-bit. However if they wrote something else to the
stack, that would not necessarily be a bug.

I suppose for an ordinary systemcall you would not expect the user stack
to be modified... I'm not sure this is a useful thing to invest time in
though. Apart from to educate us on how kernel entry code works on
various architectures.

-- 
Thank you,
Richard.
