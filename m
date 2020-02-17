From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 10:38:50 +0100
Subject: [LTP] [PATCH v7 4/4] syscalls/fsmount01: Add test for fsmount
 series API
In-Reply-To: <CAEemH2cGsXkgkfrFN2XW9ByWqNnknR+-9yCv6T+hqAp13PjVyQ@mail.gmail.com>
References: <20200217084622.11199-1-pvorel@suse.cz>
 <20200217084622.11199-5-pvorel@suse.cz>
 <CAEemH2cGsXkgkfrFN2XW9ByWqNnknR+-9yCv6T+hqAp13PjVyQ@mail.gmail.com>
Message-ID: <20200217093850.GA13398@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > NOTE: most of the syscalls numbers were added in previous commits
> > (c2f27f6e9b, 01e4dc2222, 87a2612857).


> 87a2612857 is invalid?
I'm sorry, that was this upcomming commit (besides that it needs to be removed
from it) => thanks for a report, I'll remove it.


> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > Acked-by: Li Wang <liwang@redhat.com>
> > [ pvorel: rebased, cleanup autotools and other small fixes ]
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  include/lapi/syscalls/powerpc64.in            |  4 +
> >  runtest/syscalls                              |  2 +
> >  testcases/kernel/syscalls/fsmount/.gitignore  |  1 +
> >  testcases/kernel/syscalls/fsmount/Makefile    |  8 ++
> >  testcases/kernel/syscalls/fsmount/fsmount01.c | 95 +++++++++++++++++++
> >  5 files changed, 110 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/fsmount/.gitignore
> >  create mode 100644 testcases/kernel/syscalls/fsmount/Makefile
> >  create mode 100644 testcases/kernel/syscalls/fsmount/fsmount01.c

> > diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/
> > powerpc64.in
> > index 2c1f105c1..beb0e6812 100644
> > --- a/include/lapi/syscalls/powerpc64.in
> > +++ b/include/lapi/syscalls/powerpc64.in
> > @@ -371,3 +371,7 @@ pidfd_open 434
> >  pkey_mprotect 386
> >  pkey_alloc 384
> >  pkey_free 385
> > +move_mount 429
> > +fsopen 430
> > +fsconfig 431
> > +fsmount 432
Yep.

> As Viresh and I commented in the previous email this four syscalls-number
> should be deleted from the patch.

> Besides that, the patchset looks good to me.
>     Acked-by: Li Wang <liwang@redhat.com>
I suppose you ack also the change include/lapi/fsmount.h using lapi/fcntl.h
(if not, please let me know).

Kind regards,
Petr
