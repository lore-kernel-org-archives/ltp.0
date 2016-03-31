From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 31 Mar 2016 15:52:05 +0200
Subject: [LTP] [PATCH V2 3/3] mm/oom: enable ksm before OOM-KSM testing
In-Reply-To: <1458707157-31233-3-git-send-email-liwang@redhat.com>
References: <1458707157-31233-1-git-send-email-liwang@redhat.com>
 <1458707157-31233-2-git-send-email-liwang@redhat.com>
 <1458707157-31233-3-git-send-email-liwang@redhat.com>
Message-ID: <20160331135204.GD21298@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
>  {
> +	int ksm_run_orig;
> +
>  	set_global_mempolicy(mempolicy);
>  
>  	tst_resm(TINFO, "start normal OOM testing.");
> @@ -224,7 +226,10 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
>  			 "skip OOM test for KSM pags");
>  	} else {
>  		tst_resm(TINFO, "start OOM testing for KSM pages.");
> +		SAFE_FILE_SCANF(cleanup, PATH_KSM "run", "%d", &ksm_run_orig);
> +		SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
>  		oom(KSM, lite, retcode, allow_sigkill);
> +		SAFE_FILE_PRINTF(cleanup,PATH_KSM "run", "%d", ksm_run_orig);
                                         ^
					 missing space

Technically the oom() can actually exit the test execution (calls
tst_brkm()) so it would be a bit better if the value was restored in the
test cleanup. But I guess that it's unlikely to happen and we can
proceed with this patch.

-- 
Cyril Hrubis
chrubis@suse.cz
