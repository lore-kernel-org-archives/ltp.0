Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OO9Aj-0006pO-SK
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:53:49 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OO9Ai-0008L5-RF
	for ltp-list@lists.sourceforge.net; Mon, 14 Jun 2010 12:53:49 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5ECS2pE022863
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:28:02 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5ECYad3035956
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:34:37 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o5ECYZjU029094
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Jun 2010 06:34:35 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <000001cb086a$f2fc55d0$d8f50170$@co.jp>
References: <000001cb086a$f2fc55d0$d8f50170$@co.jp>
Date: Mon, 14 Jun 2010 18:04:24 +0530
Message-Id: <1276518865.4885.8.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] fix "mail" test
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

Thanks.

Regards--
Subrata

On Thu, 2010-06-10 at 16:02 +0900, Mitani wrote: 
> Hi,
> 
> I want to suggest a patch for #2 test of "mail_tests.sh".
> 
> The failure of #2 is as following:
> ------------
> mail_tests::mail02    0  TINFO  :  Test #2: mail u...@bad-domain will result
> in failure
> mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer
> daemon should
> mail_tests::mail02    0  TINFO  :  Test #2: report this failure.
> mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root. Reason:
> No mail for root
> ------------
> 
> I use RHEL5.4, RHEL4.8 systems and x86, x86_64, ia64 architectures.
> "#2" test failed in all combinations.
> 
> At "#2" test, there is "No mail for root" in "tst_mail.res" file.
> I want to add this condition to judgment for "tst_mail.res".
> 
> The other day, I made a question  whether #2 test failed or not 
> in other systems. 
>  -->http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10184.html
> But I have received no reply yet. Therefore I don't know about other 
> systems, and I made this revision to become effective for only RHEL 
> systems.
> 
> 
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
> 
> ============
> --- a/testcases/commands/mail/mail_tests.sh	2010-06-02
> 21:46:46.000000000 +0900
> +++ b/testcases/commands/mail/mail_tests.sh	2010-06-09
> 15:33:19.000000000 +0900
> @@ -140,14 +140,18 @@
> 
>  export TCID=mail_tests::mail02
>  export TST_COUNT=2
> -RC=0
>  RC1=0
>  RC2=0
> +RC3=0
> +RC4=0
> 
>  tst_resm TINFO "Test #2: mail user@bad-domain will result in failure"
>  tst_resm TINFO "Test #2: to deliver the mail. Mailer daemon should"
>  tst_resm TINFO "Test #2: report this failure."
> 
> +tvar=${MACHTYPE%-*}
> +tvar=${tvar#*-}
> +
>  # Don't use underscores in domain names (they're illegal)...
>  mail -s "Test" root@thisdomaindoesnotexist < $LTPTMP/tst_mail.in \
>  	> $LTPTMP/tst_mail.out 2>&1
> @@ -190,9 +194,16 @@
>  		    $LTPTMP/tst_mail.res)
>  	fi
>  	if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]; then
> -		tst_res TFAIL $LTPTMP/tst_mail.res \
> -		    "Test #2: No new mail for root. Reason:"
> -		: $(( TFAILCNT += 1 ))
> +		RC4=$(awk '{print match($1 $2 $3, "Nomailfor")}' \
> +        	    $LTPTMP/tst_mail.res)
> +		if [ \( "$tvar" = "redhat" -o "$tvar" = "redhat-linux" \) -a
> -n "$RC4" ]; then
> +			tst_resm TPASS \
> +				"Test #2: No new mail for root as expected"
> +		else
> +			tst_res TFAIL $LTPTMP/tst_mail.res \
> +			    "Test #2: No new mail for root. Reason:"
> +			: $(( TFAILCNT += 1 ))
> +		fi
>  	else
> 
>  		if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne
> 0 ]; then
> ============
> 
> 
> 
> Regards--
> 
> -Tomonori Mitani
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate 
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
> lucky parental unit.  See the prize list and enter to win: 
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
