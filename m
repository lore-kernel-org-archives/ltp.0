Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeS2K-00008f-W6
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 16:02:25 +0000
Date: Thu, 7 Nov 2013 17:02:15 +0100
From: chrubis@suse.cz
Message-ID: <20131107160214.GA9169@rei.suse.cz>
References: <1383558321-1703-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383558321-1703-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] rdist01: fix mistakes
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
> @@ -130,17 +130,15 @@ check_result()
>      cd $TCtmp
>      for c_rhost in $HOSTS; do
>          for c_ruser in $RUSERS; do
> -            TOTAL_SUM=`rsh -n -l $c_ruser $c_rhost \
> -            x=0; SUM=\$(sum -s $FILES|awk '{ print \$1 }')
> -            for i in \$SUM; do
> -                x=\$(( \$x + \$i ))
> +            TOTAL_SUM=0
> +            for i in $(rsh -n -l $c_ruser $c_rhost sum -s $FILES | awk '{ print $1 }'); do
> +                TOTAL_SUM=$(( $TOTAL_SUM + $i ))
>              done
> -            echo \$x`
> -            if [ $TOTAL_SUM = $LSUM ]; then
> +            if [ $TOTAL_SUM == $LSUM ]; then

Unlike C the correct comparsion operator here is the single '='. The
'==' is bash extension that does not work with other shells. And in case
you are comparing two numbers -eq is even better (as ' 0' -eq '0' is
still true unlike ' 0' = '0').

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
