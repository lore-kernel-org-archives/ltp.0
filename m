From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Aug 2021 18:22:04 +0200
Subject: [LTP] [PATCH 2/2] broken_ip: TCONF when test run on unsupported
 protocol
In-Reply-To: <YQliykiyDtJwEKVK@pevik>
References: <20210714140716.1568-1-pvorel@suse.cz>
 <20210714140716.1568-3-pvorel@suse.cz>
 <57d4c109-d01a-2c7f-39c7-41013e70abf9@bell-sw.com>
 <YQBD4w2nKwY2G1l+@pevik>
 <b0638d98-88d5-76d7-78a1-631c801d88ad@bell-sw.com>
 <YQg0LIXG8LK0OV74@pevik>
 <80a6cbec-50b7-9912-d682-915a1076bbec@bell-sw.com>
 <YQliykiyDtJwEKVK@pevik>
Message-ID: <YQltLFTp3mRPqjQR@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> --- testcases/network/stress/broken_ip/broken_ip-checksum
> +++ testcases/network/stress/broken_ip/broken_ip-checksum
> @@ -10,7 +10,10 @@ TST_TESTFUNC="do_test"

>  do_test()
>  {
> -	tst_res TINFO "Sending ICMPv$TST_IPVER with wrong chksum field for $NS_DURATION sec"
> +	TST_IPV6=
> +	TST_IPVER=4
> +
> +	tst_res TINFO "Sending ICMPv4 with wrong chksum field for $NS_DURATION sec"
>  	tst_icmp -t $NS_DURATION -s "0 100 500 1000 $NS_ICMP_SENDER_DATA_MAXSIZE" -c
>  	tst_ping
>  }

FYI merged commit which implements this.

Kind regards,
Petr
