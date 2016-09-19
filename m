From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 19 Sep 2016 14:13:28 +0200
Subject: [LTP] [PATCH 2/3] network/ping01: use ROD_SILENT and report
 test result
In-Reply-To: <57DFD5B9.6090800@oracle.com>
References: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
 <1473320058-13205-2-git-send-email-alexey.kodanev@oracle.com>
 <20160919103113.GA7877@rei.lan> <57DFD5B9.6090800@oracle.com>
Message-ID: <20160919121328.GC6220@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes, $COUNT is small but we should multiply it by $PACKETSIZES. Even 
> with '-q' there will be a lot of output.
> What about adding redirection to /dev/null and removing tst_resm() as below:
> 
> -TST_TOTAL=1
> +TST_TOTAL=10
>   TCID="ping01"
> 
>   . test_net.sh
> @@ -45,11 +45,8 @@ do_test()
>          tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
>          local ipaddr=$(tst_ipaddr rhost)
>          for packetsize in $PACKETSIZES; do
> -               tst_resm TINFO "call $PING_CMD with packet size = 
> $packetsize"
> -               ROD_SILENT $PING_CMD -c $COUNT -s $packetsize $ipaddr
> +               EXPECT_PASS $PING_CMD -c $COUNT -s $packetsize $ipaddr 
> \>/dev/null
>          done
> -
> -       tst_resm TPASS "$PING_CMD test completed"
>   }

Looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
