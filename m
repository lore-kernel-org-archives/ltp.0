Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QgIXw-0001oY-H7
	for ltp-list@lists.sourceforge.net; Mon, 11 Jul 2011 15:37:20 +0000
Date: Mon, 11 Jul 2011 17:38:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110711153838.GA30078@saboteur.suse.cz>
References: <BANLkTi=n_UeC_YOT3o-czzAhwu9GRUbWhw@mail.gmail.com>
	<4D9EB736.2030907@cn.fujitsu.com> <4DAF85AA.5080609@cn.fujitsu.com>
	<4DB0FF1C.5060000@redhat.com> <4DC91E94.6050907@cn.fujitsu.com>
	<20110519144712.GA11838@saboteur.suse.cz>
	<4DDB2D48.3040206@cn.fujitsu.com> <4DF11877.7060503@cn.fujitsu.com>
	<BANLkTimMsG4=CvqqQRG54Vm40yr8S1NWMw@mail.gmail.com>
	<4DF1E7E5.2080401@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DF1E7E5.2080401@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] hugemmap01.c : Automatically mount hugetlbfs on
 /huge.
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
To: tangchen <tangchen@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am sorry about the style problem, and I resend this patch here.

Fixing the coding style is welcome, but please do that in patch
separated from function changes.

It's better to create several incremental patches that are easier to
review and thuss gets commited sooner.

