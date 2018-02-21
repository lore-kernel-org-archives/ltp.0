From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 21 Feb 2018 10:33:28 +0100
Subject: [LTP] [PATCH] syscalls/swapon03: do not fail if /proc/swaps is
	absent
In-Reply-To: <20180220235523.29663-1-smuckle.linux@gmail.com>
References: <20180220235523.29663-1-smuckle.linux@gmail.com>
Message-ID: <87d10y661j.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Steve,

Steve Muckle writes:

> If the /proc/swaps file is absent the test should be skipped due
> to incompatible configuration.
>
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> ---
>  testcases/kernel/syscalls/swapon/swapon03.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
> index d3f73b044fe1..f690389c55a3 100644
> --- a/testcases/kernel/syscalls/swapon/swapon03.c
> +++ b/testcases/kernel/syscalls/swapon/swapon03.c
> @@ -165,8 +165,7 @@ static int setup_swap(void)
>  
>  	/* This includes the first (header) line */
>  	if ((fd = open("/proc/swaps", O_RDONLY)) == -1) {
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "Failed to find out existing number of swap files");
> +		tst_brkm(TCONF, cleanup, "Unable to open /proc/swaps");

You should probably only return TCONF if ENOENT, otherwise TFAIL or TBROK.

>  	}
>  	do {
>  		char *p = buf;
> -- 
> 2.13.6


-- 
Thank you,
Richard.
