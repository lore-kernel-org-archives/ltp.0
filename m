From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Sep 2016 12:31:14 +0200
Subject: [LTP] [PATCH 2/3] network/ping01: use ROD_SILENT and report
 test result
In-Reply-To: <1473320058-13205-2-git-send-email-alexey.kodanev@oracle.com>
References: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
 <1473320058-13205-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160919103113.GA7877@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -47,12 +46,10 @@ do_test()
>  	local ipaddr=$(tst_ipaddr rhost)
>  	for packetsize in $PACKETSIZES; do
>  		tst_resm TINFO "call $PING_CMD with packet size = $packetsize"
> -		$PING_CMD -c $COUNT -s $packetsize $ipaddr > /dev/null 2>&1
> -		if [ $? -ne 0 ]; then
> -			tst_resm TFAIL "$PING_CMD -c $COUNT -s $packetsize $ipaddr"
> -			return
> -		fi
> +		ROD_SILENT $PING_CMD -c $COUNT -s $packetsize $ipaddr

What about we use the EXPECT_PASS here? The ROD_SILENT would produce
TBROK instead of TFAIL in case of failure.

I know that EXPECT_PASS wouldn't exit the test on first failure, do we
really need that anyway? And it also wouldn't silence the ping output,
which shouldn't be so much of a problem since the $COUNT is small.

-- 
Cyril Hrubis
chrubis@suse.cz
