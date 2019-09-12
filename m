From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Thu, 12 Sep 2019 11:04:33 +0200
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set
 by user
In-Reply-To: <CAEemH2ch1+asP7OKikqrM4Sea2f2xvVB4JPbUqDkm41cFJ+kdg@mail.gmail.com>
References: <20190829181146.20261-1-pvorel@suse.cz>
 <CAEemH2dzn92GYwiw2tP101wNkYfM30rfL=cmPU+B1iH-8UWoDw@mail.gmail.com>
 <20190830085036.GA27453@dell5510>
 <9e518589-9c98-1513-2c19-bae0268b8a81@arm.com>
 <20190830104609.GA9330@dell5510>
 <CAEemH2ch1+asP7OKikqrM4Sea2f2xvVB4JPbUqDkm41cFJ+kdg@mail.gmail.com>
Message-ID: <1568279073.3621.12.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-09-02 at 10:34 +0800, Li Wang wrote:
> On Fri, Aug 30, 2019 at 6:46 PM Petr Vorel <pvorel@suse.cz> wrote:
> > 
> > Hi Cristian,
> > 
> > > On 30/08/2019 09:50, Petr Vorel wrote:
> > > > Hi Li,
> > > > Good point. Something like this could do it:
> > > > -LTP_TIMEOUT_MUL=7
> > > > +min_timeout=7
> > > > +[ -z "$LTP_TIMEOUT_MUL" -o "$LTP_TIMEOUT_MUL" -lt $min_timeout
> > > > ] && LTP_TIMEOUT_MUL=$min_timeout
> > > > Unless we test only integers:
> > > > +[ is_int "$LTP_TIMEOUT_MUL" -o "$LTP_TIMEOUT_MUL" -lt
> > > > $min_timeout ] && LTP_TIMEOUT_MUL=$min_timeout
> > 
> > 
> > > I would certainly introduce a check on the minimum allowed test-
> > > timeout and just stick to integers.
> > > (is it really needed to worry for float multipliers ?)
> 
> No, I guess the integer division in the shell/C is enough.
> 
> > Not sure, but it'd be good to have it same for C and for shell.
> > Otherwise
> > working variable for C would fail on shell.
> > 
> > > I also wonder if it is worth somehow put this minimum-enforce
> > > mechanism inside the framework itself
> > > instead that hardcoding it in this specific test (unless you
> > > already mean to do it this way...
> > > and I misunderstood)
> > 
> > Yes, I was thinking about it as well.
> > LTP_TIMEOUT_MUL should be reserved for users, tests should use
> > LTP_TIMEOUT_MUL_MIN,
> > check for LTP_TIMEOUT_MUL being higher than LTP_TIMEOUT_MUL_MIN
> > would be in
> > _tst_setup_timer(). Similar mechanism I introduced in 9d6a960d9
> > (VIRT_PERF_THRESHOLD_MIN).
> 
> +1 agree.

I have a general question. What do we try to get with
LTP_TIMEOUT_MUL_MIN? From my perspective, we try to set a minimum
timeout value. Isn't it the value (struct tst_test*)->timeout ?

I'm missing such configuration value for shell. Is there one?

Or do we need to increase timeout in smaller steps and that is why we
need this LTP_TIMEOUT_MUL_MIN?

> 
> > 
> > I wonder if it'd be useful to have some functionality in C
> > (ltp_timeout_mul_min
> > as a struct tst_test, default 1).
> 
> Yes. But seems no need to involve a new field in struct tst_test,
> maybe we could complete that in the function tst_set_timeout(int
> timeout).
> 
> > 
> > > So that, roughly, in the test
> > > LTP_TIMEOUT_MUL_MIN=7
> > > LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-7}
> > > and somewhere in framework test initialization you enforce it
> > > (maybe with a warning for the user when overriding its setup)
> > > [ -z "$LTP_TIMEOUT_MUL" -o "$LTP_TIMEOUT_MUL" -lt
> > > $LTP_TIMEOUT_MUL_MIN ] && LTP_TIMEOUT_MUL=$LTP_TIMEOUT_MUL_MIN
> > 
> > +1. Feel free to send a patch.
> 
> Agree.
> 
> -- 
> Regards,
> Li Wang
> 
