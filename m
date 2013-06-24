Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ur418-0002aD-Uh
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 10:29:02 +0000
Date: Mon, 24 Jun 2013 12:30:29 +0200
From: chrubis@suse.cz
Message-ID: <20130624103029.GB1160@rei>
References: <1372067584-353-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372067584-353-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] getrusage03: disable the test when kernel before
	2.6.32
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
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/getrusage/getrusage03.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
> index 202356c..2670316 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> @@ -71,6 +71,13 @@ int main(int argc, char *argv[])
>  	int lc;
>  	char *msg;
>  
> +	/* Disable test if the version of the kernel is less than 2.6.32 */
> +	if ((tst_kvercmp(2, 6, 32)) < 0) {
> +		tst_resm(TWARN, "This ru_maxrss behaviors is not supported");
> +		tst_resm(TWARN, "before kernel 2.6.32");
> +		exit(0);

Also why exit() and not tst_exit()?

And the usuall place where these checks are added is setup() (not that
having it before parse_opts is wrong, just unusuall).

> +	}
> +
>  	msg = parse_opts(argc, argv, NULL, NULL);
>  	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> -- 
> 1.8.3.1.448.gfb7dfaa
> 

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
