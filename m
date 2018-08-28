From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 28 Aug 2018 06:18:49 -0400 (EDT)
Subject: [LTP] [PATCH] move_pages12: end early if runtime gets close to
 test time
In-Reply-To: <CAEemH2cgdkVrTasttdDt0Djr12B8fdzj4KxOFcXtjuqmNtqXFA@mail.gmail.com>
References: <5b181737029c9687f7cc7c49a9d15b415e62a1bc.1535378672.git.jstancek@redhat.com>
 <CAEemH2cgdkVrTasttdDt0Djr12B8fdzj4KxOFcXtjuqmNtqXFA@mail.gmail.com>
Message-ID: <1240573732.43116777.1535451529159.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Mon, Aug 27, 2018 at 10:06 PM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> > Most systems can complete this reproducer in standard test time.
> > Small groups of systems (e.g. aarch64 with 512M hugepages) can hit
> > a timeout.
> >
> > Add a check for elapsed time and end test early if we are getting close
> > (80%).
> >
> > Fixes:
> > #387
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  testcases/kernel/syscalls/move_pages/move_pages12.c | 20
> > ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c
> > b/testcases/kernel/syscalls/move_pages/move_pages12.c
> > index c0ff27114110..2813097871e4 100644
> > --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
> > +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> > @@ -40,6 +40,7 @@
> >  #include <sys/wait.h>
> >
> >  #include "tst_test.h"
> > +#include "tst_timer.h"
> >  #include "move_pages_support.h"
> >  #include "lapi/mmap.h"
> >
> > @@ -51,6 +52,7 @@
> >  #define PATH_HUGEPAGES "/sys/kernel/mm/hugepages/"
> >  #define TEST_PAGES     2
> >  #define TEST_NODES     2
> > +#define TEST_TIMEOUT   300
> >
> >  static int pgsz, hpsz;
> >  static long orig_hugepages = -1;
> > @@ -102,6 +104,8 @@ static void do_test(void)
> >         pid_t cpid = -1;
> >         int status;
> >
> > +       tst_timer_start(CLOCK_MONOTONIC);
> > +
> >         addr = SAFE_MMAP(NULL, TEST_PAGES * hpsz, PROT_READ | PROT_WRITE,
> >                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> >
> > @@ -123,14 +127,15 @@ static void do_test(void)
> >                 memset(addr, 0, TEST_PAGES * hpsz);
> >
> >                 SAFE_MUNMAP(addr, TEST_PAGES * hpsz);
> > -       }
> >
> > -       if (i == LOOPS) {
> > -               SAFE_KILL(cpid, SIGKILL);
> > -               SAFE_WAITPID(cpid, &status, 0);
> > -               if (!WIFEXITED(status))
> > -                       tst_res(TPASS, "Bug not reproduced");
> > +               if (tst_timer_expired_ms(
> > TEST_TIMEOUT))
> >
> 
> This is a good way for solving
> #387 issue, but that will make the
> LTP_TIMEOUT_MUL out of action even if someone set a value to it.
> because test will always stop on
> TEST_TIMEOUT expired every time.
> 
> Shouldn't we consider this situation?

In most cases timeout is upper bound of test runtime, but here
it could mean also time we allow test to run while it's trying
to do something.

We'll never hit timeout, but for latter case, it would make
sense to respect LTP_TIMEOUT_MUL. I'll send v2.

Thanks,
Jan

> 
> --
> Regards,
> Li Wang
> 
