Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOlh-0000FO-Ds
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:41:57 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOlZ-0006Bm-3c
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:41:57 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n77CZNN7021655
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:35:23 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77CfQBr248892
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:41:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77Ccd2C007557
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:38:39 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810908060246o597813b8gaf5a6b1087f0fba7@mail.gmail.com>
References: <f5a7b3810908060246o597813b8gaf5a6b1087f0fba7@mail.gmail.com>
Date: Fri, 07 Aug 2009 18:11:19 +0530
Message-Id: <1249648879.4851.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCHE]ltp-sched_setparam_26-1.c
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Brandon Philips <bphilips@suse.de>

On Thu, 2009-08-06 at 15:16 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed UNTESTED behavior with sched_setparam/26-1.c test case
> under open_posix_testsuite.
> 
> Test needs to be executed as non-root user.
> So I have changed user id from root to non-root user by adding
> set_nonroot() function.
> Now test case got PASSED.
> 
> I have attached patch and results before and after the patch.
> please review the same.
> 
> 
> Best regards,
> Naresh Kamboju
> 
> /*********************************************************************************************/
> Before Patch:
> /*********************************************************************************************/
> # ./26-1.test
> Run this test case as a Regular User, but not ROOT
> conformance/interfaces/sched_setparam/26-1.test:execution:UNTESTED
> /*********************************************************************************************/
> After Patch:
> /*********************************************************************************************/
> # ./26-1.test
> Testing with user 'bin' (uid: 1)
> Test PASSED
> conformance/interfaces/sched_setparam/26-1.test:execution:PASSED
> /*********************************************************************************************/
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Ok. Thanks.

Regards--
Subrata

> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c	2005-06-03
> 22:03:02.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c	2009-08-06
> 14:36:01.000000000 +0530
> @@ -16,9 +16,39 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <pwd.h>
>  #include "posixtest.h"
> 
> 
> +/** Set the euid of this process to a non-root uid */
> +int set_nonroot()
> +{
> +	struct passwd *pw;
> +	setpwent();
> +	/* search for the first user which is non root */
> +	while((pw = getpwent()) != NULL)
> +		if(strcmp(pw->pw_name, "root"))
> +			break;
> +	endpwent();
> +	if(pw == NULL) {
> +		printf("There is no other user than current and root.\n");
> +		return 1;
> +	}
> +
> +	if(seteuid(pw->pw_uid) != 0) {
> +		if(errno == EPERM) {
> +			printf("You don't have permission to change your UID.\n");
> +			return 1;
> +		}
> +		perror("An error occurs when calling seteuid()");
> +		return 1;
> +	}
> +	
> +	printf("Testing with user '%s' (uid: %d)\n",
> +	       pw->pw_name, (int)geteuid());
> +	return 0;
> +}
> +
> 
>  int main(){
>  	int result;
> @@ -28,9 +58,11 @@
>          /* and can only be accessed by root */
>          /* This test should be run under standard user permissions */
>          if (getuid() == 0) {
> -                puts("Run this test case as a Regular User, but not ROOT");
> +	  	if (set_nonroot() != 0) {
> +			  printf("Cannot run this test as non-root user\n");	
>                  return PTS_UNTESTED;
>          }
> +        }
> 
>  	if(sched_getparam(0, &param) == -1) {
>  		perror("An error occurs when calling sched_getparam()");


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
