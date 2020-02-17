From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 08:51:05 +0100
Subject: [LTP] [PATCH v6 2/2] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <CAEemH2ewgh=OnRzEs+1X4rvsiChrLRRMxeK-ChZL3wDqco_iLg@mail.gmail.com>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207144105.19947-2-pvorel@suse.cz>
 <CAEemH2f0db1i7Tpg-4jqa5h5j9KZpH+d4aRg-M3Xn3Mw9NU1eA@mail.gmail.com>
 <20200216131723.GA2725117@x230>
 <CAEemH2ewgh=OnRzEs+1X4rvsiChrLRRMxeK-ChZL3wDqco_iLg@mail.gmail.com>
Message-ID: <20200217075105.GA16499@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> On Sun, Feb 16, 2020 at 9:17 PM Petr Vorel <pvorel@suse.cz> wrote:

> > ...
> > > >  include/lapi/syscalls/powerpc64.in            |  4 +
> > > Is there any reason why only add syscall num for ppc64?
> > The other numbers are already there:
> > 01e4dc222 lapi/syscalls: Add MIPS support
> > c2f27f6e9 Add syscall numbers for new file-system related syscalls

> Good to know this.

> > Not sure if we should add a note in the commit message to prevent confusion
> > later (probably not needed).


> Or just mentionion that commit(c2f27f6e9 Add syscall numbers ...) message.

I'll add it (I'll mention both commits).

> > BTW, I like the way Viresh Kumar gives in his fsmount.h, it looks more
> > tidy
> > > and clean.
> > > http://lists.linux.it/pipermail/ltp/2020-February/015413.html
> > Hm, competing implementations.
> > Both tries to handle preventing redefinitions (e.g. FSOPEN_CLOEXEC) once
> > the API hits libc headers (at least in musl it might be soon).
> > Zorro tries to bind them to function check (e.g. #ifndef HAVE_FSMOUNT,
> > #ifndef
> > HAVE_MOVE_MOUNT), Viresh just use single check #ifndef OPEN_TREE_CLONE.
> > I slightly prefer Viresh way (it's unlikely that libc headers would
> > include just

> +1 Viresh way.
I'm also for merging 1st commit from Viresh's patchset and than Zorro's
fsmount01 test with dropped lapi commit. I'll send PR so others can see the
fixes.

> > part of the new mount API definitions, although obviously the most safest
> > way
> > would be to either guard with #ifndef each definition or just give up on
> > testing
> > header and copy whole include/uapi/linux/mount.h (+ avoid using
> > sys/mount.h;
> > that's the way used for include/lapi/bpf.h).


> @Cyril, @Jan, any else suggestion?

> Btw, we have to include "lapi/fcntl.h" in the test to get rid of build
> error from old(RHEL5.11) distro:
Thanks for notifying, I'll add it. BTW is there a way to add this old RHEL to
travis? Or is there any old Fedora version which would imitate that?
Or I can try to search about old SLES 11 (or old openSUSE version which would
imitate that).

> fsmount01.c:71: error: ?AT_FDCWD? undeclared (first use in this function)
> fsmount01.c:71: error: (Each undeclared identifier is reported only once
> fsmount01.c:71: error: for each function it appears in.)

Kind regards,
Petr
