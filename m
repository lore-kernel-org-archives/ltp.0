From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Aug 2018 16:25:24 +0200
Subject: [LTP] [PATCH ltp] syscalls/bind02.c: Fix create socker failed
 for nobody user and nogroup for "Permission denied"
In-Reply-To: <20180810025656.8825-1-zhanghuix.yuan@intel.com>
References: <20180810025656.8825-1-zhanghuix.yuan@intel.com>
Message-ID: <20180816142524.GC30369@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  testcases/kernel/syscalls/bind/bind02.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
> index 90b0e9d8e..84ce588ce 100644
> --- a/testcases/kernel/syscalls/bind/bind02.c
> +++ b/testcases/kernel/syscalls/bind/bind02.c
> @@ -86,7 +86,12 @@ void try_bind(void)
>  	}
>  
>  	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
> -		tst_brkm(TBROK | TERRNO, 0, "socket() failed");
> +		if (errno == EACCES) {
> +			tst_resm(TPASS, "correct error");
> +			return;
> +		}else {
> +			tst_brkm(TBROK | TERRNO, 0, "socket() failed");
> +		}
>  	}

There is no good reason why shouldn't the nobody user be able to create
AF_INET socket. Fist of all you should figure out why this is happening,
then, if it turns out to be the test fault, we can do something about
it.

-- 
Cyril Hrubis
chrubis@suse.cz
