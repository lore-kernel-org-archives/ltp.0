Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UrOIh-00045G-HW
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 08:08:31 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UrOIg-00031o-Gr
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 08:08:31 +0000
Date: Tue, 25 Jun 2013 04:08:22 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <443698732.1878636.1372147702171.JavaMail.root@redhat.com>
In-Reply-To: <1372124030-16256-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1372124030-16256-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH V2] getrusage03: disable the test when kernel
 before 2.6.32
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
Cc: LTP <ltp-list@lists.sourceforge.net>


----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "LTP" <ltp-list@lists.sourceforge.net>
> Cc: "Cyril Hrubis" <chrubis@suse.cz>, "Caspar Zhang" <caspar@casparzhang.com>, "Garrett Cooper" <yanegomi@gmail.com>,
> "Mike Frysinger" <vapier@gentoo.org>, jstancek@redhat.com, "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> Sent: Tuesday, 25 June, 2013 3:33:50 AM
> Subject: [PATCH V2] getrusage03: disable the test when kernel before 2.6.32
> 
> Kernel commit 1f10206c is first introduced in 2.6.32, this
> ru_maxrss behaviors will not be supported before kernel 2.6.32,
> so disable the test when kernel version is before 2.6.32.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Looks good to me.
Reviewed-by: Jan Stancek <jstancek@redhat.com>

Regards,
Jan

> ---
>  testcases/kernel/syscalls/getrusage/getrusage03.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c
> b/testcases/kernel/syscalls/getrusage/getrusage03.c
> index 202356c..5d82a94 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> @@ -346,6 +346,13 @@ static void consume(int mega)
>  
>  static void setup(void)
>  {
> +	/* Disable test if the version of the kernel is less than 2.6.32 */
> +	if ((tst_kvercmp(2, 6, 32)) < 0) {
> +		tst_resm(TCONF, "This ru_maxrss field is not supported");
> +		tst_resm(TCONF, "before kernel 2.6.32");
> +		tst_exit();
> +	}
> +
>  	tst_sig(FORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
> --
> 1.8.3.1.448.gfb7dfaa
> 
> 

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
