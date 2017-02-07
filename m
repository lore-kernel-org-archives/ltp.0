From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Feb 2017 18:30:28 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
 <20170207153352.GB3595@rei.suse.cz>
 <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
Message-ID: <20170207173028.GC3595@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This wouldn't for instance when the random output is filled with
> > non-zero constant bytes...
> > 
> > What about just fixing the max value to something as:
> > 
> > max = 3 + nb * 0.2;
> > 
> > The constat part should handle cases with small buffer and a few
> > repeating characters while for larger buffer it's neglectible.
> 
> In that case we may as well skip the check for small buffers.

The probability of a failure, given that the distribution is random,
would be:

256 * {N \choose max} / (256 ^ max)

Since you choose one of the possible 256 byte values, then you have N
tries to hit the value, so you choose all possible combinations, each of
them has probability 1/(256 ^ max).

I've tried to visualize the data with gnuplot and it looks like the
minimal reasonable constant part of the equation is 4, with anything
less we got probability of a failure in terms of percents. Bumping it to
4 the maximal probality for a failure is around 10^-5.

With max = 6 + N * 0.2 the maximal probability of a failure for a buffer
of a size around 10 is about 10^-13. So I would say that something like
this is pretty much safe. This also skips buffers smaller than 7 by
default. Or we may get even safer with something as max = 10 * N * 0.1
which has maximal failure probability about 10^-19 and skips buffers up
to size of a 11.

Try for youself:

gnuplot> comb(n,k) = gamma(n+1)/(gamma(k+1) * gamma(n - k + 1))
gnuplot> plot [6:30] 256 * comb(x, int(6 + x * 0.2)) / (256 ** int(6 + x * 0.2))

Note that we got series of spikes where each one is much smaller than
the previous one (this is because the max is not continous and "hops"
every time the x * 0.2 is integer number.

-- 
Cyril Hrubis
chrubis@suse.cz
