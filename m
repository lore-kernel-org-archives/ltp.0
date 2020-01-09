From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 13:56:15 +0100
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <CAEemH2eBO5WywEvBJKyEpVCky05CHp-JpwpFUSgAUjTx8GAKtQ@mail.gmail.com>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109095239.GB31981@rei.lan>
 <CAEemH2eBO5WywEvBJKyEpVCky05CHp-JpwpFUSgAUjTx8GAKtQ@mail.gmail.com>
Message-ID: <20200109125615.GA11609@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > +#define _GNU_SOURCE
> > >  #include <unistd.h>
> > > +#include <sys/syscall.h>

> > Defining _GNU_SOURCE anywhere but at the top of the test source is
> > meaningless. It has to be defined before we include any libc headers
> > otherwise it's ignored.


> I got the point. And yes, that means the definition should be removed from
> the tst_device.h header file.


> > > diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
...
> > > +#define _GNU_SOURCE
> > >  #define _XOPEN_SOURCE 600
> > >  #include <fcntl.h>

> > Why do we need the _GNU_SOURCE here? We switched to a syscall() in the
> > header, hence we do not need the syncfs() prototype anymore.


> But shouldn't we define the _GNU_SOURCE for syscall()?  Otherwise,
> the _XOPEN_SOURCE 600 definitions will take effect and makes the compiler
> print new errors[1].
Correct, syscall() requires _GNU_SOURCE and <unistd.h>.
+ Not sure if <sys/syscall.h> should be used (as it's in your patch or
lapi/syscalls.h.

> Here I feel a little confused, or do we need to delete the _XOPEN_SOURCE
> definition directly for the test posix_fadvise01.c?

> [1]:
> gcc -Werror=implicit-function-declaration -g -O2 -fno-strict-aliasing -pipe
> -Wall -W -Wold-style-definition
>  -I/root/ltp2/testcases/kernel/syscalls/fadvise
> -I/root/ltp2/testcases/kernel/syscalls/fadvise/../utils
> -I../../../../include -I../../../../include -I../../../../include/old/
> -L../../../../lib  posix_fadvise01.c   -lltp -o posix_fadvise01
> In file included from ../../../../include/tst_test.h:22,
>                  from posix_fadvise01.c:31:
> ../../../../include/tst_device.h: In function ?tst_dev_sync?:
> ../../../../include/tst_device.h:82:9: error: implicit declaration of
> function ?syscall?; did you mean ?strcoll??
> [-Werror=implicit-function-declaration]
>   return syscall(__NR_syncfs, fd);
>          ^~~~~~~
>          strcoll

+ Our syscall numbers in include/lapi/syscalls/ are outdated (syncfs is not at
least in include/lapi/syscalls/sparc{64,}.in and
include/lapi/syscalls/x86_64.in).

Kind regards,
Petr
