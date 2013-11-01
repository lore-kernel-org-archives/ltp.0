Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VcATk-0008FR-9E
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 08:53:16 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VcATi-0002Ye-BU
	for ltp-list@lists.sourceforge.net; Fri, 01 Nov 2013 08:53:16 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA18r7Hf002316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 1 Nov 2013 08:53:08 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA18r7oK009807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 1 Nov 2013 08:53:07 GMT
Received: from abhmt104.oracle.com (abhmt104.oracle.com [141.146.116.56])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA18r75l009798
	for <ltp-list@lists.sourceforge.net>; Fri, 1 Nov 2013 08:53:07 GMT
Message-ID: <52736BE4.3080009@oracle.com>
Date: Fri, 01 Nov 2013 16:52:52 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1383214761-1385-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1383214761-1385-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] rwho01: fix getting hostnames from command output
 and a typo
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

Could anyone review this?

Thanks
Simon

On 10/31/13 18:19, Simon Xu wrote:
> Fix the way the script gets hostnames from rwho/ruptime command output,
> and the mistake that $COUNT is used instead of $TST_COUNT in do_test().
> ---
>   testcases/network/tcp_cmds/rwho/rwho01 | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/rwho/rwho01 b/testcases/network/tcp_cmds/rwho/rwho01
> index 2c82ef1..eb31642 100755
> --- a/testcases/network/tcp_cmds/rwho/rwho01
> +++ b/testcases/network/tcp_cmds/rwho/rwho01
> @@ -106,18 +106,18 @@ do_test()
>   
>       while [ $TST_COUNT -le $NUMLOOPS ]; do
>           rwho -a > $OUTFILE
> -        HOST=`awk "\\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
> +        HOST=`grep $LHOST $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
>           [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in rwho outfile"
> -        HOST=`awk "\\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
> +        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
>           [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in rwho outfile"
>   
>           ruptime -a > $OUTFILE
> -        HOST=`awk "\\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
> +        HOST=`grep $LHOST $OUTFILE | sed 's/ .*//' | uniq`
>           [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in ruptime outfile"
> -        HOST=`awk "\\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
> +        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/ .*//' | uniq`
>           [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in ruptime outfile"
>   
> -        tst_resm TINFO "Test $COUNT of $NUMLOOPS complete"
> +        tst_resm TINFO "Test $TST_COUNT of $NUMLOOPS complete"
>           incr_tst_count
>       done
>   }


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
