From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 27 Oct 2020 17:21:36 +0800
Subject: [LTP] [PATCH 03/19] Unify error handling in
 lib/tst_safe_timerfd.c
In-Reply-To: <20201026164756.30556-4-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-4-mdoucha@suse.cz>
Message-ID: <5F97E6A0.8090506@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin
> - Properly format caller file:line locations
> - Pedantically check for invalid syscall return values
>
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   lib/tst_safe_timerfd.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
> index ffe7b2ef7..4c36a309c 100644
> --- a/lib/tst_safe_timerfd.c
> +++ b/lib/tst_safe_timerfd.c
> @@ -17,9 +17,14 @@ int safe_timerfd_create(const char *file, const int lineno,
>   	int fd;
>
>   	fd = timerfd_create(clockid, flags);
> -	if (fd<  0) {
> -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
> -			file, lineno, tst_clock_name(clockid));
> +
> +	if (fd == -1) {
> +		tst_brk_(file, lineno, TTYPE | TERRNO,
> +			"timerfd_create(%s) failed", tst_clock_name(clockid));
> +	} else if (fd<  0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid timerfd_create(%s) return value %d",
> +			tst_clock_name(clockid), fd);
>   	}
>
>   	return fd;
> @@ -31,9 +36,14 @@ int safe_timerfd_gettime(const char *file, const int lineno,
>   	int rval;
>
>   	rval = timerfd_gettime(fd, curr_value);
> -	if (rval != 0) {
> -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_gettime() failed",
> -			file, lineno);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TTYPE | TERRNO,
> +			"timerfd_gettime() failed");
> +	}
> +	if (rval) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid timerfd_gettime() return value %d", rval);
Here also should use else if.
>   	}
>
>   	return rval;
> @@ -47,9 +57,13 @@ int safe_timerfd_settime(const char *file, const int lineno,
>   	int rval;
>
>   	rval = timerfd_settime(fd, flags, new_value, old_value);
> -	if (rval != 0) {
> -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_settime() failed",
> -			file, lineno);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TTYPE | TERRNO,
> +			"timerfd_settime() failed");
> +	} else if (rval) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid timerfd_settime() return value %d", rval);
>   	}
>
>   	return rval;



