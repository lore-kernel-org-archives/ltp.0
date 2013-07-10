Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Uwk5O-0002hv-4j
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 02:24:54 +0000
Received: from mail-pd0-f170.google.com ([209.85.192.170])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uwk5M-0001Db-BN
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 02:24:54 +0000
Received: by mail-pd0-f170.google.com with SMTP id x11so5885265pdj.15
	for <ltp-list@lists.sourceforge.net>;
	Tue, 09 Jul 2013 19:24:44 -0700 (PDT)
Message-ID: <51DCC606.10404@casparzhang.com>
Date: Wed, 10 Jul 2013 10:25:10 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <CALGiYOHjLdA=roRGqztO1HjHSvy+=Je7LK-Zi2LTQMsKU5Z=1g@mail.gmail.com>
In-Reply-To: <CALGiYOHjLdA=roRGqztO1HjHSvy+=Je7LK-Zi2LTQMsKU5Z=1g@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] xinetd/xinetd_tests.sh: add IPv6 test for
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

On 07/09/2013 02:17 PM, Xie Lingyun wrote:
> +	# sometimes the default telnet may be /usr/kerberos/bin/telnet
> +	TELNET_COMM='/usr/bin/telnet'
> +	
>       # check if commands tst_*, xinetd, awk exists.
>       chk_ifexists INIT tst_resm   || return $RC
>       chk_ifexists INIT xinetd     || return $RC
>       chk_ifexists INIT diff       || return $RC
> -    chk_ifexists INIT telnet     || return $RC
> -
> +    chk_ifexists INIT $TELNET_COMM     || return $RC
> +    chk_ifexists INIT ip		 || return $RC
> +
> +    IPV6_ENABLED=0
> +    ip a | grep inet6 > /dev/null 2>&1
> +    if [ $? -eq 0 ]
> +    then
> +    	IPV6_ENABLED=1
> +    fi
> +
>   	# Create custom xinetd.conf file.
>   	# tst_xinetd.conf.1 config file has telnet service disabled.
>   	cat > $LTPTMP/tst_xinetd.conf.1 <<-EOF || RC=$?
> @@ -128,7 +139,7 @@ init()
>
>       # Create expected file with telnet disabled.
>       cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
> -	telnet: Unable to connect to remote host: Connection refused
> +	telnet: connect to address 127.0.0.1: Connection refused
>   	EOF
>
>       if [ $RC -ne 0 ]
> @@ -137,11 +148,25 @@ init()
>               "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
>           return $RC
>       fi
> +
> +    if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +    	cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
> +		telnet: connect to address ::1: Connection refused
> +		EOF
> +
> +    	if [ $RC -ne 0 ]
> +   		then
> +        	tst_brkm TBROK  NULL \
> +            	"INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1.ipv6"
> +        	return $RC
> +    	fi
> +    fi
>
>       # Create expected file with telnet enabled.
>   	cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
>   	Trying 127.0.0.1...
> -	Connected to localhost (127.0.0.1).
> +	Connected to 127.0.0.1.
>   	Escape character is '^]'.
>   	Connection closed by foreign host.
>   	EOF
> @@ -149,10 +174,27 @@ init()
>       if [ $RC -ne 0 ]
>       then
>           tst_brkm TBROK  NULL \
> -            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
> +            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2"
>           return $RC
>       fi
>
> +	if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +    	cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
> +		Trying ::1...
> +		Connected to ::1.
> +		Escape character is '^]'.
> +		Connection closed by foreign host.
> +		EOF
> +
> +    	if [ $RC -ne 0 ]
> +    	then
> +        	tst_brkm TBROK  NULL \
> +            	"INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2.ipv6"
> +        	return $RC
> +    	fi
> +    fi
> +
>       return $RC
>   }
>
> @@ -263,7 +305,7 @@ test01()
>
>   	# Not checking for exit code from telnet command because telnet is
>   	# not terminated by the test gracefully.
> -	echo "" | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
> +	echo "" | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
>   	diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
>   		> $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
>       if [ $RC -ne 0 ]
> @@ -272,7 +314,20 @@ test01()
>               "Test #1: with telnet diabled expected out differs RC=$RC. Details:"
>           return $RC
>       fi
> -
> +
> +    if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +    	echo "" | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6 1>/dev/null
> +		diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.1.ipv6 \
> +			> $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
> +    	if [ $RC -ne 0 ]
> +    	then
> +        	tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
> +            	"Test #1: with telnet diabled of IPv6 expected out differs RC=$RC. Details:"
> +        	return $RC
> +    	fi
> +    fi
> +
>       tst_resm TINFO "Test #1: restart xinetd with telnet enabled."
>   	# install the xinetd config file with telnet enabled.
>   	mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1 \
> @@ -312,7 +367,7 @@ test01()
>
>   	# Not checking for exit code from telnet command because telnet is
>   	# not terminated by the test gracefully.
> -	echo "" | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
> +	echo "" | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
>
>   	diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
>   		> $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
> @@ -321,11 +376,24 @@ test01()
>           tst_res TFAIL $LTPTMP/tst_xinetd.err \
>               "Test #1: expected output differes from actual. Details:"
>           return $RC
> -	else
> -		tst_resm TPASS \
> -		"Test #1: xinetd reads the config file and starts or stops services."
>       fi
>
> +	if [ $IPV6_ENABLED -eq 1 ]
> +    then
> +    	echo "" | $TELNET_COMM ::1 > $LTPTMP/tst_xinetd.out.ipv6 2>&1
> +
> +		diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.2.ipv6 \
> +			> $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
> +    	if [ $RC -ne 0 ]
> +    	then
> +        	tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
> +            	"Test #1: expected output differes from actual. Details:"
> +        	return $RC
> +    	fi
> +    fi
> +
> +	tst_resm TPASS \
> +		"Test #1: xinetd reads the config file and starts or stops services."
>       return $RC
>   }

IIRC there is no style guide for shell scripts for now, but I suggest 
keep the consistency of indentations in each line, i.e. either using 4 
spaces or 1 tab per level indentation, rather than mixed using of them. 
Reading from this script, I think using 4-space will be a better choice.

Thanks,
Caspar

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
