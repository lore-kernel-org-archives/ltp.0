Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VdNpH-0001ad-LV
	for ltp-list@lists.sourceforge.net; Mon, 04 Nov 2013 17:20:31 +0000
Date: Mon, 4 Nov 2013 18:20:09 +0100
From: chrubis@suse.cz
Message-ID: <20131104172008.GA11841@rei>
References: <52736BE4.3080009@oracle.com>
	<1383555538-1297-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383555538-1297-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH V2] rwho01: fix getting hostnames from command
 output and $COUNT
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Fix the way the script gets hostnames from rwho/ruptime command output,
> and the mistake that $COUNT is used instead of $TST_COUNT in do_test().

The change from COUNT to TST_COUNT is pretty straightforward. Can you
please describe more verbosely why is the second change needed? Has the
output from rwho and ruptime changed over the time?

>      while [ $TST_COUNT -le $NUMLOOPS ]; do
>          rwho -a > $OUTFILE
> -        HOST=`awk "\\$2 ~ /$LHOST>/" $OUTFILE | cut -f1 -d: | sort -u`
> +        HOST=`grep $LHOST $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
>          [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in rwho outfile"
> -        HOST=`awk "\\$2 ~ /$RHOSTNAME>/" $OUTFILE | cut -f1 -d: | sort -u`
> +        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/[^ ]* *//; s/:.*//' | uniq`
>          [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in rwho outfile"
>  
>          ruptime -a > $OUTFILE
> -        HOST=`awk "\\$1 ~ /$LHOST>/" $OUTFILE | sort -u`
> +        HOST=`grep $LHOST $OUTFILE | sed 's/ .*//' | uniq`
>          [ "$HOST" = "$LHOST" ] || end_testcase "$LHOST is not in ruptime outfile"
> -        HOST=`awk "\\$1 ~ /$RHOSTNAME>/" $OUTFILE | sort -u`
> +        HOST=`grep $RHOSTNAME $OUTFILE | sed 's/ .*//' | uniq`
>          [ "$HOST" = "$RHOSTNAME" ] || end_testcase "$RHOSTNAME is not in ruptime outfile"
>  
> -        tst_resm TINFO "Test $COUNT of $NUMLOOPS complete"
> +        tst_resm TINFO "Test $TST_COUNT of $NUMLOOPS complete"
>          incr_tst_count
>      done
>  }
> -- 
> 1.8.4.2
> 
> 
> ------------------------------------------------------------------------------
> Android is increasing in popularity, but the open development platform that
> developers love is also attractive to malware creators. Download this white
> paper to learn more about secure code signing practices that can help keep
> Android apps secure.
> http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

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
