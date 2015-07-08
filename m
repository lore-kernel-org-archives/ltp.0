Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZClrg-0006bM-Ie
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:42:04 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZClrf-0003zw-Ay
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 09:42:04 +0000
Date: Wed, 8 Jul 2015 05:41:53 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1290384689.14193896.1436348513763.JavaMail.zimbra@redhat.com>
In-Reply-To: <1436204570-7473-1-git-send-email-sunyuan3@huawei.com>
References: <1436204570-7473-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V3] userns01: add capability verification
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
To: Yuan Sun <sunyuan3@huawei.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Yuan Sun" <sunyuan3@huawei.com>
> To: jstancek@redhat.com
> Cc: ltp-list@lists.sourceforge.net
> Sent: Monday, 6 July, 2015 7:42:50 PM
> Subject: [PATCH V3] userns01: add capability verification
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>

Pushed with some small changes:
- missing CAP_LIBS in Makefile
- removed linux/types.h include
- modified message when libcap is missing

Compile tested on RHEL5.3/RHEL6.0 and RHEL7.1.
Runtime tested with kernel 4.0.4.

Regards,
Jan


> ---
>  testcases/kernel/containers/userns/userns01.c | 43
>  ++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/containers/userns/userns01.c
> b/testcases/kernel/containers/userns/userns01.c
> index 9cada5e..750ba49 100644
> --- a/testcases/kernel/containers/userns/userns01.c
> +++ b/testcases/kernel/containers/userns/userns01.c
> @@ -15,7 +15,9 @@
>   * Verify that:
>   *  If a user ID has no mapping inside the namespace, user ID and group
>   * ID will be the value defined in the file
>   /proc/sys/kernel/overflowuid(65534)
> - * and /proc/sys/kernel/overflowgid(65534).
> + * and /proc/sys/kernel/overflowgid(65534). A child process has a full set
> + * of permitted and effective capabilities, even though the program was
> + * run from an unprivileged account.
>   */
>  
>  #define _GNU_SOURCE
> @@ -29,6 +31,12 @@
>  #include "test.h"
>  #include "libclone.h"
>  #include "userns_helper.h"
> +#include "config.h"
> +#if HAVE_SYS_CAPABILITY_H
> +#include <linux/types.h>
> +#include <sys/capability.h>
> +#endif
> +
>  #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
>  #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
>  
> @@ -43,21 +51,43 @@ static long overflowgid;
>   */
>  static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
> -	int exit_val;
> +	int exit_val = 0;
>  	int uid, gid;
> +#ifdef HAVE_LIBCAP
> +	cap_t caps;
> +	int i, last_cap;
> +	cap_flag_value_t flag_val;
> +#endif
>  
>  	uid = geteuid();
>  	gid = getegid();
>  
>  	tst_resm(TINFO, "USERNS test is running in a new user namespace.");
> -	if (uid == overflowuid && gid == overflowgid) {
> -		printf("Got expected uid and gid\n");
> -		exit_val = 0;
> -	} else {
> +
> +	if (uid != overflowuid || gid != overflowgid) {
>  		printf("Got unexpected result of uid=%d gid=%d\n", uid, gid);
>  		exit_val = 1;
>  	}
>  
> +#ifdef HAVE_LIBCAP
> +	caps = cap_get_proc();
> +	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
> +	for (i = 0; i <= last_cap; i++) {
> +		cap_get_flag(caps, i, CAP_EFFECTIVE, &flag_val);
> +		if (flag_val == 0)
> +			break;
> +		cap_get_flag(caps, i, CAP_PERMITTED, &flag_val);
> +		if (flag_val == 0)
> +			break;
> +	}
> +
> +	if (flag_val == 0) {
> +		printf("unexpected effective/permitted caps\n");
> +		exit_val = 1;
> +	}
> +#else
> +	printf("System doesn't support capabilities.\n");
> +#endif
>  	return exit_val;
>  }
>  
> @@ -95,4 +125,3 @@ int main(int argc, char *argv[])
>  	}
>  	tst_exit();
>  }
> -
> --
> 1.9.1
> 
> 

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
