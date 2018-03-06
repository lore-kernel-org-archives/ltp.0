From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 6 Mar 2018 11:21:27 +0300
Subject: [LTP] [PATCH] mem/oom,
 tunable: perform cleanup actions only when they are actually
 required
In-Reply-To: <1519132260-9242-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1519132260-9242-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <24eb28d2-27a2-a3f7-c91f-9379732df79a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Could anybody have a look at this patch, please?

Thanks.

On 02/20/2018 04:11 PM, Stanislav Kholmanskikh wrote:
> In these test cases setup() may call tst_brk(TCONF) and so on we need to
> make cleanup() "revert" only those actions which had been actually
> performed in setup() before it called tst_brk(TCONF).
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/mem/lib/mem.c                   |    2 ++
>  testcases/kernel/mem/oom/oom01.c                 |    3 ++-
>  testcases/kernel/mem/oom/oom02.c                 |    3 ++-
>  testcases/kernel/mem/oom/oom03.c                 |    9 +++++++--
>  testcases/kernel/mem/oom/oom04.c                 |    9 +++++++--
>  testcases/kernel/mem/oom/oom05.c                 |   14 +++++++++++---
>  testcases/kernel/mem/tunable/max_map_count.c     |   10 ++++++----
>  testcases/kernel/mem/tunable/min_free_kbytes.c   |   10 ++++++----
>  testcases/kernel/mem/tunable/overcommit_memory.c |   10 ++++++----
>  9 files changed, 49 insertions(+), 21 deletions(-)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 59138a0..4992843 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -27,6 +27,8 @@
>  
>  /* OOM */
>  
> +long overcommit = -1;
> +
>  static int alloc_mem(long int length, int testcase)
>  {
>  	char *s;
> diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
> index 3d05860..beb232d 100644
> --- a/testcases/kernel/mem/oom/oom01.c
> +++ b/testcases/kernel/mem/oom/oom01.c
> @@ -55,7 +55,8 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> -	set_sys_tune("overcommit_memory", overcommit, 0);
> +	if (overcommit != -1)
> +		set_sys_tune("overcommit_memory", overcommit, 0);
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
> index bdf4561..866540d 100644
> --- a/testcases/kernel/mem/oom/oom02.c
> +++ b/testcases/kernel/mem/oom/oom02.c
> @@ -62,7 +62,8 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> -	set_sys_tune("overcommit_memory", overcommit, 0);
> +	if (overcommit != -1)
> +		set_sys_tune("overcommit_memory", overcommit, 0);
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
> index 3e118c8..b283b52 100644
> --- a/testcases/kernel/mem/oom/oom03.c
> +++ b/testcases/kernel/mem/oom/oom03.c
> @@ -35,6 +35,8 @@
>  
>  #ifdef HAVE_NUMA_V2
>  
> +static int memcg_mounted;
> +
>  static void verify_oom(void)
>  {
>  #if __WORDSIZE == 32
> @@ -71,12 +73,15 @@ static void setup(void)
>  	overcommit = get_sys_tune("overcommit_memory");
>  	set_sys_tune("overcommit_memory", 1, 1);
>  	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
> +	memcg_mounted = 1;
>  }
>  
>  static void cleanup(void)
>  {
> -	set_sys_tune("overcommit_memory", overcommit, 0);
> -	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
> +	if (overcommit != -1)
> +		set_sys_tune("overcommit_memory", overcommit, 0);
> +	if (memcg_mounted)
> +		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
> index 760cb06..98b31c7 100644
> --- a/testcases/kernel/mem/oom/oom04.c
> +++ b/testcases/kernel/mem/oom/oom04.c
> @@ -35,6 +35,8 @@
>  
>  #ifdef HAVE_NUMA_V2
>  
> +static int cpuset_mounted;
> +
>  static void verify_oom(void)
>  {
>  #if __WORDSIZE == 32
> @@ -67,6 +69,7 @@ static void setup(void)
>  	set_sys_tune("overcommit_memory", 1, 1);
>  
>  	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> +	cpuset_mounted = 1;
>  
>  	/*
>  	 * Some nodes do not contain memory, so use
> @@ -83,8 +86,10 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> -	set_sys_tune("overcommit_memory", overcommit, 0);
> -	umount_mem(CPATH, CPATH_NEW);
> +	if (overcommit != -1)
> +		set_sys_tune("overcommit_memory", overcommit, 0);
> +	if (cpuset_mounted)
> +		umount_mem(CPATH, CPATH_NEW);
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
> index 367b511..c5395b0 100644
> --- a/testcases/kernel/mem/oom/oom05.c
> +++ b/testcases/kernel/mem/oom/oom05.c
> @@ -35,6 +35,9 @@
>  
>  #ifdef HAVE_NUMA_V2
>  
> +static int memcg_mounted;
> +static int cpuset_mounted;
> +
>  static void verify_oom(void)
>  {
>  	int swap_acc_on = 1;
> @@ -90,7 +93,9 @@ void setup(void)
>  	set_sys_tune("overcommit_memory", 1, 1);
>  
>  	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
> +	memcg_mounted = 1;
>  	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> +	cpuset_mounted = 1;
>  	write_memcg();
>  
>  	/*
> @@ -108,9 +113,12 @@ void setup(void)
>  
>  void cleanup(void)
>  {
> -	set_sys_tune("overcommit_memory", overcommit, 0);
> -	umount_mem(CPATH, CPATH_NEW);
> -	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
> +	if (overcommit != -1)
> +		set_sys_tune("overcommit_memory", overcommit, 0);
> +	if (cpuset_mounted)
> +		umount_mem(CPATH, CPATH_NEW);
> +	if (memcg_mounted)
> +		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
> index 93a764d..5b03a60 100644
> --- a/testcases/kernel/mem/tunable/max_map_count.c
> +++ b/testcases/kernel/mem/tunable/max_map_count.c
> @@ -53,8 +53,8 @@
>  #define MAP_COUNT_DEFAULT	1024
>  #define MAX_MAP_COUNT		65536L
>  
> -static long old_max_map_count;
> -static long old_overcommit;
> +static long old_max_map_count = -1;
> +static long old_overcommit = -1;
>  static struct utsname un;
>  
>  static void setup(void)
> @@ -73,8 +73,10 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> -	set_sys_tune("overcommit_memory", old_overcommit, 0);
> -	set_sys_tune("max_map_count", old_max_map_count, 0);
> +	if (old_overcommit != -1)
> +		set_sys_tune("overcommit_memory", old_overcommit, 0);
> +	if (old_max_map_count != -1)
> +		set_sys_tune("max_map_count", old_max_map_count, 0);
>  }
>  
>  /* This is a filter to exclude map entries which aren't accounted
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index 9875345..f114dc4 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -39,8 +39,8 @@
>  #define MAP_SIZE (1UL<<20)
>  
>  volatile int end;
> -static unsigned long default_tune;
> -static unsigned long orig_overcommit;
> +static long default_tune = -1;
> +static long orig_overcommit = -1;
>  static unsigned long total_mem;
>  
>  static void test_tune(unsigned long overcommit_policy);
> @@ -221,8 +221,10 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> -	set_sys_tune("min_free_kbytes", default_tune, 0);
> -	set_sys_tune("overcommit_memory", orig_overcommit, 0);
> +	if (default_tune != -1)
> +		set_sys_tune("min_free_kbytes", default_tune, 0);
> +	if (orig_overcommit != -1)
> +		set_sys_tune("overcommit_memory", orig_overcommit, 0);
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
> index 984448b..82ceac5 100644
> --- a/testcases/kernel/mem/tunable/overcommit_memory.c
> +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> @@ -81,8 +81,8 @@ static struct tst_option options[] = {
>  	{NULL, NULL, NULL}
>  };
>  
> -static long old_overcommit_memory;
> -static long old_overcommit_ratio;
> +static long old_overcommit_memory = -1;
> +static long old_overcommit_ratio = -1;
>  static long overcommit_ratio;
>  static long sum_total;
>  static long free_total;
> @@ -136,8 +136,10 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> -	set_sys_tune("overcommit_memory", old_overcommit_memory, 0);
> -	set_sys_tune("overcommit_ratio", old_overcommit_ratio, 0);
> +	if (old_overcommit_memory != -1)
> +		set_sys_tune("overcommit_memory", old_overcommit_memory, 0);
> +	if (old_overcommit_ratio != -1)
> +		set_sys_tune("overcommit_ratio", old_overcommit_ratio, 0);
>  }
>  
>  static void overcommit_memory_test(void)
> 
