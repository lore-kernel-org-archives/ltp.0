Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WGOSI-0004g4-VS
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 07:54:02 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WGOSH-0000PJ-Rq
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 07:54:02 +0000
Message-ID: <5305B472.4010909@oracle.com>
Date: Thu, 20 Feb 2014 11:53:22 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1392862246.1997.6.camel@G08JYZSD130126>
In-Reply-To: <1392862246.1997.6.camel@G08JYZSD130126>
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!

On 02/20/2014 06:10 AM, Zeng Linggang wrote:
> When we  call getgrgid_r()  to  verify whether the corresponding gid is
> existent, if not, getgrgid_r() will return 0 or ENOENT or ESRCH or
> EBADF or EPERM...
>
> But tst_get_unused_gid() only check return value 0, this is not complete.
> For example, if the gid is not existent, getgrgid_r() in RHEL7 beta will
> return ENOENT, which will cause tst_get_unused_gid failed incorrectly.
> This is the same for getpwuid_r().

Thank you.

I was puzzled by these two sentences in the getgrgid_r man (RHEL6):
"If no matching  group  record was  found,  these  functions  return  0 
  and  store  NULL  in *result.  In case of error, an error number is
returned, and NULL is stored in *result."

Maybe update the man page according with 
http://www.gnu.org/software/libc/manual/html_node/Lookup-Group.html. I 
think that there the return values are described more clear.

What do you think?

>
> We should make tst_get_unused_uid/tst_get_unused_gid check all the possible
> return value.
>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>   lib/tst_uid_gid.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/lib/tst_uid_gid.c b/lib/tst_uid_gid.c
> index 3ba1ad6..a835c38 100644
> --- a/lib/tst_uid_gid.c
> +++ b/lib/tst_uid_gid.c
> @@ -16,6 +16,7 @@
>    * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>    */
>
> +#include <errno.h>
>   #include <grp.h>
>   #include <limits.h>
>   #include <pwd.h>
> @@ -44,10 +45,21 @@ uid_t tst_get_unused_uid(void)
>   		s = getpwuid_r(uid, &pwd, buf, bufsize, &result);
>   		if (result == NULL) {
>   			free(buf);
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
>   				return uid;
> -			else
> +			default:
>   				return -1;
> +			}
>   		}
>   	}
>
> @@ -76,10 +88,21 @@ gid_t tst_get_unused_gid(void)
>   		s = getgrgid_r(gid, &grp, buf, bufsize, &result);
>   		if (result == NULL) {
>   			free(buf);
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
>   				return gid;
> -			else
> +			default:
>   				return -1;
> +			}
>   		}
>   	}
>
>

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
