From: Sandeep Patil <sspatil@google.com>
Date: Mon, 28 Aug 2017 17:19:48 -0700
Subject: [LTP] [PATCH] android: pty01: Fix pty01 test for Android.
In-Reply-To: <CAJgzZorUrJVFpXon4FCnSoAUy_TTh1Maz6pGBMyfzdzTkRrBjA@mail.gmail.com>
References: <20170828182610.49079-1-sspatil@google.com>
 <CAJgzZorUrJVFpXon4FCnSoAUy_TTh1Maz6pGBMyfzdzTkRrBjA@mail.gmail.com>
Message-ID: <20170829001948.GM84377@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 28, 2017 at 11:32:30AM -0700, enh wrote:
> (should be __BIONIC__ rather than __ANDROID__ since this will be true for
> host bionic too.)

Thanks, fixing this now in v2.

- ssp
> 
> On Aug 28, 2017 11:26, "Sandeep Patil" <sspatil@google.com> wrote:
> 
> > The test fails because 'grantpt()' is a no-op in bionic and doesn't set
> > the /dev/pts/X mode to '020600' as expected by the test. The change
> > skips that check if __ANDROID__ is defined so the rest of the test(s)
> > can proceed and detect other failures if any.
> >
> > Signed-off-by: Sandeep Patil <sspatil@google.com>
> > ---
> >  testcases/kernel/pty/pty01.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
> > index cbcc65c97..9fdbf0841 100644
> > --- a/testcases/kernel/pty/pty01.c
> > +++ b/testcases/kernel/pty/pty01.c
> > @@ -99,9 +99,12 @@ static int test1(void)
> >                 tst_brkm(TBROK, NULL, "uid mismatch");
> >         }
> >
> > +        /* grantpt() is a no-op in bionic / Android. */
> > +#ifndef __ANDROID__
> >         if (st.st_mode != (S_IFCHR | S_IRUSR | S_IWUSR | S_IWGRP)) {
> >                 tst_brkm(TBROK, NULL, "mode mismatch (mode=%o)",
> > st.st_mode);
> >         }
> > +#endif
> >
> >         slavefd = open(slavename, O_RDWR);
> >         if (slavefd >= 0) {
> > --
> > 2.14.1.342.g6490525c54-goog
> >
> >
