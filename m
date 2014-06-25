Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wzott-0007DK-Q8
	for ltp-list@lists.sourceforge.net; Wed, 25 Jun 2014 15:14:17 +0000
Date: Wed, 25 Jun 2014 17:14:01 +0200
From: chrubis@suse.cz
Message-ID: <20140625151400.GA9191@rei.Home>
References: <1403522017-8189-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403522017-8189-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] vmsplice/vmsplice02.c: add EBADF and EINVAL error
 value tests
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static struct test_case_t {
> +	int *fd;
> +	const struct iovec *iov;
> +	unsigned long nr_segs;
> +	int exp_errno;
> +} test_cases[] = {
> +	{ &notvalidfd, &ivc, VMSPLICE_LEN, EBADF },
> +	{ &filefd, &ivc, VMSPLICE_LEN, EBADF },
                          ^
			  I've changed these two to 1 because it
			  should denote the size of the array containing
			  the iovec structures which, for single iovec
			  is 1
> +	{ &pipes[1], &ivc, IOV_MAX + 1, EINVAL },
> +};

...

> +static void setup(void)
> +{
> +	int i;
> +
> +	if ((tst_kvercmp(2, 6, 17)) < 0) {
> +		tst_brkm(TCONF, cleanup, "This test can only run on "
> +			"kernels that are 2.6.17 or higher");
> +	}
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
> +		tst_brkm(TCONF, cleanup, "Cannot do splice() "
> +			"on a file located on an NFS filesystem");
> +	}
> +
> +	for (i = 0; i < TEST_BLOCK_SIZE; i++)
> +		buffer[i] = i & 0xff;

        And I've removed this initialization which is not needed for
	anything (the buffer is not used at all).

> +	filefd = SAFE_OPEN(cleanup, TESTFILE,
> +				O_WRONLY | O_CREAT, 0644);
> +
> +	SAFE_PIPE(cleanup, pipes);
> +
> +	ivc.iov_base = buffer;
> +	ivc.iov_len = TEST_BLOCK_SIZE;
> +}
> +

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
