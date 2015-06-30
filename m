Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z9pSb-0007qN-KR
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 06:56:01 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z9pSa-0006cj-22
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 06:56:01 +0000
Date: Tue, 30 Jun 2015 02:55:50 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1697537616.10369628.1435647350988.JavaMail.zimbra@redhat.com>
In-Reply-To: <1435645125-5434-1-git-send-email-liuhangbin@gmail.com>
References: <1435645125-5434-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] containers: Use raw setns syscall for versions
	of	glibc that don't include it
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>





----- Original Message -----
> From: "Hangbin Liu" <liuhangbin@gmail.com>
> To: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Tuesday, 30 June, 2015 8:18:45 AM
> Subject: [LTP] [PATCH] containers: Use raw setns syscall for versions of	glibc that don't include it
> 
> On RHEL6.6, the kernel support setns syscall, but glibc(2.12) does not
> support
> this syscall. Thus ltp build failed with "userns04.c:58: undefined reference
> to `setns'". Use raw setns syscall to make ltp build pass.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/kernel/containers/userns/userns_helper.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/testcases/kernel/containers/userns/userns_helper.h
> b/testcases/kernel/containers/userns/userns_helper.h
> index da03bae..9107886 100644
> --- a/testcases/kernel/containers/userns/userns_helper.h
> +++ b/testcases/kernel/containers/userns/userns_helper.h
> @@ -15,6 +15,19 @@
>  #include "test.h"
>  #include "safe_macros.h"
>  
> +/*
> + * Use raw setns syscall for versions of glibc that don't include it (namely
> + * glibc-2.12)
> + */
> +#if __GLIBC__ == 2 && __GLIBC_MINOR__ < 14
> +#ifdef SYS_setns
> +int setns(int fd, int nstype)
> +{
> +	return syscall(SYS_setns, fd, nstype);
> +}
> +#endif
> +#endif
> +

This will still fail if SYS_setns is not defined.

We have ltp_syscall and "linux_syscall_numbers.h", which can guaruantee
that __NR_setns will be defined and ltp_syscall will break with TCONF
in case you get ENOSYS.

So if you add dummy call to setns in setup():
  ltp_syscall(__NR_setns, -1, 0);
you can stop the testcase quite early with TCONF if setns is not supported.

Regards,
Jan

>  static int dummy_child(void *v)
>  {
>  	(void) v;
> --
> 1.9.3
> 
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
