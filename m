Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDN9-0005OU-VW
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:35 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDN2-0005qw-WD
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:35 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F53dh008652
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:05:03 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FDI6A075524
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 10:13:19 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB3B3IHp028690
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 06:03:18 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912012300.nB1N08rZ029752@e1.ny.us.ibm.com>
References: <200912012300.nB1N08rZ029752@e1.ny.us.ibm.com>
Date: Thu, 03 Dec 2009 20:42:40 +0530
Message-Id: <1259853166.5085.43.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix small errors in the runtest files
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Tue, 2009-12-01 at 23:55 +0100, Jiri Palecek wrote: 
> Hello,
> 
> this patch fixes the following problems in the runtest files:
> 
>  - rwtest has been renamed to rwtest.sh
> 
>  - there is no ipv6 variant of rlogin test
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  runtest/fs          |   10 +++++-----
>  runtest/ipv6_expect |    1 -
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/runtest/fs b/runtest/fs
> index 717336a..9042c87 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -29,11 +29,11 @@ gf27 growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$ -d $TMP
>  gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$ -d $TMPDIR
>  gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$ -d $TMPDIR
>  gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$ -d $TMPDIR
> -rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:$TMPDIR/rw-sync-$$
> -rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:$TMPDIR/rw-buffered-$$
> -rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
> -rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
> -rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwtest01%f
> +rwtest01 export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s  -f sync 10%25000:$TMPDIR/rw-sync-$$
> +rwtest02 export LTPROOT; rwtest.sh -N rwtest02 -c -q -i 60s  -f buffered 10%25000:$TMPDIR/rw-buffered-$$
> +rwtest03 export LTPROOT; rwtest.sh -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
> +rwtest04 export LTPROOT; rwtest.sh -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
> +rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwtest01%f
> 
>  #must be run as root
>  #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ | doio -akv -n 2
> diff --git a/runtest/ipv6_expect b/runtest/ipv6_expect
> index 522082e..fbed53d 100644
> --- a/runtest/ipv6_expect
> +++ b/runtest/ipv6_expect
> @@ -1,2 +1 @@
>  #DESCRIPTION:IPV6 related tests which require expect
> -rlogin6 rlogin01 -6


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
