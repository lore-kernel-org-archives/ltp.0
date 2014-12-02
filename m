Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xvstq-0000YA-1u
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 19:14:14 +0000
Date: Tue, 2 Dec 2014 18:02:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202170220.GE22135@rei.suse.de>
References: <1411398517-2207-1-git-send-email-alexey.kodanev@oracle.com>
	<1411398517-2207-2-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1411398517-2207-2-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 2/2] network/ping: cleanup test,
	use new net library
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +	tst_resm TINFO "$PING_CMD with $PACKETSIZES ICMP packets"
> +	for packetsize in $PACKETSIZES; do
> +		tst_resm TINFO "call $PING_CMD with packet size = $packetsize"
> +		$PING_CMD -c $COUNT -s $packetsize $RHOST > /dev/null 2>&1
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "$PING_CMD -c $COUNT -s $packetsize $RHOST"
> +			return
> +		fi
> +		sleep $SLEEPTIME

Is the sleep necessary here?


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
