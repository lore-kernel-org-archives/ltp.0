Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YAyfL-0004MV-DA
	for ltp-list@lists.sourceforge.net; Tue, 13 Jan 2015 10:25:39 +0000
Date: Tue, 13 Jan 2015 11:24:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150113102446.GA8612@rei.suse.de>
References: <1412835916-5039-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412835916-5039-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH v4] ltp-networking/tcp_cmds/finger: fix finger bad
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> Finger always return 0 with bad user and host test. And it also return
> different error message on different distros. So let's only check stderr
> message and decide whether the test pass or fail.

Okay, so the test passes if anything was written into stderr. Sounds
good to me.

> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/network/tcp_cmds/finger/finger01 | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
> index 203d746..e01c1ad 100755
> --- a/testcases/network/tcp_cmds/finger/finger01
> +++ b/testcases/network/tcp_cmds/finger/finger01
> @@ -112,14 +112,13 @@ do_test2()
>      BADHOST="xxxx"
>  
>      tst_resm TINFO "finger -badflag default "
> -    finger -x 2>&1 1>/dev/null && end_testcase "finger -x should fail"
> +    finger -x &>/dev/null && end_testcase "finger -x should fail"
>  
>      tst_resm TINFO "finger -bad user "
> -    finger $BADUSER 2>&1 1>/dev/null || end_testcase "finger $BADUSER"
> -    finger @$BADHOST 2>&1 1>/dev/null | grep "finger: unknown host" \
> -        || end_testcase "finger @$BADHOST"
> -    if ! finger $BADUSER@$BADHOST 2>&1 1>/dev/null \
> -        | grep "finger: unknown host"; then
> +    [ "$(finger $BADUSER 2>&1 1>/dev/null)" ] || end_testcase "finger $BADUSER"
> +    [ "$(finger @$BADHOST 2>&1 1>/dev/null)" ] || \
> +        end_testcase "finger @$BADHOST"
> +    [ "finger $BADUSER@$BADHOST 2>&1 1>/dev/null" ] || \

Missing $(), otherwise this will be always true because we just pass a
string to the [].

>          end_testcase "finger $BADUSER@$BADHOST"
>      fi

And this fi does belong to the deleted if.

Alexey can you please fix the minor issues and push the patch?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
