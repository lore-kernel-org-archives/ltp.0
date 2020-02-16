From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 16 Feb 2020 14:17:23 +0100
Subject: [LTP] [PATCH v6 2/2] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <CAEemH2f0db1i7Tpg-4jqa5h5j9KZpH+d4aRg-M3Xn3Mw9NU1eA@mail.gmail.com>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207144105.19947-2-pvorel@suse.cz>
 <CAEemH2f0db1i7Tpg-4jqa5h5j9KZpH+d4aRg-M3Xn3Mw9NU1eA@mail.gmail.com>
Message-ID: <20200216131723.GA2725117@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Patch v6 looks almost good besides tiny issues:

> I don't like the commit summary with kernel version number, can we just
> note as:
>     "syscalls/fsmount01: Add test for fsmount series API"?
Sure.

> >  configure.ac                                  |  4 +
> >  include/lapi/newmount.h                       | 95 +++++++++++++++++++
> >  include/lapi/syscalls/powerpc64.in            |  4 +
> Is there any reason why only add syscall num for ppc64?
The other numbers are already there:
01e4dc222 lapi/syscalls: Add MIPS support
c2f27f6e9 Add syscall numbers for new file-system related syscalls

Not sure if we should add a note in the commit message to prevent confusion
later (probably not needed).

> > +++ b/include/lapi/newmount.h
> Maybe rename to fsmount.h is better? Now we think it new since mainline
> v5.2 is new to us, one year later it probably not new actually, to use a
> name can indicate the functionality is wiser I guess.
+1

> BTW, I like the way Viresh Kumar gives in his fsmount.h, it looks more tidy
> and clean.
> http://lists.linux.it/pipermail/ltp/2020-February/015413.html
Hm, competing implementations.
Both tries to handle preventing redefinitions (e.g. FSOPEN_CLOEXEC) once
the API hits libc headers (at least in musl it might be soon).
Zorro tries to bind them to function check (e.g. #ifndef HAVE_FSMOUNT, #ifndef
HAVE_MOVE_MOUNT), Viresh just use single check #ifndef OPEN_TREE_CLONE.
I slightly prefer Viresh way (it's unlikely that libc headers would include just
part of the new mount API definitions, although obviously the most safest way
would be to either guard with #ifndef each definition or just give up on testing
header and copy whole include/uapi/linux/mount.h (+ avoid using sys/mount.h;
that's the way used for include/lapi/bpf.h).

> > +++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
...
> > +static void test_newmount(void)
> static void test_fsmount(void)? Or, static void run(void).
+1.


> > +       if (ismount(MNTPOINT)) {
> > +               tst_res(TPASS, "new mount API from v5.2 works");


> Can we avoid appearance the v5.2? I guess many Enterprise Linux
> Distributions will backport the fsmount() series API, v5.2 in test log
> looks strange if the kernel is older than it.
+1. That was added by myself.

I've prepared fixed version, we just need to decide how to handle LAPI header.

Kind regards,
Petr
