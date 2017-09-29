From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 30 Sep 2017 01:15:32 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
	SOCKET} macros
In-Reply-To: <20170929231036.32262-1-pvorel@suse.cz>
References: <20170929231036.32262-1-pvorel@suse.cz>
Message-ID: <20170929231532.mrzjj26w5nxrj7q2@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> instead of tst_brk{,m}(TBROK, ...)

> Patch was made thanks to Coccinelle.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
Please ignore second sign.

<snip>

> diff --git a/lib/tst_net.c b/lib/tst_net.c
> index f842e94a6..326b92e6f 100644
> --- a/lib/tst_net.c
> +++ b/lib/tst_net.c
> @@ -25,6 +25,7 @@
>  #include <netinet/in.h>

>  #include "test.h"
> +#include "safe_macros.h"

>  unsigned short tst_get_unused_port(void (cleanup_fn)(void),
>  	unsigned short family, int type)
> @@ -57,16 +58,9 @@ unsigned short tst_get_unused_port(void (cleanup_fn)(void),
>  		return -1;
>  	}

> -	sock = socket(addr->sa_family, type, 0);
> -	if (sock < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn, "socket failed");
> -		return -1;
> -	}
> +	sock = SAFE_SOCKET(cleanup_fn, addr->sa_family, type, 0);

> -	if (bind(sock, addr, slen) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn, "bind failed");
> -		return -1;
> -	}
> +	SAFE_BIND(cleanup_fn, sock, addr, slen);
I suppose tst_brkm(TBROK, ...) always exit testing, so we can have SAFE_* macros even here
in lib.


Kind regards,
Petr
