Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Urjg7-0002Gq-Ms
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 06:58:07 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Urjg5-0004a2-KH
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 06:58:07 +0000
Date: Wed, 26 Jun 2013 02:57:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <124690609.2453786.1372229877036.JavaMail.root@redhat.com>
In-Reply-To: <1372210229-28153-1-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1372210229-28153-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] sendfile08: disable this test on kernel less than
 2.6.33
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
> Sent: Wednesday, 26 June, 2013 3:30:29 AM
> Subject: [PATCH] sendfile08: disable this test on kernel less than 2.6.33
> 
> After kernel commit cc56f7d, sendfile(2) can support any file refered
> "out_fd" instead of only socket.
> Since this test for general file refered "out_fd", so we disable this
> test on the kernel less than 2.6.33.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Reviewed-by: Jan Stancek <jstancek@redhat.com>

Looks good to me.

Regards,
Jan

> ---
>  testcases/kernel/syscalls/sendfile/sendfile08.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c
> b/testcases/kernel/syscalls/sendfile/sendfile08.c
> index 3d4caa3..748fcd4 100644
> --- a/testcases/kernel/syscalls/sendfile/sendfile08.c
> +++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
> @@ -95,6 +95,13 @@ static void setup(void)
>  {
>  	int ret;
>  
> +	/* Disable test if the version of the kernel is less than 2.6.33 */
> +	if ((tst_kvercmp(2, 6, 33)) < 0) {
> +		tst_resm(TCONF, "The out_fd must refer to a socket before kernel");
> +		tst_resm(TCONF, "2.6.33, see kernel commit cc56f7d");
> +		tst_exit();
> +	}
> +
>  	TEST_PAUSE;
>  
>  	tst_tmpdir();
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
