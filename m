From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 May 2021 13:20:54 +0200
Subject: [LTP] [PATCH v5 6/7] mem: Convert tests to new CGroups API
In-Reply-To: <20210430112649.16302-7-rpalethorpe@suse.com>
References: <20210430112649.16302-1-rpalethorpe@suse.com>
 <20210430112649.16302-7-rpalethorpe@suse.com>
Message-ID: <YI/clrb4houmTsY7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
> index 51f5d4cca..e6de61ece 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -59,6 +59,9 @@
>  #ifdef HAVE_NUMA_V2
>  #include <numaif.h>
>  
> +static const struct tst_cgroup_group *cg;
> +static const struct tst_cgroup_group *cg_drain;
> +
>  static void verify_ksm(void)
>  {
>  	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
> @@ -76,9 +79,10 @@ static void verify_ksm(void)
>  	}
>  	create_same_memory(size, num, unit);
>  
> -	write_cpusets(PATH_TMP_CG_CST, node);
> -	tst_cgroup_move_current(PATH_TMP_CG_CST);
> +	write_cpusets(cg, node);
> +	SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", getpid());
>  	create_same_memory(size, num, unit);
> +	SAFE_CGROUP_PRINTF(cg_drain, "cgroup.procs", "%d", getpid());
>  }
>  
>  static void cleanup(void)
> @@ -87,7 +91,7 @@ static void cleanup(void)
>  		FILE_PRINTF(PATH_KSM "merge_across_nodes",
>  				 "%d", merge_across_nodes);
>  
> -	tst_cgroup_umount(PATH_TMP_CG_CST);
> +	tst_cgroup_cleanup();
>  }
>  
>  static void setup(void)
> @@ -103,7 +107,8 @@ static void setup(void)
>  		SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
>  	}
>  
> -	tst_cgroup_mount(TST_CGROUP_CPUSET, PATH_TMP_CG_CST);
> +	tst_cgroup_require("cpuset", NULL);
> +	cg = tst_cgroup_get_test_group();

Forgotten cg_drain = tst_cgroup_get_drain_group() ?

Other than that the rest is pretty much straightforward, so with the
above fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
