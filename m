Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZJcvg-0002Hz-Oj
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 07:34:32 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZJcvf-0003Hz-C3
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 07:34:32 +0000
Date: Mon, 27 Jul 2015 03:34:22 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <597743632.351275.1437982462629.JavaMail.zimbra@redhat.com>
In-Reply-To: <2055436226.240732.1437976466421.JavaMail.zimbra@redhat.com>
References: <1437722520-2794-1-git-send-email-liwang@redhat.com>
	<1216267366.178924.1437911143948.JavaMail.zimbra@redhat.com>
	<2055436226.240732.1437976466421.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] syscalls/sysfs: replace the TWARN to TCONF
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Monday, 27 July, 2015 7:54:26 AM
> Subject: Re: [LTP] [PATCH] syscalls/sysfs: replace the TWARN to TCONF
> 
> Hi Jan,
> 
> ----- Original Message -----
> > 
> > 
> > 
> > 
> > ----- Original Message -----
> > > From: "Li Wang" <liwang@redhat.com>
> > > To: ltp-list@lists.sourceforge.net
> > > Sent: Friday, 24 July, 2015 9:22:00 AM
> > > Subject: [LTP] [PATCH] syscalls/sysfs: replace the TWARN to TCONF
> > > 
> > > I run some of these cases on aarch64 today and get a series waring,
> > > that's
> > > because
> > > sysfs syscall is not implemented on aarch64. So, maybe TCONF is better
> > > than
> > > TWARN
> > > in the testcase.
> > 
> > Are you sure it's not supported? Or is it just disabled in your kernel
> > config?
> > I'm looking at Kconfig and nothing suggests you can't use it on aarch64:
> 
> Hmm, to be precise, it has supported sysfs_syscall but not define
> '__NR_sysfs' on aarch64.

Hi,

Same question:
  http://linux-arm-kernel.infradead.narkive.com/n9PCFfpR/arm64-dose-arm64-support-the-sysfs-system-call

So it looks like you can enable CONFIG_SYSFS_SYSCALL, but still you won't
be able to use it (for 64bit on 64bit), since it doesn't appear to be in syscall table.

> 
> My system config:
> # grep -i sysfs_syscall /boot/config-4.1.0-0.12.el7.aarch64
> CONFIG_SYSFS_SYSCALL=y
> # grep -i EXPERT /boot/config-4.1.0-0.12.el7.aarch64
> CONFIG_EXPERT is not set
> 
> (1)---->
> If I change the code as:
> 
> diff --git a/testcases/kernel/syscalls/sysfs/sysfs01.c
> b/testcases/kernel/syscalls/sysfs/sysfs01.c
> index 11ebe43..770c9c9 100644
> --- a/testcases/kernel/syscalls/sysfs/sysfs01.c
> +++ b/testcases/kernel/syscalls/sysfs/sysfs01.c
> @@ -67,6 +67,7 @@
>   ******************************************************************************/
>  
>  #include "test.h"
> +#include "linux_syscall_numbers.h"
>  #include <errno.h>
>  #include <unistd.h>
>  #include <syscall.h>
> @@ -85,14 +86,12 @@ int main(int ac, char **av)
>  
>         setup();
>  
> -#ifdef __NR_sysfs
> -
>         for (lc = 0; TEST_LOOPING(lc); lc++) {
>  
>                 tst_count = 0;
>  
>                 /* option 1, buf holds fs name */
> -               TEST(syscall(__NR_sysfs, 1, "proc"));
> +               TEST(ltp_syscall(__NR_sysfs, 1, "proc"));
>  
>                 /* check return code */
>                 if (TEST_RETURN == -1) {
> @@ -102,10 +101,6 @@ int main(int ac, char **av)
>                         tst_resm(TPASS, "sysfs(2) Passed for " "option 1");
>                 }
>         }                       /*End of TEST_LOOPING */
> -#else
> -       tst_resm(TWARN,
> -                "This test can only run on kernels that support the sysfs
> system call");
> -#endif
>  
>         /*Clean up and exit */
>         cleanup();
> 
> 
> It's show:
> 
> # ./sysfs01
> sysfs01     1  TCONF  :  sysfs01.c:94: syscall __NR_sysfs not supported on
> your arch
> sysfs01     2  TCONF  :  sysfs01.c:94: Remaining cases not appropriate for
> configuration

I think this is correct way to go.

> 
> 
> 
> (2)---->
> then I add the macro to "linux_syscall_numbers.h" by manual:

linux_syscall_numbers.h is generated from *.in files in the same directory.

> 
> # grep -e __aarch64 -e __NR_sysfs  linux_syscall_numbers.h -A 2 -B 2
> 
> #ifdef __aarch64__
> ...
> # ifndef __NR_sysfs
> #  define __NR_sysfs 135
> # endif

This appears to be taken from unistd32.h.

> 
> 
> It's failed as:
> 
> # ./sysfs01
> sysfs01     1  TFAIL  :  sysfs01.c:99: sysfs(2) Failed for option 1 and set
> errno to 22
> 

Yeah, I think that's because the number you picked is used for __NR_rt_sigprocmask:

$ grep -e __aarch64 -e __NR_rt_sigproc linux_syscall_numbers.h
#ifdef __aarch64__
# ifndef __NR_rt_sigprocmask
#  define __NR_rt_sigprocmask 135

Regards,
Jan

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
