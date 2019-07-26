From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 26 Jul 2019 08:22:57 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/mprotect04: Fix compilation error for
 ia64
In-Reply-To: <20190726092110.13116-1-pvorel@suse.cz>
References: <20190726092110.13116-1-pvorel@suse.cz>
Message-ID: <1968200096.2791881.1564143777013.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Fixes: 94f5be719 ("syscalls/mprotect04: align exec_func to 64 bytes")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> or should we drop ia64 support as the architecture is obsolete?
> Since we don't test this arch, there are some other build failures
> (at least on old SLES I tested the patch).

Thanks, I missed the ia64-specific code. RHEL dropped support for ia64 in RHEL6,
and RHEL5 will likely be EOL in ~6 months, so I'm fine either way.

One note below.

> 
> Kind regards,
> Petr
> 
>  testcases/kernel/syscalls/mprotect/mprotect04.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mprotect/mprotect04.c
> b/testcases/kernel/syscalls/mprotect/mprotect04.c
> index a014ab6b4..d1991a2db 100644
> --- a/testcases/kernel/syscalls/mprotect/mprotect04.c
> +++ b/testcases/kernel/syscalls/mprotect/mprotect04.c
> @@ -141,7 +141,7 @@ struct func_desc {
>  	uint64_t glob_pointer;
>  };
>  
> -static __attribute__((noinline)) void *get_func(void *mem)
> +static __attribute__((noinline)) void *get_func(void *mem, uintptr_t
> *func_page_offset LTP_ATTRIBUTE_UNUSED)
>  {
>  	static struct func_desc fdesc;
>  
> @@ -275,11 +275,13 @@ static void testfunc_protexec(void)
>  	if (!func)
>  		goto out;
>  
> +#ifndef __ia64__

If you initialize func_page_offset to 0 in ia64 get_func(), then this ifdef
is not needed. Either way:

Acked-by: Jan Stancek <jstancek@redhat.com>

>  	if (func_page_offset + 64 > page_sz) {
>  		SAFE_MUNMAP(cleanup, p, page_sz);
>  		tst_brkm(TCONF, cleanup, "func too close to page boundary, "
>  			"maybe your compiler ignores -falign-functions?");
>  	}
> +#endif
>  
>  	/* Change the protection to PROT_EXEC. */
>  	TEST(mprotect(p, page_sz, PROT_EXEC));
> --
> 2.22.0
> 
> 
