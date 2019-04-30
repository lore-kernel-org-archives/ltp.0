From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 30 Apr 2019 18:42:40 +0300
Subject: [LTP] [PATCH 1/1] net/broken_ip: Rewrite into new API
In-Reply-To: <20190427053929.7372-1-pvorel@suse.cz>
References: <20190427053929.7372-1-pvorel@suse.cz>
Message-ID: <5cff91e0-c566-27c3-95dd-39dd4e2b6d0e@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 27.04.2019 08:39, Petr Vorel wrote:
> Remove IP version from filename as files are for both IPv4 and IPv6
> (although not all are used for both versions).
> 
> + Add packet related variables to tst_net.sh ($ICMPV{4,6,}_DATA_MAXSIZE)
> and use it.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>

...
> @@ -59,6 +59,14 @@ tst_net_setup()
>  {
>  	tst_net_remote_tmpdir
>  	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
> +
> +	if [ -z "$ICMP_DATA_MAXSIZE" ]; then
> +		if [ "$TST_IPV6" ]; then
> +			ICMP_DATA_MAXSIZE="$ICMPV6_DATA_MAXSIZE"
> +		else
> +			ICMP_DATA_MAXSIZE="$ICMPV4_DATA_MAXSIZE"
> +		fi
> +	fi
>  }
>  
>  [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> @@ -820,6 +828,9 @@ export TST_NET_MAX_PKT="${TST_NET_MAX_PKT:-$(tst_default_max_pkt)}"
>  export LHOST_HWADDRS="${LHOST_HWADDRS:-$(tst_get_hwaddrs lhost)}"
>  export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
>  
> +export ICMPV4_DATA_MAXSIZE=1472
> +export ICMPV6_DATA_MAXSIZE=1452

Since these variables are in the library, may be it would be better to tune
them depending on an MTU of the tests interfaces?

Also we can send more with fragmentation, but I guess ns-icmpv doesn't
have proper support...
