Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZAAtr-0003Wc-B6
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 05:49:35 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAAtp-0003uf-V7
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 05:49:35 +0000
Date: Wed, 1 Jul 2015 01:49:25 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2001395979.10893550.1435729765770.JavaMail.zimbra@redhat.com>
In-Reply-To: <1435728882-9272-1-git-send-email-liuhangbin@gmail.com>
References: <1435728882-9272-1-git-send-email-liuhangbin@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCHv2] containers: Use raw setns syscall for versions
 of glibc that don't include it
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
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Wednesday, 1 July, 2015 7:34:42 AM
> Subject: [LTP][PATCHv2] containers: Use raw setns syscall for versions of glibc that don't include it
> 
> The setns() system call was added to glibc in version 2.14. On systems with
> lower version glic, like RHEL6.6 glibc 2.12, ltp will build failed with
> error "userns04.c:58: undefined reference to `setns'". Use ltp_syscall to
> make
> build pass.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  testcases/kernel/containers/userns/userns_helper.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/testcases/kernel/containers/userns/userns_helper.h
> b/testcases/kernel/containers/userns/userns_helper.h
> index da03bae..21e5cb8 100644
> --- a/testcases/kernel/containers/userns/userns_helper.h
> +++ b/testcases/kernel/containers/userns/userns_helper.h
> @@ -15,6 +15,16 @@
>  #include "test.h"
>  #include "safe_macros.h"
>  
> +/*
> + * Use raw setns syscall for versions of glibc that don't include it
> + */
> +#if __GLIBC__ <= 2 && __GLIBC_MINOR__ < 14
> +int setns(int fd, int nstype)
> +{
> +	return ltp_syscall(__NR_setns, fd, nstype);
> +}
> +#endif
> +

What I had in mind was to replace setns calls with ltp_syscall(__NR_setns),
which would work with any libc library, not just glibc.

You also need this in setup():
  ltp_syscall(__NR_setns, -1, 0);
because setns is used in child processes, so any tst_brkm call will end
the child and then parent will see that as unexpected failure.
Calling __NR_setns as first thing in setup() will immediately end
the test with TCONF if it's not supported. If it's supported the
syscall silently fails and test continues.

Regards,
Jan

>  static int dummy_child(void *v)
>  {
>  	(void) v;
> --
> 1.9.3
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
