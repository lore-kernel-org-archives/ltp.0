From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 11:11:10 +0100
Subject: [LTP] [PATCh v2] clock_gettime04: print more info to help
 debugging
In-Reply-To: <20210310084304.d6b626clzj5rafvh@vireshk-i7>
References: <20210309080028.16284-1-liwang@redhat.com>
 <20210309094525.4ggmppfpvavsvjzl@vireshk-i7>
 <YEdhgvXg/mYkppz6@pevik>
 <20210309115623.ze5c7li7vuf65gvg@vireshk-i7>
 <CAEemH2esvVfy0YeCL2nXgj441XeBY7F+Y8MVEJ31nKRNPvjC+g@mail.gmail.com>
 <20210310084304.d6b626clzj5rafvh@vireshk-i7>
Message-ID: <YEibPvXnSpGceN/e@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Viresh, Cyril,

> On 10-03-21, 16:34, Li Wang wrote:
> > But we can put the printing behind the 'gettimeofday+CLOCK_REALTIME'
> > checking.
> > Just similar to what I did in patch V1, is that your mean, Petr?

> > --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> > +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> > @@ -108,6 +108,9 @@ static void run(unsigned int i)
> >                         if (tv->clock_gettime == my_gettimeofday && clks[i]
> > != CLOCK_REALTIME)
> >                                 continue;

> > +                       if (count == 10000)
> > +                                tst_res(TINFO, "\t- %s", tv->desc);
> > +
> >                         ret = tv->clock_gettime(clks[i], tst_ts_get(&ts));
> >                         if (ret) {
> >                                 /*
> > @@ -139,8 +142,8 @@ static void run(unsigned int i)

> >                         diff = end + slack - start;
> >                         if (diff < 0) {
> > -                               tst_res(TFAIL, "%s: Time travelled
> > backwards (%d): %lld ns",
> > -                                       tst_clock_name(clks[i]), j, diff);
> > +                               tst_res(TFAIL, "%s(%s): Time travelled
> > backwards (%d): %lld ns",
> > +                                       tst_clock_name(clks[i]), tv->desc,
> > j, diff);
> >                                 return;
> >                         }

> I think it would be worth keeping it simple then and just print all
> variants only once from setup(). Leave the special case of REALTIME
> clock.
+1.

From a long term, I'd like some easy solution when printing would be handled in
the library. Some time ago I posted a patch which turned .test_variants from int
into array of string description [1]. Cyril didn't see much value at it and
didn't like that it introduced more ifdefs (together with Viresh).
But now we have docparse, could we reconsider this approach? Maybe we could keep
.test_variants and introduce .test_variants_desc for tests which are simple enough.
Or, maybe there is a cleaner solution for clock_adjtime0* tests which I don't
see.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20200519120725.25750-1-pvorel@suse.cz/
