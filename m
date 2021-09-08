From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Sep 2021 09:24:26 +0800
Subject: [LTP] [PATCH] openposix: make use of tst_process_state_wait3
In-Reply-To: <YTc20vtM2HbhTVTg@yuki>
References: <20210907025258.3294914-1-liwang@redhat.com>
 <YTc20vtM2HbhTVTg@yuki>
Message-ID: <CAEemH2e66Yfkobgy1D7mDGmK3YkmWx0240imVroCDay66VBmUg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 7, 2021 at 5:54 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > diff --git
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> > index 04ef0a2cc..554714695 100644
> > ---
> a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> > +++
> b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> > @@ -17,6 +17,7 @@
> >  #include <stdlib.h>
> >  #include <errno.h>
> >  #include "posixtest.h"
> > +#include "proc.h"
> >
> >  #define SLEEPSEC 30
> >
> > @@ -88,7 +89,7 @@ int main(void)
> >               /* parent here */
> >               int i;
> >
> > -             sleep(1);
> > +             tst_process_state_wait3(pid, 'S', 1);
>
> This test is actually the only one that looks at the remining time as
> returned by clock_nanosleep() so it may make a sense to keep the
> sleep(1) in this test so that the remaining time is smaller than the
> sleep time by some reasonable margin. But I guess that the test will
> work fine without it as well.
>

Good point, I have retrieved that 1 sec sleep and applied. Thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210908/2aceeefd/attachment-0001.htm>
