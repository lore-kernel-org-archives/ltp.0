From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Jan 2016 06:57:20 -0500 (EST)
Subject: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT
	from	oom()
In-Reply-To: <20151228074919.GA12782@localhost.localdomain>
References: <20151228074919.GA12782@localhost.localdomain>
Message-ID: <423580278.5207145.1452167840798.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: ltp@lists.linux.it
> Sent: Monday, 28 December, 2015 8:49:19 AM
> Subject: [LTP] [PATCH] mem/oom: remove non-existent case OVERCOMMIT from	oom()
> 
> Looks like there is no such a case "OVERCOMMIT" in oom(), so we can just
> remove it.
> 
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Looks good to me, regards,
Jan

> ---
>  testcases/kernel/mem/include/mem.h | 7 +++----
>  testcases/kernel/mem/lib/mem.c     | 2 +-
>  testcases/kernel/mem/oom/oom01.c   | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/mem/include/mem.h
> b/testcases/kernel/mem/include/mem.h
> index 4a18799..041c437 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -32,10 +32,9 @@ static inline void clean_node(unsigned long *array)
>  
>  #define LENGTH			(3UL<<30)
>  #define TESTMEM			(1UL<<30)
> -#define OVERCOMMIT		1
> -#define NORMAL			2
> -#define MLOCK			3
> -#define KSM			4
> +#define NORMAL			1
> +#define MLOCK			2
> +#define KSM			3
>  
>  long overcommit;
>  void oom(int testcase, int lite, int retcode, int allow_sigkill);
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index cee4e91..56104cb 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -110,7 +110,7 @@ out:
>   * oom - allocates memory according to specified testcase and checks
>   *       desired outcome (e.g. child killed, operation failed with ENOMEM)
>   * @testcase: selects how child allocates memory
> - *            valid choices are: OVERCOMMIT, NORMAL, MLOCK and KSM
> + *            valid choices are: NORMAL, MLOCK and KSM
>   * @lite: if non-zero, child makes only single TESTMEM+MB allocation
>   *        if zero, child keeps allocating memory until it gets killed
>   *        or some operation fails
> diff --git a/testcases/kernel/mem/oom/oom01.c
> b/testcases/kernel/mem/oom/oom01.c
> index 712d7b5..e39394b 100644
> --- a/testcases/kernel/mem/oom/oom01.c
> +++ b/testcases/kernel/mem/oom/oom01.c
> @@ -58,12 +58,12 @@ int main(int argc, char *argv[])
>  
>  		/* we expect mmap to fail before OOM is hit */
>  		set_sys_tune("overcommit_memory", 2, 1);
> -		oom(OVERCOMMIT, 0, ENOMEM, 0);
> +		oom(NORMAL, 0, ENOMEM, 0);
>  
>  		/* with overcommit_memory set to 0 or 1 there's no
>  		 * guarantee that mmap fails before OOM */
>  		set_sys_tune("overcommit_memory", 0, 1);
> -		oom(OVERCOMMIT, 0, ENOMEM, 1);
> +		oom(NORMAL, 0, ENOMEM, 1);
>  
>  		set_sys_tune("overcommit_memory", 1, 1);
>  		testoom(0, 0, ENOMEM, 1);
> --
> 1.9.3
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
