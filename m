From: Jiri Jaburek <jjaburek@redhat.com>
Date: Wed, 8 Feb 2017 12:23:55 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <20170207173028.GC3595@rei.suse.cz>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
 <20170207153352.GB3595@rei.suse.cz>
 <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
 <20170207173028.GC3595@rei.suse.cz>
Message-ID: <f07ab26f-b4b7-fafb-436b-b6c21f266557@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/07/17 18:30, Cyril Hrubis wrote:
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
<snip>

If you're interested in that level of randomness verification (although
I would suggest splitting it from the getrandom syscall, so it could
test ie. /dev/urandom output as well as both should be internally the
same), take a look at rng-tools implementation of some of FIPS-140 at

http://gkernel.cvs.sourceforge.net/viewvc/gkernel/rng-tools/

(fips.c / rngtest.c)

This would AFAIK cover most catastrophic failures of HW RNGs, although
on Linux, you're really testing just the CSPRNG,
http://lxr.free-electrons.com/source/drivers/char/random.c

Jiri

