From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 May 2020 03:45:18 -0400 (EDT)
Subject: [LTP] [PATCH v1 2/4] mem: take use of new cgroup API
In-Reply-To: <20200527031430.22144-2-liwang@redhat.com>
References: <20200527031430.22144-1-liwang@redhat.com>
 <20200527031430.22144-2-liwang@redhat.com>
Message-ID: <396532423.13763181.1590565518615.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> diff --git a/testcases/kernel/mem/cpuset/cpuset01.c
> b/testcases/kernel/mem/cpuset/cpuset01.c
> index 853f7fe55..cecc4ba86 100644
> --- a/testcases/kernel/mem/cpuset/cpuset01.c
> +++ b/testcases/kernel/mem/cpuset/cpuset01.c
> @@ -51,11 +51,11 @@ static void test_cpuset(void)
>  	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
>  	char mems[BUFSIZ], buf[BUFSIZ];
>  
> -	read_cpuset_files(CPATH, "cpus", buf);
> -	write_cpuset_files(CPATH_NEW, "cpus", buf);
> -	read_cpuset_files(CPATH, "mems", mems);
> -	write_cpuset_files(CPATH_NEW, "mems", mems);
> -	SAFE_FILE_PRINTF(CPATH_NEW "/tasks", "%d", getpid());
> +	read_cpuset_files(PATH_TMP_CG1_CST, "cpus", buf);
> +	write_cpuset_files(PATH_CG1_CST_LTP, "cpus", buf);
> +	read_cpuset_files(PATH_TMP_CG1_CST, "mems", mems);
> +	write_cpuset_files(PATH_CG1_CST_LTP, "mems", mems);

This mixes generic api with cgroup1. It currently relies on implementation
detail of tst_cgroup_mount(), which isn't visible just by looking at this test.

We should make it generic or make it clear that test is for cgroup1 only:

setup()
  if (tst_cgroup_version() != TST_CGROUP_V1)
    TCONF


> diff --git a/testcases/kernel/mem/oom/oom03.c
> b/testcases/kernel/mem/oom/oom03.c
> index ce0b34c31..af3a565ce 100644
> --- a/testcases/kernel/mem/oom/oom03.c
> +++ b/testcases/kernel/mem/oom/oom03.c
> @@ -36,27 +36,26 @@
>  
>  #ifdef HAVE_NUMA_V2
>  
> -static int memcg_mounted;
> -
>  static void verify_oom(void)
>  {
>  #ifdef TST_ABI32
>  	tst_brk(TCONF, "test is not designed for 32-bit system.");
>  #endif
>  
> -	SAFE_FILE_PRINTF(MEMCG_PATH_NEW "/tasks", "%d", getpid());
> -	SAFE_FILE_PRINTF(MEMCG_LIMIT, "%ld", TESTMEM);
> +	tst_cgroup_mem_set_maxbytes(TESTMEM);
>  
>  	testoom(0, 0, ENOMEM, 1);
>  
> -	if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
> +	if ((access(PATH_MEMORY_SW_LIMIT, F_OK) == -1) ||
> +			(access(PATH_MEMORY_SW_MAX, F_OK) == -1)) {

This could be tst_cgroup_mem_swapacct_enabled(), without need for test
to probe specific cgroup[12] files.

