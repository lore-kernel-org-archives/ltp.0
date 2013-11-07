Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VeS7k-0003hZ-SM
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 16:08:00 +0000
Date: Thu, 7 Nov 2013 17:07:50 +0100
From: chrubis@suse.cz
Message-ID: <20131107160750.GA9653@rei.Home>
References: <1383556829-1464-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383556829-1464-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] networktests.sh: add ${LTPROOT}/bin into $PATH
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
> Some tests need `gethost' (e.g. sendfile01), which lives in ${LTPROOT}/bin,
> which is not in $PATH of networktests.sh.
> 
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>  testscripts/networktests.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testscripts/networktests.sh b/testscripts/networktests.sh
> index b136749..9465356 100755
> --- a/testscripts/networktests.sh
> +++ b/testscripts/networktests.sh
> @@ -110,7 +110,7 @@ fi
>  
>  cd $TMPDIR
>  
> -export PATH="${PATH}:${LTPROOT}/testcases/bin"
> +export PATH="${PATH}:${LTPROOT}/bin:${LTPROOT}/testcases/bin"

You can remove the original export that adds ${LTPROOT}/testcases/bin as
this path is allready added by runltp script.

And I think that better solution would be to install genhost into the
testcases/bin (as the rest of the binaries used from the tests such as
tst_resm).

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
