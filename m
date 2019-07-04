From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 4 Jul 2019 04:17:39 -0400 (EDT)
Subject: [LTP] Bug Report: diotest4 fails on mips64
In-Reply-To: <faeb7464-f0c8-b97e-3b0b-7f38c2e94b99@windriver.com>
References: <dc4e1e30-face-9039-db90-5a6dae2fc2ea@windriver.com>
 <1731168043.30655111.1561720172996.JavaMail.zimbra@redhat.com>
 <77f916ad-58e3-bf0c-e1e7-da8fc3397ba4@windriver.com>
 <818477200.31466413.1562158387201.JavaMail.zimbra@redhat.com>
 <286312662.31605904.1562198532095.JavaMail.zimbra@redhat.com>
 <faeb7464-f0c8-b97e-3b0b-7f38c2e94b99@windriver.com>
Message-ID: <168662696.31634307.1562228259867.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> On 7/4/19 8:02 AM, Jan Stancek wrote:
> >
> > ----- Original Message -----
> >> ----- Original Message -----
> >>> Thanks for your work.
> >>>
> >>> I will backport the patch to my project after merged.
> >> Does it mean, that patch I posted fixes problem for you?
> >>
> >> Do you have good/bad kernel version? I was looking at recent
> >> upstream changes, but didn't spot anything that could explain
> >> that EINVAL.
> > Problem appears to be that "mmap.h" doesn't include "config.h",
> > so MMAP_GRANULARITY ends up being just single page.
> 
> Sorry, can you tell me the relationship between config.h and
> MMAP_GRANULARITY ?

configure detects that you have sys/smh.h, which is recorded in config.h:
  /* Define to 1 if you have the <sys/shm.h> header file. */
  #define HAVE_SYS_SHM_H 1

If your platform has shm.h, then MMAP_GRANULARITY is define as SHMLBA,
otherwise as single page.

If lapi/mmap.h doesn't include config.h, then it's always the latter,
because HAVE_SYS_SHM_H is undefined.

> 
> I tested several times that including "config.h" indeed fixed the bug.
> 
> 
> >
> > Following fixes it for me on qemu emulated 5kc-malta, running 5.2.0-rc7:
> >
> > diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
> > index 18547c0d4..98b6ade1e 100644
> > --- a/include/lapi/mmap.h
> > +++ b/include/lapi/mmap.h
> > @@ -19,6 +19,8 @@
> >   #ifndef LAPI_MMAP_H__
> >   #define LAPI_MMAP_H__
> >
> > +#include "config.h"
> > +
> >   #ifndef MAP_HUGETLB
> >   # define MAP_HUGETLB 0x40000
> >   #endif
> >
> > but still, perhaps we should also drop that MAP_FIXED.
> 
> 
> Agree with it. Could I send the patch with your signed-off?

I sent one ~20 minutes ago, you should be on CC.

> 
> --Hongzhi
> 
> 
> >
> >>>
> >>> --Hongzhi
> >>>
> >>>
> >>>
> >>> On 6/28/19 7:09 PM, Jan Stancek wrote:
> >>>> ----- Original Message -----
> >>>>> *Ltp:*
> >>>>>
> >>>>> latest master
> >>>>>
> >>>>>
> >>>>> *Kernel:*
> >>>>>
> >>>>> After v5.1 ARCH=mips64
> >>>>>
> >>>>>
> >>>>> *Error info:*
> >>>>>
> >>>>> diotest4 10 TBROK : diotest4.c:368: can't mmap file: Invalid argument
> >>>>> diotest4 11 TBROK : diotest4.c:368: Remaining cases broken
> >>>>>
> >>>>>
> >>>>> I think the first argument of mmap is invalid.
> >>>>>
> >>>>>    ?? >shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz -
> >>>>>    ?? >1));
> >>>>>
> >>>>>    ?? >shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
> >>>> I don't see any note why that mmap needs to be MAP_FIXED. I'd drop it,
> >>>> let kernel pick an address:
> >>>>
> >>>> diff --git a/testcases/kernel/io/direct_io/diotest4.c
> >>>> b/testcases/kernel/io/direct_io/diotest4.c
> >>>> index e4616e400abd..bf200cd41a27 100644
> >>>> --- a/testcases/kernel/io/direct_io/diotest4.c
> >>>> +++ b/testcases/kernel/io/direct_io/diotest4.c
> >>>> @@ -352,18 +352,14 @@ int main(int argc, char *argv[])
> >>>>           total++;
> >>>>
> >>>>           /* Test-10: read, write to a mmaped file */
> >>>> -       shm_base = (char *)(((long)sbrk(0) + (shmsz - 1)) & ~(shmsz -
> >>>> 1));
> >>>> -       if (shm_base == NULL) {
> >>>> -               tst_brkm(TBROK, cleanup, "sbrk failed: %s",
> >>>> strerror(errno));
> >>>> -       }
> >>>>           offset = 4096;
> >>>>           count = bufsize;
> >>>>           if ((fd = open(filename, O_DIRECT | O_RDWR)) < 0) {
> >>>>                   tst_brkm(TBROK, cleanup, "can't open %s: %s",
> >>>>                            filename, strerror(errno));
> >>>>           }
> >>>> -       shm_base = mmap(shm_base, 0x100000, PROT_READ | PROT_WRITE,
> >>>> -                       MAP_SHARED | MAP_FIXED, fd, 0);
> >>>> +       shm_base = mmap(0, 0x100000, PROT_READ | PROT_WRITE,
> >>>> +                       MAP_SHARED, fd, 0);
> >>>>           if (shm_base == (caddr_t) - 1) {
> >>>>                   tst_brkm(TBROK, cleanup, "can't mmap file: %s",
> >>>>                            strerror(errno));
> >>>>
> >> --
> >> Mailing list info: https://lists.linux.it/listinfo/ltp
> >>
> 
