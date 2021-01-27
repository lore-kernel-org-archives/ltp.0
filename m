From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 27 Jan 2021 13:13:35 +0100
Subject: [LTP] [PATCH v3 2/7] can: Add can_common.h for vcan device setup
In-Reply-To: <87im7i94iu.fsf@suse.de>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
 <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net>
 <87bldd9t9i.fsf@suse.de> <20210126212855.GC15365@pevik>
 <64f599af-f2a7-901d-06a6-a5ff56a107a2@hartkopp.net>
 <87im7i94iu.fsf@suse.de>
Message-ID: <YBFY7w1vseKSA4Df@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

<snip>
> >>>> IFF_ECHO was included into Linux 2.6.25 together with the CAN
> >>>> subsystem itself.

> >>>> So when you run the tests on Kernels < 2.6.25 you don't have CAN
> >>>> support and don't need IFF_ECHO too.

> >>> Petr, what kernel version and/or distro version did compilation fail on?

> >>> There is a small chance someone might be compiling with old kernel
> >>> headers relative to their kernel. However it is a challenge to compile
> >>> LTP with such an old user land.
> >> No, we don't support 2.6.25 :). I was playing with Buildroot distro
> >> in my spare time.
> >> These embedded toolchains suffer compatibility problems (usually uclibc-ng and
> >> sometimes musl lack the support). This problem was when using sourcery-arm-*.

> > :-/

> >> But this is definitely not a blocker for this patchset. That lapi is not a must,
> >> I can fix it some time later. I usually fix few of these problems before each
> >> LTP release.

> > Ok. No problem. I wasn't aware that e.g. musl or other toolchains
> > select such strange starting points for their include files.

> I wonder Petr, is it still necessary to define IFF_ECHO now only
> <linux/if.h> is included? Or do they somehow symlink linux/if.h ->
> net/if.h?
No.

> Indeed it seems the current version of uclibc-ng doesn't include
> IFF_ECHO in <net/if.h>. OTOH musl does define it.
Yes => please keep that definition in can_common.h (enough here, we don't have
to bother with if.h when we don't have it yet).
And I'll send tonight patch to uclibc-ng.
The more mature musl is the less relevant uclibc-ng is.

Kind regards,
Petr