> Please comment! Thanks.:)
> 
> Signed-off-by: tangchen <tangchen@cn.fujitsu.com>
> ---
>  runtest/hugetlb                                    |    8 +-
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   27 +++++++-
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   59 +++++++---------
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   49 +++++++-------
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |   56 ++++++++--------
>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   41 +++++-------
>  testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile |   25 +++++++
>  testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c |   70 ++++++++++++++++++++
>  testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h |   27 ++++++++
>  9 files changed, 245 insertions(+), 117 deletions(-)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index af45868..641c2a6 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -1,7 +1,7 @@
> -hugemmap01 hugemmap01 -H/tmp
> -hugemmap02 hugemmap02 -H/tmp -c10
> -hugemmap03 hugemmap03 -H/tmp -I2 -c10
> -hugemmap04 hugemmap04 -H/tmp
> +hugemmap01 hugemmap01
> +hugemmap02 hugemmap02 -c10
> +hugemmap03 hugemmap03 -I2 -c10
> +hugemmap04 hugemmap04
>  hugemmap05 hugemmap05
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> index a1ba46e..b89a040 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/Makefile
> @@ -20,8 +20,31 @@
>  # Garrett Cooper, July 2009
>  #
>  
> -top_srcdir              ?= ../../../../..
> +top_srcdir		?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> -include $(abs_srcdir)/../Makefile.inc
> +
> +LIBDIR			:= lib
> +LIB			:= $(LIBDIR)/libmnt_hugetlb.a
> +FILTER_OUT_DIRS		:= $(LIBDIR)
> +
> +$(LIBDIR):
> +	mkdir -p "$@"
> +
> +$(LIB): $(LIBDIR)
> +	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
> +
> +CPPFLAGS                += -I$(abs_srcdir)/$(LIBDIR)
> +
> +LDFLAGS                 += -L$(abs_builddir)/$(LIBDIR)
> +
> +LDLIBS                  += -lmnt_hugetlb
> +
> +MAKE_DEPS		:= $(LIB)
> +
> +trunk-clean:: | lib-clean
> +
> +lib-clean:: $(LIBDIR)
> +	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> index 874f736..ddde10c 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
> @@ -73,53 +73,42 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define BUFFER_SIZE  256
>  
> -char* TEMPFILE="mmapfile";
> +char TEMPFILE[MAXPATHLEN];
>  
>  char *TCID="hugemmap01";	/* Test program identifier.    */
>  int TST_TOTAL=1;		/* Total number of test cases. */
>  long *addr;			/* addr of memory mapped region */
>  int fildes;			/* file descriptor for tempfile */
> -char *Hopt;                     /* location of hugetlbfs */
> -int beforetest=0;		/* Amount of free huge pages before testing */
> -int aftertest=0;		/* Amount of free huge pages after testing */
> +int free_huge_before=0;
> +int free_huge_after=0;
>  int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
> +char *mount_point = NULL;
>  
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -void help()
> -{
> -	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");
> -}
> +void setup(void);
> +void cleanup(void);
>  
>  int
>  main(int ac, char **av)
>  {
>  	int lc;			/* loop counter */
>  	char *msg;		/* message returned from parse_opts */
> -        int Hflag=0;              /* binary flag: opt or not */
>  	int page_sz=0;
>  
> -       	option_t options[] = {
> -        	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
> -            	{ NULL, NULL, NULL }          /* NULL required to end array */
> -       	};
> +	option_t options[] = {
> +		{ NULL, NULL, NULL }	/* NULL required to end array */
> +	};
>  
>  	/* Parse standard options given to run the test. */
> -	msg = parse_opts(ac, av, options, &help);
> +	msg = parse_opts(ac, av, options, NULL);
>  	if (msg != (char *) NULL) {
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);
>  		tst_exit();
>  	}
>  
> -	if (Hflag == 0) {
> -		tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test, use -h for options help");
> -		tst_exit();
> -	}
> -
>  	setup();
>  
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> @@ -134,7 +123,7 @@ main(int ac, char **av)
>  		Tst_count=0;
>  
>  		/* Note the number of free huge pages BEFORE testing */
> -		beforetest = get_no_of_free_hugepages();
> +		free_huge_before = get_no_of_free_hugepages();
>  
>  		/* Note the size of huge page size BEFORE testing */
>  		page_sz = hugepages_size();
> @@ -159,8 +148,8 @@ main(int ac, char **av)
>  		}
>  
>  		/* Make sure the number of free huge pages AFTER testing decreased */
> -		aftertest = get_no_of_free_hugepages();
> -		hugepagesmapped = beforetest - aftertest;
> +		free_huge_after = get_no_of_free_hugepages();
> +		hugepagesmapped = free_huge_before - free_huge_after;
>  		if (hugepagesmapped < 1) {
>  			tst_resm(TWARN,"Number of HUGEPAGES_FREE stayed the same. Okay if");
>  			tst_resm(TWARN,"multiple copies running due to test collision.");
> @@ -189,18 +178,21 @@ main(int ac, char **av)
>   * 	     Write some known data into file and get the size of the file.
>   */
>  void
> -setup()
> +setup(void)
>  {
> -	char mypid[40];
> -
> -	sprintf(mypid,"/%d",getpid());
> -	TEMPFILE=strcat(mypid,TEMPFILE);
> -	TEMPFILE=strcat(Hopt,TEMPFILE);
> +	tst_require_root(NULL);
>  
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
>  
> +	tst_tmpdir();
> +	mount_point = get_tst_tmpdir();
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point, getpid());
>  }
>  
>  /*
> @@ -209,7 +201,7 @@ setup()
>   * 	       Remove the temporary directory created.
>   */
>  void
> -cleanup()
> +cleanup(void)
>  {
>  	/*
>  	 * print timing stats if that option was specified.
> @@ -217,5 +209,6 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
> +	tst_rmdir();
>  }
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> index 45cddf7..bef5b78 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
> @@ -63,6 +63,7 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define LOW_ADDR       (void *)(0x80000000)
>  #define LOW_ADDR2      (void *)(0x90000000)
> @@ -77,36 +78,27 @@ unsigned long *addrlist[5];	/* list of addresses of memory mapped region */
>  int i;
>  int fildes;			/* file descriptor for tempfile */
>  int nfildes;			/* file descriptor for /dev/zero */
> -char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;
>  
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -void help()
> -{
> -	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");
> -}
> +void setup(void);			/* Main setup function of test */
> +void cleanup(void);			/* cleanup function for the test */
>  
>  int
>  main(int ac, char **av)
>  {
>  	int lc;
> -	char *msg;
> -        int Hflag = 0;
> +	char *msg;		/* message returned from parse_opts */
>  	int page_sz, map_sz;
>  
> -       	option_t options[] = {
> -        	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
> -            	{ NULL, NULL, NULL }          /* NULL required to end array */
> -       	};
> +	option_t options[] = {
> +		{ NULL, NULL, NULL }	/* NULL required to end array */
> +	};
>  
>  	/* Parse standard options given to run the test. */
> -	if ((msg = parse_opts(ac, av, options, &help)) != NULL)
> +	msg = parse_opts(ac, av, options, NULL);
> +	if (msg != (char *) NULL) {
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);
> -
> -	if (Hflag == 0) {
> -		tst_brkm(TBROK, NULL,
> -		    "-H option is REQUIRED for this test, use -h for options help");
> +		tst_exit();
>  	}
>  
>  	page_sz = getpagesize();
> @@ -206,15 +198,20 @@ main(int ac, char **av)
>   * 	     Write some known data into file and get the size of the file.
>   */
>  void
> -setup()
> +setup(void)
>  {
> -	tst_tmpdir();
> -
> -	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
> +	tst_require_root(NULL);
>  
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
>  	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +	mount_point = get_tst_tmpdir();
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point, getpid());
>  }
>  
>  /*
> @@ -223,7 +220,7 @@ setup()
>   * 	       Remove the temporary directory created.
>   */
>  void
> -cleanup()
> +cleanup(void)
>  {
>  	/*
>  	 * print timing stats if that option was specified.
> @@ -231,6 +228,6 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
>  	tst_rmdir();
>  }
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> index cac94b0..1ffb8a1 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c
> @@ -54,31 +54,26 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define HIGH_ADDR      (void *)(0x1000000000000)
>  
> -char* TEMPFILE="mmapfile";
> +char TEMPFILE[MAXPATHLEN];
>  
>  char *TCID="hugemmap03";	/* Test program identifier.    */
>  int TST_TOTAL=1;		/* Total number of test cases. */
>  unsigned long *addr;		/* addr of memory mapped region */
>  int fildes;			/* file descriptor for tempfile */
> -char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;
>  
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -void help()
> -{
> -	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");
> -}
> +void setup(void);			/* Main setup function of test */
> +void cleanup(void);			/* cleanup function for the test */
>  
>  int
>  main(int ac, char **av)
>  {
>  	int lc;			/* loop counter */
>  	char *msg;		/* message returned from parse_opts */
> -        int Hflag=0;              /* binary flag: opt or not */
>  	int page_sz;
>  
>  #if __WORDSIZE==32  /* 32-bit compiled */
> @@ -86,22 +81,16 @@ main(int ac, char **av)
>  #endif
>  
>         	option_t options[] = {
> -        	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
>              	{ NULL, NULL, NULL }          /* NULL required to end array */
>         	};
>  
>  	/* Parse standard options given to run the test. */
> -	msg = parse_opts(ac, av, options, &help);
> +	msg = parse_opts(ac, av, options, NULL);
>  	if (msg != (char *) NULL) {
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);
>  		tst_exit();
>  	}
>  
> -	if (Hflag == 0) {
> -		tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test, use -h for options help");
> -		tst_exit();
> -	}
> -
>  	page_sz = getpagesize();
>  
>  	setup();
> @@ -122,8 +111,15 @@ main(int ac, char **av)
>  		addr = mmap(HIGH_ADDR, page_sz, PROT_READ,
>  			    MAP_SHARED | MAP_FIXED, fildes, 0);
>  		if (addr != MAP_FAILED) {
> -			tst_resm(TFAIL, "Normal mmap() into high region unexpectedly succeeded on %s, errno=%d : %s",
> -				 TEMPFILE, errno, strerror(errno));
> +			tst_resm(TFAIL, "Normal mmap() into high region unexpectedly "
> +				"succeeded on %s, errno=%d : %s",
> +				TEMPFILE, errno, strerror(errno));
> +
> +			/* Unmap the mapped memory */
> +			if (munmap(addr, page_sz) != 0) {
> +				tst_brkm(TFAIL, NULL, "munmap() fails to unmap the "
> +					"memory, errno=%d", errno);
> +			}
>  			continue;
>  		} else {
>  			tst_resm(TPASS, "Normal mmap() into high region failed correctly");
> @@ -133,6 +129,7 @@ main(int ac, char **av)
>  		close(fildes);
>  	}
>  
> +	close(fildes);
>  	cleanup();
>  
>  	tst_exit();
> @@ -149,18 +146,20 @@ main(int ac, char **av)
>   * 	     Write some known data into file and get the size of the file.
>   */
>  void
> -setup()
> +setup(void)
>  {
> -	char mypid[40];
> -
> -	sprintf(mypid,"/%d",getpid());
> -	TEMPFILE=strcat(mypid,TEMPFILE);
> -	TEMPFILE=strcat(Hopt,TEMPFILE);
> +	tst_require_root(NULL);
>  
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
>  	TEST_PAUSE;
>  
> +	tst_tmpdir();
> +	mount_point = get_tst_tmpdir();
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point, getpid());
>  }
>  
>  /*
> @@ -169,7 +168,7 @@ setup()
>   * 	       Remove the temporary directory created.
>   */
>  void
> -cleanup()
> +cleanup(void)
>  {
>  	/*
>  	 * print timing stats if that option was specified.
> @@ -177,5 +176,6 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
> +	tst_rmdir();
>  }
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> index 4cc6ed4..ba606d4 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> @@ -73,10 +73,11 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "system_specific_hugepages_info.h"
> +#include "lib/libmnt.h"
>  
>  #define BUFFER_SIZE  256
>  
> -char* TEMPFILE="mmapfile";
> +char TEMPFILE[MAXPATHLEN];
>  
>  char *TCID="hugemmap04";	/* Test program identifier.    */
>  int TST_TOTAL=1;		/* Total number of test cases. */
> @@ -88,40 +89,29 @@ int beforetest=0;		/* Amount of free huge pages before testing */
>  int aftertest=0;		/* Amount of free huge pages after testing */
>  int hugepagesmapped=0;		/* Amount of huge pages mapped after testing */
>  char *Hopt;                     /* location of hugetlbfs */
> +char *mount_point = NULL;
>  
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -void help()
> -{
> -	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs \n");
> -}
> +void setup(void);			/* Main setup function of test */
> +void cleanup(void);			/* cleanup function for the test */
>  
>  int
>  main(int ac, char **av)
>  {
>  	int lc;			/* loop counter */
>  	char *msg;		/* message returned from parse_opts */
> -        int Hflag=0;              /* binary flag: opt or not */
>  	int huge_pagesize=0;
>  
>         	option_t options[] = {
> -        	{ "H:",   &Hflag, &Hopt },    /* Required for location of hugetlbfs */
>              	{ NULL, NULL, NULL }          /* NULL required to end array */
>         	};
>  
>  	/* Parse standard options given to run the test. */
> -	msg = parse_opts(ac, av, options, &help);
> +	msg = parse_opts(ac, av, options, NULL);
>  	if (msg != (char *) NULL) {
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s, use -help", msg);
>  		tst_exit();
>  	}
>  
> -	if (Hflag == 0) {
> -		tst_brkm(TBROK, NULL, "-H option is REQUIRED for this test, use -h for options help");
> -		tst_exit();
> -	}
> -
>  	/* Check number of hugepages */
>  	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
>  		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
> @@ -151,7 +141,7 @@ main(int ac, char **av)
>  		tst_resm(TINFO,"Total amount of free huge pages is %d",freepages);
>  		tst_resm(TINFO,"Max number allowed for 1 mmap file in 32-bits is 128");
>  		if (freepages > 128)
> -		  freepages=128;
> +			freepages=128;
>  #endif
>  		/*
>  		 * Call mmap
> @@ -206,16 +196,18 @@ main(int ac, char **av)
>  void
>  setup()
>  {
> -	char mypid[40];
> -
> -	sprintf(mypid,"/%d",getpid());
> -	TEMPFILE=strcat(mypid,TEMPFILE);
> -	TEMPFILE=strcat(Hopt,TEMPFILE);
> +	tst_require_root(NULL);
>  
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
>  	TEST_PAUSE;
>  
> +	tst_tmpdir();
> +	mount_point = get_tst_tmpdir();
> +
> +	mount_hugetlbfs(mount_point);
> +	hugepage_alloc(1024);
> +
> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", mount_point, getpid());
>  }
>  
>  /*
> @@ -232,5 +224,6 @@ cleanup()
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
> -
> +	umount_hugetlbfs(mount_point);
> +	tst_rmdir();
>  }
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile b/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile
> new file mode 100644
> index 0000000..f37b87a
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/lib/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#  Copyright (c) International Business Machines  Corp., 2001
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> +#
> +
> +top_srcdir		?= ../../../../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +LIB			:= libmnt_hugetlb.a
> +
> +include $(top_srcdir)/include/mk/lib.mk
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c
> new file mode 100644
> index 0000000..ac7fadb
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.c
> @@ -0,0 +1,70 @@
> +/*
> + *
> + *   Copyright (c) International Business Machines  Corp., 2001
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +/*
> + * NAME
> + *	libmnt.c
> + *
> + * DESCRIPTION
> + *	Helper functions for mounting hugetlbfs automatically.
> + *
> + *	The library contains the following routines:
> + *
> + *	hugepage_alloc()
> + *	mount_hugetlbfs()
> + *	umount_hugetlbfs()
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mount.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +
> +#include "test.h"
> +
> +#include "libmnt.h"
> +
> +void
> +hugepage_alloc(int num)
> +{
> +	FILE *file = fopen("/proc/sys/vm/nr_hugepages", "w+");
> +	if (file == NULL) {
> +		tst_brkm(TBROK|TERRNO, NULL, "fopen failed on /proc/sys/vm/nr_hugepages");
> +	}
> +
> +	if (fprintf(file, "%d", num) < 0) {
> +		tst_brkm(TBROK|TERRNO, NULL, "fprintf failed on /proc/sys/vm/nr_hugepages");
> +	}
> +
> +	fclose(file);
> +}

Actually this may fail silently. The FILE abstraction is buffered, so
the fprintf() will succeed as it is writing only to the FILE buffer
(which is empty just after the file was opened and because of that the
buffer flush is not likely triggered) and so the real write to the
"/proc/sys/vm/nr_hugepages" is done at the point you are calling
fclose() which, when something went wrong, may return failure.

Also the LKML coding style says that adding curly braces around one line
statements is pointless.

> +void
> +mount_hugetlbfs(char *mount_point)
> +{
> +	if (mount("none", mount_point, "hugetlbfs", 0, NULL) < 0) {
> +		tst_brkm(TBROK|TERRNO, NULL, "mount failed on %s", mount_point);
> +	}
> +}
> +
> +void
> +umount_hugetlbfs(char *mount_point)
> +{
> +	umount(mount_point);
> +}

The umount() can fail too and I would rather see error message in the
logs, which would save time when figuring out what went wrong.

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h
> new file mode 100644
> index 0000000..b9b26ed
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/lib/libmnt.h
> @@ -0,0 +1,27 @@
> +/*
> + *
> + *   Copyright (c) International Business Machines  Corp., 2001

Shouldn't this line rather be "Copyright Fujitsu (c) 2011"?

> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +/*
> + * libmnt.h - functions to mount hugetlbfs automatically.
> + */
> +
> +void hugepage_alloc(int num);
> +void mount_hugetlbfs(char *mount_point);
> +void umount_hugetlbfs(char *mount_point);
> +

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
