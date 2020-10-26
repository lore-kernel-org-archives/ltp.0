From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Oct 2020 09:49:39 +0100
Subject: [LTP] [PATCH 4/5] network/virt: add wireguard01
In-Reply-To: <20201015122056.20715-4-alexey.kodanev@oracle.com>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
 <20201015122056.20715-4-alexey.kodanev@oracle.com>
Message-ID: <20201026084939.GE21306@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> * performance tests with TCP traffic

> * invalid configuration with allowed IPs, public key

> * emulation of the lossy link for the underlying interface.

Thanks a lot for supporting wireguard!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +TST_NEEDS_TMPDIR=1
> +TST_NEEDS_CMDS="$TST_NEEDS_CMDS wg"
> +TST_TESTFUNC=${TST_TESTFUNC:-virt_netperf_msg_sizes}
> +TST_SETUP=${TST_SETUP:-wireguard_lib_setup}
> +TST_CLEANUP=${TST_CLEANUP:-wireguard_lib_cleanup}
> +TST_NEEDS_DRIVERS="wireguard"
> +VIRT_PERF_THRESHOLD_MIN=${VIRT_PERF_THRESHOLD_MIN:-200}
> +
> +virt_type="wireguard"
> +. virt_lib.sh
> +
> +# Usage: wireguard_lib_setup [TYPE]
> +# TYPE: [ default | invalid_allowed_ips | invalid_pub_keys ]
> +wireguard_lib_setup()
> +{
> +	local type="${1:-default}"
> +	local pub_key0="$(wg genkey | tee wg0.key | wg pubkey)"
> +	local pub_key1="$(wg genkey | tee wg1.key | wg pubkey)"
> +
> +	local port_loc="$(tst_get_unused_port ipv${TST_IPVER} dgram)"
> +	local port_rmt=$(tst_rhost_run -c "tst_get_unused_port ipv${TST_IPVER} dgram")
> +
> +	# copy private key to remote host
> +	tst_rhost_run -s -c "echo '$(cat wg1.key)' > wg1.key"
> +
> +	tst_res TINFO "setup wireguard UDPv${TST_IPVER} tunnel, port $port_loc/$port_rmt"
> +	tst_res TINFO "lhost[$(tst_ipaddr)] <-> rhost[$(tst_ipaddr rhost)]"
> +
> +	virt_setup
> +
> +	local ka_opt="persistent-keepalive 1"
> +	local allow_ip_loc="${ip_virt_local}/32,${ip6_virt_local}/128"
> +	local allow_ip_rmt="${ip_virt_remote}/32,${ip6_virt_remote}/128"
> +
> +	case $type in
> +	invalid_allowed_ips)
> +		allow_ip_loc="${ip_virt_remote}/32,${ip6_virt_remote}/128"
> +		allow_ip_rmt="${ip_virt_local}/32,${ip6_virt_local}/128"
> +		tst_res TINFO "Allowed IPs are source IPs only"
> +		;;
> +	invalid_pub_keys)
> +		pub_key0="$(wg genkey | wg pubkey)"
> +		tst_res TINFO "Invalid peer public key of lhost"
> +		;;
> +	esac
> +
> +	ROD wg set ltp_v0 listen-port $port_loc private-key wg0.key
> +	ROD wg set ltp_v0 peer $pub_key1 endpoint \
> +		$(tst_ipaddr rhost):$port_rmt $ka_opt \
> +		allowed-ips $allow_ip_rmt
> +
> +	tst_rhost_run -s -c \
> +		"wg set ltp_v0 listen-port $port_rmt private-key wg1.key"
> +	tst_rhost_run -s -c "wg set ltp_v0 peer $pub_key0 \
> +		endpoint $(tst_ipaddr):$port_loc $ka_opt \
> +		allowed-ips $allow_ip_loc"
> +
> +	tst_net_run -s "ip route add 128.0.0.0/1 dev ltp_v0"
Out of curiosity: why is IPv4 enough? (we test also IPv6)

> +}
> +
> +wireguard_lib_cleanup()
> +{
> +	virt_cleanup
> +}

Why not use just virt_cleanup() ?

Kind regards,
Petr
