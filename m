Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VoxYV-0001fk-EJ
	for ltp-list@lists.sourceforge.net; Fri, 06 Dec 2013 15:43:03 +0000
Date: Fri, 6 Dec 2013 16:42:29 +0100
From: chrubis@suse.cz
Message-ID: <20131206154229.GA3426@rei>
References: <529D7CFE.9090104@oracle.com>
	<1386159388-23713-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386159388-23713-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V3 3/3] safe_touch: use utimes(2) if utimensat(2)
 is not defined
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> If utimensat(2) is not defined on the platform we switch
> to using utimes(2).
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  include/safe_file_ops.h |    1 +
>  lib/safe_file_ops.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/include/safe_file_ops.h b/include/safe_file_ops.h
> index 77ad594..1815984 100644
> --- a/include/safe_file_ops.h
> +++ b/include/safe_file_ops.h
> @@ -36,6 +36,7 @@
>  
>  #include <sys/stat.h>
>  
> +#include "lapi/utime.h"
>  #include "test.h"
>  
>  /*
> diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
> index 8cfd264..f9c316d 100644
> --- a/lib/safe_file_ops.c
> +++ b/lib/safe_file_ops.c
> @@ -21,11 +21,15 @@
>   * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>   */
>  
> +#include "config.h"
>  #include <stdarg.h>
>  #include <stdio.h>
> +#include <sys/time.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
> +#include <unistd.h>
> +#include <utime.h>
>  
>  #include "safe_file_ops.h"
>  
> @@ -69,6 +73,22 @@ static int count_scanf_conversions(const char *fmt)
>  	return cnt;
>  }
>  
> +static void set_time(struct timeval *res, struct timespec *src,
> +			long cur_tv_sec, long cur_tv_usec)
> +{
> +	switch (src->tv_nsec) {
> +	case UTIME_NOW:
> +	break;
> +	case UTIME_OMIT:
> +		res->tv_sec = cur_tv_sec;
> +		res->tv_usec = cur_tv_usec;
> +	break;
> +	default:
> +		res->tv_sec = src->tv_sec;
> +		res->tv_usec = src->tv_nsec / 1000;
> +	}
> +}

I've added an #ifndef HAVE_UTIMENSAT around this block, because
otherwise we will get unused function warning when HAVE_UTIMENSAT is
defined.

>  void safe_file_scanf(const char *file, const int lineno,
>  		     void (*cleanup_fn) (void),
>  		     const char *path, const char *fmt, ...)
> @@ -186,10 +206,39 @@ void safe_touch(const char *file, const int lineno,
>  				pathname, file, lineno);
>  	}
>  
> +
> +#if HAVE_UTIMENSAT
>  	ret = utimensat(AT_FDCWD, pathname, times, 0);
> +#else
> +	if (times == NULL) {
> +		ret = utimes(pathname, NULL);
> +	} else {
> +		struct stat sb;
> +		struct timeval cotimes[2];
> +
> +		ret = stat(pathname, &sb);
> +		if (ret == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				"Failed to stat file '%s' at %s:%d",
> +				pathname, file, lineno);
> +
> +		ret = gettimeofday(cotimes, NULL);
> +		if (ret == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup_fn,
> +				"Failed to gettimeofday() at %s:%d",
> +				file, lineno);
> +		cotimes[1] = cotimes[0];
> +
> +		set_time(cotimes, times,
> +			sb.st_atime, sb.st_atim.tv_nsec / 1000);
> +		set_time(cotimes + 1, times + 1,
> +			sb.st_mtime, sb.st_mtim.tv_nsec / 1000);
> +
> +		ret = utimes(pathname, cotimes);
> +	}
> +#endif
>  	if (ret == -1)
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
> -			"Failed to do utimensat() on file '%s' at %s:%d",
> +			"Failed to update the access/modification times on file '%s' at %s:%d",

And I've also fixed this line to fit into 80 chars.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
