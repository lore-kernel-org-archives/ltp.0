From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Apr 2016 10:32:02 -0400 (EDT)
Subject: [LTP] [PATCH 1/4] tst_atomic: make tst_atomic_inc take a signed
 integer
In-Reply-To: <20160413140702.GC11529@rei.lan>
References: <82bcc056edc64dee3a13275a2b4bdbec958f60eb.1460552890.git.jstancek@redhat.com>
 <20160413140702.GC11529@rei.lan>
Message-ID: <1325842962.871291.1460557922959.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 13 April, 2016 4:07:02 PM
> Subject: Re: [LTP] [PATCH 1/4] tst_atomic: make tst_atomic_inc take a signed integer
> 
> Hi!
> > This is a preparation for upcoming patches, which add atomic_add_return(),
> > that takes signed integer.
> 
> What is the problem with unsigned integer?

All atomic code in kernel is int based. I wanted to match that as closely
as possible in our code.

> 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  doc/test-writing-guidelines.txt | 2 +-
> >  include/tst_atomic.h            | 2 +-
> >  lib/newlib_tests/test08.c       | 2 +-
> >  lib/tst_test.c                  | 8 ++++----
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/doc/test-writing-guidelines.txt
> > b/doc/test-writing-guidelines.txt
> > index d0b14084c90b..c0ef33afd5bb 100644
> > --- a/doc/test-writing-guidelines.txt
> > +++ b/doc/test-writing-guidelines.txt
> > @@ -780,7 +780,7 @@ the user supplied cleanup to the test library.
> >  
> >  static void cleanup(void)
> >  {
> > -	static unsigned int flag;
> > +	static int flag;
> >  
> >  	if (tst_atomic_inc(&flag) != 1)
> >  		pthread_exit(NULL);
> > diff --git a/include/tst_atomic.h b/include/tst_atomic.h
> > index 75c713d38d2a..40b2c581f19d 100644
> > --- a/include/tst_atomic.h
> > +++ b/include/tst_atomic.h
> > @@ -18,7 +18,7 @@
> >  #ifndef TST_ATOMIC_H__
> >  #define TST_ATOMIC_H__
> >  
> > -static inline unsigned int tst_atomic_inc(unsigned int *v)
> > +static inline unsigned int tst_atomic_inc(int *v)
>                     ^
> 		 This should be removed as well, right?

Correct. I missed that.

> 
> >  {
> >  	return __sync_add_and_fetch(v, 1);
> >  }
> > diff --git a/lib/newlib_tests/test08.c b/lib/newlib_tests/test08.c
> > index 8fefc182650d..0a2023119a71 100644
> > --- a/lib/newlib_tests/test08.c
> > +++ b/lib/newlib_tests/test08.c
> > @@ -35,7 +35,7 @@ static void setup(void)
> >  
> >  static void cleanup(void)
> >  {
> > -	static unsigned int flag;
> > +	static int flag;
> >  
> >  	/* Avoid subsequent threads to enter the cleanup */
> >  	if (tst_atomic_inc(&flag) != 1)
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 37265fe50951..66c0bc67127f 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -43,10 +43,10 @@ static float duration = -1;
> >  static pid_t main_pid;
> >  
> >  struct results {
> > -	unsigned int passed;
> > -	unsigned int skipped;
> > -	unsigned int failed;
> > -	unsigned int warnings;
> > +	int passed;
> > +	int skipped;
> > +	int failed;
> > +	int warnings;
> >  };
> 
> We print these values with %u in do_exit(), that should be updated as
> well.

This as well.

> 
> >  static struct results *results;
> > --
> > 1.8.3.1
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
