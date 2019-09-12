From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Sep 2019 17:34:51 +0800
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set
 by user
In-Reply-To: <1568279073.3621.12.camel@suse.de>
References: <20190829181146.20261-1-pvorel@suse.cz>
 <CAEemH2dzn92GYwiw2tP101wNkYfM30rfL=cmPU+B1iH-8UWoDw@mail.gmail.com>
 <20190830085036.GA27453@dell5510>
 <9e518589-9c98-1513-2c19-bae0268b8a81@arm.com>
 <20190830104609.GA9330@dell5510>
 <CAEemH2ch1+asP7OKikqrM4Sea2f2xvVB4JPbUqDkm41cFJ+kdg@mail.gmail.com>
 <1568279073.3621.12.camel@suse.de>
Message-ID: <CAEemH2cw+O5ZrZyQV5qy7wp6-h1SSinu3ENueRG7Gr--xJCRfA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > > > I also wonder if it is worth somehow put this minimum-enforce
> > > > mechanism inside the framework itself
> > > > instead that hardcoding it in this specific test (unless you
> > > > already mean to do it this way...
> > > > and I misunderstood)
> > >
> > > Yes, I was thinking about it as well.
> > > LTP_TIMEOUT_MUL should be reserved for users, tests should use
> > > LTP_TIMEOUT_MUL_MIN,
> > > check for LTP_TIMEOUT_MUL being higher than LTP_TIMEOUT_MUL_MIN
> > > would be in
> > > _tst_setup_timer(). Similar mechanism I introduced in 9d6a960d9
> > > (VIRT_PERF_THRESHOLD_MIN).
> >
> > +1 agree.
>
> I have a general question. What do we try to get with
> LTP_TIMEOUT_MUL_MIN? From my perspective, we try to set a minimum
> timeout value. Isn't it the value (struct tst_test*)->timeout ?
>

Well, the (struct tst_test*)->timeout is the default minimum value to set a
timeout, but for some test case(e.g memcg_stress_test.sh), they required
time should be higher than the default. So as we discussed in the above
mails, we're planning to introduce a new variable LTP_TIMEOUT_MUL_MIN to
set as a new minimum value for test timeout. The operation will be
encapsulate in function  _tst_setup_timer().



>
> I'm missing such configuration value for shell. Is there one?
>

No, we don't have it so far.


>
> Or do we need to increase timeout in smaller steps and that is why we
> need this LTP_TIMEOUT_MUL_MIN?
>

Hmm, what we want to do is:

If a testcase needs timeout value is larger than the default (300 sec), we
could only define a variable LTP_TIMEOUT_MUL_MIN in the test, then the
_tst_setup_timer() will detect if LTP_TIMEOUT_MUL_MIN is valid and reset
the minimum time for the test.

@Petr and @Cristian, If I misunderstand anything, please correct me.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190912/37dfd516/attachment.htm>
