From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2016 14:14:22 +0100
Subject: [LTP] [PATCH 2/4] mm/ksm: extend 'max_page_sharing' before ksm
 testing
In-Reply-To: <1457602468-24268-2-git-send-email-liwang@redhat.com>
References: <1457602468-24268-1-git-send-email-liwang@redhat.com>
 <1457602468-24268-2-git-send-email-liwang@redhat.com>
Message-ID: <20160322131422.GA10905@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index 43988fe..fbb11b2 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -43,6 +43,7 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
>  /* KSM */
>  
>  #define PATH_KSM		"/sys/kernel/mm/ksm/"
> +int max_page_sharing;

This variable is not used in the library. It does not make sense to
declare it in the header file.

>  void test_ksm_merge_across_nodes(unsigned long nr_pages);
>  
> diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
> index b62df06..a352abd 100644
> --- a/testcases/kernel/mem/ksm/ksm01.c
> +++ b/testcases/kernel/mem/ksm/ksm01.c
> @@ -105,6 +105,9 @@ void setup(void)
>  		tst_brkm(TCONF, NULL, "2.6.32 or greater kernel required");
>  	if (access(PATH_KSM, F_OK) == -1)
>  		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +		SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
> +				"%d", &max_page_sharing);
>  
>  	/*
>  	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
> @@ -128,4 +131,8 @@ void cleanup(void)
>  	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
>  		FILE_PRINTF(PATH_KSM "merge_across_nodes",
>  				 "%d", merge_across_nodes);
> +
> +	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +		FILE_PRINTF(PATH_KSM "max_page_sharing",
> +				 "%d", max_page_sharing);
>  }

You are saving and restoring the file in each test. Why can't you just
add two functions to save and restore it the library instead and call
them from test setup and cleanup?

It's also quite confusing that the test saves and restores a value while
it's not modifying it at all. It will be less confusing if it's all done
in the library.

-- 
Cyril Hrubis
chrubis@suse.cz
