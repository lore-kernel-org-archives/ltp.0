Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TTpmS-0007Y5-BZ
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 08:05:36 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TTpmR-0006vA-2e
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 08:05:36 +0000
Date: Thu, 1 Nov 2012 04:05:17 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <787397777.3211869.1351757117123.JavaMail.root@redhat.com>
In-Reply-To: <1351742419-30299-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] ioctl01: change the errno to ENOTTY when passed
 an	invalid command
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: shyju pv <shyju.pv@huawei.com>, sanil kumar <sanil.kumar@huawei.com>, max maxiansheng <max.maxiansheng@huawei.com>, Mike Frysinger <vapier@gentoo.org>, LTP <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "LTP" <ltp-list@lists.sourceforge.net>
> Cc: "sanil kumar" <sanil.kumar@huawei.com>, "Mike Frysinger" <vapier@gentoo.org>, "shyju pv" <shyju.pv@huawei.com>,
> "max maxiansheng" <max.maxiansheng@huawei.com>
> Sent: Thursday, 1 November, 2012 5:00:19 AM
> Subject: [LTP] [PATCH] ioctl01: change the errno to ENOTTY when passed an	invalid command
> 
> As linus said at the below commit,
> commit 07d106d0a33d6063d2061305903deb02489eba20
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Jan 5 15:40:12 2012 -0800
> 
>     vfs: fix up ENOIOCTLCMD error handling
> 
>     We're doing some odd things there, which already messes up
>     various users
>     (see the net/socket.c code that this removes), and it was going
>     to add
>     yet more crud to the block layer because of the incorrect error
>     code
>     translation.
> 
>     ENOIOCTLCMD is not an error return that should be returned to
>     user mode
>     from the "ioctl()" system call, but it should *not* be translated
>     as
>     EINVAL ("Invalid argument").  It should be translated as ENOTTY
>     ("Inappropriate ioctl for device").
> 
>     That EINVAL confusion has apparently so permeated some code that
>     the
>     block layer actually checks for it, which is sad.  We continue to
>     do so
>     for now, but add a big comment about how wrong that is, and we
>     should
>     remove it entirely eventually.  In the meantime, this tries to
>     keep the
>     changes localized to just the EINVAL -> ENOTTY fix, and removing
>     code
>     that makes it harder to do the right thing.
> 
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> Return ENOTTY is right. And with the tty driver change with below
> commit,
> commit bbb63c514a3464342967237a51a21ea8f61ab951
> Author: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Date:   Mon Aug 27 15:23:12 2012 +0800
> 
>     drivers:tty:fix up ENOIOCTLCMD error handling
> 
>     At commit 07d106d0, Linus pointed out that ENOIOCTLCMD should be
>     translated as ENOTTY to user mode.
>     For example:
>         fd = open("/dev/tty", O_RDWR);
>         ioctl(fd, -1, &argp);
> 
>     then the errno should be ENOTTY but not EINVAL.
> 
>     Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>     Acked-by: Alan Cox <alan@linux.intel.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The tty driver will return the right ENOTTY in upstream kernel when
> passed a invalid ioctl command, so we fixed the LTP test case to
> suit this return value change.
> ---
>  testcases/kernel/syscalls/ioctl/ioctl01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c
> b/testcases/kernel/syscalls/ioctl/ioctl01.c
> index 8b044e7..ef64896 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
> @@ -87,7 +87,7 @@ struct test_case_t {
>  	&fd, TCGETA, (struct termio *)-1, EFAULT},
>  	    /* command is invalid */
>  	{
> -	&fd, INVAL_IOCTL, &termio, EINVAL},
> +	&fd, INVAL_IOCTL, &termio, ENOTTY},

Won't this break on older kernels? Can we test for kernel version with tst_kvercmp()?

Regards,
Jan

>  	    /* file descriptor is for a regular file */
>  	{
>  	&fd1, TCGETA, &termio, ENOTTY},
> --
> 1.8.0
> 
> 
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_sfd2d_oct
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
