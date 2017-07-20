From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 17:01:44 +0200
Subject: [LTP] [PATCH v2 1/3] lib: Add personality fallback and SAFE
	macro
In-Reply-To: <87y3rjp4c5.fsf@our.domain.is.not.set>
References: <20170719090831.2326-1-rpalethorpe@suse.com>
 <87y3rjp4c5.fsf@our.domain.is.not.set>
Message-ID: <20170720150144.GD11392@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#include "config.h"
> > +
> > +#if defined(HAVE_SYS_PERSONALITY_H)
> > +#include <sys/personality.h>
> > +#elif defined(HAVE_LINUX_PERSONALITY_H)
> > +#include <linux/personality.h>
> > +#endif
> > +
> > +#ifndef HAVE_SYS_PERSONALITY_H
> > +#include "linux_syscall_numbers.h"
> > +
> > +static int personality(unsigned long persona)
> > +{
> > +	return tst_syscall(__NR_personality, persona);
> > +}
> > +#endif
> > +
> 
> Oops, linux_syscall_numbers.h is not available to the LTP library. I am
> wondering if we can just add it to the include path?

I was wondering the same. But we would have to tweek the build
system.

See include/mk/testcases.mk that makes every test depend on the header.

We also have special rule to make lib/ first if we start the build from
the top level Makefile.

And lastly but not least recenlty we started to run the regen.sh script
from the configure script to avoid races on parallel build.

If code in lib/ makes use of that header we have to make sure that the
header is create before we start building the lib.

And given that the header is not removed on make clean we may as well
remove all the dependencies from makefiles and depend on configure
script to create it. And possibly move the whole thing somewhere into
include/lapi/ so that we can drop one of the -I directives and maybe
rename the hader to something shorther, maybe lapi/syscalls.h or
something.

-- 
Cyril Hrubis
chrubis@suse.cz
