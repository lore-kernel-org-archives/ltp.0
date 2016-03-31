From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Mar 2016 15:31:15 +0200
Subject: [LTP] [PATCH V2 2/3] mm/ksm: extend 'max_page_sharing' before
 ksm testing
In-Reply-To: <1458707157-31233-2-git-send-email-liwang@redhat.com>
References: <1458707157-31233-1-git-send-email-liwang@redhat.com>
 <1458707157-31233-2-git-send-email-liwang@redhat.com>
Message-ID: <20160331133114.GC21298@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/kernel/mem/include/mem.h |  3 +++
>  testcases/kernel/mem/ksm/ksm01.c   |  4 ++++
>  testcases/kernel/mem/ksm/ksm02.c   |  3 +++
>  testcases/kernel/mem/ksm/ksm03.c   |  4 ++++
>  testcases/kernel/mem/ksm/ksm04.c   |  4 ++++
>  testcases/kernel/mem/ksm/ksm06.c   |  4 ++++
>  testcases/kernel/mem/lib/mem.c     | 22 +++++++++++++++++++++-
>  7 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index 43988fe..69d08dd 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -43,7 +43,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
>  /* KSM */
>  
>  #define PATH_KSM		"/sys/kernel/mm/ksm/"
> +int max_page_sharing;

This value is not modified outside the library. It makes no sense to
declare it in the header.

As a matter of fact it would be far better to declare it as static int
inside the library so that there is no chance that it will be modified
by the testcases.

> +void save_max_page_sharing(void);
> +void restore_max_page_sharing(void);
>  void test_ksm_merge_across_nodes(unsigned long nr_pages);
>  
>  /* THP */
> diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
> index b62df06..824881c 100644
> --- a/testcases/kernel/mem/ksm/ksm01.c
> +++ b/testcases/kernel/mem/ksm/ksm01.c
> @@ -106,6 +106,8 @@ void setup(void)
>  	if (access(PATH_KSM, F_OK) == -1)
>  		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
>  
> +	save_max_page_sharing();
> +
>  	/*
>  	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
>  	 * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
> @@ -128,4 +130,6 @@ void cleanup(void)
>  	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
>  		FILE_PRINTF(PATH_KSM "merge_across_nodes",
>  				 "%d", merge_across_nodes);
> +
> +	restore_max_page_sharing();
>  }
> diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
> index 537ec01..6274f8a 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -125,6 +125,8 @@ void cleanup(void)
>  		FILE_PRINTF(PATH_KSM "merge_across_nodes",
>  				 "%d", merge_across_nodes);
>  
> +	restore_max_page_sharing();
> +
>  	umount_mem(CPATH, CPATH_NEW);
>  }
>  
> @@ -136,6 +138,7 @@ void setup(void)
>  		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
>  	if (access(PATH_KSM, F_OK) == -1)
>  		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> +	save_max_page_sharing();
>  
>  	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
>  		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
> diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
> index b73e023..979222a 100644
> --- a/testcases/kernel/mem/ksm/ksm03.c
> +++ b/testcases/kernel/mem/ksm/ksm03.c
> @@ -113,6 +113,8 @@ void setup(void)
>  		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
>  	}
>  
> +	save_max_page_sharing();
> +
>  	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
>  	tst_sig(FORK, DEF_HANDLER, NULL);
>  	TEST_PAUSE;
> @@ -124,5 +126,7 @@ void cleanup(void)
>  		FILE_PRINTF(PATH_KSM "merge_across_nodes",
>  				 "%d", merge_across_nodes);
>  
> +	restore_max_page_sharing();
> +
>  	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
>  }
> diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
> index 0c1d4e0..4beeed6 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -127,6 +127,8 @@ void cleanup(void)
>  		FILE_PRINTF(PATH_KSM "merge_across_nodes",
>  				 "%d", merge_across_nodes);
>  
> +	restore_max_page_sharing();
> +
>  	umount_mem(CPATH, CPATH_NEW);
>  	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
>  }
> @@ -146,6 +148,8 @@ void setup(void)
>  		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
>  	}
>  
> +	save_max_page_sharing();
> +
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  	TEST_PAUSE;
>  	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
> diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
> index 02d304f..2092746 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -105,6 +105,8 @@ void setup(void)
>  	SAFE_FILE_SCANF(NULL, PATH_KSM "sleep_millisecs",
>  			"%d", &sleep_millisecs);
>  
> +	save_max_page_sharing();
> +
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  	TEST_PAUSE;
>  }
> @@ -116,6 +118,8 @@ void cleanup(void)
>  	FILE_PRINTF(PATH_KSM "sleep_millisecs",
>  			 "%d", sleep_millisecs);
>  	FILE_PRINTF(PATH_KSM "run", "%d", run);
> +
> +	restore_max_page_sharing();
>  }
>  
>  static void usage(void)
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index 7b5bb35..084e5a4 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -230,6 +230,20 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
>  
>  /* KSM */
>  
> +void save_max_page_sharing(void)
> +{
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +	        SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
> +	                        "%d", &max_page_sharing);
> +}
> +
> +void restore_max_page_sharing(void)
> +{
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +	        FILE_PRINTF(PATH_KSM "max_page_sharing",
> +	                         "%d", max_page_sharing);
> +}
> +
>  static void check(char *path, long int value)
>  {
>  	char fullpath[BUFSIZ];
> @@ -502,9 +516,12 @@ void create_same_memory(int size, int num, int unit)
>  	stop_ksm_children(child, num);
>  
>  	tst_resm(TINFO, "KSM merging...");
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +		SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
> +				"%ld", size * pages * num);
>  	SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
>  	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
> -			 size * pages *num);
> +			 size * pages * num);
>  	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
>  
>  	resume_ksm_children(child, num);
> @@ -595,6 +612,9 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
>  	SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
>  	SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
>  			 nr_pages * num_nodes);
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +		SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
> +			"%ld", nr_pages * num_nodes);
>  	/*
>  	 * merge_across_nodes setting can be changed only when there
>  	 * are no ksm shared pages in system, so set run 2 to unmerge

-- 
Cyril Hrubis
chrubis@suse.cz
