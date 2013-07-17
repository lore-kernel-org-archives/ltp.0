Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UzQSI-0005Dk-MT
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 12:03:38 +0000
Date: Wed, 17 Jul 2013 14:05:22 +0200
From: chrubis@suse.cz
Message-ID: <20130717120522.GB25145@rei>
References: <51E6272B.3020509@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51E6272B.3020509@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] Add support for xfs quota tests
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> Add support for xfs quota tests:
> 
>   *Create a xfs block device
> 
>   *Define HAVE_XFS_QUOTA to show if xfs quota is available
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  configure.ac        |  1 +
>  m4/ltp-xfs_quota.m4 | 39 +++++++++++++++++++++++++++++++++++++
>  runltp              | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 m4/ltp-xfs_quota.m4
> 
> diff --git a/configure.ac b/configure.ac
> index f0fc6b0..1f95603 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -168,5 +168,6 @@ LTP_CHECK_ACL_SUPPORT
>  LTP_CHECK_FS_IOC_FLAGS
>  LTP_CHECK_MREMAP_FIXED
>  LTP_CHECK_KERNEL_DEVEL
> +LTP_CHECK_XFS_QUOTACTL
> 
>  AC_OUTPUT
> diff --git a/m4/ltp-xfs_quota.m4 b/m4/ltp-xfs_quota.m4
> new file mode 100644
> index 0000000..a17d4d9
> --- /dev/null
> +++ b/m4/ltp-xfs_quota.m4
> @@ -0,0 +1,39 @@
> +dnl
> +dnl Copyright (c) 2013 Fujitsu Ltd.
> +dnl Author: DAN LI <li.dan@cn.fujitsu.com>
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_XFS_QUOTACTL
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_XFS_QUOTACTL],[dnl
> +	AC_LINK_IFELSE([AC_LANG_SOURCE([
> +#include <xfs/xqm.h>
> +#include <sys/quota.h>
> +int main(void) {
> +	struct fs_quota_stat qstat;
> +	return quotactl(QCMD(Q_XGETQSTAT, USRQUOTA), (const char *) "/dev/null",
> +			geteuid(), (caddr_t) &qstat);

Why the (const char *) and (caddr_t) casts?

> +}])],[has_xfs_quota="yes"])
> +
> +if test "x$has_xfs_quota" = xyes; then
> +	AC_DEFINE(HAVE_XFS_QUOTA,1,[Define to 1 if you have xfs quota])
> +else
> +	AC_MSG_WARN(No xfs quota support)
> +fi
> +])
> diff --git a/runltp b/runltp
> index 28e6bed..210a332 100755
> --- a/runltp
> +++ b/runltp
> @@ -163,6 +163,7 @@ usage()
>      -b DEVICE       Some tests require an unmounted block device
>                      to run correctly.
>      -B DEVICE_FS_TYPE The file system of test block devices.
> +    -X XFS_DEVICE   Some tests require an unmounted xfs-format block device
> 
> 
>      example: ${0##*/} -c 2 -i 2 -m 2,4,10240,1 -D 2,10,10240,1 -p -q  -l /tmp/result-log.$$ -o /tmp/result-output.$$ -C
> /tmp/result-failed.$$ -d ${PWD}
> @@ -211,7 +212,7 @@ main()
> 
>      version_date=$(cat "$LTPROOT/Version")
> 
> -    while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B: arg
> +    while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w:x:b:B:X: arg
>      do  case $arg in
>          a)  EMAIL_TO=$OPTARG
>              ALT_EMAIL_OUT=1;;
> @@ -424,6 +425,7 @@ main()
>              INSTANCES="-x $OPTARG";;
>          b) DEVICE=$OPTARG;;
>          B) DEVICE_FS_TYPE=$OPTARG;;
> +        X) XFS_DEVICE=$OPTARG;;
>          \?) usage;;
>          esac
>      done
> @@ -679,6 +681,24 @@ main()
>      }
>      }
> 
> +    if [ -n "$XFS_DEVICE" ]; then
> +        sed -i "s|XFS_DEVICE|$XFS_DEVICE|"  ${TMP}/alltests
> +        RC=$?
> +    else
> +        create_xfs_block
> +        if [ $? -eq 0 ]; then
> +            sed -i "s|XFS_DEVICE|$XFS_DEVICE|"  ${TMP}/alltests
> +            RC=$?
> +        else
> +            echo "No xfs-format block device was specified on commandline."
> +            echo "Block device could not be created using loopback device"
> +            echo "Tests which require xfs block device are disabled."
> +            echo "You can specify it with option -X"
> +            sed -i "/XFS_DEVICE/d"  ${TMP}/alltests
> +            RC=$?
> +        fi
> +    fi
> +
>      if [ -n "$DEVICE" ]; then
>          sed -i "s|DEVICE|$DEVICE|"  ${TMP}/alltests
>          RC=$?
> @@ -1019,9 +1039,43 @@ create_block()
>      fi
>  }
> 
> +create_xfs_block()
> +{
> +    #create a block device with xfs filesystem.
> +    dd if=/dev/zero of=${TMP}/xfstest.img bs=1kB count=20480
> +    if [ $? -ne 0 ]; then
> +        echo "Failed to create loopback device image, please check disk space and re-run"
> +        return 1
> +    else
> +        ##search for an unused loop dev
> +        LOOP_DEV_XFS=$(losetup -f)
> +        if [ $? -ne 0 ]; then
> +            echo "no unused loop device is found"
> +            return 1
> +        else
> +            ##attach the created file to loop dev.
> +            losetup $LOOP_DEV_XFS ${TMP}/xfstest.img
> +            if [ $? -ne 0 ]; then
> +                echo "losetup failed to create block device"
> +                return 1
> +            else
> +                mkfs.xfs $LOOP_DEV_XFS
> +                if [ $? -ne 0 ]; then
> +                    echo "creating an xfs block device failed."
> +                    return 1
> +                fi
> +
> +                XFS_DEVICE=$LOOP_DEV_XFS
> +                return 0
> +            fi
> +        fi
> +    fi
> +}


Now this is getting a bit out of hand.

What about we change the tests (we have) to take only device to work
with and let each test prepare the filesystem it needs? This will
simplify the runltp script to only prepare loop device.

If we agree on that I can write the tst_mkfs() function and convert
current usages.

Or has anbody better idea?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
