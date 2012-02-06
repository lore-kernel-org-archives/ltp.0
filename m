Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RuExE-0000pU-SF
	for ltp-list@lists.sourceforge.net; Mon, 06 Feb 2012 03:09:20 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RuExD-0005bw-Jk
	for ltp-list@lists.sourceforge.net; Mon, 06 Feb 2012 03:09:20 +0000
Received: by iaby12 with SMTP id y12so10221873iab.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 05 Feb 2012 19:09:14 -0800 (PST)
Message-ID: <4F2F4444.6040105@casparzhang.com>
Date: Mon, 06 Feb 2012 11:08:52 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1328493428-7929-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1328493428-7929-4-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1328493428-7929-4-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 3/4] hugemmap03: code cleanups
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
Cc: ltp-list@lists.sourceforge.net

On 02/06/2012 09:57 AM, Wanlong Gao wrote:
> cleanup the code
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---

[snip]

> +
> +		/*
> +		 * Attempt to mmap using normal pages and
> +		 * a high memory address
> +		 */
>  		addr = mmap(HIGH_ADDR, page_sz, PROT_READ,
>  			    MAP_SHARED | MAP_FIXED, fildes, 0);
>  		if (addr != MAP_FAILED) {
> -			tst_resm(TFAIL, "Normal mmap() into high region unexpectedly succeeded on %s, errno=%d : %s",
> -				 TEMPFILE, errno, strerror(errno));
> +			tst_resm(TFAIL|TERRNO, "Normal mmap() into high region"
> +				 " unexpectedly succeeded on %s, TEMPFILE");
>  			continue;
> -		} else {
> -			tst_resm(TPASS, "Normal mmap() into high region failed correctly");
> +		} else { tst_resm(TPASS, "Normal mmap() into high region" " failed correctly");

Hmmm... several returns are missing here.

>  			break;
>  		}
>  
> @@ -138,24 +120,13 @@ main(int ac, char **av)
>  	tst_exit();
>  }
>  

[snip]

>  
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - * 	       Remove the temporary directory created.
> - */
> -void
> -cleanup()
> +static void cleanup(void)
>  {
>  	/*
>  	 * print timing stats if that option was specified.

And better remove this comment too.

Others look good.

Thanks,
Caspar

> @@ -179,3 +144,8 @@ cleanup()
>  	unlink(TEMPFILE);
>  
>  }
> +
> +static void help(void)
> +{
> +	printf("  -H /..  Location of hugetlbfs, i.e. -H /var/hugetlbfs\n");
> +}


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
