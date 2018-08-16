From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Aug 2018 12:28:16 +0200
Subject: [LTP] [PATCH] pty: fix some issues in pty02
In-Reply-To: <20180816080724.25143-1-liwang@redhat.com>
References: <20180816080724.25143-1-liwang@redhat.com>
Message-ID: <20180816102816.GA4077@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1. Add EXTPROC into lapi
> 
> 2. Exit the test with TCONF if we get EINVAL from tcsetattr()
> 
> 3. Giving newline('\n') to ptmx to avoid reading pts block on rhel6
> 
> 4. Using tcgetattr() to get attributes before re-setting it
> Fix this error:
>    tst_test.c:1015: INFO: Timeout per run is 0h 50m 00s
>    pty02.c:42: BROK: tcsetattr() failed: EINVAL
> 
> POSIX.1 General description:
>   Changes the attributes associated with a terminal. New attributes are
>   specified with a termios control structure. Programs should always
>   issue a tcgetattr() first, modify the desired fields, and then issue
>   a tcsetattr(). tcsetattr() should never be issued using a termios
>   structure that was not obtained using tcgetattr(). tcsetattr() should
>   use only a termios structure that was obtained by tcgetattr().

I've tried the test with this patch applied and I still got soft-lockup
on unpatched kernel, so it seems like the reproducer works fine with
these changes.

> diff --git a/testcases/kernel/pty/pty02.c b/testcases/kernel/pty/pty02.c
> index fd3d26b..8720407 100644
> --- a/testcases/kernel/pty/pty02.c
> +++ b/testcases/kernel/pty/pty02.c
> @@ -25,27 +25,42 @@
>   */
>  
>  #include <stdlib.h>
> +#include <errno.h>
>  #include <termio.h>
>  
>  #include "tst_test.h"
> +#include "lapi/termbits.h"
>  
>  static void do_test(void)
>  {
> -	struct termios io = { .c_lflag = EXTPROC | ICANON };
> +	struct termios io;
>  	int ptmx, pts;
>  	char c = 'A';
> +	char n = '\n';
>  	int nbytes;
>  
>  	ptmx = SAFE_OPEN("/dev/ptmx", O_WRONLY);
>  
> -	if (tcsetattr(ptmx, TCSANOW, &io) != 0)
> -		tst_brk(TBROK | TERRNO, "tcsetattr() failed");
> +	if (tcgetattr(ptmx, &io) != 0)
> +		tst_brk(TBROK | TERRNO, "tcgetattr() failed");
> +
> +	io.c_lflag = EXTPROC | ICANON;
> +
> +	TEST(tcsetattr(ptmx, TCSANOW, &io));
> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EINVAL)
> +			tst_res(TCONF, "tcsetattr(, , EXTPROC | ICANON) is not supported");
> +		else
> +			tst_brk(TBROK | TERRNO, "tcsetattr() failed");
> +	}

We changed the TEST_RETURN to TST_RET and TEST_ERRNO to TST_ERR a few
weeks ago, can you please update you git tree?

>  	if (unlockpt(ptmx) != 0)
>  		tst_brk(TBROK | TERRNO, "unlockpt() failed");
>  
>  	pts = SAFE_OPEN(ptsname(ptmx), O_RDONLY);
>  	SAFE_WRITE(1, ptmx, &c, 1);
> +	/* giving newline('\n') to ptmx to avoid reading pts block */
> +	SAFE_WRITE(1, ptmx, &n, 1);

I wonder if we can just do SAFE_WRITE(1, ptmx, "A\n", 2) here instead?

Also the comment is a bit misleading, I was thinking for a while about
what is pts block and why do we need to avoid reading it. So maybe we
should reword it as:

/* write newline to ptmx to avoid read() on pts to block */

>  	SAFE_READ(1, pts, &c, 1);
>  
>  	tst_res(TINFO, "Calling FIONREAD, this will hang in n_tty_ioctl() if the bug is present...");
> -- 
> 2.9.5
> 

-- 
Cyril Hrubis
chrubis@suse.cz
