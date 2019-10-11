From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 10:12:01 +0200
Subject: [LTP] [RFC PATCH v4 2/5] shell: Introduce TST_TIMEOUT variable,
 add checks
In-Reply-To: <20191009143434.GE7561@rei.lan>
References: <20190930145916.20465-1-pvorel@suse.cz>
 <20190930145916.20465-3-pvorel@suse.cz>
 <20191009143434.GE7561@rei.lan>
Message-ID: <20191011081201.GA31207@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > +	if ! tst_is_int "$LTP_TIMEOUT_MUL"; then
> > +		tst_test_cmds cut

> I do not think that it's necessary to check for the presense of the cut
> command.
I wouldn't check for cut in tests, but in library I tend to be careful.
But sure, I'll delete it.

BTW we already check for basic commands in tst_run():
tst_test_cmds cut tr wc
_tst_setup_timer() is called later.
Do you want to drop some of these checks?

> > +		LTP_TIMEOUT_MUL=$(echo "$LTP_TIMEOUT_MUL" | cut -d. -f1)
> > +		LTP_TIMEOUT_MUL=$((LTP_TIMEOUT_MUL+1))
> > +		tst_res TINFO "ceiling LTP_TIMEOUT_MUL to $LTP_TIMEOUT_MUL"
> > +	fi
> > +	[ "$LTP_TIMEOUT_MUL" -ge 1 ] || tst_brk TCONF "$err ($LTP_TIMEOUT_MUL)"
> > +
> > +	if ! tst_is_int "$TST_TIMEOUT" || [ "$TST_TIMEOUT" -lt 1 ]; then
> > +		tst_brk TBROK "TST_TIMEOUT must be int >= 1! ($TST_TIMEOUT)"
> > +	fi
> > +
> > +	local sec
> > +	if [ "$is_float" ]; then
> > +		sec=`echo | awk '{printf("%d\n", '$TST_TIMEOUT' * '$LTP_TIMEOUT_MUL'+ 0.5)}'`
> > +	else
> > +		sec=$((TST_TIMEOUT * LTP_TIMEOUT_MUL))
> > +	fi

> Is this a leftover? Now that LTP_TIMEOUT_MUL has been converted to int
> we can simply do what is done in the else branch.
Yes, thanks for catching this.

Kind regards,
Petr
