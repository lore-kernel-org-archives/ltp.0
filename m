Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wi2LS-00019Q-1g
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 13:57:14 +0000
Date: Wed, 7 May 2014 15:56:15 +0200
From: chrubis@suse.cz
Message-ID: <20140507135615.GA21868@rei>
References: <1398391328-13711-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398391328-13711-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/2] lib/tst_fs_has_free.c: add
 tst_fs_has_free() to determine filesystem's free space
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The existing lib/tst_cwd_has_free.c only determines the filesystem, which
> the current directory is in. And I think tst_cwd_has_free() is not entirely
> correct. See this code in tst_cwd_has_free():
> 	return ((float)sf.f_bfree) / (1024 / sf.f_bsize) >=
> 		 required_kib ? 1 : 0;
> if sf.f_bsize is greater than 1024, this code is wrong.
> 
> I choose to remove tst_cwd_has_free.c and add lib/tst_fs_has_free.c.
> The prototype is below:
> 	int tst_fs_has_free(void (*cleanup)(void), const char *path,
> 		unsigned int size, unsigned int mult);
> 
> User can specify the path to determine the corresponding filesystem.

Pushed with a small fixes, thanks.

> +enum {
> +	TST_KB = 1024,
> +	TST_MB = 1048576,
> +	TST_GB = 1073741824,
> +};

I've added TST_BYTES = 1 here so that we don't have to divide the 10 *
pagesize in the last case.

> diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> index b4d19de..96b52ae 100644
> --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> @@ -99,7 +99,7 @@ static void setup(void)
>  	break;
>  	}
>  
> -	if (!tst_cwd_has_free(65536)) {
> +	if (!tst_fs_has_free(NULL, ".", 64, TST_KB)) {
>  		tst_brkm(TBROK, cleanup,
>  			 "Insufficient disk space to create swap file");
>  	}


And changes this to:

	if (!tst_fs_has_free(NULL, ".", 64, TST_MB)) {

Because as far as I can tell, the test creates 64 megabytes files.


PS: We should document the function in Test Writing Guidelines. Will you
    send a patch or should I write it?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
