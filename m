Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MfrTR-0006G7-5Q
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 08:33:49 +0000
Received: from smtp103.biz.mail.re2.yahoo.com ([68.142.229.217])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MfrTM-000280-No
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 08:33:49 +0000
Date: Tue, 25 Aug 2009 16:34:37 +0800 (CST)
Message-Id: <20090825.163437.1076064300636358628.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
In-Reply-To: <1251184057.5534.4.camel@subratamodak.linux.ibm.com>
References: <20090824.023736.115924320.caiqian@cclom.cn>
	<1251184057.5534.4.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Let set_thread_area Choose either user_desc or
 modify_ldt_ldt_s
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
To: ltp-list@lists.sf.net

From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH] Let set_thread_area Choose either user_desc or modify_ldt_ldt_s
Date: Tue, 25 Aug 2009 12:37:37 +0530

> Cai,
> 
> On Mon, 2009-08-24 at 02:37 +0800, CAI Qian wrote:
> > Old glibc (like in RHEL4) has modify_ldt_ldt_s instead of user_desc
> > structure defined in asm/ldt.h. It should follow the example of
> > modify_ldt test cases to choose the feasible structure based on
> > build-time checking. Also, a new header file has been created to handle
> > code duplication.
> > 
> > Signed-off-by: CAI Qian <caiqian@cclom.cn>
> > 
> >  .../syscalls/set_thread_area/set_thread_area.h     |   32 ++++++++++++++++++++
> >  .../syscalls/set_thread_area/set_thread_area01.c   |   13 +-------
> >  .../syscalls/set_thread_area/set_thread_area02.c   |   14 +-------
> >  3 files changed, 36 insertions(+), 23 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area.h b/testcases/kernel/syscalls/set_thread_area/set_thread_area.h
> > new file mode 100644
> > index 0000000..66e9278
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area.h
> > @@ -0,0 +1,32 @@
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <linux/unistd.h>
> > +
> > +/* Harness Specific Include Files. */
> > +#include "test.h"
> > +#include "usctest.h"
> > +#include "linux_syscall_numbers.h"
> 
> Do not include these 3 headers into some other header file. Instead,
> keep them inside the main *.c file only. Let only the set_thread*
> specific stuff be inside this header.
>

Why?
 
> > +#include "config.h"
> > +
> > +#if defined HAVE_ASM_LDT_H
> > +#include <asm/ldt.h>
> > +
> > +#if defined HAVE_STRUCT_USER_DESC
> > +typedef struct user_desc thread_area_s;
> > +#elif defined HAVE_STRUCT_MODIFY_LDT_LDT_S
> > +typedef struct modify_ldt_ldt_s thread_area_s;
> > +#else
> > +typedef struct user_desc {
> > +	unsigned int entry_number;
> > +	unsigned long int base_addr;
> > +	unsigned int limit;
> > +	unsigned int seg_32bit:1;
> > +	unsigned int contents:2;
> > +	unsigned int read_exec_only:1;
> > +	unsigned int limit_in_pages:1;
> > +	unsigned int seg_not_present:1;
> > +	unsigned int useable:1;
> > +	unsigned int empty:25;
> > +} thread_area_s;
> > +#endif /* HAVE_STRUCT_USER_DESC */
> > +#endif /* HAVE_ASM_LDT_H */
> > diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> > index 6f10c05..a6aacf8 100644
> > --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> > +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> > @@ -48,15 +48,8 @@
> >  /* History:     Porting from Crackerjack to LTP is done by                    */
> >  /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
> >  /******************************************************************************/
> > -#include <stdio.h>
> > -#include <errno.h>
> > -#include <linux/unistd.h>
> > +#include "set_thread_area.h"
> > 
> > -/* Harness Specific Include Files. */
> > -#include "test.h"
> > -#include "usctest.h"
> > -#include "linux_syscall_numbers.h"
> 
> Keep them here only.
> 
> > -#include "config.h"
> > 
> >  /* Global Variables */
> >  char *TCID = "set_thread_area01";  /* Test program identifier.*/
> > @@ -64,8 +57,6 @@ int  testno;
> >  int  TST_TOTAL = 2;                   /* total number of tests in this file.   */
> > 
> >  #if defined HAVE_ASM_LDT_H
> > -#include <asm/ldt.h>
> > -
> >  /* Extern Global Variables */
> >  extern int Tst_count;           /* counter for tst_xxx routines.         */
> >  extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> > @@ -124,7 +115,7 @@ void setup() {
> > 
> >  int main(int ac, char **av) {
> >          
> > -	struct user_desc u_info;
> > +        thread_area_s u_info;
> >          int lc;                 /* loop counter */
> >          char *msg;              /* message returned from parse_opts */
> >  	
> > diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
> > index 3effebd..1b351c1 100644
> > --- a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
> > +++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
> > @@ -49,15 +49,7 @@
> >  /* History:     Porting from Crackerjack to LTP is done by                    */
> >  /*              Manas Kumar Nayak maknayak@in.ibm.com>                        */
> >  /******************************************************************************/
> > -#include <stdio.h>
> > -#include <errno.h>
> > -#include <linux/unistd.h>
> > -
> > -/* Harness Specific Include Files. */
> > -#include "test.h"
> > -#include "usctest.h"
> > -#include "linux_syscall_numbers.h"
> 
> Same here.
> 
> Regards--
> Subrata
> 
> > -#include "config.h"
> > +#include "set_thread_area.h"
> > 
> >  /* Global Variables */
> >  char *TCID = "set_thread_area_02";  /* Test program identifier.*/
> > @@ -65,8 +57,6 @@ int  testno;
> >  int  TST_TOTAL = 3;                   /* total number of tests in this file.   */
> > 
> >  #if defined HAVE_ASM_LDT_H
> > -#include <asm/ldt.h>
> > -
> >  /* Extern Global Variables */
> >  extern int Tst_count;           /* counter for tst_xxx routines.         */
> >  extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
> > @@ -125,7 +115,7 @@ void setup() {
> > 
> >  int main(int ac, char **av) {
> >          
> > -	struct user_desc u_info;
> > +	thread_area_s u_info;
> >          int lc;                 /* loop counter */
> >          char *msg;              /* message returned from parse_opts */
> >  	
> > 
> > ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> > trial. Simplify your report design, integration and deployment - and focus on 
> > what you do best, core application coding. Discover what's new with 
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
