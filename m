From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Feb 2017 15:08:55 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <9fd2359c-ab9e-8f3d-3022-30ad6a430380@redhat.com>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
 <20170207153352.GB3595@rei.suse.cz>
 <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
 <20170207173028.GC3595@rei.suse.cz>
 <9fd2359c-ab9e-8f3d-3022-30ad6a430380@redhat.com>
Message-ID: <20170208140855.GC16139@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > gnuplot> comb(n,k) = gamma(n+1)/(gamma(k+1) * gamma(n - k + 1))
> > gnuplot> plot [6:30] 256 * comb(x, int(6 + x * 0.2)) / (256 ** int(6 + x * 0.2))
> 
> This does not look correct to me. Try it with old formula, it goes above 1:
> gnuplot> comb(n,k) = gamma(n+1)/(gamma(k+1) * gamma(n - k + 1))
> gnuplot> plot [6:30] 256 * comb(x, int(x * 0.1)) / (256 ** int(x * 0.1))

You are right, this would be for if we fail the test test when
table[i] >= max, which would fail with 100% probability for most of the smaller
buffers, hence we get results that does not make much sense. We have to
add 1 to the int(x * 0.1) in the formula.

Try plotting this:

plot [10:60] 256 * comb(x, int(x * 0.1) + 1) / (256 ** (int(x * 0.1) + 1))

which pretty much shows the same you are saying for N=19 the old formula
has about 70% chance of failing. Well your script with poisson
aproximation gets close to 50% but the order of magnitude seems to be
the same for both formulae.

> ---
> 
> With old formula, for N<20 (and max=1), this is pretty much birthday
> problem [1] with smaller pool - we don't have 365 days, we have 256 bytes.
> 
> With birthday problem you get 50% chance of having 2 people with same
> birthday if number of people is 23. Since we have smaller pool, I'd expect
> we reach 50% chance sooner.
> 
> With N>=20, max increases and it gets a lot more complicated. Best advice
> I've found online was to use Poisson approximation [2].
> 
> Based on that (see attached python snippet) I'm getting that:
> "x*0.1" is quite bad, specially for N=19
> "6+x*0.2" is a lot better, with chance ~10^-16

I'm getting the same with the fixed formula in gnuplot:

plot [10:60] 256 * comb(x, int(6 + x * 0.2) + 1) / (256 ** (int(6 + x * 0.2) + 1))

This shows a peak for 15 which is about ~10^-16.

> I'll send v2, with "6+x*0.2".

Agreed.

-- 
Cyril Hrubis
chrubis@suse.cz
