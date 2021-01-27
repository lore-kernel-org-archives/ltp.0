From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Jan 2021 16:07:27 +0100
Subject: [LTP] [PATCH v3 2/7] can: Add can_common.h for vcan device setup
In-Reply-To: <YBFY7w1vseKSA4Df@pevik>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
 <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net>
 <87bldd9t9i.fsf@suse.de> <20210126212855.GC15365@pevik>
 <64f599af-f2a7-901d-06a6-a5ff56a107a2@hartkopp.net>
 <87im7i94iu.fsf@suse.de> <YBFY7w1vseKSA4Df@pevik>
Message-ID: <YBGBr3mBUuX21mtE@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

...
> > I wonder Petr, is it still necessary to define IFF_ECHO now only
> > <linux/if.h> is included? Or do they somehow symlink linux/if.h ->
> > net/if.h?
> No.

> > Indeed it seems the current version of uclibc-ng doesn't include
> > IFF_ECHO in <net/if.h>. OTOH musl does define it.
> Yes => please keep that definition in can_common.h (enough here, we don't have
> to bother with if.h when we don't have it yet).
> And I'll send tonight patch to uclibc-ng.
> The more mature musl is the less relevant uclibc-ng is.

Just for a record, I was wrong. Using <linux/if.h> is enough, no need to
keep definition on can_common.h. Sorry for wasting your time.

I mixed two problems: <linux/if.h> and <net/if.h> conflict (there are more headers
which conflict) [1] and sometimes missing definition on uclibc-ng.

*But* musl defines IFF_ECHO in <net/if.h> as they try to allow people not having
to depend on <linux/*.h>, which is IMHO better than blindly relying on
<linux/*.h> which glibc and uclibc{,-ng} (which follows glibc) does much more
than musl:

$ git grep '^#include <linux/.*\.h>' |wc -l
43 # glibc
37 # uclibc-ng
3 # musl

Kind regards,
Petr

[1] https://sourceware.org/glibc/wiki/Synchronizing_Headers#Known_Pairs_of_Headers_that_Conflict
