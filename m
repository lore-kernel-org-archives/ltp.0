From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 May 2017 07:45:33 +0200
Subject: [LTP] [PATCH] Add terminating NUL after calling readlink()
In-Reply-To: <20170506085206.GA3058@ls3530.fritz.box>
References: <20170506085206.GA3058@ls3530.fritz.box>
Message-ID: <20170509054533.3ec5mwqthklp2fdi@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> readlink() does not append a NUL byte to the target buffer. Fix it in
> the pidns03 and fsstress testcases to avoid wrong test results.

<snip>
>  	rval = readlink(name->path, lbuf, lbufsiz);
> +	if (rval >= 0)
> +		lbuf[rval] = 0; /* add terminating NUL */
How about using '\0' and leave the comment?


Kind regards,
Petr
