From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 26 Mar 2018 11:27:56 +1100
Subject: [LTP] [PATCH] mprotect04: get the right function entry of big
	endian powerpc system
In-Reply-To: <20180325034024.31743-1-liwang@redhat.com>
References: <20180325034024.31743-1-liwang@redhat.com>
Message-ID: <87efk7llyr.fsf@concordia.ellerman.id.au>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> writes:

> On Big endian powerpc ABI, function ptrs are basically pointers to
> function descriptors. The testcase copies functions which results
> in function descriptors getting copied. So easily the access was
> denied by memory protection key in that address when performing it.
>
> 10000000-10020000 r-xp 00000000 fd:00 167223           mprotect04
> 10020000-10030000 r--p 00010000 fd:00 167223           mprotect04
> 10030000-10040000 rw-p 00020000 fd:00 167223           mprotect04
> 1001a380000-1001a3b0000 rw-p 00000000 00:00 0          [heap]
> 7fffa6c60000-7fffa6c80000 --xp 00000000 00:00 0
>
> &exec_func = 0x10030170
> &func = 0x7fffa6c60170
>
> While perform the (*func)(); we get segmentation fault.
>
> strace log:
> -----------
> mprotect(0x7fffaed00000, 131072, PROT_EXEC) = 0
> rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
> --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_PKUERR, si_addr=0x7fffaed00170} ---
>
> Reported-and-tested-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> CC: Michael Ellerman <mpe@ellerman.id.au>

Thanks for fixing this.

Some comments below ...

> diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c b/testcases/kernel/syscalls/mprotect/mprotect04.c
> index 1173afd..5705cb0 100644
> --- a/testcases/kernel/syscalls/mprotect/mprotect04.c
> +++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
> @@ -189,6 +191,14 @@ static void clear_cache(void *start, int len)
>  #endif
>  }
>  
> +#if (defined (__powerpc__) || (__powerpc64__)) && __BYTE_ORDER == __BIG_ENDIAN

That's not quite the right condition.

32-bit powerpc big endian doesn't use function descriptors, but your
check for __powerpc__ will match on 32-bit.

Also the check for __powerpc64__ is missing defined().

So this would work:

  #if defined(__powerpc64__) && __BYTE_ORDER == __BIG_ENDIAN

More correct would be to check for the ABI version, because ppc64le can
technically use function descriptors (it just doesn't in any
configuration you're likely to see).

That would be:

  #if defined(__powerpc64__) && (!defined(_CALL_ELF) || _CALL_ELF < 2)

Given you need that in a few places you should probably make it a
define, eg:

  #if defined(__powerpc64__) && (!defined(_CALL_ELF) || _CALL_ELF < 2)
  #define USE_FUNCTION_DESCRIPTORS
  #endif

  #ifdef USE_FUNCTION_DESCRIPTORS
  typedef struct {
  	uintptr_t entry;
  	uintptr_t toc;
  	uintptr_t env;
  } func_descr_t;
  #endif


cheers

