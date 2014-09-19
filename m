Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XUwAv-0002kS-Bm
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 11:16:29 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XUwAu-0008Ew-Da
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 11:16:29 +0000
Message-ID: <541C10F2.6090801@oracle.com>
Date: Fri, 19 Sep 2014 15:18:10 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1410503959-31712-1-git-send-email-liuhangbin@gmail.com>
In-Reply-To: <1410503959-31712-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] ltp-networking/tcp_cmds/finger: fix finger
 unknown host test
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
Cc: Vincent Hsu <vincent.hsu@linaro.org>

Hi!
On 09/12/2014 10:39 AM, Hangbin Liu wrote:
> On RHEL6/7 and Fedora, finger added a patch that will return error like
> finger: Name or service not known: host 'xxxx', service 'finger'
>
> >From commit e1c5e46 ltp-networking/tcp_cmds/finger: fix finger test,
> on Ubuntu will return
>      finger: unknown host: xxx
>      getaddrinfo: No address associated with hostname
> on CentOS will return
>      finger: xxx: nodename nor servname provided, or not known
>
> So modify the check option and only grep finger: .*known
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   testcases/network/tcp_cmds/finger/finger01 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
> index 203d746..c00f2cc 100755
> --- a/testcases/network/tcp_cmds/finger/finger01
> +++ b/testcases/network/tcp_cmds/finger/finger01
> @@ -116,10 +116,10 @@ do_test2()
>   
>       tst_resm TINFO "finger -bad user "
>       finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"

Finger always returns 0 here, test-case pass.

> -    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" \
> +    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: .*known" \
>           || end_testcase "finger @$BADHOST"

It doesn't return error exit code when it fails to find users and hosts, 
but we could check stderr for the presence of any messages, e.g.:

if [ -z "$(finger $BADUSER 2>&1 >/dev/null)" ]; then
     end_testcase "finger $BADUSER"
fi


>       if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null \
> -        | grep "finger: unknown host"; then
> +        | grep "finger: .*known"; then
>           end_testcase "finger $BADUSER@$BADHOST"
>       fi
>   }

Thanks,
Alexey


------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
