From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Jan 2017 16:52:01 +0300
Subject: [LTP] [PATCH 1/1] network/mc_cmds: fix testing with iproute2 <=
 ss161212
In-Reply-To: <20170118125758.11479-1-pvorel@suse.cz>
References: <20170118125758.11479-1-pvorel@suse.cz>
Message-ID: <ea05d70f-e106-cec1-2537-0ced868056e1@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/18/2017 03:57 PM, Petr Vorel wrote:
> -	ip maddr show $(tst_iface) | grep -q '224.0.0.1' || \
> -		tst_brkm TFAIL "all-host-group for $(tst_iface) not joined"
> +	ip maddr show $(tst_iface) | grep -q '224.0.0.1'
> +	if [ $? -ne 0 ]; then
> +		tst_resm TINFO "ip failed to detect multicast, parsing /proc/net/igmp"

Would be better if we pass 'TWARN' flag here.

> +		grep "$(tst_iface)\s*:" -A 1 /proc/net/igmp | tail -1 |grep -q '\s010000E0\s' || \
> +			tst_brkm TFAIL "all-host-group for $(tst_iface) not joined"

I think it's safe to omit 'tail -1'.

Thanks,
Alexey

