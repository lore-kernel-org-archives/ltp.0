Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2goi-00058D-B3
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 14:17:20 +0000
Date: Wed, 10 Jun 2015 16:16:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150610141614.GE31980@rei.suse.de>
References: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/4] syscalls/chroot&creat: fix undefined behavior
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testcases/kernel/syscalls/chroot/chroot03.c b/testcases/kernel/syscalls/chroot/chroot03.c
> index 9376892..69fead4 100644
> --- a/testcases/kernel/syscalls/chroot/chroot03.c
> +++ b/testcases/kernel/syscalls/chroot/chroot03.c
> @@ -151,7 +151,9 @@ static void setup(void)
>  	 * set up good_dir to test whether chroot() is setting ENOENT if the
>  	 * directory does not exist.
>  	 */
> -	(void)sprintf(good_dir, "%s.%d", good_dir, getpid());
> +	good_dir_dup = strdup(good_dir);
> +	(void)sprintf(good_dir, "%s.%d", good_dir_dup, getpid());
> +	free(good_dir_dup);

Rather than that we can simply use "nonexistent" as the directory name.

Because the test creates unique test temporary directory at the start
and changes working directory to it. Then any local path points to a
nonexistent directory.

Also naming the variable good_dir is a bad idea. It should be named
nonexistent_dir or so.

>  #if !defined(UCLINUX)
>  	bad_addr = mmap(0, 1, PROT_NONE,
> diff --git a/testcases/kernel/syscalls/creat/creat04.c b/testcases/kernel/syscalls/creat/creat04.c
> index 0268e77..44c249f 100644
> --- a/testcases/kernel/syscalls/creat/creat04.c
> +++ b/testcases/kernel/syscalls/creat/creat04.c
> @@ -192,10 +192,11 @@ void setup(void)
>  
>  	/* make a temporary directory and cd to it */
>  	tst_tmpdir();
> -
> -	sprintf(good_dir, "%s.%d", good_dir, getpid());
> -	sprintf(fname1, "%s/file1.%d", good_dir, getpid());
> -	sprintf(fname, "%s/file.%d", good_dir, getpid());
> +	good_dir_dup = strdup(good_dir);
> +	sprintf(good_dir, "%s.%d", good_dir_dup, getpid());
> +	sprintf(fname1, "%s/file1.%d", good_dir_dup, getpid());
> +	sprintf(fname, "%s/file.%d", good_dir_dup, getpid());
> +	free(good_dir_dup);

There is no need to append pid to the directory and file name, the test
temporary directory create by tst_tmpdir() is unique allready.

So rather than doing ugly workarounds like that, what about removing the
sprintf() and usign static directory and file names?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
