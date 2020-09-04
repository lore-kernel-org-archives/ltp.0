From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 4 Sep 2020 17:28:09 +0200
Subject: [LTP] [PATCH v2] syscall/ptrace08: Simplify the test.
In-Reply-To: <20200904140931.10153-1-chrubis@suse.cz>
References: <20200904140931.10153-1-chrubis@suse.cz>
Message-ID: <5d127ee5-56d1-01c5-c364-dcb004204e9d@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
looks good and the test passes on older fixed kernels. Just one
compatibility issue below. Otherwise:

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 04. 09. 20 16:09, Cyril Hrubis wrote:
> The original test was attempting to crash the kernel by setting a
> breakpoint on do_debug kernel function which, when triggered, caused an
> infinite loop in the kernel. The problem with this approach is that
> kernel internal function names are not stable at all and the name was
> changed recently, which made the test fail for no good reason.
> 
> The original kernel fix made it however poissible to set a kernel
> address as a breakpoint and instead disabled the breakpoint on userspace
> modification. The error checks were deffered to write to the dr7 that
> enabled the breakpoint again.
> 
> So on newer kernels we do not allow to set the breakpoint to the kernel
> addres at all, which means that the POKEUSR to dr0 has to fail with an
> address in a kernel range and also we read back the breakpoint address
> and check that it wasn't set just to be sure.
> 
> On older kernels we check that the POKEUSER to dr7 that enables the
> breakpoint fails properly after the dr0 has been set to an address in
> the kernel range.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Alexandre Chartre <alexandre.chartre@oracle.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace08.c | 136 +++++++++++---------
>  1 file changed, 76 insertions(+), 60 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
> index 591aa0dd2..1b84ce376 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace08.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
> @@ -5,8 +5,17 @@
>   *
>   * CVE-2018-1000199
>   *
> - * Test error handling when ptrace(POKEUSER) modifies debug registers.
> - * Even if the call returns error, it may create breakpoint in kernel code.
> + * Test error handling when ptrace(POKEUSER) modified x86 debug registers even
> + * when the call returned error.
> + *
> + * When the bug was present we could create breakpoint in the kernel code,
> + * which shoudn't be possible at all. The original CVE caused a kernel crash by
> + * setting a breakpoint on do_debug kernel function which, when triggered,
> + * caused an infinite loop. However we do not have to crash the kernel in order
> + * to assert if kernel has been fixed or not. All we have to do is to try to
> + * set a breakpoint, on any kernel address, then read it back and check if the
> + * value has been set or not.
> + *
>   * Kernel crash partially fixed in:
>   *
>   *  commit f67b15037a7a50c57f72e69a6d59941ad90a0f0f
> @@ -26,69 +35,54 @@
>  #include "tst_safe_stdio.h"
>  
>  #if defined(__i386__) || defined(__x86_64__)
> -#define SYMNAME_SIZE 256
> -#define KERNEL_SYM "do_debug"
>  
> -static unsigned long break_addr;
>  static pid_t child_pid;
>  
> -static void setup(void)
> -{
> -	int fcount;
> -	char endl, symname[256];
> -	FILE *fr = SAFE_FOPEN("/proc/kallsyms", "r");
> -
> -	/* Find address of do_debug() in /proc/kallsyms */
> -	do {
> -		fcount = fscanf(fr, "%lx %*c %255s%c", &break_addr, symname,
> -			&endl);
> -
> -		if (fcount <= 0 && feof(fr))
> -			break;
> -
> -		if (fcount < 2) {
> -			fclose(fr);
> -			tst_brk(TBROK, "Unexpected data in /proc/kallsyms %d",
> -				fcount);
> -		}
> -
> -		if (fcount >= 3 && endl != '\n')
> -			while (!feof(fr) && fgetc(fr) != '\n');
> -	} while (!feof(fr) && strcmp(symname, KERNEL_SYM));
> -
> -	SAFE_FCLOSE(fr);
> -
> -	if (strcmp(symname, KERNEL_SYM))
> -		tst_brk(TBROK, "Cannot find address of kernel symbol \"%s\"",
> -			KERNEL_SYM);
> -
> -	if (!break_addr)
> -		tst_brk(TCONF, "Addresses in /proc/kallsyms are hidden");
> +#if defined(__x86_64__)
> +# define KERN_ADDR_MIN 0xffff800000000000
> +# define KERN_ADDR_MAX 0xffffffffffffffff
> +# define KERN_ADDR_BITS 64
> +#elif defined(__i386__)
> +# define KERN_ADDR_MIN 0xc0000000
> +# define KERN_ADDR_MAX 0xffffffff
> +# define KERN_ADDR_BITS 32
> +#endif
>  
> -	tst_res(TINFO, "Kernel symbol \"%s\" found at 0x%lx", KERNEL_SYM,
> -		break_addr);
> -}
> +static int deffered_check;
>  
> -static void debug_trap(void)
> +static void setup(void)
>  {
> -	/* x86 instruction INT1 */
> -	asm volatile (".byte 0xf1");
> +	/*
> +	 * When running in compat mode we can't pass 64 address to ptrace so we
> +	 * have to skip the test.
> +	 */
> +	if (tst_kernel_bits() != KERN_ADDR_BITS)
> +		tst_brk(TCONF, "Cannot pass 64bit kernel address in compat mode");
> +
> +
> +	/*
> +	 * The original fix for the kernel haven't rejected the kernel address
> +	 * right away when breakpoint was modified from userspace it was
> +	 * disabled and the EINVAL was returned when dr7 was written to enable
> +	 * it again.
> +	 */
> +	if (tst_kvercmp(4, 17, 0) < 0)
> +		deffered_check = 1;
>  }
>  
>  static void child_main(void)
>  {
>  	raise(SIGSTOP);
> -	/* wait for SIGCONT from parent */
> -	debug_trap();
>  	exit(0);
>  }
>  
> -static void run(void)
> +static void ptrace_try_kern_addr(unsigned long kern_addr)
>  {
>  	int status;
> -	pid_t child;
>  
> -	child = child_pid = SAFE_FORK();
> +	tst_res(TINFO, "Trying address 0x%lx", kern_addr);
> +
> +	child_pid = SAFE_FORK();
>  
>  	if (!child_pid)
>  		child_main();
> @@ -102,23 +96,46 @@ static void run(void)
>  	SAFE_PTRACE(PTRACE_POKEUSER, child_pid,
>  		(void *)offsetof(struct user, u_debugreg[7]), (void *)1);
>  
> -	/* Return value intentionally ignored here */
> -	ptrace(PTRACE_POKEUSER, child_pid,
> +	TEST(ptrace(PTRACE_POKEUSER, child_pid,
>  		(void *)offsetof(struct user, u_debugreg[0]),
> -		(void *)break_addr);
> +		(void *)kern_addr));
> +
> +	if (deffered_check) {
> +		TEST(ptrace(PTRACE_POKEUSER, child_pid,
> +			(void *)offsetof(struct user, u_debugreg[7]), (void *)1));
> +	}
> +
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "ptrace() breakpoint with kernel addr succeeded");
> +	} else {
> +		if (TST_ERR == EINVAL) {
> +			tst_res(TPASS | TTERRNO,
> +				"ptrace() breakpoint with kernel addr failed");
> +		} else {
> +			tst_res(TFAIL | TTERRNO,
> +				"ptrace() breakpoint on kernel addr should return EINVAL, got");
> +		}
> +	}
> +
> +	unsigned long addr;

