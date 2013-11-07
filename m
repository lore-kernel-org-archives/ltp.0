Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VePO7-0005qX-HC
	for ltp-list@lists.sourceforge.net; Thu, 07 Nov 2013 13:12:43 +0000
Date: Thu, 7 Nov 2013 14:12:34 +0100
From: chrubis@suse.cz
Message-ID: <20131107131234.GA28961@rei.suse.cz>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-4-git-send-email-vincent.hsu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383085243-5833-4-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH 3/9] ltp-networking/tcp_cmds/finger: finger
 an unknown host test will return 1 even if execution success on Ubuntu
 12.04
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, linaro-networking@linaro.org

Hi!
> for example:
>     $ finger @xxxx || echo "test fail"
>     finger: unknown host: xxxx
>     getaddrinfo: No address associated with hostname
>     test fail

Hmm, at my computers (SUSE, Gentoo) it works as:

$ finger @xxxx || echo "test fail"
finger: unknown host: xxxx

Are you sure that finger returns nonzero? From what package and what
version does your finger come from?

Btw what is wrong at the code bellow is the redirection, which does not
work, the >/dev/null should be before the 2>&1. Even if your finger
really returns nonzero the code bellow is quite cryptic as it looks like
it redirects all output from the finger into the /dev/null but it really
just redirects stderr into stdout which goes to the grep...

> ---
>  testcases/network/tcp_cmds/finger/finger01 |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
> index 6a72c8f..a5206be 100755
> --- a/testcases/network/tcp_cmds/finger/finger01
> +++ b/testcases/network/tcp_cmds/finger/finger01
> @@ -116,8 +116,8 @@ do_test2()
> 
>      tst_resm TINFO "finger -bad user "
>      finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"
> -    finger @$BADHOST 2>&1 1>/dev/null || end_testcase "finger @$BADHOST"
> -    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null; then
> +    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" || end_testcase "finger @$BADHOST"
> +    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host"; then
>          end_testcase "finger $BADUSER@$BADHOST"
>      fi
>  }

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
