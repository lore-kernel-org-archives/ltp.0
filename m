Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Meufa-0002ic-Iy
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:26 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MeufT-0003Ig-BA
	for ltp-list@lists.sourceforge.net; Sat, 22 Aug 2009 17:46:26 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7MHj7TP030590
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 13:45:07 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7MHkDCF174466
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 13:46:13 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7MHkDXP029207
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 13:46:13 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810908180135m6d185842i78ac522f4a163e25@mail.gmail.com>
References: <f5a7b3810908180135m6d185842i78ac522f4a163e25@mail.gmail.com>
Date: Sat, 22 Aug 2009 23:15:41 +0530
Message-Id: <1250963141.10642.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] ltp-fix-mlockall_15-1.c
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

On Tue, 2009-08-18 at 14:05 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed UNRESOLVED of following test cases
> mlockall/15-1.c
> mlockall/speculative/15-1.c

Thanks.

Regards--
Subrata

> 
> These test cases are fixed by setting the Rlimit to zero to get EPERM
> as per the kernel code.
> 
> I have attached patch and below
> Please review the same
> 
> Best regards,
> Naresh Kamboju
> 
> /***********************************************************/
> Results:
> Before patch:
> =============
> 
> conformance/interfaces/mlockall/15-1.test:execution:UNRESOLVED
> conformance/interfaces/mlockall/speculative/15-1.test:execution:UNRESOLVED
> 
> After Patch:
> ============
> 
> conformance/interfaces/mlockall/15-1.test:execution:PASS
> conformance/interfaces/mlockall/speculative/15-1.test:execution:PASS
> 
> /***********************************************************/
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c	2005-06-03
> 22:00:33.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c	2009-08-18
> 11:28:02.000000000 +0530
> @@ -21,6 +21,7 @@
>  #include <sys/types.h>
>  #include <pwd.h>
>  #include <string.h>
> +#include <sys/resource.h>
>  #include "posixtest.h"
> 
> 
> @@ -28,6 +29,9 @@
>  int set_nonroot()
>  {
>  	struct passwd *pw;
> +        struct rlimit rlim;
> +        int ret=0;
> +
>  	setpwent();
>  	/* search for the first user which is non root */
>  	while((pw = getpwent()) != NULL)
> @@ -39,6 +43,11 @@
>  		return 1;
>  	}
> 
> +        rlim.rlim_cur = 0;
> +        rlim.rlim_max = 0;
> +        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
> +                printf("Failed at setrlimit() return %d \n", ret);
> +
>  	if(seteuid(pw->pw_uid) != 0) {
>  		if(errno == EPERM) {
>  			printf("You don't have permission to change your UID.\n");
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c	2007-07-26
> 17:32:13.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c	2009-08-18
> 11:28:00.000000000 +0530
> @@ -21,6 +21,7 @@
>  #include <sys/types.h>
>  #include <pwd.h>
>  #include <string.h>
> +#include <sys/resource.h>
>  #include "posixtest.h"
> 
> 
> @@ -28,6 +29,9 @@
>  int set_nonroot()
>  {
>  	struct passwd *pw;
> +        struct rlimit rlim;
> +        int ret=0;
> +
>  	setpwent();
>  	/* search for the first user which is non root */
>  	while((pw = getpwent()) != NULL)
> @@ -39,6 +43,11 @@
>  		return 1;
>  	}
> 
> +        rlim.rlim_cur = 0;
> +        rlim.rlim_max = 0;
> +        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
> +                printf("Failed at setrlimit() return %d \n", ret);
> +
>  	if(seteuid(pw->pw_uid) != 0) {
>  		if(errno == EPERM) {
>  			printf("You don't have permission to change your UID.\n");


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
