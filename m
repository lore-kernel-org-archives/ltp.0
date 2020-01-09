From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 15:28:02 +0100
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <20200109131056.GC22952@rei.lan>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109095239.GB31981@rei.lan>
 <CAEemH2eBO5WywEvBJKyEpVCky05CHp-JpwpFUSgAUjTx8GAKtQ@mail.gmail.com>
 <20200109125615.GA11609@dell5510> <20200109131056.GC22952@rei.lan>
Message-ID: <20200109142802.GA15780@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > But shouldn't we define the _GNU_SOURCE for syscall()?  Otherwise,
> > > the _XOPEN_SOURCE 600 definitions will take effect and makes the compiler
> > > print new errors[1].
> > Correct, syscall() requires _GNU_SOURCE and <unistd.h>.

> Not really, it's guarded by _USE_MISC which is enabled by default and
> disabled by _XOPEN_SOURCE.
Yep, looking into features.h __USE_MISC is defined by _DEFAULT_SOURCE,
which is enabled if nothing or only _GNU_SOURCE is defined.

> Looks like the manual page is outdated at least.
Yes, that's what I checked this time (I usually look into sources).

> > + Not sure if <sys/syscall.h> should be used (as it's in your patch or
> > lapi/syscalls.h.

> Well, given that syncfs is old enough (2.6.39) either should work.

> > > Here I feel a little confused, or do we need to delete the _XOPEN_SOURCE
> > > definition directly for the test posix_fadvise01.c?

> > > [1]:
> > > gcc -Werror=implicit-function-declaration -g -O2 -fno-strict-aliasing -pipe
> > > -Wall -W -Wold-style-definition
> > >  -I/root/ltp2/testcases/kernel/syscalls/fadvise
> > > -I/root/ltp2/testcases/kernel/syscalls/fadvise/../utils
> > > -I../../../../include -I../../../../include -I../../../../include/old/
> > > -L../../../../lib  posix_fadvise01.c   -lltp -o posix_fadvise01
> > > In file included from ../../../../include/tst_test.h:22,
> > >                  from posix_fadvise01.c:31:
> > > ../../../../include/tst_device.h: In function ???tst_dev_sync???:
> > > ../../../../include/tst_device.h:82:9: error: implicit declaration of
> > > function ???syscall???; did you mean ???strcoll????
> > > [-Werror=implicit-function-declaration]
> > >   return syscall(__NR_syncfs, fd);
> > >          ^~~~~~~
> > >          strcoll

> > + Our syscall numbers in include/lapi/syscalls/ are outdated (syncfs is not at
> > least in include/lapi/syscalls/sparc{64,}.in and
> > include/lapi/syscalls/x86_64.in).

> The lapi/syscall.h includes sys/syscall.h so it's probably not a
> problem, since there are no distribution that are missing syncfs in the
> system headers. Note that we are only adding fallback definitions there
> and if present the system values take precedence.
Good. Sorry for wrong report (haven't notice <sys/syscall.h> inclusion).

Kind regards,
Petr
