From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Oct 2019 20:08:55 +0200
Subject: [LTP] [PATCH v4 2/5] tst_test.c: Add tst_multiply_timeout()
In-Reply-To: <1571671901.4633.17.camel@suse.de>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-3-cfamullaconrad@suse.de>
 <20191021143703.GA27848@rei> <1571671901.4633.17.camel@suse.de>
Message-ID: <20191021180854.GA32537@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On Mon, 2019-10-21 at 16:37 +0200, Cyril Hrubis wrote:
> > Hi!
> > > +	if (timeout_mul == -1) {
> > > +		mul = getenv("LTP_TIMEOUT_MUL");
> > > +		if (mul) {
> > > +			timeout_mul = mul_float = atof(mul);
> > > +			if (timeout_mul != mul_float) {
> > > +				timeout_mul++;
> > > +				tst_res(TINFO, "ceiling
> > > LTP_TIMEOUT_MUL to %d",
> > > +						timeout_mul);
> > > +			}

> > Huh, why are we ceiling the timeout multiplier?
I didn't notice Cyril's comment.
I'm sorry to overlook this. I agree with Cyril to keep float for C.
> Hm, I just understood the discussion about TST_TIMEOUT/LTP_TIMEOUT_MUL
> in that way, that we tried to keep both implementations more or less
> the same.

> So we keep float for LTP_TIMEOUT_MUL in c implementation?
> Maybe a v5 is then needed, pvorel?
Yes please. Can you please document float vs int in LTP_TIMEOUT_MUL
in the last commit.

> thanks
> Clemens


Kind regards,
Petr
