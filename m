From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 9 Feb 2017 17:00:52 +0800
Subject: [LTP] [PATCH v2] syscalls/signal06: fix test for regression
 with earlier version of gcc and kernel
In-Reply-To: <1479284063-12968-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <20161010131529.GA1684@rei>
 <1479284063-12968-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <589C2FC4.4080502@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Ping, thanks!


Best Regards,
Guangwen Feng

On 11/16/2016 04:14 PM, Guangwen Feng wrote:
> 1. Currently, following code is incorrect on some releases with
>    earlier version of gcc(tested on RHEL5.11GA):
> 
> 	while (D == d && loop < LOOPS) {
> 
>    Because the argument in function test(double d) is used via (%rsp),
>    but here we actually need a xmm register to trigger the fpu bug.
>    So use global value instead to make sure to take use of xmm.
> 
> 2. Although this regression test is designed to trigger SIGSEGV
>    intentionally, on some releases with old kernel(tested on RHEL5.11GA),
>    this will still lead to segmentation fault that terminate the program
>    and break the test even though compiling with -O2.  So slightly adjust
>    the weight of the codes in child thread to depress SIGSEGV trigger's
>    chance while increase LOOPS to ensure reproducible.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/signal/signal06.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
> index 75ef733..1f1b31c 100644
> --- a/testcases/kernel/syscalls/signal/signal06.c
> +++ b/testcases/kernel/syscalls/signal/signal06.c
> @@ -31,8 +31,8 @@
>   * 		Date:   Tue Sep 2 19:57:17 2014 +0200
>   *
>   *      commit 66463db4fc5605d51c7bb81d009d5bf30a783a2c
> - *               Author: Oleg Nesterov <oleg@redhat.com>
> - *               Date:   Tue Sep 2 19:57:13 2014 +0200
> + *              Author: Oleg Nesterov <oleg@redhat.com>
> + *              Date:   Tue Sep 2 19:57:13 2014 +0200
>   *
>   * Reproduce:
>   *	Test-case (needs -O2).
> @@ -55,20 +55,21 @@ int TST_TOTAL = 5;
>  
>  #if __x86_64__
>  
> -#define LOOPS 10000
> +#define LOOPS 30000
> +#define VALUE 123.456
>  
>  volatile double D;
>  volatile int FLAGE;
>  
>  char altstack[4096 * 10] __attribute__((aligned(4096)));
>  
> -void test(double d)
> +void test(void)
>  {
>  	int loop = 0;
>  	int pid = getpid();
>  
> -	D = d;
> -	while (D == d && loop < LOOPS) {
> +	D = VALUE;
> +	while (D == VALUE && loop < LOOPS) {
>  		/* sys_tkill(pid, SIGHUP); asm to avoid save/reload
>  		 * fp regs around c call */
>  		asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
> @@ -94,12 +95,16 @@ void sigh(int sig LTP_ATTRIBUTE_UNUSED)
>  
>  void *tfunc(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
> -	for (; ;) {
> -		TEST(mprotect(altstack, sizeof(altstack), PROT_READ));
> -		if (TEST_RETURN == -1)
> -			tst_brkm(TBROK | TTERRNO, NULL, "mprotect failed");
> +	int i;
> +
> +	for (i = -1; ; i *= -1) {
> +		if (i == -1) {
> +			TEST(mprotect(altstack, sizeof(altstack), PROT_READ));
> +			if (TEST_RETURN == -1)
> +				tst_brkm(TBROK | TTERRNO, NULL, "mprotect failed");
> +		}
>  
> -		TEST(mprotect(altstack, sizeof(altstack), PROT_READ|PROT_WRITE));
> +		TEST(mprotect(altstack, sizeof(altstack), PROT_READ | PROT_WRITE));
>  		if (TEST_RETURN == -1)
>  			tst_brkm(TBROK | TTERRNO, NULL, "mprotect failed");
>  
> @@ -148,7 +153,7 @@ int main(int ac, char **av)
>  				tst_brkm(TBROK | TRERRNO, NULL,
>  						"pthread_create failed");
>  
> -			test(123.456);
> +			test();
>  
>  			TEST(pthread_join(pt, NULL));
>  			if (TEST_RETURN)
> 


