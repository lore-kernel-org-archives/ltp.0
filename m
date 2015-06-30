Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z9rts-0003gc-Vi
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 09:32:20 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z9rtr-0003Jj-Fo
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 09:32:20 +0000
Date: Tue, 30 Jun 2015 05:31:39 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <901716087.10438550.1435656699261.JavaMail.zimbra@redhat.com>
In-Reply-To: <1435233277-19842-1-git-send-email-sunyuan3@huawei.com>
References: <1435233277-19842-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] userns01: add capability verification
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
> Sent: Thursday, 25 June, 2015 1:54:37 PM
> Subject: [PATCH] userns01: add capability verification
> 
> A child process has a full set of permitted and effective capabilities,
> even though the program was run from an unprivileged account.
> 
> Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
> ---
>  testcases/kernel/containers/userns/Makefile   |  2 +-
>  testcases/kernel/containers/userns/userns01.c | 18 ++++++++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/containers/userns/Makefile
> b/testcases/kernel/containers/userns/Makefile
> index 9f67216..20a0677 100644
> --- a/testcases/kernel/containers/userns/Makefile
> +++ b/testcases/kernel/containers/userns/Makefile
> @@ -21,6 +21,6 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../Makefile.inc
>  
> -LDLIBS			:= -lclone -lltp
> +LDLIBS			:= -lclone -lltp -lcap

We have m4 check for libcap, for the cases when libcap is not installed,
see m4/ltp-cap.m4.

>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/containers/userns/userns01.c
> b/testcases/kernel/containers/userns/userns01.c
> index 9cada5e..ca4815a 100644
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
> @@ -29,6 +31,7 @@
>  #include "test.h"
>  #include "libclone.h"
>  #include "userns_helper.h"
> +#include <sys/capability.h>

You should use HAVE_LIBCAP and $(CAP_LIBS).

>  #define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
>  #define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
>  
> @@ -43,21 +46,24 @@ static long overflowgid;
>   */
>  static int child_fn1(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
> -	int exit_val;
> +	int exit_val = 0;
>  	int uid, gid;
> +	cap_t caps;
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
> +	caps = cap_get_proc();
> +	if (strcmp(cap_to_text(caps, NULL), "=ep") != 0)

I'd suggest cap_compare, comparing strings seems error-prone,
when same set of capabilities can have multiple string representation,
e.g. "all=" and "=".

Regards,
Jan

> +		exit_val = 1;
> +
>  	return exit_val;
>  }
>  
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
