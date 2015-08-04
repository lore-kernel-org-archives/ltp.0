Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMgOj-0002mH-Pz
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 17:53:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMgOi-0000Of-Mk
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 17:53:09 +0000
Date: Tue, 4 Aug 2015 19:52:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150804175247.GC20633@rei.suse.de>
References: <1436949363-8356-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
	<1436949363-8356-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436949363-8356-3-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 3/3] umount2/umount2_03.c: add new test
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
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void umount2_verify(void)
> +{
> +	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> +	mount_flag = 1;
> +
> +	TEST(umount2(SYMLINK, UMOUNT_NOFOLLOW));
> +
> +	if (TEST_RETURN == 0 || TEST_ERRNO != EINVAL) {
> +		tst_resm(TFAIL | TTERRNO,
> +			"umount2(2) UMOUNT_NOFOLLOW flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EINVAL, strerror(EINVAL));

Let's keep the messages short and to the point, what about:


tst_resm(TFAIL | TTERRNO,
         "umount2('symlink', UMOUNT_NOFOLLOW) failed unexpectedly, expected EINVAL");


Also it would be better if if we had separate case for the when the call
succeeded something as:

tst_resm(TFAIL, "umount2('symlink', UMOUNT_NOFOLLOW) "
         "succeeded unexpectedly");

> +		if (TEST_RETURN == 0)
> +			mount_flag = 0;
> +		goto EXIT;
> +	}
> +
> +	TEST(umount2(MNTPOINT, UMOUNT_NOFOLLOW));
> +
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) Failed");
> +		goto EXIT;
> +	}
> +
> +	mount_flag = 0;
> +
> +	tst_resm(TPASS, "umount2(2) Passed");
> +
> +EXIT:
> +	if (mount_flag) {
> +		SAFE_UMOUNT(cleanup, MNTPOINT);
> +		mount_flag = 0;
> +	}
> +}


Again, these are two testcases you should print two PASS/FAIL for each of
them. What about you split the verify funciton into two
umount2_verify_failure and umount2_verify_success and mount and umout
the device in each of them. That way we can make the code flow more
straightforward.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
