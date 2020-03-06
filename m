From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 6 Mar 2020 09:53:18 +0800
Subject: [LTP] [PATCH 1/1] hugeshmctl01: Fix reset stat_time when
 looping with -i n
In-Reply-To: <20200305171844.24020-1-pvorel@suse.cz>
References: <20200305171844.24020-1-pvorel@suse.cz>
Message-ID: <cd067b8a-224d-993f-8668-e8f7b70f59bc@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

> c7a2d296b didn't reset stat_time, thus uninitialized set_shared was
> assigned to test variable and test got value from a null pointer,
> which leaded to segfault.
> 
> hugeshmctl01.c:279: PASS: shmctl in func_rmid() failed as expected, shared memory appears to be removed
> tst_checkpoint.c:147: BROK: hugeshmctl01.c:152: tst_checkpoint_wait(0, 10000): ETIMEDOUT (110)
> mem.c:817: INFO: set nr_hugepages to 0
> 
> dmesg:
> segfault at 7f73f8c00000 ip 00000000004051e1 sp 00007ffef375f9a0 error 6 in hugeshmctl01.master[404000+13000]
> addr2line -e hugeshmctl01 -f  00000000004051e1
> stat_setup
> hugeshmctl01.c:139 (discriminator 4)
> 
> test = (stat_time == FIRST) ? set_shmat() : set_shared;
> 
> /* do an assignement for fun */
> *(int *)test = i; // error here
> 
> Fixes: c7a2d296b ("hugeshmctl: Use loop from the API")
> 
> Reported-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Suggested-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Xu,
> 
> I'm sorry for introducing a regression.
> Thank you for a report and fixing the test.
> I'd personally prefer to keep .tcnt = ARRAY_SIZE(tcases),
> but maybe others will prefer to keep loop in test_hugeshmctl()
> as it was before my change.
> 
> BTW it'd be nice to have something like setup_i() and cleanup_i(),
> which would be called before/after each run of whole test, when run with
> -i n.
Sub tests have own clean and setup function. They only reused  a System 
V shared memory segment. IMO, this is a question of coupling.
> 
> Kind regards,
> Petr
> 
>   .../mem/hugetlb/hugeshmctl/hugeshmctl01.c     | 27 ++++++++++---------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> index e6cf8bf09..3b7e14363 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
> @@ -75,6 +75,20 @@ struct tcase {
>   
>   static void test_hugeshmctl(unsigned int i)
>   {
> +	stat_time = FIRST;
> +
My description may confuse you.  stat_time should not be reseted every 
time, it only needs to be reseted when next loop. This value will be +1 
  when call stat_cleanup.
struct tcase {
         int cmd;
         void (*func_test) (void);
         void (*func_setup) (void);
} tcases[] = {
         {IPC_STAT, func_stat, stat_setup},   //stat_time = FIRST
         {IPC_STAT, func_stat, stat_setup},   //stat_time = SECOND

As you do, the first and second case are same. it should be added into 
the "if == 0".

ps: I personally think old case is more cleaner. Let's hear from others.

Best Regards
Yang Xu
> +	/*
> +	 * Create a shared memory segment with read and write
> +	 * permissions. Do this here instead of in setup()
> +	 * so that looping (-i) will work correctly.
> +	 */
> +	if (i == 0) {
> +		shm_id_1 = shmget(shmkey, shm_size,
> +				SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
> +		if (shm_id_1 == -1)
> +			tst_brk(TBROK | TERRNO, "shmget #main");
> +	}
> +
>   	/*
>   	 * if needed, set up any required conditions by
>   	 * calling the appropriate setup function
> @@ -296,19 +310,6 @@ void setup(void)
>   	shm_size = hpage_size * hugepages / 2;
>   	update_shm_size(&shm_size);
>   	shmkey = getipckey();
> -
> -	/* initialize stat_time */
> -	stat_time = FIRST;
> -
> -	/*
> -	 * Create a shared memory segment with read and write
> -	 * permissions.  Do this here instead of in setup()
> -	 * so that looping (-i) will work correctly.
> -	 */
> -	shm_id_1 = shmget(shmkey, shm_size,
> -			SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW);
> -	if (shm_id_1 == -1)
> -		tst_brk(TBROK | TERRNO, "shmget #main");
>   }
>   
>   void cleanup(void)
> 


