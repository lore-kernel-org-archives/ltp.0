From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Mar 2018 14:52:38 +0800
Subject: [LTP] [PATCH v2] mprotect04: get right function entry if system
 using function descriptors
In-Reply-To: <20180326064808.5503-1-liwang@redhat.com>
References: <20180326064808.5503-1-liwang@redhat.com>
Message-ID: <CAEemH2cSep2YeVUuafCGuksTRkjftdZnf0xAkZKk8ssq=A436w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add CC'ing Michael Ellerman <mpe@ellerman.id.au>


On Mon, Mar 26, 2018 at 2:48 PM, Li Wang <liwang@redhat.com> wrote:

> On some big endian powerpc64 ABI, function ptrs are basically pointers
> to function descriptors. The testcase copies functions which results
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
> --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_PKUERR,
> si_addr=0x7fffaed00170} ---
>
> Reported-and-tested-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/mprotect/mprotect04.c | 41
> ++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c
> b/testcases/kernel/syscalls/mprotect/mprotect04.c
> index 1173afd..60941a4 100644
> --- a/testcases/kernel/syscalls/mprotect/mprotect04.c
> +++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
> @@ -56,6 +56,7 @@ int TST_TOTAL = ARRAY_SIZE(testfunc);
>  static volatile int sig_caught;
>  static sigjmp_buf env;
>  static unsigned int copy_sz;
> +typedef void (*func_ptr_t)(void);
>
>  int main(int ac, char **av)
>  {
> @@ -190,6 +191,22 @@ static void clear_cache(void *start, int len)
>  }
>
>  /*
> + * To check for the ABI version, because ppc64le can technically use
> + * function descriptors.
> + */
> +#if defined(__powerpc64__) && (!defined(_CALL_ELF) || _CALL_ELF < 2)
> +#define USE_FUNCTION_DESCRIPTORS
> +#endif
> +
> +#ifdef USE_FUNCTION_DESCRIPTORS
> +typedef struct {
> +       uintptr_t entry;
> +       uintptr_t toc;
> +       uintptr_t env;
> +} func_descr_t;
> +#endif
> +
> +/*
>   * Copy page where &exec_func resides. Also try to copy subsequent page
>   * in case exec_func is close to page boundary.
>   */
> @@ -197,11 +214,21 @@ static void *get_func(void *mem)
>  {
>         uintptr_t page_sz = getpagesize();
>         uintptr_t page_mask = ~(page_sz - 1);
> -       uintptr_t func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
> -       void *func_copy_start = mem + func_page_offset;
> -       void *page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
> +       uintptr_t func_page_offset;
> +       void *func_copy_start, *page_to_copy;
>         void *mem_start = mem;
>
> +#ifdef USE_FUNCTION_DESCRIPTORS
> +       func_descr_t *opd =  (func_descr_t *)&exec_func;
> +       func_page_offset = (uintptr_t)opd->entry & (page_sz - 1);
> +       func_copy_start = mem + func_page_offset;
> +       page_to_copy = (void *)((uintptr_t)opd->entry & page_mask);
> +#else
> +       func_page_offset = (uintptr_t)&exec_func & (page_sz - 1);
> +       func_copy_start = mem + func_page_offset;
> +       page_to_copy = (void *)((uintptr_t)&exec_func & page_mask);
> +#endif
> +
>         /* copy 1st page, if it's not present something is wrong */
>         if (!page_present(page_to_copy)) {
>                 tst_resm(TINFO, "exec_func: %p, page_to_copy: %p\n",
> @@ -228,7 +255,7 @@ static void *get_func(void *mem)
>
>  static void testfunc_protexec(void)
>  {
> -       void (*func)(void);
> +       func_ptr_t func;
>         void *p;
>
>         sig_caught = 0;
> @@ -236,7 +263,13 @@ static void testfunc_protexec(void)
>         p = SAFE_MMAP(cleanup, 0, copy_sz, PROT_READ | PROT_WRITE,
>                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>
> +#ifdef USE_FUNCTION_DESCRIPTORS
> +       func_descr_t opd;
> +       opd.entry = (uintptr_t)get_func(p);
> +       func = (func_ptr_t)&opd;
> +#else
>         func = get_func(p);
> +#endif
>
>         /* Change the protection to PROT_EXEC. */
>         TEST(mprotect(p, copy_sz, PROT_EXEC));
> --
> 2.9.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180326/362ca9dc/attachment-0001.html>
