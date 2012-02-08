Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Rv2wt-00027s-Ji
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 08:32:19 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Rv2wm-00055Y-4N
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 08:32:19 +0000
Received: by iaby12 with SMTP id y12so643674iab.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Feb 2012 00:32:06 -0800 (PST)
Message-ID: <4F3232EC.4030007@casparzhang.com>
Date: Wed, 08 Feb 2012 16:31:40 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1328689302-5506-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<1328689302-5506-2-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1328689302-5506-2-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/4] hugemmap01: auto mount the temporary dir
 for testing
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
Cc: caspar@casparzhang.com, ltp-list@lists.sourceforge.net

On 02/08/2012 04:21 PM, Wanlong Gao wrote:
> -static void setup(void)
> +void setup(void)
>  {
> -	char mypid[40];
> -
> -	sprintf(mypid, "/%d", getpid());
> -	TEMPFILE = strcat(mypid, TEMPFILE);
> -	TEMPFILE = strcat(Hopt, TEMPFILE);
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
>  	TEST_PAUSE;
> -
> +	tst_require_root(NULL);
> +	if (mount("none", Hopt, "hugetlbfs", 0, NULL) < 0)
> +		tst_brkm(TBROK|TERRNO, NULL,
> +			 "mount failed on %s", Hopt);
> +
> +	set_sys_tune("nr_hugepages", hugepages, 1);
> +	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d",
> +		 Hopt, getpid());
>  }
>  
> -static void cleanup(void)
> +void cleanup(void)
>  {
>  	TEST_CLEANUP;
>  
>  	unlink(TEMPFILE);
>  
> +	umount(Hopt);
> +	tst_rmdir();
>  }

Hi, I just have another concern, that you might want to keep the initial
value of nr_hugepages and restore it once the test is done.

Thanks,
Caspar

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
