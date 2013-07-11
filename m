Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UxBpu-0000lR-4a
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 08:02:46 +0000
Received: from mail-pb0-f45.google.com ([209.85.160.45])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UxBpr-0005om-W9
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 08:02:46 +0000
Received: by mail-pb0-f45.google.com with SMTP id mc8so7564395pbc.18
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Jul 2013 01:02:38 -0700 (PDT)
Message-ID: <51DE66B8.5030807@casparzhang.com>
Date: Thu, 11 Jul 2013 16:03:04 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
	<1373454200-8630-2-git-send-email-lingyun.xie@bj.cs2c.com.cn>
	<51DD9A44.4090409@casparzhang.com>
	<CALGiYOGnBrGcM5nLE4EZaGvYv02oYnNC2QZm1CH4uVwFrFMMyw@mail.gmail.com>
	<CALGiYOFmr61vz8JzZxV1YMGPQtbYGt5qwiMMQX+xk5BSGx22Rw@mail.gmail.com>
In-Reply-To: <CALGiYOFmr61vz8JzZxV1YMGPQtbYGt5qwiMMQX+xk5BSGx22Rw@mail.gmail.com>
Subject: Re: [LTP] [PATCH 2/2 v3] xinetd/xinetd_tests.sh: add IPv6 test for
 xinetd
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
To: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 07/11/2013 04:00 PM, Xie Lingyun wrote:
>
>  From b80c141e2dcc37e4470fccb04ca70e4782e98a6e Mon Sep 17 00:00:00 2001
> From: Xie Lingyun<lingyun.xie@bj.cs2c.com.cn>
> Date: Thu, 11 Jul 2013 15:14:18 +0800
> Subject: [PATCH 2/2 v4] xinetd/xinetd_tests.sh: add IPv6 test for xinetd
>
> If IPv6 is enabled, telnet ::1 will be tested. Otherwise, IPv4 only.
> The IPv6 test will be executed first and give a separate result.
>
> Signed-off-by: Xie Lingyun<lingyun.xie@bj.cs2c.com.cn>
> ---
>   testcases/network/xinetd/xinetd_tests.sh | 81 +++++++++++++++++++++++++++++---
>   1 file changed, 75 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
> index d898af0..a607d32 100755
> --- a/testcases/network/xinetd/xinetd_tests.sh
> +++ b/testcases/network/xinetd/xinetd_tests.sh
> @@ -84,11 +84,22 @@ init()
>            return $RC
>       fi
>
> +    # sometimes the default telnet may be /usr/kerberos/bin/telnet
> +    TELNET_COMM='/usr/bin/telnet'
> +
>       # check if commands tst_*, xinetd, awk exists.
>       chk_ifexists INIT tst_resm   || return $RC
>       chk_ifexists INIT xinetd     || return $RC
>       chk_ifexists INIT diff       || return $RC
> -    chk_ifexists INIT telnet     || return $RC
> +    chk_ifexists INIT ip         || return $RC
> +    chk_ifexists INIT $TELNET_COMM || return $RC
> +
> +    IPV6_ENABLED=0
> +    ip a | grep inet6 > /dev/null 2>&1
> +    if [ $? -eq 0 ]
> +    then
> +        IPV6_ENABLED=1
> +    fi
>
>       # Create custom xinetd.conf file.
>       # tst_xinetd.conf.1 config file has telnet service disabled.
> @@ -128,7 +139,7 @@ EOF
>
>       # Create expected file with telnet disabled.
>       cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
> -telnet: Unable to connect to remote host: Connection refused
> +telnet: connect to address 127.0.0.1: Connection refused
>   EOF
>
>       if [ $RC -ne 0 ]
> @@ -138,10 +149,23 @@ EOF
>           return $RC
>       fi
>
> +    if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +        cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
> +telnet: connect to address ::1: Connection refused
> +EOF
> +
> +        if [ $RC -ne 0 ]
> +        then
> +            tst_brkm TBROK NULL \
> +                "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
> +        fi
> +    fi
> +
>       # Create expected file with telnet enabled.
>       cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
>   Trying 127.0.0.1...
> -Connected to localhost (127.0.0.1).
> +Connected to 127.0.0.1.
>   Escape character is '^]'.
>   Connection closed by foreign host.
>   EOF
> @@ -149,10 +173,26 @@ EOF
>       if [ $RC -ne 0 ]
>       then
>           tst_brkm TBROK  NULL \
> -            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
> +            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2"
>           return $RC
>       fi
>
> +    if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +        cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
> +Trying ::1...
> +Connected to ::1.
> +Escape character is '^]'.
> +Connection closed by foreign host.
> +EOF
> +
> +        if [ $RC -ne 0 ]
> +        then
> +            tst_brkm TBROK NULL \
> +                "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2.ipv6"
> +        fi
> +    fi
> +
>       return $RC
>   }
>
> @@ -263,7 +303,20 @@ test01()
>
>       # Not checking for exit code from telnet command because telnet is
>       # not terminated by the test gracefully.
> -    echo "" | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
> +    if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +        echo "" | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6 1>/dev/null
> +        diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.1.ipv6 \
> +            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
> +        if [ $RC -ne 0 ]
> +        then
> +            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
> +                "Test #1: with telnet diabled expected out differs RC=$RC. Details:"
> +            return $RC
> +        fi
> +    fi
> +
> +    echo "" | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>       diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
>           > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>       if [ $RC -ne 0 ]
> @@ -312,7 +365,23 @@ test01()
>
>       # Not checking for exit code from telnet command because telnet is
>       # not terminated by the test gracefully.
> -    echo "" | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
> +    if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +        echo "" | $TELNET_COMM ::1 >$LTPTMP/tst_xinetd.out.ipv6 2>&1
> +        diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.2.ipv6 \
> +            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
> +        if [ $RC -ne 0 ]
> +        then
> +            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
> +                "Test #1: with telnet diabled expected out differs RC=$RC. Details:"
> +            return $RC
> +        else
> +            tst_resm TPASS \
> +            "Test #1: xinetd reads the config file and starts or stops IPv6 services."
> +        fi
> +    fi
> +
> +    echo "" | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
>
>       diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
>           > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
> -- 1.8.3.1

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
