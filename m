Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Meufs-0004Xk-Cw
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:44 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Meufo-0003jL-7Z
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:44 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7MHgr0j007829
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:42:53 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7MHkYcS217534
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:46:34 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7MHkYrY029157
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 11:46:34 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810908180930q41ceddc0w24a15c21f3c4d796@mail.gmail.com>
References: <f5a7b3810908180930q41ceddc0w24a15c21f3c4d796@mail.gmail.com>
Date: Sat, 22 Aug 2009 23:16:18 +0530
Message-Id: <1250963179.10642.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] ltp-fix-sched_setscheduler_17-6
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

On Tue, 2009-08-18 at 22:00 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed sched_setscheduler/17-6.c test case as UNTESTED.
> 
> Test needs to be executed as non-root user.
> So I have changed user id from root to non-root user by adding
> set_nonroot() function. Now test case got PASSED.
> 
> I have attached patch and results before and after the patch.
> Please review the same.
> 
> Best regards
> Naresh Kamboju
> 
> /************************************************************/
>  Results:
> /************************************************************/
> Before patch:
> conformance/interfaces/sched_setscheduler/17-6.test:execution:UNTESTED
> 
> After patch:
> conformance/interfaces/sched_setscheduler/17-6.test:execution:PASS
> /*************************************************************/
> 
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Thanks.

Regards--
Subrata

> 
> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c
> b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c	2005-06-03
> 22:03:12.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c	2009-08-18
> 21:03:50.000000000 +0530
> @@ -24,10 +24,42 @@
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>
> +#include <pwd.h>
> +#include <string.h>
>  #include "posixtest.h"
> 
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
> +
>  int main(){
>  	int max_priority, old_priority, old_policy, new_policy, policy;
>          struct sched_param param;
> @@ -36,9 +68,11 @@
>          /* and can only be accessed by root */
>          /* This test should be run under standard user permissions */
>          if (getuid() == 0) {
> -                puts("Run this test case as a Regular User, but not ROOT");
> +	  	if (set_nonroot() != 0) {
> +			printf("Cannot run this test as non-root user\n");	
>                  return PTS_UNTESTED;
>          }	
> +        }	
> 
>  	if(sched_getparam(getpid(), &param) == -1) {
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
