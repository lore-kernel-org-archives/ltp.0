From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 24 Oct 2019 03:12:04 -0400 (EDT)
Subject: [LTP] [PATCH] lsmod01.sh: retry test couple times to lower
 false positives
In-Reply-To: <20191023182845.GA2863@x230>
References: <c8843f2f4a325e820d030d9c7c36d7624f1baa82.1571393044.git.jstancek@redhat.com>
 <20191023121901.GA25868@dell5510>
 <463301336.8732968.1571837306503.JavaMail.zimbra@redhat.com>
 <20191023182845.GA2863@x230>
Message-ID: <1035796293.8861381.1571901124690.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan,
> 
> > > > -	tst_res TPASS "'lsmod' passed."
> > > > +lsmod_test()
> > > > +{
> > > > +	for i in $(seq 1 5); do
> > > > +		if lsmod_matches_proc_modules; then
> > > > +			tst_res TPASS "'lsmod' passed."
> > > > +			return
> > > > +		fi
> > > > +		tst_res TINFO "Trying again"
> > > > +		sleep 1
> > > > +	done
> > > This is similar pattern to TST_RETRY_FUNC()/TST_RETRY_FN_EXP_BACKOFF()
> > > (for both shell and C). I wonder if we also have use for TPASS/TFAIL
> > > instead of just TBROK and specifying number of tries instead of time to
> > > be
> > > setup.
> 
> > I think TFAIL fits more here, it's outcome of what we are testing.
> > TBROK in my mind is failure unrelated to subject of test.
> I express myself wrong. Sure, I meant to have TPASS/TFAIL,
> just to use some helper function instead of writing the wrapper in the test.
> 
> > But functionally TST_RETRY_FUNC should work too.
> 
> > > C and shell usage is a bit different, so maybe
> > > TST_RETRY_FUNC()/TST_RETRY_FN_EXP_BACKOFF() doesn't make much sense for
> > > shell
> 
> > I see it used in mkswap01.sh and numa01.sh.
> Sorry, I searched just TST_RETRY_FN_EXP_BACKOFF.
> Correct, TST_RETRY_FUNC is used there.
> 
> > I wonder if we need to TBROK in TST_RETRY_FUNC(). We could just return
> > what the FUNC returns and let the test decide.
> > TST_RETRY_FUNC_BRK() could be a wrapper that TBROKs on timeout.
> That could work (apart from the fact it diverges the functionality from C).
> + there could be the third one, which TPASS/TFAIL (instead of nothing/TBROK).
> 
> But this should be based on TST_RETRY_FN_EXP_BACKOFF (TST_RETRY_FUNC is
> reusing
> TST_RETRY_FN_EXP_BACKOFF) + add also TST_RETRY_FUNC wrappers.
> 
> Do we need similar functionality in C?

If we make modifications we should keep it consistent with C.

