From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2016 14:26:51 +0100
Subject: [LTP] [PATCH 4/4] mm/oom: enable ksm before OOM-KSM testing
In-Reply-To: <1457602468-24268-4-git-send-email-liwang@redhat.com>
References: <1457602468-24268-1-git-send-email-liwang@redhat.com>
 <1457602468-24268-2-git-send-email-liwang@redhat.com>
 <1457602468-24268-3-git-send-email-liwang@redhat.com>
 <1457602468-24268-4-git-send-email-liwang@redhat.com>
Message-ID: <20160322132651.GC10905@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int ksm_run_orig;

This should be declared as local variable in the testoom() function.

>  int max_page_sharing;
>  int merge_across_nodes;
>  
> diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
> index 2baca3b..4037ff3 100644
> --- a/testcases/kernel/mem/ksm/ksm05.c
> +++ b/testcases/kernel/mem/ksm/ksm05.c
> @@ -72,8 +72,6 @@ int TST_TOTAL = 1;
>  
>  #ifdef HAVE_MADV_MERGEABLE
>  
> -static int ksm_run_orig;
> -

And this shouldn't be touched at all.

>  static void sighandler(int sig);
>  
>  int main(int argc, char *argv[])
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index d37d6a4..0ecde55 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -224,7 +224,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
>  			 "skip OOM test for KSM pags");
>  	} else {
>  		tst_resm(TINFO, "start OOM testing for KSM pages.");
> +		SAFE_FILE_SCANF(NULL, PATH_KSM "run", "%d", &ksm_run_orig);
> +		SAFE_FILE_PRINTF(NULL, PATH_KSM "run", "1");
>  		oom(KSM, lite, retcode, allow_sigkill);
> +		FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
>  	}
>  }

-- 
Cyril Hrubis
chrubis@suse.cz
