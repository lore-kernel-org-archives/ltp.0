Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WO1KM-0005aH-2R
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 08:49:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WO1KK-00076P-N7
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 08:49:22 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s2D8X52d023982
	for <ltp-list@lists.sourceforge.net>; Thu, 13 Mar 2014 16:33:06 +0800
Message-ID: <1394699584.2087.5.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 13 Mar 2014 16:33:04 +0800
In-Reply-To: <1392862246.1997.6.camel@G08JYZSD130126>
References: <1392862246.1997.6.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] lib/tst_uid_gid.c: fix checking return value
 errors about getpwuid_r/getgrgid_r
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hi,
	Could any one help to review this patch?
Thanks,
Zeng

On Thu, 2014-02-20 at 10:10 +0800, Zeng Linggang wrote:
> When we  call getgrgid_r()  to  verify whether the corresponding gid is
> existent, if not, getgrgid_r() will return 0 or ENOENT or ESRCH or
> EBADF or EPERM...
> 
> But tst_get_unused_gid() only check return value 0, this is not complete.
> For example, if the gid is not existent, getgrgid_r() in RHEL7 beta will
> return ENOENT, which will cause tst_get_unused_gid failed incorrectly.
> This is the same for getpwuid_r().
> 
> We should make tst_get_unused_uid/tst_get_unused_gid check all the possible
> return value.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  lib/tst_uid_gid.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/tst_uid_gid.c b/lib/tst_uid_gid.c
> index 3ba1ad6..a835c38 100644
> --- a/lib/tst_uid_gid.c
> +++ b/lib/tst_uid_gid.c
> @@ -16,6 +16,7 @@
>   * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>  
> +#include <errno.h>
>  #include <grp.h>
>  #include <limits.h>
>  #include <pwd.h>
> @@ -44,10 +45,21 @@ uid_t tst_get_unused_uid(void)
>  		s = getpwuid_r(uid, &pwd, buf, bufsize, &result);
>  		if (result == NULL) {
>  			free(buf);
> -			if (s == 0)
> +			/*
> +			 * When the given name or gid was not found, getgrgid_r
> +			 * may return 0 or ENOENT or ESRCH or EBADF or EPERM
> +			 * or ...
> +			 */
> +			switch (s) {
> +			case 0:
> +			case ENOENT:
> +			case ESRCH:
> +			case EBADF:
> +			case EPERM:
>  				return uid;
> -			else
> +			default:
>  				return -1;
> +			}
>  		}
>  	}
>  
> @@ -76,10 +88,21 @@ gid_t tst_get_unused_gid(void)
>  		s = getgrgid_r(gid, &grp, buf, bufsize, &result);
>  		if (result == NULL) {
>  			free(buf);
> -			if (s == 0)
> +			/*
> +			 * When the given name or gid was not found, getgrgid_r
> +			 * may return 0 or ENOENT or ESRCH or EBADF or EPERM
> +			 * or ...
> +			 */
> +			switch (s) {
> +			case 0:
> +			case ENOENT:
> +			case ESRCH:
> +			case EBADF:
> +			case EPERM:
>  				return gid;
> -			else
> +			default:
>  				return -1;
> +			}
>  		}
>  	}
>  



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
