From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 6 May 2021 03:35:02 +0000
Subject: [LTP] [PATCH] syscalls/unlinkat01: Bugfix and update to new API
Message-ID: <ebf341b8fdd0424aae31204b4376d559@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Thanks for your review!

> > -char *TCID = "unlinkat01";
> > -int TST_TOTAL = TEST_CASES;
> > -
> >  static const char pathname[] = "unlinkattestdir",
> >  		  subpathname[] = "unlinkatsubtestdir",
> >  		  subpathdir[] = "unlinkattestdir/unlinkatsubtestdir",
> > @@ -65,82 +41,79 @@ static const int flags[] = { 0, 0, 0, 0, 9999, 0,
> > AT_REMOVEDIR };
> 
> Could you please use static struct for testcases data which is the usual way
> in LTP instead of using arrays? (e.g. in
> testcases/kernel/syscalls/access/access02.c).
> It helps to the readability of the code as we'll be able to remove lines like:
> 	fds[1] = fds[4] = fds[6] = fds[0];
> 
> and most of the setup.
> 
> Than you can then drop also TEST_CASES.

It is more clearer that using arrays, but in this case, fds and filenames can not be complete initialized at first, so it seems there are some trouble to cleanup,

Chould you give me some suggestions for it?


Thanks so much!

Best Regards,
Gongyi


> 
> Hi Zhao,
> 
> > 1) When run the test with option "-i 2", test will fail, and fixed
> Good catch!
> 
> > 2) Update to new API
> Great! Yes it's working, but it deserves more improvements.
> 
> ...
> > diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
> > b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
> ...
> > - * Author
> > - *	Yi Yang <yyangcdl@cn.ibm.com>
> > + * AUTHOR: Yi Yang <yyangcdl@cn.ibm.com>
> nit: * Author: Yi Yang <yyangcdl@cn.ibm.com>
> 
> > + */
> > +
> > +/*\
> > + * [Description]
> > + * This test case will verify basic function of unlinkat
> > + * added by kernel 2.6.16 or up.
> nit: * Basic unlinkat() tests.
> 
> >   */
> 
> >  #define _GNU_SOURCE
> IMHO you can remove this one.
> 
> > -#include <sys/types.h>
> > -#include <sys/stat.h>
> > -#include <sys/time.h>
> > -#include <fcntl.h>
> > -#include <stdlib.h>
> > -#include <errno.h>
> > -#include <string.h>
> > -#include <signal.h>
> > -#include "test.h"
> > -#include "safe_macros.h"
> 
> > +#include <linux/limits.h>
> Why this kernel header? I guess for PATH_MAX, but for that please use
> <limits.h> (We try to avoid using kernel headers for basic things not
> related to testing. There is also glibc vs. kernel header clash:
> https://sourceware.org/glibc/wiki/Synchronizing_Headers)
> 
> > +#include "tst_test.h"
> >  #include "lapi/syscalls.h"
> > +#include "tst_safe_stdio.h"
> 
> >  #define TEST_CASES 7
> > +
> >  #ifndef AT_FDCWD
> >  #define AT_FDCWD -100
> >  #endif
> > @@ -45,12 +27,6 @@
> >  #define AT_REMOVEDIR 0x200
> >  #endif
> AT_FDCWD and AT_REMOVEDIR has been added to <fcntl.h> 10+ years
> ago, we could safely remove it. But we have them in lapi/fcntl.h, let's use
> this header please.
> 
> > -void setup();
> > -void cleanup();
> > -
> > -char *TCID = "unlinkat01";
> > -int TST_TOTAL = TEST_CASES;
> > -
> >  static const char pathname[] = "unlinkattestdir",
> >  		  subpathname[] = "unlinkatsubtestdir",
> >  		  subpathdir[] = "unlinkattestdir/unlinkatsubtestdir",
> > @@ -65,82 +41,79 @@ static const int flags[] = { 0, 0, 0, 0, 9999, 0,
> > AT_REMOVEDIR };
> 
> Could you please use static struct for testcases data which is the usual way
> in LTP instead of using arrays? (e.g. in
> testcases/kernel/syscalls/access/access02.c).
> It helps to the readability of the code as we'll be able to remove lines like:
> 	fds[1] = fds[4] = fds[6] = fds[0];
> 
> and most of the setup.
> 
> Than you can then drop also TEST_CASES.
> 
> >  int myunlinkat(int dirfd, const char *filename, int flags)  {
> > -	return ltp_syscall(__NR_unlinkat, dirfd, filename, flags);
> > +	return tst_syscall(__NR_unlinkat, dirfd, filename, flags);
> >  }
> Could you please use unlinkat() libc implementation? It was added to glibc
> in 2.4, musl has it also for 10+ years. Or you can use both raw syscall and
> libc variant via .test_variants (not needed, we added more variants for
> some tests, but most of syscall tests does not cover it).
> 
> > -int main(int ac, char **av)
> > +static void run(int i)
> i needs to be unsigned int. Compiler warned you (it's good to pay attention
> to the warnings and don't introduce new ones).
> 
> >  {
> > -	int lc;
> > -	int i;
> > -
> > -	if ((tst_kvercmp(2, 6, 16)) < 0)
> > -		tst_brkm(TCONF, NULL, "Test must be run with kernel 2.6.16+");
> > -
> > -	tst_parse_opts(ac, av, NULL, NULL);
> > -
> > -	setup();
> > -
> > -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > -		tst_count = 0;
> > -
> > -		for (i = 0; i < TST_TOTAL; i++) {
> > -			TEST(myunlinkat(fds[i], filenames[i], flags[i]));
> > -
> > -			if (TEST_ERRNO == expected_errno[i]) {
> > -				tst_resm(TPASS | TTERRNO,
> > -					 "unlinkat() returned expected errno");
> > -			} else {
> > -				tst_resm(TFAIL | TTERRNO, "unlinkat() failed");
> > -			}
> > -		}
> > -
> > +	if (!expected_errno[i]) {
> > +		fds[0] = SAFE_OPEN(pathname, O_DIRECTORY);
> > +		fds[1] = fds[4] = fds[6] = fds[0];
> > +
> > +		/* tesfile2 will be unlinked by test0. */
> > +		if (access(testfile2, F_OK))
> > +			SAFE_FILE_PRINTF(testfile2, testfile2);
> > +
> > +		/* testfile3 will be unlined by test1. */
> > +		if (access(testfile3, F_OK))
> > +			SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
> > +
> > +		/* subpathdir will be unlinked by test6. */
> > +		if (access(subpathdir, F_OK))
> > +			SAFE_MKDIR(subpathdir, 0700);
> > +	} else
> > +		fds[2] = SAFE_OPEN(testfile3, O_CREAT | O_RDWR, 0600);
> > +
> > +	/* testfile must exist except test1 and test6. */
> > +	if (access(testfile, F_OK))
> > +		SAFE_FILE_PRINTF(testfile, testfile);
> > +
> > +	TEST(myunlinkat(fds[i], filenames[i], flags[i]));
> > +	if (TST_ERR == expected_errno[i])
> > +		tst_res(TPASS | TTERRNO, "unlinkat() returned expected errno");
> > +	else
> > +		tst_res(TFAIL | TTERRNO, "unlinkat() failed");
> > +
> > +	if (!expected_errno[i]) {
> > +		SAFE_CLOSE(fds[0]);
> > +	} else {
> > +		SAFE_CLOSE(fds[2]);
> >  	}
> You can remove { } for consistency with previous.
> 
> Kind regards,
> Petr
