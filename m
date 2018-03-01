From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 1 Mar 2018 18:43:21 +0300
Subject: [LTP] [RFC PATCH v2 1/2] lib: TCONF on "not supported" errnos
 in SAFE_SOCKET()
In-Reply-To: <20180301105943.5487-1-pvorel@suse.cz>
References: <20180301105943.5487-1-pvorel@suse.cz>
Message-ID: <de8a2ee4-9f84-601f-17b7-39a1ae76dc08@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/01/2018 01:59 PM, Petr Vorel wrote:
> *NOSUPPORT errnos likely mean there is configuration issue rather than
> test failure.
> 
> e.g. missing dccp module in netstress.c which was sofar set as TBROK:
> safe_net.c:117: BROK: netstress.c:654: socket(10, 6, 33) failed: ESOCKTNOSUPPORT
> 
...
>  
>  	if (rval < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup_fn,
> -			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
> -			 domain, type, protocol);
> +		switch (errno) {
> +		case EPROTONOSUPPORT:
> +		case ESOCKTNOSUPPORT:
> +		case EOPNOTSUPP:
> +		case EPFNOSUPPORT:
> +		case EAFNOSUPPORT:
> +			ttype = TCONF;
> +			break;
> +		default:
> +			ttype = TBROK;
> +		}
> +
> +		tst_brkm(ttype | TERRNO, cleanup_fn, "%s:%d: socket(%d, %d, %d) failed",

Looks like this line is over 80 chars. Otherwise looks good to me.

Thanks,
Alexey
