From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Sep 2019 12:46:41 +0200
Subject: [LTP] [PATCH 2/3] shell: Introduce LTP_TIMEOUT variable
In-Reply-To: <61c28ae1-d696-3910-d1c5-07ee5e13c754@arm.com>
References: <20190912201318.30931-1-pvorel@suse.cz>
 <20190912201318.30931-3-pvorel@suse.cz>
 <61c28ae1-d696-3910-d1c5-07ee5e13c754@arm.com>
Message-ID: <20190913104641.GB598@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

<snip>
> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > index ca63745fd..f427cd459 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -379,9 +379,31 @@ _tst_rescmp()

> >  _tst_setup_timer()
> >  {
> > +	TST_TIMEOUT=${TST_TIMEOUT:-300}
> >  	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}

> > -	local sec=$((300 * LTP_TIMEOUT_MUL))
> > +	if [ "$LTP_TIMEOUT_MUL" = -1 ]; then
> > +		tst_res TINFO "Timeout per run is disabled"
> > +		return
> > +	fi
> > +
> > +	local err
> > +	tst_is_num || err=1

> Not sure to understand what's going on here ....tst_is_num needs at least an arg right ?
Good point, it should have been
tst_is_num "$TST_TIMEOUT" || err=1

And I omit to grep TIMEOUT" in tst_run() in tst_test.s.

> > +	if tst_is_int; then
> > +		[ "$LTP_TIMEOUT_MUL" -ge 1 ] || err=1

> ....same for tst_is_int .... and I can see no trace of code handling the new LTP_TIMEOUT
> around this patch...am I missing something ?
Sorry, s/LTP_TIMEOUT/TST_TIMEOUT in docs and tests. Will be in v2.

> Cheers 

> Cristian

Kind regards,
Petr

PS: please snip the unrelated content in long patches like this one
(easier to read in both mail and patchwork).
