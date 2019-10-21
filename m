From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 21 Oct 2019 16:17:56 +0200
Subject: [LTP] [PATCH v4 2/5] tst_test.c: Add tst_multiply_timeout()
In-Reply-To: <20191021125053.GA18513@x230>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-3-cfamullaconrad@suse.de>
 <20191021125053.GA18513@x230>
Message-ID: <1571667476.4633.13.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-10-21 at 14:50 +0200, Petr Vorel wrote:

> +	if (timeout < 1)
> > +		tst_brk(TBROK, "timeout need to be >= 1! (%d)",
> > timeout);
> 
> need => needs, but better to use must (to be consistent with the
> previous one:
> 		tst_brk(TBROK, "timeout must to be >= 1! (%d)",
> timeout);

agree

> I also wonder, if this check is needed, next step is
> results->timeout = tst_multiply_timeout(timeout);
> which does the same check.

In shell we have the same check. And there it is more clear, as we
refer to TST_TIMEOUT variable. Here both messages just say "timeout"
but the linenumber would be more close to the actual call.

kind regards
Clemens
