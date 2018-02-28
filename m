From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Feb 2018 13:04:07 +0100
Subject: [LTP] [RFC PATCH 1/2] lib: TCONF on ESOCKTNOSUPPORT and
 EPROTONOSUPPORT in SAFE_SOCKET()
In-Reply-To: <20180227180044.21867-2-pvorel@suse.cz>
References: <20180227180044.21867-1-pvorel@suse.cz>
 <20180227180044.21867-2-pvorel@suse.cz>
Message-ID: <20180228120406.GA19317@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	if (rval < 0)
> +		tst_brkm((errno == EPROTONOSUPPORT || errno == ESOCKTNOSUPPORT ? TCONF : TBROK)
> +				 | TERRNO, cleanup_fn, "%s:%d: socket(%d, %d, %d) failed",
> +				 file, lineno, domain, type, protocol);

This is kind of ugly code, can we please write it more readable?

-- 
Cyril Hrubis
chrubis@suse.cz
