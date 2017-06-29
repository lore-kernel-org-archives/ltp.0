From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Jun 2017 18:14:11 +0200
Subject: [LTP] [PATCH v2 2/3] syscalls/shmat0*: cleanup && convert to
	new API
In-Reply-To: <1496317753-2871-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170529145709.GC6618@rei.lan>
 <1496317753-2871-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1496317753-2871-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170629161411.GD3233@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
> +++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.c
> @@ -26,6 +26,8 @@
>  #include <stdlib.h>
>  #include <sys/types.h>
>  #include <sys/ipc.h>
> +#include <sys/msg.h>
> +#include <sys/shm.h>
>  
>  #define	TST_NO_DEFAULT_MAIN
>  
> @@ -79,3 +81,33 @@ int get_used_queues(const char *file, const int lineno)
>  
>  	return used_queues;
>  }
> +
> +void *probe_free_addr(const char *file, const int lineno)
> +{
> +	void *addr;
> +	int shm_id = -1;
> +	key_t probe_key = 0;
> +
> +	if (!probe_key)
> +		probe_key = GETIPCKEY();
> +
> +	shm_id = shmget(probe_key, SHMLBA * 2, SHM_RW | IPC_CREAT | IPC_EXCL);
> +	if (shm_id == -1)
> +		tst_brk(TBROK, "probe: shmget() failed at %s:%d", file, lineno);
> +
> +	addr = shmat(shm_id, NULL, 0);
> +	if (addr == (void *) -1)
> +		tst_brk(TBROK, "probe: shmat() failed at %s:%d", file, lineno);
> +
> +	if (shmdt(addr) == -1)
> +		tst_brk(TBROK, "probe: shmdt() failed at %s:%d", file, lineno);
> +
> +	if (shm_id != -1 && shmctl(shm_id, IPC_RMID, NULL) == -1) {
> +		tst_brk(TWARN, "probe: shmctl() failed at %s:%d", file, lineno);
> +		shm_id == -1;
> +	}

Huh, this part does not really make any sense.

Not only shm_id cannot be -1 since we check for that earlier (and exit
with tst_brk() in case that it is). The shm_id == -1; here is no-op.

I guess that what we really wanted to do here is just:

	if (shmctl(shm_id, IPC_RMID, NULL) == -1)
		tst_brk(TBROK, "...");

> +	addr = (void *)(((unsigned long)(addr) + (SHMLBA - 1)) & ~(SHMLBA - 1));
> +
> +	return addr;
> +}
> diff --git a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
> index 39148be..660be80 100644
> --- a/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
> +++ b/testcases/kernel/syscalls/ipc/libnewipc/libnewipc.h
> @@ -50,4 +50,8 @@ int get_used_queues(const char *file, const int lineno);
>  #define GET_USED_QUEUES() \
>  	get_used_queues(__FILE__, __LINE__)
>  
> +void *probe_free_addr(const char *file, const int lineno);
> +#define PROBE_FREE_ADDR() \
> +	probe_free_addr(__FILE__, __LINE__)
> +
>  #endif /* newlibipc.h */
> diff --git a/testcases/kernel/syscalls/ipc/shmat/Makefile b/testcases/kernel/syscalls/ipc/shmat/Makefile
> index f467389..f9ee8d2 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/Makefile
> +++ b/testcases/kernel/syscalls/ipc/shmat/Makefile
> @@ -19,5 +19,5 @@
>  top_srcdir              ?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> -include $(abs_srcdir)/../Makefile.inc
> +include $(abs_srcdir)/../Makefile2.inc
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> index 6de1872..75958a9 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> @@ -17,225 +17,142 @@
>   */
>  
>  /*
> - * NAME
> - *	shmat01.c
> - *
>   * DESCRIPTION
> - *	shmat01 - test that shmat() works correctly
>   *
> - * ALGORITHM
> - *	create a shared memory resouce with read/write permissions
> - *	loop if that option was specified
> - *	call shmat() with the TEST() macro using three valid conditions
> - *	check the return code
> - *	  if failure, issue a FAIL message.
> - *	otherwise,
> - *	  if doing functionality testing
> - *		check for the correct conditions after the call
> - *		if correct,
> - *			issue a PASS message
> - *		otherwise
> - *			issue a FAIL message
> - *	call cleanup
> + * 1) shmat() chooses a suitable (unused) address when shmaddr is NULL.
> + * 2) shmat() attaches shm segment to the shmaddr when shmaddr is a
> + *    page-aligned address.
> + * 3) shmat() attaches shm segment to the address equal to shmaddr rounded
> + *    down to the nearest multiple of SHMLBA when shmaddr is a page-unaligned
> + *    address and shmflg is set to SHM_RND.
> + * 4) shmat() attaches shm segment to the shmaddr for reading when shmflg
> + *    is set to SHM_RDONLY.
>   */
>  
> -#include "ipcshm.h"
> -#include "shmat_common.h"
> -
> -#define CASE0		10
> -#define CASE1		20
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/shm.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
>  
> -char *TCID = "shmat01";
> -int TST_TOTAL = 4;
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
>  
> -int shm_id_1 = -1;
> +#define ALIGN_DOWN(in_addr) ((void *)(((intptr_t)in_addr / SHMLBA) * SHMLBA))
>  
> -/*
> - * By probing this address first, we can make
> - * non-aligned addresses from it for different
> - * architectures without explicitly code it.
> - */
> -void *base_addr;
> -void *addr;
> +static int shm_id = -1;
> +static key_t shm_key;
> +static void *null_addr;
> +static void *aligned_addr;
> +static void *unaligned_addr;
>  
>  static struct test_case_t {
> -	int *shmid;
> -	int offset;
> -	int flags;
> -	int getbase;
> -} *TC;
> -
> -static void check_functionality(int);
> -
> -int main(int argc, char *argv[])
> +	void **shmaddr;
> +	int flag;
> +	int exp_status;
> +} tcases[] = {
> +	{&null_addr, 0, 0},
> +	{&aligned_addr, 0, 0},
> +	{&unaligned_addr, SHM_RND, 0},
> +	{&aligned_addr, SHM_RDONLY, SIGSEGV}
> +};

Can we, pretty please, include some testcase description here as well?
Since otherwise we cannot tell what was tested given the test output.

Something as:

static struct test_case_t {
        void **shmaddr;
        int flag;
        int exp_status;
        const char *desc;
} tcases[] = {
        {&null_addr, 0, 0, "NULL address"},
        {&aligned_addr, 0, 0, "Aligned address"},
        {&unaligned_addr, SHM_RND, 0, "Unaligned address with SHM_RND"},
        {&aligned_addr, SHM_RDONLY, SIGSEGV, "SIGSEGV on write with SHM_READONLY"}
};

Then use that in the PASS/FAIL message at the end of the test.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
