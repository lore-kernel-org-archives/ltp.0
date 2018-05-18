From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 18 May 2018 12:36:08 +0300
Subject: [LTP] [PATCH 1/2] network/route: Rewrite route-change-dst into
	new API
In-Reply-To: <20180517103527.23542-1-pvorel@suse.cz>
References: <20180517103527.23542-1-pvorel@suse.cz>
Message-ID: <f566c2ba-5a7e-2fe7-e92f-1da4459e18c5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17.05.2018 13:35, Petr Vorel wrote:
> Drop route command (use just ip command), simplify
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

...

> +
> +	tst_res TINFO "change IPv$ipver route destination $NS_TIMES times"
> +
> +	while [ $cnt -le $NS_TIMES ]; do
> +		new_rt="$(tst_ipaddr_un $cnt)/$mask"
> +		addr="$(tst_ipaddr_un $cnt 1)"
> +
> +		ROD ip route add $new_rt dev $iface
> +		ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface
> +
> +		# Load the route with one UDP datagram
> +		ROD ns-udpsender -f $ipver -D $addr -p $cnt -o -s $udp_size

'-p' parameter should be in range from 1 to 65535, $cnt can exceed that.

It would be good to print some intermediate result message inside
the loop to show the current progress.
