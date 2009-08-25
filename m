Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfsnK-00088O-0m
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:26 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfsnF-0007KG-Re
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:25 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7P9vtKk015636
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:57:55 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7P9wE30241452
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:58:14 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7P9wETC011427
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 05:58:14 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090824.214834.232757270.caiqian@cclom.cn>
References: <20090824.214834.232757270.caiqian@cclom.cn>
Date: Tue, 25 Aug 2009 15:28:10 +0530
Message-Id: <1251194290.5534.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3 v3] Fix unshare02
Reply-To: subrata@linux.vnet.ibm.com
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-08-24 at 21:48 +0800, CAI Qian wrote: 
> v3: simplify reporting by using TERRNO.
> 
> v2: remove unneeded linux_syscall_numbers.h and simplify the checking of
> errno according to Mike's suggestion.
> 
> When no unshare function found during the build-time checking or the
> kernel returns ENOSYS, it reports TCONF. It also simplify logic a little
> bit and fix some coding style issues. In addition, the original test
> expects the following call to return 0,
> 
>   TEST_RETURN = unshare(-1);
> 
> and checking TEST_ERRNO for errors. Those look like incorrect, since
> "-1" looks like an invalid flag, and TEST_ERRNO does not set to errno
> from the syscall. It has been modified to expect,
> 
>   TEST_RETURN = -1;
>   errno = EINVAL;
> 
> Signed-off-by: CAI Qian <caiqian@cclom.cn>

Thanks.

Regards--
Subrata

> 
>  testcases/kernel/syscalls/unshare/unshare02.c |   78 ++++++++++++++++---------
>  1 files changed, 51 insertions(+), 27 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
> index 1075936..1b2f125 100644
> --- a/testcases/kernel/syscalls/unshare/unshare02.c
> +++ b/testcases/kernel/syscalls/unshare/unshare02.c
> @@ -56,7 +56,7 @@
>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"
> -#include "linux_syscall_numbers.h"
> +#include "config.h"
> 
>  /* Extern Global Variables */
>  extern int Tst_count;           /* counter for tst_xxx routines.         */
> @@ -67,6 +67,8 @@ char *TCID = "unshare02";  /* Test program identifier.*/
>  int  testno;
>  int  TST_TOTAL = 2;                   /* total number of tests in this file.   */
> 
> +#ifdef HAVE_UNSHARE
> +
>  /* Extern Global Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -141,37 +143,53 @@ int main(int ac, char **av) {
>   *fork a child process;testing which one is a child or a parent;
>   * */
>  		        TEST(pid1=fork());    //call to fork()
> -			if (TEST_RETURN == -1){
> -			tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> -			cleanup();
> -			tst_exit();
> -			}
> -			else if (TEST_RETURN == 0){
> -				if((TEST_RETURN = unshare(-1)) == 0) {
> -	        		tst_resm(TPASS, "Call succeeded");
> +			if (TEST_RETURN == -1) {
> +				tst_resm(TFAIL|TTERRNO,
> +					"fork() failed.");
> +				cleanup();
>  				tst_exit();
> +			} else if (TEST_RETURN == 0) {
> +				TEST_RETURN = unshare(-1);
> +				if (TEST_RETURN == 0)
> +					tst_resm(TFAIL,
> +						"Call unexpectedly succeeded.");
> +				else if (TEST_RETURN == -1) {
> +					if (errno == EINVAL)
> +						tst_resm(TPASS|TERRNO,
> +							"Expect EINVAL.");
> +					else if (errno == ENOSYS)
> +						tst_resm(TCONF,
> +							"unshare is not "
> +							"implemented in kernel."
> +							);
> +					else
> +						tst_resm(TFAIL|TERRNO,
> +							"Test failed.");
>  				}
> -				else if (TEST_RETURN == -1 ){
> -					tst_resm(TFAIL,"Test Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> -					tst_exit();
> -                     			}
> +				tst_exit();
>  			}
> 
>  			TEST(pid1=fork());    //call to fork()
> -                        if (pid1 == -1){
> -                        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> -                        cleanup();
> -                        tst_exit();
> -                        }
> -                        else if (TEST_RETURN == 0){
> -                                if((TEST_RETURN = unshare((int)NULL)) == 0) {
> -                                tst_resm(TPASS, "Call succeeded");
> +			if (pid1 == -1) {
> +				tst_resm(TFAIL|TTERRNO,
> +					"fork() failed.");
> +				cleanup();
> +				tst_exit();
> +			} else if (TEST_RETURN == 0) {
> +				TEST_RETURN = unshare((int)NULL);
> +				if (TEST_RETURN == 0)
> +					tst_resm(TPASS, "Call succeeded");
> +				else if (TEST_RETURN == -1) {
> +					if (errno == ENOSYS)
> +						tst_resm(TCONF,
> +							"unshare is not "
> +							"implemented in kernel."
> +							);
> +					else
> +						tst_resm(TFAIL|TERRNO,
> +							"Test failed 2. ");
> +				}
>  				tst_exit();
> -                                }
> -                                else if (TEST_RETURN == -1 ){
> -                                        tst_resm(TFAIL,"Test Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> -					tst_exit();
> -                                        }
>                          }
> 
> 
> @@ -180,4 +198,10 @@ int main(int ac, char **av) {
>  	cleanup();
>          tst_exit();
>  }
> -
> +#else
> +int main(void)
> +{
> +	tst_resm(TCONF, "unshare is undefined.");
> +	return 0;
> +}
> +#endif
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
