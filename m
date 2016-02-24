From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Feb 2016 06:03:26 -0500 (EST)
Subject: [LTP] [PATCH] mem/oom: call WEXITSTATUS() only if
	WIFEXITED()	returned true
In-Reply-To: <20160224101914.GA4402@localhost.localdomain>
References: <20160224101914.GA4402@localhost.localdomain>
Message-ID: <1952284603.26737557.1456311806125.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Han Pingtian" <hanpt@linux.vnet.ibm.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 24 February, 2016 11:19:14 AM
> Subject: [LTP] [PATCH] mem/oom: call WEXITSTATUS() only if WIFEXITED()	returned true
> 
> Only when WIFEXITED() returned true that WEXITSTATUS() can return a
> meanful result. So we should check WIFEXITED() first.
> 
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>

Looks good to me.

> ---
>  testcases/kernel/mem/lib/mem.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index cedcf32..8327998 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -150,12 +150,16 @@ void oom(int testcase, int lite, int retcode, int
> allow_sigkill)
>  				WTERMSIG(status),
>  				tst_strsig(WTERMSIG(status)));
>  		}
> -	} else	if (WIFEXITED(status) && WEXITSTATUS(status) == retcode) {
> -		tst_resm(TPASS, "victim retcode: (%d) %s",
> +	} else if (WIFEXITED(status)) {
> +		if (WEXITSTATUS(status) == retcode) {
> +			tst_resm(TPASS, "victim retcode: (%d) %s",
>  				retcode, strerror(retcode));
> -	} else {
> -		tst_resm(TFAIL, "victim unexpectedly ended with retcode: %d, "
> +		} else {
> +			tst_resm(TFAIL, "victim unexpectedly ended with retcode: %d, "
>  				"expected: %d", WEXITSTATUS(status), retcode);
> +		}
> +	} else {
> +		tst_resm(TFAIL, "victim unexpectedly ended");

Is this only theoretical or did you actually run into this?
If so, what are the circumstances for this to happen?

Regards,
Jan

>  	}
>  }
>  
> --
> 1.9.3
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
