From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2020 20:41:19 +0800
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <20200109095239.GB31981@rei.lan>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109095239.GB31981@rei.lan>
Message-ID: <CAEemH2eBO5WywEvBJKyEpVCky05CHp-JpwpFUSgAUjTx8GAKtQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jan 9, 2020 at 5:52 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > +#define _GNU_SOURCE
> >  #include <unistd.h>
> > +#include <sys/syscall.h>
>
> Defining _GNU_SOURCE anywhere but at the top of the test source is
> meaningless. It has to be defined before we include any libc headers
> otherwise it's ignored.
>

I got the point. And yes, that means the definition should be removed from
the tst_device.h header file.


> >  /*
> > diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > index 2af040840..f5d7ca8ac 100644
> > --- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > +++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
> > @@ -20,6 +20,7 @@
> >   *   None
> >   */
> >
> > +#define _GNU_SOURCE
> >  #define _XOPEN_SOURCE 600
> >  #include <fcntl.h>
>
> Why do we need the _GNU_SOURCE here? We switched to a syscall() in the
> header, hence we do not need the syncfs() prototype anymore.
>
>
But shouldn't we define the _GNU_SOURCE for syscall()?  Otherwise,
the _XOPEN_SOURCE 600 definitions will take effect and makes the compiler
print new errors[1].

Here I fee a little confused, or do we need to delete the _XOPEN_SOURCE
definition directly for the test posix_fadvise01.c?

[1]:
gcc -Werror=implicit-function-declaration -g -O2 -fno-strict-aliasing -pipe
-Wall -W -Wold-style-definition
 -I/root/ltp2/testcases/kernel/syscalls/fadvise
-I/root/ltp2/testcases/kernel/syscalls/fadvise/../utils
-I../../../../include -I../../../../include -I../../../../include/old/
-L../../../../lib  posix_fadvise01.c   -lltp -o posix_fadvise01
In file included from ../../../../include/tst_test.h:22,
                 from posix_fadvise01.c:31:
../../../../include/tst_device.h: In function ?tst_dev_sync?:
../../../../include/tst_device.h:82:9: error: implicit declaration of
function ?syscall?; did you mean ?strcoll??
[-Werror=implicit-function-declaration]
  return syscall(__NR_syncfs, fd);
         ^~~~~~~
         strcoll

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200109/c446e9d2/attachment.htm>
