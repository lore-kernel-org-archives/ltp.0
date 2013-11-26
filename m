Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlIlx-0005t7-Lo
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 13:33:49 +0000
Date: Tue, 26 Nov 2013 14:33:21 +0100
From: chrubis@suse.cz
Message-ID: <20131126133321.GB13496@rei>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
	<1384400319-30776-6-git-send-email-vincent.hsu@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384400319-30776-6-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH 6/8] ltp-networking/tcp_cmds/finger: fix
 finger test
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
> Ubuntu use modified finger command. finger an unknown host test will
> return nonzero on Ubuntu 12.04 even if execution success.
> 
> for example:
> in Ubuntu
>     finger @xxx 2>&1 1>/dev/null ; echo $?
> will return
>     finger: unknown host: xxx
>     getaddrinfo: No address associated with hostname
>     1
> in CentOS
>     finger @xxx 2>&1 1>/dev/null ; echo $?
> will return
>     finger: xxx: nodename nor servname provided, or not known
>     0
> 
> Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
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

The same as the last one, please fix the over 80 chars line.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
