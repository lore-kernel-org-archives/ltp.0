Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XYdvP-0005lN-2f
	for ltp-list@lists.sourceforge.net; Mon, 29 Sep 2014 16:35:47 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XYdvO-0000im-8s
	for ltp-list@lists.sourceforge.net; Mon, 29 Sep 2014 16:35:47 +0000
Message-ID: <54298ACA.1050101@oracle.com>
Date: Mon, 29 Sep 2014 20:37:30 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1411649975-17339-1-git-send-email-liuhangbin@gmail.com>
In-Reply-To: <1411649975-17339-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH v2] ltp-networking/tcp_cmds/finger: fix finger bad
 user and host test
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
To: Hangbin Liu <liuhangbin@gmail.com>, LTP List <ltp-list@lists.sourceforge.net>
Cc: vasily.isaenko@oracle.com, Vincent Hsu <vincent.hsu@linaro.org>

Hi!

On 09/25/2014 04:59 PM, Hangbin Liu wrote:
> Finger always return 0 with bad user and host test. And it also return
> different error message on different distros. So let's only check stderr
> message and decide whether the test pass or fail.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   testcases/network/tcp_cmds/finger/finger01 | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
> index 203d746..89693ff 100755
> --- a/testcases/network/tcp_cmds/finger/finger01
> +++ b/testcases/network/tcp_cmds/finger/finger01
> @@ -115,13 +115,10 @@ do_test2()
>       finger -x 2>&1 1>/dev/null && end_testcase "finger -x should fail"

I would change redirection here to  > /dev/null 2>&1 as we don't need to 
print stderr.

>   
>       tst_resm TINFO "finger -bad user "
> -    finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"
> -    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" \
> -        || end_testcase "finger @$BADHOST"
> -    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null \
> -        | grep "finger: unknown host"; then
> +    [ "finger $BADUSER 2>&1 1>/dev/null" ] || end_testcase "finger $BADUSER"
> +    [ "finger @$BADHOST 2>&1 1>/dev/null" ] || end_testcase "finger @$BADHOST"
> +    [ "finger $BADUSER@$BADHOST 2>&1 1>/dev/null" ] || \

Checking string constants... not command output, forgot to add '$()'?

Besides, it'd be great to get rid of obsolete 'net_cmdlib.sh' in the test.

Thanks
Alexey


------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
