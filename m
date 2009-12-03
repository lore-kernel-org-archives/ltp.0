Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDMu-0003Is-2T
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:20 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDMn-00075I-Rh
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:13:20 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nB3F7dnB006270
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 08:07:39 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB3FCwhr215990
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 08:13:00 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nB3FCmkm015149
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Dec 2009 08:12:49 -0700
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200912012346.nB1Nk9Sv015715@e34.co.us.ibm.com>
References: <200912012346.nB1Nk9Sv015715@e34.co.us.ibm.com>
Date: Thu, 03 Dec 2009 20:42:21 +0530
Message-Id: <1259853141.5085.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fixes of some errors discovered by "set -u"
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

On Tue, 2009-12-01 at 23:30 +0100, Jiri Palecek wrote: 
> Hello,
> 
> this patch fixes the following problems:
> 
>  - read of $TEST_USER before it's set in ftp03
> 
>  - remnants of the $COMMAND variable which isn't really there anymore
>    in netstat01
> 
>  - probably a typo in rsh01 ($COUNT vs. $TST_COUNT)
> 
>  - $2 has to be escaped twice in rwho01, to appear in the awk script
> 
>  - when no interface is found tcpdump01, $IF is unset. Don't spit out
>    an error in that case
> 
> This is a version with changes reflecting Mike's comments.
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/network/tcp_cmds/ftp/ftp03         |    2 +-
>  testcases/network/tcp_cmds/netstat/netstat01 |    2 +-
>  testcases/network/tcp_cmds/rsh/rsh01         |    2 +-
>  testcases/network/tcp_cmds/rwho/rwho01       |    8 ++++----
>  testcases/network/tcp_cmds/tcpdump/tcpdump01 |    2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/ftp/ftp03 b/testcases/network/tcp_cmds/ftp/ftp03
> index 24e30e9..e85a985 100755
> --- a/testcases/network/tcp_cmds/ftp/ftp03
> +++ b/testcases/network/tcp_cmds/ftp/ftp03
> @@ -39,8 +39,8 @@ do_setup()
>  {
>  	
>      RHOST="localhost"
> -    TCtmp=/home/$TEST_USER
>      TEST_USER="ftpuser1"
> +    TCtmp=/home/$TEST_USER
>      TEST_USER_PASSWD="eal"
>      TEST_USER_ENCRYPTED_PASSWD="42VmxaOByKwlA"
>      TEST_USER_HOMEDIR="/home/$TEST_USER"
> diff --git a/testcases/network/tcp_cmds/netstat/netstat01 b/testcases/network/tcp_cmds/netstat/netstat01
> index 365c142..45238dc 100755
> --- a/testcases/network/tcp_cmds/netstat/netstat01
> +++ b/testcases/network/tcp_cmds/netstat/netstat01
> @@ -59,7 +59,7 @@ do_test() {
> 
>          for flag in "-s" "-rn" "-i" "-gn" "-apn"; do
>              if ! netstat $flag 1>/dev/null 2>&1; then
> -                end_testcase "$COMMAND failed"
> +                end_testcase "netstat $flag failed"
>              fi
>          done
> 
> diff --git a/testcases/network/tcp_cmds/rsh/rsh01 b/testcases/network/tcp_cmds/rsh/rsh01
> index 0a2b58f..1409cbf 100755
> --- a/testcases/network/tcp_cmds/rsh/rsh01
> +++ b/testcases/network/tcp_cmds/rsh/rsh01
> @@ -87,7 +87,7 @@ do_test()
>              tst_resm TFAIL "rsh to $RHOST failed"
>              # If the first rsh failed, the likelihood that the rest will
>              # succeed is low.
> -            if [ "$FAIL_IMMEDIATELY" = "1" ] && [ $COUNT -eq 1 ]; then
> +            if [ "$FAIL_IMMEDIATELY" = "1" ] && [ $TST_COUNT -eq 1 ]; then
>                  exit 2
>              fi
>          fi
> diff --git a/testcases/network/tcp_cmds/rwho/rwho01 b/testcases/network/tcp_cmds/rwho/rwho01
> index 9967967..72fb569 100755
> --- a/testcases/network/tcp_cmds/rwho/rwho01
> +++ b/testcases/network/tcp_cmds/rwho/rwho01
> @@ -106,15 +106,15 @@ do_test()
> 
>      while [ $TST_COUNT -le $NUMLOOPS ]; do
>          rwho -a > $OUTFILE
> -        HOST=`awk "\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
> +        HOST=`awk "\\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
>          [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in rwho outfile"
> -        HOST=`awk "\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
> +        HOST=`awk "\\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
>          [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in rwho outfile"
> 
>          ruptime -a > $OUTFILE
> -        HOST=`awk "\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
> +        HOST=`awk "\\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
>          [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in ruptime outfile"
> -        HOST=`awk "\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
> +        HOST=`awk "\\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
>          [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in ruptime outfile"
> 
>          tst_resm TINFO "Test $COUNT of $NUMLOOPS complete"
> diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
> index 650e97e..0f4aba7 100755
> --- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
> +++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
> @@ -59,7 +59,8 @@ do_setup()
>              break
>          fi
>      done
> -    if [ -z "${IF}" ]; then
> +    # Default to empty string if unset, to avoid errors caused by set -u, which we use (see cmdlib.sh)
> +    if [ -z "${IF:-}" ]; then
>          end_testcase "Could not identify interface"
>          exit 1
>      fi


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
