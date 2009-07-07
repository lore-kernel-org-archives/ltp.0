Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCfA-0001rR-Mg
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:56 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCf4-0001pv-OF
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:56 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n67FTMTe030354
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:29:22 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n67FWeti099350
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:32:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n67FWdin030465
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 09:32:39 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <f5a7b3810907070219k5ca1e6d5u7ad4fbfb2a85250e@mail.gmail.com>
References: <f5a7b3810907070219k5ca1e6d5u7ad4fbfb2a85250e@mail.gmail.com>
Date: Tue, 07 Jul 2009 21:02:27 +0530
Message-Id: <1246980747.5539.48.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [FIX PATCH] ltp-posix-mmap_18-1.c
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
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

On Tue, 2009-07-07 at 14:49 +0530, naresh kamboju wrote: 
> Hi,
> 
> I have noticed FAIL and fixed mmap/18-1.c under open posix testsuite.
> I have fixed this test case by changing the seteuid() from root to
> non-root. To get resource limit setrlimit()
> 
> STEPS:
> mmap:
> EAGAIN:
> Lock all the memory by mlockall().
> Set resource limit setrlimit()
> Change the user to non-root then only setrmilit is applicable.
> 
> I have attached the patch and below.
> Please review the same.
> 
> Best regards,
> Naresh Kamboju
> 
> /*****************************************************************/
> [mmap]# ./18-1.test
> Test Pass: mmap/18-1.c Get EAGAIN: Resource temporarily unavailable
> /*****************************************************************/
> 
> 
> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

Thanks.

Regards--
Subrata

> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c	2005-06-03
> 22:00:33.000000000 +0530
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c	2009-07-07
> 14:03:47.000000000 +0530
> @@ -13,9 +13,11 @@
>   * 1. Call mlockall(), setting MCL_FUTURE;
>   * 2. Call setrlimit(), set rlim_cur of resource RLIMIT_MEMLOCK to a
>   *    certain value.
> - * 3. Map a shared memory object, with size larger than the
> + * 3. Change user to non-root user seteuid()
> + * 4. Map a shared memory object, with size larger than the
>   *    rlim_cur value set in step 2
> - * 4. Should get EAGAIN.
> + * 5. Should get EAGAIN.
> + * 6. Change user to root seteuid()
>   */
> 
>  #define _XOPEN_SOURCE 600
> @@ -28,12 +30,43 @@
>  #include <sys/stat.h>
>  #include <sys/resource.h>
>  #include <fcntl.h>
> +#include <pwd.h>
>  #include <string.h>
>  #include <errno.h>
>  #include "posixtest.h"
> 
>  #define TNAME "mmap/18-1.c"
> 
> +
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
>  int main()
>  {
>    char tmpfname[256];
> @@ -93,11 +126,29 @@
>    }
> 
>    fd = shm_fd;	
> +	
> +  /* This test should be run under standard user permissions */
> +  if (getuid() == 0) {
> +	  if (set_nonroot() != 0) {
> +		  printf("Cannot run this test as non-root user\n");	
> +		  return PTS_UNTESTED;
> +	  }
> +  }
> +
> +  /*
> +   * EAGAIN:
> +   * Lock all the memory by mlockall().
> +   * Set resource limit setrlimit()
> +   * Change the user to non-root then only setrmilit is applicable.
> +   */
> +
>    pa = mmap (addr, len, prot, flag, fd, off);
>    if (pa == MAP_FAILED && errno == EAGAIN)
>    {
>      printf ("Test Pass: " TNAME " Get EAGAIN: %s\n",
>              strerror(errno));
> +    /* Change user to root */
> +    seteuid(0);
>      close(fd);
>      munmap(pa, len);
>      exit(PTS_PASS);


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
