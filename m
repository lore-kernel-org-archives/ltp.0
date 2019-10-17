From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Thu, 17 Oct 2019 14:23:19 +0200
Subject: [LTP] [PATCH v3 1/4] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
In-Reply-To: <20191017083935.GA21011@dell5510>
References: <1571225126.8494.1.camel@suse.de>
 <20191016161519.11256-1-cfamullaconrad@suse.de>
 <20191017083935.GA21011@dell5510>
Message-ID: <1571314999.4128.3.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 2019-10-17 at 10:39 +0200, Petr Vorel wrote:
> Hi Clemens,
> 
> ...
> > -_tst_setup_timer()
> > +tst_multiply_timeout()
> 
> Private function, it should have underscore prefix.
> >  {
> > -	TST_TIMEOUT=${TST_TIMEOUT:-300}
> > -	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
> > +	# first parameter is used as return value
> > +	local timeout="${!1}"
> 
> Bashism, this will not work on dash, busybox shell ('busybox sh'),
> etc.
> 
> checkbashisms.pl is your friend :).
> https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkba
> shisms.pl
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guideline
> s#132-shell-coding-style
> 
> Variable variable is possible to do portable way with eval.
> eval timeout=\$$1

Ok, I will take bashisms into acount. Thx for pointing me to that
script.

> 
> > +	[ $# -gt 1 ] && timeout="$2"
> > -	if [ "$TST_TIMEOUT" = -1 ]; then
> > -		tst_res TINFO "Timeout per run is disabled"
> > -		return
> > -	fi
> > +	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
> >  	local err="LTP_TIMEOUT_MUL must be number >= 1!"
> > @@ -396,13 +395,29 @@ _tst_setup_timer()
> >  		LTP_TIMEOUT_MUL=$((LTP_TIMEOUT_MUL+1))
> >  		tst_res TINFO "ceiling LTP_TIMEOUT_MUL to
> > $LTP_TIMEOUT_MUL"
> >  	fi
> > +
> >  	[ "$LTP_TIMEOUT_MUL" -ge 1 ] || tst_brk TBROK "$err
> > ($LTP_TIMEOUT_MUL)"
> > +	[ "$timeout" -ge 1 ] || tst_brk TBROK "timeout need to be
> > >= 1 ($timeout)"
> > +
> > +	eval "$1='$(( timeout * LTP_TIMEOUT_MUL))'"
> 
> Eval on input, eval on output :).
> 
> > +	return 0
> 
> You don't use return value anywhere. + There is no return 1.
> > +}
> 
> Passing timeout variable name and optionally timeout value works and
> allows
> TBROK messages not to be mangled/hidden (which would be if function
> echo the
> result, which is then read the usual way:
> timeout=$(tst_multiply_timeout 100) ),
> but I'm not sure if all this is worth of just error handling.
> Having 2x eval, $2 optionally used (but only in tests) makes code a
> bit complex.

In the end, I never called the function with the optional second
parameter. So we could remove it and with it, the first eval.
Would you be ok with just one eval ?

> How about just simply save the result into global variable
> $TST_TIMEOUT?

Will not work, as this function is also used in
TST_RETRY_FN_EXP_BACKOFF() where we do not use TST_TIMEOUT.

thanks
Clemens
