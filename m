Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Urr8U-0001As-I9
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 14:55:54 +0000
Date: Wed, 26 Jun 2013 16:57:21 +0200
From: chrubis@suse.cz
Message-ID: <20130626145720.GA2960@rei.suse.cz>
References: <1372210229-28153-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372210229-28153-1-git-send-email-gaowanlong@cn.fujitsu.com>
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
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> After kernel commit cc56f7d, sendfile(2) can support any file refered
> "out_fd" instead of only socket.
> Since this test for general file refered "out_fd", so we disable this
> test on the kernel less than 2.6.33.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/sendfile/sendfile08.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
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

Pushed with slightly modified message (so that the line of code fits to
80 chars).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
