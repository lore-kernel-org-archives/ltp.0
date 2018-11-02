From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 2 Nov 2018 23:37:36 +0100
Subject: [LTP] [PATCH 2/2] net/ipsec: Add check for xfrm_user
In-Reply-To: <20181102221454.5056-2-pvorel@suse.cz>
References: <20181102221454.5056-1-pvorel@suse.cz>
 <20181102221454.5056-2-pvorel@suse.cz>
Message-ID: <20181102223736.GA7615@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> which is required by ip xfrm command.
> As ipsec_lib.sh is used for other commands than it,
> check it only when used. Call in cleanup function could trigger infinite
> loop, therefore check only once.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
...
> +tst_ipsec_check_driver()
> +{
> +	if [ -z "$ipsec_driver_checked" ]; then
> +		export ipsec_driver_checked=1
> +		tst_net_driver "xfrm_user"
> +	fi
I know that all *_ipsec_vti.sh are affected, but I think it's better to be universal.


And maybe ip xfrm calls in tst_init_iface() (in tst_net.sh) should have stderr redirected:

$ udp_ipsec_vti.sh -p comp -m tunnel -s 1500
udp_ipsec_vti 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
Cannot open netlink socket: Protocol not supported
udp_ipsec_vti 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
Cannot open netlink socket: Protocol not supported
# tst_net_iface_prefix.c:145: INFO: prefix and interface not found for '10.0.0.2'.

# tst_net_iface_prefix.c:145: INFO: prefix and interface not found for 'fd00:1:1:1::2'.

udp_ipsec_vti 1 TINFO: Network config (local -- remote):
udp_ipsec_vti 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
udp_ipsec_vti 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
udp_ipsec_vti 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
udp_ipsec_vti 1 TINFO: Test vti + IPsec[comp/tunnel]
udp_ipsec_vti 1 TCONF: xfrm_user driver not available
Cannot open netlink socket: Protocol not supported
Cannot open netlink socket: Protocol not supported
Cannot open netlink socket: Protocol not supported


Kind regards,
Petr
