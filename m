From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jan 2020 19:31:09 +0100
Subject: [LTP] [PATCH 2/2] rpc01.sh: Rewrite into new shell API
In-Reply-To: <20200128160735.26241-2-pvorel@suse.cz>
References: <20200128160735.26241-1-pvorel@suse.cz>
 <20200128160735.26241-2-pvorel@suse.cz>
Message-ID: <20200128183109.GA7356@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> +++ b/testcases/network/rpc/basic_tests/rpc_lib.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> +
> +. tst_net.sh
> +
> +check_portmap_rpcbind()
> +{
> +	tst_res TINFO "Checking for portmap or rpcbind"
> +
> +	if pgrep portmap > /dev/null; then
> +		PORTMAPPER="portmap"
> +	else
> +		pgrep rpcbind > /dev/null && PORTMAPPER="rpcbind" || \
> +			tst_brk TCONF "portmap or rpcbind is not running"
> +	fi
> +}
Actually I'd just switch the order of the check (rpcbind has replaced portmap)
and print what is used.

Kind regards,
Petr
