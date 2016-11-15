From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 17:47:14 +0100
Subject: [LTP] [PATCH v5 1/5] safe_macros: add safe_setxattr(),
 safe_lsetxattr() and safe_fsetxattr()
In-Reply-To: <1479212377-12830-2-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1479212377-12830-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1479212377-12830-2-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161115164713.GE24751@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int safe_setxattr(const char *file, const int lineno, const char *path,
> +				  const char *name, const void *value, size_t size, int flags)
         ^
	 This line is over 80 chars. It looks like you have tab lenght
	 set to 4 spaces. You should set it to 8 when you are working on
	 LTP, Linux kernel, etc.

> +{
> +	int rval;
> +
> +	rval = setxattr(path, name, value, size, flags);
> +
> +	if (rval) {
> +		if (errno == ENOTSUP) {
> +			tst_brkm(TCONF, NULL,
> +				 "%s:%d: no xattr support in fs or mounted "
> +				 "without user_xattr option", file, lineno);
> +		}
> +
> +		tst_brkm(TBROK | TERRNO, NULL, "%s:%d: setxattr() failed",
                                                         ^
							 I would have
							 included the
							 name in the
							 message as
							 well, i.e.:

		tst_brkm(TBROK | TERRNO, NULL, "%s:%d" setxattr(%s, ...) failed"
		         file, lineno, name);
> +			     file, lineno);
> +	}
> +
> +	return rval;
> +}

And the same for the rest of the functions.

Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
