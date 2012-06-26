Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SjRG2-0007QD-Mk
	for ltp-list@lists.sourceforge.net; Tue, 26 Jun 2012 08:36:22 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SjRFy-0000P3-Px
	for ltp-list@lists.sourceforge.net; Tue, 26 Jun 2012 08:36:22 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q5Q8aBg7031408
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Jun 2012 16:36:12 +0800
Message-ID: <4FE97480.3040007@cn.fujitsu.com>
Date: Tue, 26 Jun 2012 16:36:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1340593602-5462-1-git-send-email-penght@cn.fujitsu.com>
In-Reply-To: <1340593602-5462-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] dummy.c: fix a bug of TCONF fail
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 06/25/2012 11:06 AM, Peng Haitao wrote:
> When HAVE_LIBCAP or HAVE_SYS_CAPABILITY_H is not defined, 
> the case should not be fail.

pushed, thanks Peng.

Wanlong Gao

> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/kernel/security/cap_bound/dummy.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/cap_bound/dummy.c b/testcases/kernel/security/cap_bound/dummy.c
> index 3ee7c9b..d161efd 100644
> --- a/testcases/kernel/security/cap_bound/dummy.c
> +++ b/testcases/kernel/security/cap_bound/dummy.c
> @@ -1,10 +1,14 @@
>  #include <stdio.h>
>  #include "config.h"
> +#include "test.h"
>  
>  #if HAVE_SYS_CAPABILITY_H
>  #include <sys/capability.h>
>  #endif
>  
> +char *TCID = "dummy";
> +int TST_TOTAL=1;
> +
>  int main(void)
>  {
>  #if HAVE_SYS_CAPABILITY_H
> @@ -15,11 +19,9 @@ int main(void)
>  	cap_free(cur);
>  	return 0;
>  #else /* libcap */
> -	printf("System doesn't support POSIX capabilities.\n");
> -	return 1;
> +	tst_brkm(TCONF, NULL, "System doesn't support POSIX capabilities.");
>  #endif
>  #else /* capability_h */
> -	printf("System doesn't support sys/capability.h\n");
> -	return 1;
> +	tst_brkm(TCONF, NULL, "System doesn't support sys/capability.h.");
>  #endif
>  }
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
