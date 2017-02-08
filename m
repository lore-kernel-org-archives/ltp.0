From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Feb 2017 14:14:52 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <20170207173028.GC3595@rei.suse.cz>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
 <20170207153352.GB3595@rei.suse.cz>
 <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
 <20170207173028.GC3595@rei.suse.cz>
Message-ID: <9fd2359c-ab9e-8f3d-3022-30ad6a430380@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/07/2017 06:30 PM, Cyril Hrubis wrote:
> Hi!
>>> This wouldn't for instance when the random output is filled with
>>> non-zero constant bytes...
>>>
>>> What about just fixing the max value to something as:
>>>
>>> max = 3 + nb * 0.2;
>>>
>>> The constat part should handle cases with small buffer and a few
>>> repeating characters while for larger buffer it's neglectible.
>>
>> In that case we may as well skip the check for small buffers.
> 
> The probability of a failure, given that the distribution is random,
> would be:
> 
> 256 * {N \choose max} / (256 ^ max)
> 
> Since you choose one of the possible 256 byte values, then you have N
> tries to hit the value, so you choose all possible combinations, each of
> them has probability 1/(256 ^ max).
> 
> I've tried to visualize the data with gnuplot and it looks like the
> minimal reasonable constant part of the equation is 4, with anything
> less we got probability of a failure in terms of percents. Bumping it to
> 4 the maximal probality for a failure is around 10^-5.
> 
> With max = 6 + N * 0.2 the maximal probability of a failure for a buffer
> of a size around 10 is about 10^-13. So I would say that something like
> this is pretty much safe. This also skips buffers smaller than 7 by
> default. Or we may get even safer with something as max = 10 * N * 0.1
> which has maximal failure probability about 10^-19 and skips buffers up
> to size of a 11.
> 
> Try for youself:
> 
> gnuplot> comb(n,k) = gamma(n+1)/(gamma(k+1) * gamma(n - k + 1))
> gnuplot> plot [6:30] 256 * comb(x, int(6 + x * 0.2)) / (256 ** int(6 + x * 0.2))

This does not look correct to me. Try it with old formula, it goes above 1:
gnuplot> comb(n,k) = gamma(n+1)/(gamma(k+1) * gamma(n - k + 1))
gnuplot> plot [6:30] 256 * comb(x, int(x * 0.1)) / (256 ** int(x * 0.1))

---

With old formula, for N<20 (and max=1), this is pretty much birthday
problem [1] with smaller pool - we don't have 365 days, we have 256 bytes.

With birthday problem you get 50% chance of having 2 people with same
birthday if number of people is 23. Since we have smaller pool, I'd expect
we reach 50% chance sooner.

With N>=20, max increases and it gets a lot more complicated. Best advice
I've found online was to use Poisson approximation [2].

Based on that (see attached python snippet) I'm getting that:
"x*0.1" is quite bad, specially for N=19
"6+x*0.2" is a lot better, with chance ~10^-16

I'll send v2, with "6+x*0.2".

Regards,
Jan

[1] https://en.wikipedia.org/wiki/Birthday_problem
[2] http://math.stackexchange.com/questions/25876/probability-of-3-people-in-a-room-of-30-having-the-same-birthday

-------------- next part --------------
A non-text attachment was scrubbed...
Name: birthday_problem.py
Type: text/x-python
Size: 650 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170208/b3ca6ad4/attachment.py>
