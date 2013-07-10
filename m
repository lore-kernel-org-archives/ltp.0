Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwveV-00009y-1I
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 14:45:55 +0000
Date: Wed, 10 Jul 2013 16:47:32 +0200
From: chrubis@suse.cz
Message-ID: <20130710144731.GG19178@rei.suse.cz>
References: <51DA513C.2040403@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51DA513C.2040403@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mount/mount06.c: new case to test MS_MOVE of
 mount
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> +		SAFE_FILE_PRINTF(cleanup, file_src, "TEST FILE");
> +
> +		TEST(mount(mntpoint_src, mntpoint_des, fs_type, MS_MOVE, NULL));
> +
> +		if (TEST_RETURN != 0) {
> +			tst_resm(TFAIL | TTERRNO, "mount(2) failed");
> +		} else {
> +
> +			if (open(file_des, O_CREAT | O_EXCL) == -1 &&
> +			    errno == EEXIST)
> +				tst_resm(TPASS, "move mount is ok");
> +			else
> +				tst_resm(TFAIL, "file %s is not available",
> +					 file_des);
> +
> +			TEST(umount(mntpoint_des));
> +			if (TEST_RETURN != 0)
> +				tst_brkm(TBROK | TTERRNO, cleanup,
> +					 "umount(2) failed");

I still think that we should make this check more robust...

> +		}
> +	}
> +	cleanup();
> +
> +	tst_exit();
> +}
> +
> +void cleanup(void)
> +{
> +	if (umount(path_name) != 0)
> +		tst_brkm(TBROK | TTERRNO, NULL, "umount(2) %s failed",
> +			 path_name);

I think that the TTERRNO is a typo here and it should be TERRNO.

> +	TEST_CLEANUP;
> +
> +	tst_rmdir();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
