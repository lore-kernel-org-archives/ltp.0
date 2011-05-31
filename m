Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QRR8R-0003mp-Hb
	for ltp-list@lists.sourceforge.net; Tue, 31 May 2011 15:45:35 +0000
Date: Tue, 31 May 2011 17:42:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110531154222.GC1901@saboteur.suse.cz>
References: <1305189432-24927-1-git-send-email-lliubbo@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1305189432-24927-1-git-send-email-lliubbo@gmail.com>
Subject: Re: [LTP] [PATCH] testcases: syscall: readlink: fix except return
 val
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
To: Bob Liu <lliubbo@gmail.com>
Cc: ltp-list@lists.sf.net

Hi!
> This kernel commit "readlinkat(), fchownat() and fstatat() with empty relative
> pathnames"(65cfc6722361570bfe255698d9cd4dccaf47570d) broken POSIX scope which
> makes readlink03 fail like this:
> 
> readlink03    1  TFAIL  :  readlink() failed, Symlink Pathname is empty,
> errno=22, expected errno=2
> 
> This patch fix the except return val from -ENOENT to -EINVAL.
> 
> Signed-off-by: Bob Liu <lliubbo@gmail.com>
> ---
>  testcases/kernel/syscalls/readlink/readlink03.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
> index 0535b25..dbc20e6 100644
> --- a/testcases/kernel/syscalls/readlink/readlink03.c
> +++ b/testcases/kernel/syscalls/readlink/readlink03.c
> @@ -132,7 +132,7 @@ struct test_case_t {		/* test case struct. to hold ref. test cond's */
>  	TEST_FILE2, "File is not symbolic link", EINVAL, 1, no_setup}, {
>  	Longpathname, "Symlink path too long", ENAMETOOLONG, 1, lpath_setup},
>  	{
> -	"", "Symlink Pathname is empty", ENOENT, 1, no_setup}, {
> +	"", "Symlink Pathname is empty", EINVAL, 1, no_setup}, {
>  	NULL, NULL, 0, 0, no_setup}
>  };

Same as previous one. Please make sure this doesn't break the test on
older kernels.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger. 
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Data protection magic?
Nope - It's vRanger. Get your free trial download today. 
http://p.sf.net/sfu/quest-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
