Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WGTHh-0008DF-1q
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 13:03:25 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGTHf-0005M5-5h
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 13:03:24 +0000
Date: Thu, 20 Feb 2014 08:03:05 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <929738145.6498501.1392901385804.JavaMail.zimbra@redhat.com>
In-Reply-To: <1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1615091378.3633979.1392375266510.JavaMail.zimbra@redhat.com>
	<1392802716.2083.4.camel@G08JYZSD130126>
	<1392802803.2083.5.camel@G08JYZSD130126>
	<1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>
	<1392889204.2053.7.camel@G08JYZSD130126>
	<1392889813.2053.10.camel@G08JYZSD130126>
	<1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3 2/2] mlock/mlock02.c: add EPERM and ENOMEM
 errno tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> Sent: Thursday, 20 February, 2014 12:05:29 PM
> Subject: Re: [LTP] [PATCH v3 2/2] mlock/mlock02.c: add EPERM and ENOMEM errno tests
> 
> 
> 
> ----- Original Message -----
> > From: "Zeng Linggang" <zenglg.jy@cn.fujitsu.com>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: "ltp-list" <ltp-list@lists.sourceforge.net>
> > Sent: Thursday, 20 February, 2014 10:50:13 AM
> > Subject: [PATCH v3 2/2] mlock/mlock02.c: add EPERM and ENOMEM errno tests
> > 
> > Add EPERM and ENOMEM errno tests for mlock(2).
> > 
> > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> 
> Hi,
> 
> part1 looks good to me, comments for part2 are inline.
> 
> > ---
> >  testcases/kernel/syscalls/mlock/mlock02.c | 65
> >  +++++++++++++++++++++++++++++--
> >  1 file changed, 62 insertions(+), 3 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/mlock/mlock02.c
> > b/testcases/kernel/syscalls/mlock/mlock02.c
> > index 811d141..79f1d29 100644
> > --- a/testcases/kernel/syscalls/mlock/mlock02.c
> > +++ b/testcases/kernel/syscalls/mlock/mlock02.c
> > @@ -20,13 +20,22 @@
> >   * ALGORITHM
> >   * 	test 1:
> >   *		Call mlock with a NULL address.  ENOMEM should be returned
> > + *	test 2:
> > + *		The caller was not privileged and its RLIMIT_MEMLOCK soft
> > + *		resource limit was 0. EPERM should be returned
> > + *	test 3:
> > + *		The caller was not privileged and its RLIMIT_MEMLOCK soft
> > + *		resource limit was nonzero, but tried to lock more memory than
> > + *		the limit permitted. ENOMEM should be returned
> >   */
> >  
> >  #include <errno.h>
> >  #include <unistd.h>
> >  #include <sys/mman.h>
> > +#include <pwd.h>
> >  #include "test.h"
> >  #include "usctest.h"
> > +#include "safe_macros.h"
> >  
> >  char *TCID = "mlock02";
> >  
> > @@ -36,21 +45,29 @@ struct test_case_t {
> >  	void **addr;
> >  	int len;
> >  	int error;
> > -	void (*setupfunc) (struct test_case_t *);
> > +	void (*setupfunc) ();
> 
> If you don't want any parameters add void.
> 
> > +	void (*cleanupfunc) (void);
> >  };
> >  
> >  static void *addr1;
> > +static char addr2[1024];
> > +static struct passwd *ltpuser;
> >  static void setup(void);
> >  static void setup1(struct test_case_t *);
> > +static void setup2(void);
> > +static void setup3(void);
> > +static void cleanup2(void);
> >  static void cleanup(void);
> >  static void mlock_verify(struct test_case_t *);
> >  
> >  static struct test_case_t TC[] = {
> > -	{&addr1, 1024, ENOMEM, setup1},
> > +	{&addr1, 1024, ENOMEM, setup1, NULL},
> > +	{(void **)&addr2, 1024, EPERM, setup2, cleanup2},
> > +	{(void **)&addr2, 1024, ENOMEM, setup3, cleanup2},
> >  };
> 
> I think I misunderstood intent of **addr. As you outlined it
> above, we can remove one pointer entirely along with addr1:
> 
> -static void *addr1;
> 
>  struct test_case_t {
> -       void **addr;
> +       void *addr;
> 
>  static struct test_case_t TC[] = {
> -       {&addr1, 1024, ENOMEM, setup1, NULL},
> -       {(void **)&addr2, 1024, EPERM, setup2, cleanup2},
> -       {(void **)&addr2, 1024, ENOMEM, setup3, cleanup2},
> +       {NULL, 1024, ENOMEM, setup1, NULL},
> +       {addr2, 1024, EPERM, setup2, cleanup2},
> +       {addr2, 1024, ENOMEM, setup3, cleanup2},
> 
>  static void mlock_verify(struct test_case_t *test)
> -       TEST(mlock(*(test->addr), test->len));
> +       TEST(mlock(test->addr, test->len));
> 
>  static void setup1(struct test_case_t *test)
> -#else
> -       *test->addr = NULL;
> 
> 
> I'm going to try this testcase on ia64 to have a look at that
> ia64 specific setup.

ia64 maps something at that area with pagesize length:

# cat /proc/self/maps 
00000000-00004000 r--p 00000000 00:00 0 
2000000000000000-200000000003c000 r-xp 00000000 fd:00 950277             /lib/ld-2.5.so
2000000000048000-2000000000050000 rw-p 00038000 fd:00 950277             /lib/ld-2.5.so
2000000000050000-20000000002c0000 r-xp 00000000 fd:00 950284             /lib/libc-2.5.so
20000000002c0000-20000000002cc000 ---p 00270000 fd:00 950284             /lib/libc-2.5.so
20000000002cc000-20000000002d4000 rw-p 0026c000 fd:00 950284             /lib/libc-2.5.so
20000000002d4000-20000000002e4000 rw-p 20000000002d4000 00:00 0 
20000000002e4000-2000000003af4000 r--p 00000000 fd:00 69955              /usr/lib/locale/locale-archive
4000000000000000-4000000000008000 r-xp 00000000 fd:00 524317             /bin/cat
6000000000004000-600000000000c000 rw-p 00004000 fd:00 524317             /bin/cat
600000000000c000-6000000000030000 rw-p 600000000000c000 00:00 0          [heap]
600007fffffa8000-600007fffffac000 rw-p 600007fffffa8000 00:00 0 
60000ffffff50000-60000ffffffa4000 rw-p 60000ffffffa8000 00:00 0          [stack]
a000000000000000-a000000000020000 r-xp 00000000 00:00 0                  [vdso]

I think we can make that generic and get rid of that ifdef:

 static void setup1(struct test_case_t *test)
 {
-#ifdef __ia64__
-       test->len = getpagesize() + 1;
-#else
-       *test->addr = NULL;
-#endif
+       /* find some unmapped area */
+       test->addr = mmap(NULL, getpagesize(), PROT_NONE,
+                MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+       if (test->addr == MAP_FAILED)
+               tst_brkm(TBROK | TERRNO, cleanup, "mmap");
+       if (munmap(test->addr, getpagesize()) < 0)
+               tst_brkm(TBROK | TERRNO, cleanup, "munmap");
 }

Works for me on x86 and ia64. I can post it afterwards (rebased to latest
version of your patches).

Regards,
Jan

> 
> Regards,
> Jan
> 
> >  
> >  int TST_TOTAL = ARRAY_SIZE(TC);
> > -static int exp_enos[] = { ENOMEM, 0 };
> > +static int exp_enos[] = { ENOMEM, EPERM, 0 };
> >  
> >  int main(int ac, char **av)
> >  {
> > @@ -76,9 +93,13 @@ int main(int ac, char **av)
> >  
> >  static void setup(void)
> >  {
> > +	tst_require_root(NULL);
> > +
> >  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> >  
> >  	TEST_PAUSE;
> > +
> > +	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
> >  }
> >  
> >  static void mlock_verify(struct test_case_t *test)
> > @@ -88,6 +109,9 @@ static void mlock_verify(struct test_case_t *test)
> >  
> >  	TEST(mlock(*(test->addr), test->len));
> >  
> > +	if (test->cleanupfunc != NULL)
> > +		test->cleanupfunc();
> > +
> >  	if (TEST_RETURN != -1) {
> >  		tst_resm(TFAIL, "mlock succeeded unexpectedly");
> >  		return;
> > @@ -111,6 +135,41 @@ static void setup1(struct test_case_t *test)
> >  #endif
> >  }
> >  
> > +static void setup2(void)
> > +{
> > +	struct rlimit rl;
> > +
> > +	rl.rlim_max = 0;
> > +	rl.rlim_cur = 0;
> > +	if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
> > +		tst_brkm(TBROK, cleanup,
> > +			 "setrlimit failed to set the resource for "
> > +			 "RLIMIT_MEMLOCK to check for mlock()");
> > +	}
> > +
> > +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
> > +}
> > +
> > +static void setup3(void)
> > +{
> > +	struct rlimit rl;
> > +
> > +	rl.rlim_max = 1;
> > +	rl.rlim_cur = 1;
> > +	if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
> > +		tst_brkm(TBROK, cleanup,
> > +			 "setrlimit failed to set the resource for "
> > +			 "RLIMIT_MEMLOCK to check for mlock()");
> > +	}
> > +
> > +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
> > +}
> > +
> > +static void cleanup2(void)
> > +{
> > +	SAFE_SETEUID(cleanup, 0);
> > +}
> > +
> >  static void cleanup(void)
> >  {
> >  	TEST_CLEANUP;
> > --
> > 1.8.4.2
> > 
> > 
> > 
> > 
> 
> ------------------------------------------------------------------------------
> Managing the Performance of Cloud-Based Applications
> Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
> Read the Whitepaper.
> http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