AFAICT, we're not compiling with --std=c99 so older compilers may
complain about the variable declaration here.

> +
> +	addr = ptrace(PTRACE_PEEKUSER, child_pid,
> +	              (void*)offsetof(struct user, u_debugreg[0]), NULL);
> +
> +	if (!deffered_check && addr == kern_addr)
> +		tst_res(TFAIL, "Was able to set breakpoint on kernel addr");
>  
>  	SAFE_PTRACE(PTRACE_DETACH, child_pid, NULL, NULL);
>  	SAFE_KILL(child_pid, SIGCONT);
>  	child_pid = 0;
> +	tst_reap_children();
> +}
>  
> -	if (SAFE_WAITPID(child, &status, 0) != child)
> -		tst_brk(TBROK, "Received event from unexpected PID");
> -
> -	if (!WIFSIGNALED(status))
> -		tst_brk(TBROK, "Received unexpected event from child");
> -
> -	tst_res(TPASS, "Child killed by %s", tst_strsig(WTERMSIG(status)));
> -	tst_res(TPASS, "We're still here. Nothing bad happened, probably.");
> +static void run(void)
> +{
> +	ptrace_try_kern_addr(KERN_ADDR_MIN);
> +	ptrace_try_kern_addr(KERN_ADDR_MAX);
> +	ptrace_try_kern_addr(KERN_ADDR_MIN + (KERN_ADDR_MAX - KERN_ADDR_MIN)/2);
>  }
>  
>  static void cleanup(void)
> @@ -133,7 +150,6 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.forks_child = 1,
> -	.taint_check = TST_TAINT_W | TST_TAINT_D,
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "f67b15037a7a"},
>  		{"CVE", "2018-1000199"},
> 


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
