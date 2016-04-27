From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Apr 2016 11:50:40 +0200
Subject: [LTP] [PATCH v7 1/3] lib/test_net.sh: add tst_ping() to check
 icmp connectivity
In-Reply-To: <1461724170-19580-2-git-send-email-haliu@redhat.com>
References: <1461724170-19580-1-git-send-email-haliu@redhat.com>
 <1461724170-19580-2-git-send-email-haliu@redhat.com>
Message-ID: <20160427095040.GA16528@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +# tst_ping [IFACE] [DST ADDR] [MESSAGE SIZE ARREY]
                                                 ^
						 ARRAY
> +# Check icmp connectivity
> +# IFACE: source interface name
> +# DST ADDR: destination IPv4 or IPv6 address
> +# MESSAGE SIZE ARREY: message size arrey
                  ^                     ^
		  ARRAY                array
> +tst_ping()
> +{
> +	# The max number of ICMP echo request
> +	PING_MAX=${PING_MAX:-"10"}
> +
> +	local src_iface=${1:-"$(tst_iface)"}
> +	local dst_addr=${2:-"$(tst_ipaddr rhost)"}
> +	local msg_sizes=${@:3}
                         ^
			 bashism you should use shift instead

> +	local ret=0
> +
> +	# ping cmd use 56 as default message size
> +	for size in ${msg_sizes:-"56"}; do
> +		ping$TST_IPV6 -I $src_iface -c $PING_MAX $dst_addr \
> +			-s $size > /dev/null 2>&1
> +		ret=$?
> +		if [ $ret -eq 0 ]; then
> +			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size pass"
> +		else
> +			tst_resm TINFO "tst_ping IPv${TST_IPV6:-4} msg_size $size fail"
> +			break
> +		fi
> +	done
> +	return $ret
> +}
> -- 
> 2.5.5
> 

-- 
Cyril Hrubis
chrubis@suse.cz
