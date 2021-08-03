From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Aug 2021 11:30:32 +0200
Subject: [LTP] [PATCH v7 1/7] lib: Print Summary: into stderr
In-Reply-To: <20210802173536.19525-2-pvorel@suse.cz>
References: <20210802173536.19525-1-pvorel@suse.cz>
 <20210802173536.19525-2-pvorel@suse.cz>
Message-ID: <YQkMuOHjZ4HHO+QQ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I wonder if this change can break anything but I guess that it's
unlikely.

Also while you are at it can you also fix tags? We do print help() to
stderr but tags that follow go into stdout which is rather starnge.

And the failure hints are written to stdout as well, which should be
fixed as well.

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> The same as in v6.
> 
>  lib/tst_test.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c7c77596c..d15c8c054 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -734,12 +734,12 @@ static void do_exit(int ret)
>  		if (results->broken)
>  			ret |= TBROK;
>  
> -		printf("\nSummary:\n");
> -		printf("passed   %d\n", results->passed);
> -		printf("failed   %d\n", results->failed);
> -		printf("broken   %d\n", results->broken);
> -		printf("skipped  %d\n", results->skipped);
> -		printf("warnings %d\n", results->warnings);
> +		fprintf(stderr, "\nSummary:\n");
> +		fprintf(stderr, "passed   %d\n", results->passed);
> +		fprintf(stderr, "failed   %d\n", results->failed);
> +		fprintf(stderr, "broken   %d\n", results->broken);
> +		fprintf(stderr, "skipped  %d\n", results->skipped);
> +		fprintf(stderr, "warnings %d\n", results->warnings);
>  	}
>  
>  	do_cleanup();
> -- 
> 2.32.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
