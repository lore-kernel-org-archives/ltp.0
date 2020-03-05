From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Mar 2020 16:20:33 +0100
Subject: [LTP] [PATCH v2 2/2] Reimplement TST_SAFE_TIMERFD_*() using
 TST_ASSERT_SYSCALL*()
In-Reply-To: <20200305151459.30341-2-mdoucha@suse.cz>
References: <20200305151459.30341-1-mdoucha@suse.cz>
 <20200305151459.30341-2-mdoucha@suse.cz>
Message-ID: <20200305152033.GA1160@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tst_safe_timerfd.c | 35 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
> index ffe7b2ef7..8c042f8c8 100644
> --- a/lib/tst_safe_timerfd.c
> +++ b/lib/tst_safe_timerfd.c
> @@ -9,34 +9,18 @@
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  
> -#define TTYPE (errno == ENOTSUP ? TCONF : TBROK)
> -
>  int safe_timerfd_create(const char *file, const int lineno,
>  				      int clockid, int flags)
>  {
> -	int fd;
> -
> -	fd = timerfd_create(clockid, flags);
> -	if (fd < 0) {
> -		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
> -			file, lineno, tst_clock_name(clockid));
> -	}
> -
> -	return fd;
> +	return TST_ASSERT_SYSCALL_FD_IMPL(timerfd_create(clockid, flags), file,
> +		lineno, "timerfd_create(%s)", tst_clock_name(clockid));
>  }

Well at this point we basically pass everything that has been in the
function to the macro. So we do not save much on typing, the code is not
simpler and the obvious and readable code we had has been turned into a
macro. I do not think that this is improvement.

-- 
Cyril Hrubis
chrubis@suse.cz
