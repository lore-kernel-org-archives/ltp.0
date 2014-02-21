Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WGeY8-0007Wv-P1
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 01:05:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGeY6-00082I-Pm
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 01:05:08 +0000
Message-ID: <1392944689.2006.17.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 21 Feb 2014 09:04:49 +0800
In-Reply-To: <1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
References: <1392372604.2085.10.camel@G08JYZSD130126>
	<1392372746.2085.11.camel@G08JYZSD130126>
	<1615091378.3633979.1392375266510.JavaMail.zimbra@redhat.com>
	<1392802716.2083.4.camel@G08JYZSD130126>
	<1392802803.2083.5.camel@G08JYZSD130126>
	<1795224124.5672526.1392809381205.JavaMail.zimbra@redhat.com>
	<1392889204.2053.7.camel@G08JYZSD130126>
	<1392889813.2053.10.camel@G08JYZSD130126>
	<1128042688.6449127.1392894329625.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Thu, 2014-02-20 at 06:05 -0500, Jan Stancek wrote:
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

Thanks for your review.

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

Yes. We can remove that. And it looks well. :)

> I'm going to try this testcase on ia64 to have a look at that
> ia64 specific setup.
> 

Thank you very much.
Best regards,
Zeng

> Regards,
> Jan
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
