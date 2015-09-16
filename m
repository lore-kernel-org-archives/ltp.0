From: Li Wang <liwang@redhat.com>
Date: Wed, 16 Sep 2015 16:02:42 +0800
Subject: [LTP] [PATCH] lib/mem.c: handle the case oom0{3,
	5} exit with EAGAIN situation
In-Reply-To: <1289358576.12408077.1442386696367.JavaMail.zimbra@redhat.com>
References: <1442380011-22409-1-git-send-email-liwang@redhat.com>
 <1289358576.12408077.1442386696367.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fpdefErBNcm0eAs4ybpY22i3rPh8RQ=fghqUPc4Ofgew@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Wed, Sep 16, 2015 at 2:58 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
>
>
> ----- Original Message -----
> > From: "Li Wang" <liwang@redhat.com>
> > To: jstancek@redhat.com
> > Cc: ltp@lists.linux.it
> > Sent: Wednesday, 16 September, 2015 7:06:51 AM
> > Subject: [PATCH] lib/mem.c: handle the case oom0{3,5} exit with EAGAIN
> situation
> >
> > Sometimes oom0{3,5} failed as the following results:
> >
> > oom05       0  TINFO  :  start OOM testing for mlocked pages.
> > oom05       0  TINFO  :  expected victim is 3371.
> > oom05       0  TINFO  :  thread (3fff788ff1c0), allocating 3221225472
> bytes.
> > ...
> > oom05       5  TFAIL  :  mem.c:153: victim unexpectedly ended with
> retcode:
> > 11, expected: 12
> >
> > In the OOM test, that tries to consume all memory. But the test doesn't
> retry
> > to mlock, it simply
> > exits with errno returned by mlock. At the moment testcase is expecting
> > either ENOMEM or getting
> > killed by kernel.
> >
> > Here do retry the function if mlock() fail with 'EAGAIN' errno.
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
> Hi,
>
> Please don't include my "Signed-off-by" for patches I haven't
> written/modified.
>

Since the issue you provided some good advises on debugging work, so I
include you.

Ok, sorry for my unclear the patch rules.



>
> > ---
> >  testcases/kernel/mem/lib/mem.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/testcases/kernel/mem/lib/mem.c
> b/testcases/kernel/mem/lib/mem.c
> > index 8fe4bf0..dc9d958 100644
> > --- a/testcases/kernel/mem/lib/mem.c
> > +++ b/testcases/kernel/mem/lib/mem.c
> > @@ -39,8 +39,13 @@ static int alloc_mem(long int length, int testcase)
> >       if (s == MAP_FAILED)
> >               return errno;
> >
> > -     if (testcase == MLOCK && mlock(s, length) == -1)
> > -             return errno;
> > +     if (testcase == MLOCK) {
> > +             while (mlock(s, length) == -1) {
> > +                     if (EAGAIN != errno)
> > +                             return errno;
> > +             }
> > +     }
> > +
>
> Isn't this going to introduce infinite loop? Shouldn't we limit
> the number of retries by some finite number before we let it
> touch the pages (and hit OOM)?
>

Hmm, at first I'm trying to use finite loop for the mlock(), but think
over, I feel it is not a big matter since  mlock() desen't need so much
memory to do the lock. and I did that.

Anyway, for security consideration, finite loop is also has itself
advantages.

If so, How about this:

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 8fe4bf0..99eeb04 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -30,6 +30,7 @@ static int alloc_mem(long int length, int testcase)
 {
        char *s;
        long i, pagesz = getpagesize();
+       int ln = 10;

        tst_resm(TINFO, "thread (%lx), allocating %ld bytes.",
                (unsigned long) pthread_self(), length);
@@ -39,8 +40,14 @@ static int alloc_mem(long int length, int testcase)
        if (s == MAP_FAILED)
                return errno;

-       if (testcase == MLOCK && mlock(s, length) == -1)
-               return errno;
+       if (testcase == MLOCK) {
+               while (mlock(s, length) == -1 && ln > 0) {
+                       if (EAGAIN != errno)
+                               return errno;
+                       ln--;
+               }
+       }




>
> Regards,
> Jan
>
> >  #ifdef HAVE_MADV_MERGEABLE
> >       if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
> >               return errno;
> > --
> > 1.8.3.1
> >
> >
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20150916/886c22cf/attachment-0001.html>
