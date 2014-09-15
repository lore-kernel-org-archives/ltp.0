Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XTVMt-00021N-Dc
	for ltp-list@lists.sourceforge.net; Mon, 15 Sep 2014 12:26:55 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XTVMs-00035Y-HG
	for ltp-list@lists.sourceforge.net; Mon, 15 Sep 2014 12:26:55 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s8FCQmOF010557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Sep 2014 12:26:48 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8FCQlDU009986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Sep 2014 12:26:47 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s8FCQkqq019049
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Sep 2014 12:26:47 GMT
Message-ID: <5416DB00.5070303@oracle.com>
Date: Mon, 15 Sep 2014 16:26:40 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1408610694-12939-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1408610694-12939-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [RFC/PATCH] ltpstress.sh: added cmdline to set the block
 device
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
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Hi!

Could anybody help to review this change, please?

Thanks.

On 21.08.2014 12:44, Stanislav Kholmanskikh wrote:
> I think it's not needed to use set_block_device(),
> create_block_device() from runltp, because their logic
> is in tst_acquire_device()/tst_release_device() now.
>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>   testscripts/ltpstress.sh |   13 +++++++++++--
>   1 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/testscripts/ltpstress.sh b/testscripts/ltpstress.sh
> index a0dc088..39a5caf 100755
> --- a/testscripts/ltpstress.sh
> +++ b/testscripts/ltpstress.sh
> @@ -58,7 +58,8 @@ usage()
>   {
>
>   	cat <<-END >&2
> -	usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ] [ -n ] [ -p ] [ -q ] [ -t duration ] [ -x TMPDIR ] [ [-S]|[-T] ]
> +    usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ]
> +    [ -n ] [ -p ] [ -q ] [ -t duration ] [ -x TMPDIR ] [-b DEVICE] [-B LTP_DEV_FS_TYPE] [ [-S]|[-T] ]
>
>       -d datafile     Data file for 'sar' or 'top' to log to. Default is "/tmp/ltpstress.data".
>       -i # (in sec)   Interval that 'sar' or 'top' should take snapshots. Default is 10 seconds.
> @@ -72,6 +73,10 @@ usage()
>       -T              Use LTP's modified 'top' tool to measure data.
>       -t duration     Execute the testsuite for given duration in hours. Default is 24.
>       -x TMPDIR       Directory where temporary files will be created.
> +    -b DEVICE       Some tests require an unmounted block device
> +                    to run correctly. If DEVICE is not set, a loop device is
> +                    created and used automatically.
> +    -B LTP_DEV_FS_TYPE The file system of DEVICE.
>
>   	example: ${0##*/} -d /tmp/sardata -l /tmp/ltplog.$$ -m 128 -t 24 -S
>   	END
> @@ -88,7 +93,7 @@ check_memsize()
>     leftover_memsize=$memsize
>   }
>
> -while getopts d:hi:I:l:STt:m:npqx:\? arg
> +while getopts d:hi:I:l:STt:m:npqx:b:B:\? arg
>   do  case $arg in
>
>   	d)	datafile="$OPTARG";;
> @@ -138,6 +143,10 @@ do  case $arg in
>
>   	x)	export TMPBASE=$(readlink -f ${OPTARG});;
>
> +	b)	export LTP_DEV=${OPTARG};;
> +
> +	B)	export LTP_DEV_FS_TYPE=${OPTARG};;
> +
>           \?)     echo "Help info:"
>   		usage;;
>           esac
>

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
