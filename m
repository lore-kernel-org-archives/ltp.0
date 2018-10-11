From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Oct 2018 00:15:24 +0200
Subject: [LTP] [PATCH 1/4] net/dhcp: Use paths allowed by AppArmor for
	dnsmasq
In-Reply-To: <20181011220525.24628-2-pvorel@suse.cz>
References: <20181011220525.24628-1-pvorel@suse.cz>
 <20181011220525.24628-2-pvorel@suse.cz>
Message-ID: <20181011221524.GA26301@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Fixes for --log-facility and --dhcp-leasefile.

> Path for log file expects AppArmor commit
> 025c7dc6 ("dnsmasq: Add permission to open log files").

> NOTE: AppArmor optimization isn't needed for dhcpd.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
...
> Changing path to /var/log require root, but we run most of network tests
> under root anyway, at least for network  namespaces.
> I didn't add TST_NEEDS_ROOT=1, maybe I should.

...
> +++ b/testcases/network/dhcp/dnsmasq_tests.sh
...


> +log="/var/log/tst_dnsmasq.log"
Another option (instead of writing int /var/log/) is to detect enabled AppArmor
and /etc/apparmor.d/local/.  If enabled and dir exist, then append/create
/etc/apparmor.d/local/usr.sbin.dnsmasq with write permissions to our directory.
But this would require restart AppArmor.

> +
>  common_opt="--no-hosts --no-resolv --dhcp-authoritative \
> -	--log-facility=./tst_dnsmasq.log --interface=$iface0 \
> -	--dhcp-leasefile=tst_dnsmasq.lease --port=0 --conf-file= "
> +	--log-facility=$log --interface=$iface0 \
> +	--dhcp-leasefile=/var/lib/misc/dnsmasq.tst.leases --port=0 --conf-file= "


Kind regards,
Petr
