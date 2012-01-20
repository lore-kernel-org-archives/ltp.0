Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoFJo-00008J-F9
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 14:19:52 +0000
Date: Fri, 20 Jan 2012 15:32:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120143207.GB13447@saboteur.suse.cz>
References: <1326184383-2268-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F0E2948.3000800@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F0E2948.3000800@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] hugemmap01: auto mount the tmp dir
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Hi Cyril, Casper and folks :
> > 
> > I just cooked one patch to request for your comments,
> > after your comments with this, I will cook patches on
> > other hugemmap cases, and also with some code cleanup.
> 
> Any comments? the case now is sometime FAIL without this
> patch,

Sorry for the delay, there is (again) quite a load of patches and work
to do...

Speaking of cleanups, you are welcome to delete all the useless comments
like /* this is a loop variable */. And you could also run checkpatch on
files too, as checkpatch -f file.c. And if you send the cleanups in
separate patch, these would be applied right away.

The changes in functionality looks reasonably straightforward to me more
comments bellow. And I would definitly like to hear what Caspar thinks
about this patch (as he was planing to do some cleanups in the mem/
testcases).

> > 1. auto mount can reduce bugs
> > 2. add a option to change the default hugepages to be allocated
> > 
> > Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> > ---
> >  runtest/hugetlb                                    |    2 +-
> >  testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   12 +++++
> >  testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   49 ++++++++++++-------
> >  3 files changed, 44 insertions(+), 19 deletions(-)
> > 
> > diff --git a/runtest/hugetlb b/runtest/hugetlb
> > index a316043..2cbd410 100644
> > --- a/runtest/hugetlb
> > +++ b/runtest/hugetlb
> > @@ -1,4 +1,4 @@
> > -hugemmap01 hugemmap01 -H/tmp
> > +hugemmap01 hugemmap01
> >  hugemmap02 hugemmap02 -H/tmp -c10
> >  hugemmap03 hugemmap03 -H/tmp -I2 -c10
> >  hugemmap04 hugemmap04 -H/tmp
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> > index a1ba46e..98d0694 100644
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> > @@ -24,4 +24,16 @@ top_srcdir              ?= ../../../../..
> >  
> >  include $(top_srcdir)/include/mk/testcases.mk
> >  include $(abs_srcdir)/../Makefile.inc
> > +
> > +LIBMEMDIR		:= ../../lib
> > +LIBMEM			:= $(LIBMEMDIR)/libmem.a
> > +$(LIBMEM):
> > +	$(MAKE) -C "$^" -f "$(abs_srcdir)/$^/Makefile" all
> > +
> > +CPPFLAGS		+= -I$(abs_srcdir)/$(LIBMEMDIR)
> > +LDFLAGS			+= -L$(abs_builddir)/$(LIBMEMDIR)
> > +LDLIBS			+= -lmem
> > +MAKE_DEPS		+= $(LIBMEM)
> > +
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > +#vim: syntax=make
> > diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> > index 874f736..5e2c962 100644
> > --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> > +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> > @@ -69,23 +69,27 @@
> >  #include <sys/stat.h>
> >  #include <sys/mman.h>
> >  #include <sys/types.h>
> > +#include <sys/mount.h>
> >  
> >  #include "test.h"
> >  #include "usctest.h"
> >  #include "system_specific_hugepages_info.h"
> > +#include "../../include/mem.h"
> >  
> >  #define BUFFER_SIZE  256
> >  
> > -char* TEMPFILE="mmapfile";
> > +char TEMPFILE[MAXPATHLEN];
> >  
> >  char *TCID="hugemmap01";	/* Test program identifier.    */
> >  int TST_TOTAL=1;		/* Total number of test cases. */
> >  long *addr;			/* addr of memory mapped region */
> >  int fildes;			/* file descriptor for tempfile */
> >  char *Hopt;                     /* location of hugetlbfs */
> > +char *nr_opt;
> >  int beforetest=0;		/* Amount of free huge pages before testing */
> >  int aftertest=0;		/* Amount of free huge pages after testing */
> >  int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
> > +long hugepages = 1024;		/* Amount of allocated huge pages, default 1024 */
> >  
> >  void setup();			/* Main setup function of test */
> >  void cleanup();			/* cleanup function for the test */
> > @@ -100,12 +104,16 @@ main(int ac, char **av)
> >  {
> >  	int lc;			/* loop counter */
> >  	char *msg;		/* message returned from parse_opts */
> > -        int Hflag=0;              /* binary flag: opt or not */
> > +        int Hflag=0;		/* binary flag: opt or not */
> > +	int sflag=0;
> >  	int page_sz=0;
> >  
> >         	option_t options[] = {
> > -        	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
> > -            	{ NULL, NULL, NULL }          /* NULL required to end array */
> > +		/* Required for location of hugetlbfs */
> > +        	{ "H:", &Hflag, &Hopt },
> > +		{ "s:", &sflag, &nr_opt },
> > +		/* NULL required to end array */
> > +            	{ NULL, NULL, NULL }
> >         	};
> >  
> >  	/* Parse standard options given to run the test. */
> > @@ -115,11 +123,15 @@ main(int ac, char **av)
> >  		tst_exit();
> >  	}
> >  
> > -	if (Hflag == 0) {
> > -		tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test, use -h for options help");
> > -		tst_exit();
> > +	if (!Hflag) {
> > +		tst_require_root(NULL);
> > +		tst_tmpdir();
> > +		Hopt = get_tst_tmpdir();
> >  	}

Isn't the tst_require_root(NULL) useless here as we do another one in
setup? Or isn't the one in setup redundant?

> > +	if (sflag)
> > +		hugepages = strtol(nr_opt, NULL, 10);
> > +
> >  	setup();
> >  
> >  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > @@ -189,17 +201,16 @@ main(int ac, char **av)
> >   * 	     Write some known data into file and get the size of the file.
> >   */
> >  void
> > -setup()
> > +setup(void)
> >  {
> > -	char mypid[40];
> > -
> > -	sprintf(mypid,"/%d",getpid());
> > -	TEMPFILE=strcat(mypid,TEMPFILE);
> > -	TEMPFILE=strcat(Hopt,TEMPFILE);
> > -
> > -	tst_sig(FORK, DEF_HANDLER, cleanup);
> > -
> > -	TEST_PAUSE;
> > +	tst_require_root(NULL);
> > +	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0) {
> > +		tst_brkm(TBROK|TERRNO, NULL,
> > +			"mount failed on %s", Hopt);
> > +	}
> > +	set_sys_tune("nr_hugepages", hugepages, 1);
> > +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
> > +		 Hopt, getpid());
> >  }
> >  
> > @@ -209,7 +220,7 @@ setup()
> >   * 	       Remove the temporary directory created.
> >   */
> >  void
> > -cleanup()
> > +cleanup(void)
> >  {
> >  	/*
> >  	 * print timing stats if that option was specified.
> > @@ -218,4 +229,6 @@ cleanup()
> >  
> >  	unlink(TEMPFILE);
> >  
> > +	umount(Hopt);
> > +	tst_rmdir();
> >  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
