From: Zorro Lang <zlang@redhat.com>
Date: Fri, 29 Nov 2019 11:48:02 +0800
Subject: [LTP] [PATCH] syscalls/newmount: new test case for new mount API
In-Reply-To: <20191128191442.GB5202@dell5510>
References: <20191128173532.6468-1-zlang@redhat.com>
 <20191128191442.GB5202@dell5510>
Message-ID: <20191129034802.GE4601@dhcp-12-102.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 28, 2019 at 08:14:42PM +0100, Petr Vorel wrote:
> Hi Zorro,
> 
> > Linux supports new mount syscalls from 5.2, so add new test cases
> > to cover these new API. This newmount01 case make sure new API -
> > fsopen(), fsconfig(), fsmount() and move_mount() can mount a
> > filesystem, then can be unmounted.
> Thanks for writing test for recently added kernel functionality.
> This is important.
> Test itself looks ok to me.
> There are few code style differences (note below), but that's not important.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> BTW I thought it'd be nice to use more filesystems via .all_filesystems = 1 [1]
> but at least it breaks nfs. And IMHO we don't have blacklist support for
> .all_filesystems.

I(or with my colleagues) would like to add more filesystem specified test later,
to make sure filesystem specified mount options still works well with new mount
syscalls.

> 
> >  configure.ac                                  |   4 +
> >  include/lapi/newmount.h                       | 106 +++++++++++++
> >  include/lapi/syscalls/aarch64.in              |   4 +
> >  include/lapi/syscalls/powerpc64.in            |   4 +
> >  include/lapi/syscalls/s390x.in                |   4 +
> >  include/lapi/syscalls/x86_64.in               |   4 +
> In final version we'd want to add syscall numbers for all archs.

Yeah, I tried to find a .in file for all archs, but didn't find, so had to
add these __NR_ definition separately.

> 
> ...
> > +++ b/include/lapi/newmount.h
> > @@ -0,0 +1,106 @@
> > +/*
> > + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it would be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write the Free Software Foundation,
> > + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > + */
> Use SPDX license identifier instead of verbose GPL everywhere (including headers
> and makefiles; we don't want any HISTORY: text, but feel free to add Author:
> your name).

Wow, sorry I don't learn about the license things so much, just copy from other file:)
I'll search how to use the SPDX license.

> > +
> > +#ifndef __NEWMOUNT_H__
> > +#define __NEWMOUNT_H__
> Double underscore at the beginning and end (__FOO_H__) is IMHO reserved for library
> (use NEWMOUNT_H__).

Sure, I'll change it to a proper one.

> ...
> 
> > diff --git a/m4/ltp-fsconfig.m4 b/m4/ltp-fsconfig.m4
> > new file mode 100644
> > index 000000000..397027f1b
> > --- /dev/null
> > +++ b/m4/ltp-fsconfig.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_FSCONFIG],[
> > +AC_CHECK_FUNCS(fsconfig,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> > diff --git a/m4/ltp-fsmount.m4 b/m4/ltp-fsmount.m4
> > new file mode 100644
> > index 000000000..ee32ef713
> > --- /dev/null
> > +++ b/m4/ltp-fsmount.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_FSMOUNT],[
> > +AC_CHECK_FUNCS(fsmount,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> > diff --git a/m4/ltp-fsopen.m4 b/m4/ltp-fsopen.m4
> > new file mode 100644
> > index 000000000..6e23d437d
> > --- /dev/null
> > +++ b/m4/ltp-fsopen.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_FSOPEN],[
> > +AC_CHECK_FUNCS(fsopen,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> > diff --git a/m4/ltp-move_mount.m4 b/m4/ltp-move_mount.m4
> > new file mode 100644
> > index 000000000..d6bfd82e9
> > --- /dev/null
> > +++ b/m4/ltp-move_mount.m4
> > @@ -0,0 +1,7 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_MOVE_MOUNT],[
> > +AC_CHECK_FUNCS(move_mount,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> As all of these require <sys/mount.h>, I'd add them into single file
> m4/ltp-newmount.m4.

OK, I'll do that.

> BTW it might take a time before it get into <sys/mount.h>, they're now just <linux/mount.h> (even in musl, which is unlike glic fast with porting new things).

Yes, there're still in kernel-headers, glibc doesn't have patch for that. Maybe
they're waiting. I don't know if there'll be more newmount syscalls (e.g fsinfo
or something else), or fsdevel might would like to disconnect umount() in the
feature:)

> 
> ...
> > +++ b/testcases/kernel/syscalls/newmount/Makefile
> ...
> > +
> > +top_srcdir		?= ../../../..
> > +
> > +include $(top_srcdir)/include/mk/testcases.mk
> > +
> > +CFLAGS			+= -D_GNU_SOURCE
> Is _GNU_SOURCE needed?

Hmm... I'm not sure, just copy this Makefile from syscalls/mount/Makefile ;)
I think the new mount API might not be POSIX defined?

Thanks for your review so much, I'll send V2 patch soon.

Thanks,
Zorro

> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2215-testing-with-a-block-device
> 

