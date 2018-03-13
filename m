From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Mar 2018 13:27:29 +0100
Subject: [LTP] [PATCH v6 2/3] Add a library wrapper for sigaction()
In-Reply-To: <20180309124418.30271-3-mmoese@suse.de>
References: <20180309124418.30271-1-mmoese@suse.de>
 <20180309124418.30271-3-mmoese@suse.de>
Message-ID: <20180313122729.GB19715@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static inline int safe_sigaction(const char *file, const int lineno,
> +				 int signum, const struct sigaction *act,
> +				 struct sigaction *oldact)
> +{
> +	int rval;
> +
> +	rval = sigaction(signum, act, oldact);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"sigaction(%d, %p, %p) failed", signum, act, oldact);
                                   ^
				   I've added tst_strsig() here as well
				   to get better error messages.

And I had to move the function the C source to avoid tst_strsig()
redefinition warnings...

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
