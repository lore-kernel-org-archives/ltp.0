Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MGHg8-000849-0d
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:17:12 +0000
Received: from [32.97.182.145] (helo=e5.ny.us.ibm.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MGHg7-0007kI-45
	for ltp-list@lists.sourceforge.net; Mon, 15 Jun 2009 19:17:11 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5FJADe8032718
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:10:13 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5FJGKK0247396
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:16:20 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5FJE3vP007610
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Jun 2009 15:14:03 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810906120646w6aff4e33wce787b684e91bee8@mail.gmail.com>
References: <f5a7b3810906120646w6aff4e33wce787b684e91bee8@mail.gmail.com>
Date: Tue, 16 Jun 2009 00:45:45 +0530
Message-Id: <1245093345.4871.39.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] POSIX mlock/12-1.c and
	mlock/speculative/12-1.c
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
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, rohit.170309@gmail.com

On Fri, 2009-06-12 at 19:16 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed failures under
> testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c
> and
> testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c
> and fixed as per man page
> mlock()
> 
> EPERM:
> 
> (Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
> and its RLIMIT_MEMLOCK soft resource limit was 0.
> 
> Please find the patch below and as attachment.
> 
> Best regards
> Naresh Kamboju
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Thanks.

Regards--
Subrata

> 
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c	2005-06-03
> 22:00:32.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c	2009-06-12
> 17:18:00.000000000 +0530
> @@ -8,7 +8,8 @@
>   *  GNU General Public License for more details.
>   *
>   * Test that the mlock() function sets errno = EPERM if the calling process
> - * does not have the appropriate privilege to perform the requested operation.
> + * does not have the appropriate privilege to perform the requested operation
> + * (Linux 2.6.9 and later) and its RLIMIT_MEMLOCK soft resource limit set to 0.
>   */
> 
>  #define _XOPEN_SOURCE 600
> @@ -21,6 +22,7 @@
>  #include <sys/types.h>
>  #include <pwd.h>
>  #include <string.h>
> +#include <sys/resource.h>
>  #include "posixtest.h"
> 
>  #define BUFSIZE 8
> @@ -29,6 +31,9 @@
>  int set_nonroot()
>  {
>  	struct passwd *pw;
> +        struct rlimit rlim;
> +        int ret=0;
> +
>  	setpwent();
>  	/* search for the first user which is non root */
>  	while((pw = getpwent()) != NULL)
> @@ -40,6 +45,18 @@
>  		return 1;
>  	}
> 
> +	/*
> +	 * mlock()
> +	 * EPERM:
> +	 * (Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
> +	 * and its RLIMIT_MEMLOCK soft resource limit was 0.
> +	 */
> +
> +        rlim.rlim_cur = 0;
> +        rlim.rlim_max = 0;
> +        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
> +                printf("Failed at setrlimit() return %d \n", ret);
> +
>  	if(seteuid(pw->pw_uid) != 0) {
>  		if(errno == EPERM) {
>  			printf("You don't have permission to change your UID.\n");
> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c	2007-07-26
> 17:32:13.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c	2009-06-12
> 17:18:24.000000000 +0530
> @@ -8,7 +8,8 @@
>   *  GNU General Public License for more details.
>   *
>   * Test that the mlock() function sets errno = EPERM if the calling process
> - * does not have the appropriate privilege to perform the requested operation.
> + * does not have the appropriate privilege to perform the requested operation
> + * (Linux 2.6.9 and later) and its RLIMIT_MEMLOCK soft resource limit set to 0.
>   */
> 
>  #define _XOPEN_SOURCE 600
> @@ -21,6 +22,7 @@
>  #include <sys/types.h>
>  #include <pwd.h>
>  #include <string.h>
> +#include <sys/resource.h>
>  #include "posixtest.h"
> 
>  #define BUFSIZE 8
> @@ -29,6 +31,9 @@
>  int set_nonroot()
>  {
>  	struct passwd *pw;
> +        struct rlimit rlim;
> +        int ret=0;
> +
>  	setpwent();
>  	/* search for the first user which is non root */
>  	while((pw = getpwent()) != NULL)
> @@ -40,6 +45,18 @@
>  		return 1;
>  	}
> 
> +	/*
> +	 * mlock()
> +	 * EPERM:
> +	 * (Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
> +	 * and its RLIMIT_MEMLOCK soft resource limit was 0.
> +	 */
> +
> +        rlim.rlim_cur = 0;
> +        rlim.rlim_max = 0;
> +        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
> +                printf("Failed at setrlimit() return %d \n", ret);
> +
>  	if(seteuid(pw->pw_uid) != 0) {
>  		if(errno == EPERM) {
>  			printf("You don't have permission to change your UID.\n");


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
