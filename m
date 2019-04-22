From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Apr 2019 23:21:53 +0200
Subject: [LTP] [PATCH] crypto/af_alg06: new regression test for setting
 malformed authenc key
In-Reply-To: <20190422180123.107038-1-ebiggers@kernel.org>
References: <20190422180123.107038-1-ebiggers@kernel.org>
Message-ID: <20190422212153.GA6945@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric,

> +	tst_res(TINFO,
> +		"Setting malformed authenc key.  May crash buggy kernels.");
> +	TEST(setsockopt(algfd, SOL_ALG, ALG_SET_KEY, &key, sizeof(key)));
While test itself works nicely (crashes 4.20 kernel), there were still some
old distros issues - missing SOL_ALG [1].
Thus pushed with added lapi/socket.h include.

Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/523184489/log.txt

