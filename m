Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WkuYZ-0005jL-Sj
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 12:14:40 +0000
Date: Thu, 15 May 2014 14:14:30 +0200
From: chrubis@suse.cz
Message-ID: <20140515121430.GC23965@rei.Home>
References: <1397731818-26430-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1397731818-26430-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397731818-26430-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] rmdir/rmdir02.c: add ELOOP,
 EROFS and EBUSY error value tests
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
To: "gux.fnst@cn.fujitsu.com" <gux.fnst@cn.fujitsu.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
>  int main(int ac, char **av)
>  {
>  	int i, lc;
>  	char *msg;
>  
> -	msg = parse_opts(ac, av, NULL, NULL);
> +	msg = parse_opts(ac, av, options, help);
>  	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> +	if (!device) {
> +		tst_brkm(TBROK, NULL, "you must specify the device "
> +			"used for mounting with -D option");
                 This should be TCONF rather than TBROK (I've fixed
		 that).


>  	setup();
>  
>  	TEST_EXP_ENOS(exp_enos);
> @@ -108,12 +141,34 @@ int main(int ac, char **av)
>  
>  static void setup(void)
>  {
> +	int i;
> +	struct passwd *ltpuser;
> +
> +	tst_require_root(NULL);
> +
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
>  	TEST_PAUSE;
>  
>  	tst_tmpdir();
>  
> +	tst_mkfs(NULL, device, fstype, NULL);
> +	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
> +	if (mount(device, MNTPOINT, fstype, 0, NULL) == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"mount device:%s failed", device);
> +	}
> +	SAFE_MKDIR(cleanup, TESTDIR5, DIR_MODE);
> +	if (mount(device, MNTPOINT, fstype, MS_REMOUNT | MS_RDONLY,
> +			NULL) == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"mount device:%s failed", device);
> +	}
> +	mount_flag = 1;
> +
> +	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
> +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);

I've removed the EUID changes for all because these has no effect on the
test behavior (at least I haven't figured out why they are needed).

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
