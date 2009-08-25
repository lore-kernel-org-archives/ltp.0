Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MfsnH-0004tR-Pj
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:23 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfsnC-0005Ji-Cy
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 09:58:23 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7P9qXFt018589
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:52:33 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7P9w9A2212012
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7P9w9MD032541
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Aug 2009 03:58:09 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090824.214707.245407769.caiqian@cclom.cn>
References: <20090824.214707.245407769.caiqian@cclom.cn>
Date: Tue, 25 Aug 2009 15:28:06 +0530
Message-Id: <1251194286.5534.22.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3 v3] Fix unshare01
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

On Mon, 2009-08-24 at 21:47 +0800, CAI Qian wrote: 
> v3: simplify reporting by using TERRNO.
> 
> v2: remove unneeded linux_syscall_numbers.h and simplify the checking of
> errno according to Mike's suggestion.
> 
> When no unshare function found during the build-time checking or the
> kernel returns ENOSYS, it reports TCONF. It also simplify logic a little
> bit and fix some coding style issues.
> 
> Signed-off-by: CAI Qian <caiqian@cclom.cn>

Thanks.

Regards--
Subrata

> 
>  testcases/kernel/syscalls/unshare/unshare01.c |   94 +++++++++++++++++-------
>  1 files changed, 66 insertions(+), 28 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
> index 2a7cc1b..a928e65 100644
> --- a/testcases/kernel/syscalls/unshare/unshare01.c
> +++ b/testcases/kernel/syscalls/unshare/unshare01.c
> @@ -92,7 +92,7 @@
>  /* Harness Specific Include Files. */
>  #include "test.h"
>  #include "usctest.h"
> -#include "linux_syscall_numbers.h"
> +#include "config.h"
> 
>  /* Extern Global Variables */
>  extern int Tst_count;           /* counter for tst_xxx routines.         */
> @@ -103,6 +103,8 @@ char *TCID = "unshare01";  /* Test program identifier.*/
>  int  testno;
>  int  TST_TOTAL =1;                   /* total number of tests in this file.   */
> 
> +#ifdef HAVE_UNSHARE
> +
>  /* Extern Global Functions */
>  /******************************************************************************/
>  /*                                                                            */
> @@ -177,47 +179,77 @@ int main(int ac, char **av) {
>   *fork a child process;testing which one is a child or a parent;
>   * */
>  		        TEST(pid1=fork());    //call to fork()
> -			if (TEST_RETURN == -1){
> -				tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +			if (TEST_RETURN == -1) {
> +				tst_resm(TFAIL|TTERRNO, "fork() failed.");
>  				cleanup();
>  				tst_exit();
> -			}else if (TEST_RETURN == 0){
> -				if((TEST_RETURN = unshare(CLONE_FILES)) == 0) {
> -	        		tst_resm(TPASS, "unshare with CLONE_FILES call succeeded");
> +			} else if (TEST_RETURN == 0) {
> +				TEST_RETURN = unshare(CLONE_FS);
> +				if (TEST_RETURN == 0)
> +					tst_resm(TPASS,
> +						"unshare with CLONE_FILES call "
> +						"succeeded");
> +				else if (TEST_RETURN == -1) {
> +					if (errno == ENOSYS)
> +						tst_resm(TCONF,
> +							"unshare is not "
> +							"implemented in kernel."
> +							);
> +					else
> +						tst_resm(TFAIL|TERRNO,
> +							"unshare failed.");
> +				}
>  				tst_exit();
> -				}else if (TEST_RETURN == -1 )
> -					tst_resm(TFAIL,"unshare Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> -					tst_exit();
>  			}else{
>  			}
> 
>  			TEST(pid1=fork());    //call to fork()
> -                        if (TEST_RETURN == -1){
> -                	        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +			if (TEST_RETURN == -1) {
> +				tst_resm(TFAIL|TTERRNO, "fork() failed.");
>  	                        cleanup();
>                          	tst_exit();
> -                        }else if (TEST_RETURN == 0){
> -                                if((TEST_RETURN = unshare(CLONE_FS)) == 0) {
> -                                	tst_resm(TPASS, "unshare with CLONE_FS call succeeded");
> -					tst_exit();
> -                                }else if (TEST_RETURN == -1 )
> -                                        tst_resm(TFAIL,"unshare Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> -					tst_exit();
> +			} else if (TEST_RETURN == 0) {
> +				TEST_RETURN = unshare(CLONE_FS);
> +				if (TEST_RETURN == 0)
> +					tst_resm(TPASS,
> +						"unshare with CLONE_FS call "
> +						"succeeded");
> +				else if (TEST_RETURN == -1) {
> +					if (errno == ENOSYS)
> +						tst_resm(TCONF,
> +							"unshare is not "
> +							"implemented in kernel."
> +							);
> +					else
> +						tst_resm(TFAIL|TERRNO,
> +							"unshare failed 2.");
> +				}
> +				tst_exit();
>                          }else{
>  			}
> 
>  			TEST(pid1=fork());    //call to fork()
> -                        if (TEST_RETURN == -1){
> -                	        tst_resm(TFAIL, "fork() Failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> +			if (TEST_RETURN == -1) {
> +				tst_resm(TFAIL|TTERRNO, "fork() failed.");
>  	                        cleanup();
>                          	tst_exit();
> -                        }else if (TEST_RETURN == 0){
> -                                if((TEST_RETURN = unshare(CLONE_NEWNS)) == 0) {
> -                                	tst_resm(TPASS, "unshare call with CLONE_NEWNS succeeded");
> -					tst_exit();
> -                                }else if (TEST_RETURN == -1 )
> -                                        tst_resm(TFAIL,"unshare Failed 2, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> -					tst_exit();
> +			} else if (TEST_RETURN == 0) {
> +				TEST_RETURN = unshare(CLONE_NEWNS);
> +				if (TEST_RETURN == 0) {
> +					tst_resm(TPASS,
> +						"unshare call with CLONE_NEWNS "
> +						"succeeded");
> +				} else if (TEST_RETURN == -1) {
> +					if (errno == ENOSYS)
> +						tst_resm(TCONF,
> +							"unshare is not "
> +							"implemented in kernel."
> +							);
> +					else
> +						tst_resm(TFAIL|TERRNO,
> +							"unshare failed 2.");
> +				}
> +				tst_exit();
>                          }else{
>  			}
> 
> @@ -228,4 +260,10 @@ int main(int ac, char **av) {
>  	cleanup();
>  	tst_exit();
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
