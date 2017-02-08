From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Feb 2017 14:32:35 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <f07ab26f-b4b7-fafb-436b-b6c21f266557@redhat.com>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
 <20170207153352.GB3595@rei.suse.cz>
 <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
 <20170207173028.GC3595@rei.suse.cz>
 <f07ab26f-b4b7-fafb-436b-b6c21f266557@redhat.com>
Message-ID: <20170208133235.GB16139@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The probability of a failure, given that the distribution is random,
> > would be:
> > 
> > 256 * {N \choose max} / (256 ^ max)
> > 
> <snip>
> 
> If you're interested in that level of randomness verification (although
> I would suggest splitting it from the getrandom syscall, so it could
> test ie. /dev/urandom output as well as both should be internally the
> same), take a look at rng-tools implementation of some of FIPS-140 at
> 
> http://gkernel.cvs.sourceforge.net/viewvc/gkernel/rng-tools/
> 
> (fips.c / rngtest.c)
> 
> This would AFAIK cover most catastrophic failures of HW RNGs, although
> on Linux, you're really testing just the CSPRNG,
> http://lxr.free-electrons.com/source/drivers/char/random.c

All I strive for for the getrandom test is to have some reasonable
verification that the buffer was filled with something that looks at
least a bit like random data, so that we rule out cases where the buffer
was only partially filled or not filled in at all. The hard part is
where to draw the line between the complexity of the check and
probability of a failure...

Adding real entropy tests to LTP sounds like a good excercise though,
maybe I will have a look into that later :-).

-- 
Cyril Hrubis
chrubis@suse.cz
