From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jan 2017 16:37:33 +0100
Subject: [LTP] [PATCH] test_net.sh: add tst_wait_ipv6_dad()
In-Reply-To: <1484139234-14043-1-git-send-email-alexey.kodanev@oracle.com>
References: <1484139234-14043-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170124153732.GA31989@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +tst_wait_ipv6_dad()
> +{
> +	local ret=
> +	local i=
> +	local iface_loc=${1:-$(tst_iface)}
> +	local iface_rmt=${2:-$(tst_iface rhost)}
> +
> +	for i in $(seq 1 5); do
> +		ip a sh $iface_loc | grep -q tentative
> +		ret=$?
> +
> +		tst_rhost_run -c "ip a sh $iface_rmt | grep -q tentative"
> +
> +		[ $ret -ne 0 -a $? -ne 0 ] && return
> +
> +		if [ $i -ne 5 ]; then
> +			tst_resm TINFO "wait for IPv6 DAD completion $i/5 sec"
> +			tst_sleep 1s

My only concern here is that sleeping for 1s is too much and will slow
down things more than it should. How long this operation usually takes?
Can we reduce the sleep to 0.1s here and print the TINFO only
if [ $((i % 10)) -eq 0 ] ?


> +			continue
> +		fi
> +
> +		tst_resm TWARN "Interface has tentative IP address(es)"
> +	done
> +}
> +
>  # tst_netload ADDR [FILE] [TYPE] [OPTS]
>  # Run network load test
>  # ADDR: IP address
> -- 
> 1.7.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
