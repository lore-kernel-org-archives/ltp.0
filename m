From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 26 Jul 2019 20:50:04 +0200
Subject: [LTP] [PATCH] syscalls/mprotect04: Fix compilation error for
 ia64
In-Reply-To: <20190726124752.GB28028@rei.lan>
References: <20190726092110.13116-1-pvorel@suse.cz>
 <1968200096.2791881.1564143777013.JavaMail.zimbra@redhat.com>
 <20190726122830.GA4254@dell5510> <20190726124752.GB28028@rei.lan>
Message-ID: <20190726185004.GA12472@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > > Thanks, I missed the ia64-specific code. RHEL dropped support for
> > > ia64 in RHEL6, and RHEL5 will likely be EOL in ~6 months, so I'm
> > > fine either way.
> > Thanks for a quick reply. So it's up to Cyril, whether keep the
> > support or not.

> Hmm, the last processors were made in 2017 but looking at TOP500 systems
> there was peek for itanim in 2004 and there were pretty nonexistent
> since 2012. Given that officially supported distros are going EOL soon
> enough I do not think that it makes sense to keep itanium specific code
> just so that 0.1% of our tests works on these processors.
Agree. OK, I'll remove ia64 specific code.


Kind regards,
Petr
