From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Oct 2019 09:46:44 +0200
Subject: [LTP] [PATCH v3 1/4] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <1571314999.4128.3.camel@suse.de>
References: <1571225126.8494.1.camel@suse.de>
 <20191016161519.11256-1-cfamullaconrad@suse.de>
 <20191017083935.GA21011@dell5510> <1571314999.4128.3.camel@suse.de>
Message-ID: <20191018074643.GA4755@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

> > Variable variable is possible to do portable way with eval.
> > eval timeout=\$$1

> Ok, I will take bashisms into acount. Thx for pointing me to that
> script.
Thanks!

> > Passing timeout variable name and optionally timeout value works and
> > allows
> > TBROK messages not to be mangled/hidden (which would be if function
> > echo the
> > result, which is then read the usual way:
> > timeout=$(tst_multiply_timeout 100) ),
> > but I'm not sure if all this is worth of just error handling.
> > Having 2x eval, $2 optionally used (but only in tests) makes code a
> > bit complex.

> In the end, I never called the function with the optional second
> parameter. So we could remove it and with it, the first eval.
> Would you be ok with just one eval ?

> > How about just simply save the result into global variable
> > $TST_TIMEOUT?

> Will not work, as this function is also used in
> TST_RETRY_FN_EXP_BACKOFF() where we do not use TST_TIMEOUT.
OK.

Previously I was thinking to echo result or error message and handle error
outside, depending on return value:

	timeout_or_error=$(tst_multiply_timeout 100) || tst_brk TBROK "$timeout_or_error"

but that's not nice solution either.

Your solution (with removed second parameter) is ok, it just looks unusual for
me (passing variable name to be changed, something like "shell way of passing a
pointer" is not really common), but as I don't see any other solution, I'm ok
with that. But I'd like to get somebody else opinion, maybe we just don't see
other obvious solution.

Kind regards,
Petr
