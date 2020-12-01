From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Dec 2020 19:04:43 +0100
Subject: [LTP] [PATCH v2] net/ip_tests: Return TCONF if driver dummy not
 present
In-Reply-To: <20201201134356.28635-1-kory.maincent@bootlin.com>
References: <20201201134356.28635-1-kory.maincent@bootlin.com>
Message-ID: <X8aFuymYt4Vz+3kC@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory, Alexey,

...
>  	# test #5
> -	ip route show | grep $ip4_addr && ip route del $ip4_addr
> +	[ "$ip4_addr" ] && ip route show | grep $ip4_addr && ip route del $ip4_addr

Added -q to grep and merged.

Thanks for your patch!
Alexey, thanks for review!

Kind regards,
Petr
