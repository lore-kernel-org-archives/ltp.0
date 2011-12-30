Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1RgSak-0005VE-V9
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 02:53:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RgSai-0006C1-K5
	for ltp-list@lists.sourceforge.net; Fri, 30 Dec 2011 02:53:10 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBU2r24U014678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Dec 2011 21:53:02 -0500
Date: Fri, 30 Dec 2011 10:53:00 +0800
From: Eryu Guan <eguan@redhat.com>
Message-ID: <20111230025300.GA30803@eguan-t400>
References: <1325154816-31411-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1325154816-31411-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/setxattr02: New test case to test
	setxattr(2)
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
To: ltp-list@lists.sourceforge.net

On Thu, Dec 29, 2011 at 06:33:36PM +0800, Eryu Guan wrote:
> 
> In the user.* namespace, only regular files and directories can
> have extended attributes. Otherwise setxattr(2) should return -1
> and set errno to EPERM.
snip
> +		for (i = 0; i < TST_TOTAL; i++)	{
> +			tname = tc[i].fname;
> +			tkey = tc[i].key;
> +			tvalue = tc[i].value;
> +			tsize = tc[i].size;
> +			tflags = tc[i].flags;
> +			texp_err = tc[i].exp_err;

Please ignore this setxattr02 test too, I'll resend a v2 to remove
variables above.

Eryu Guan
> +
> +			TEST(setxattr(tname, tkey, tvalue, tsize, tflags));
> +
> +			if (TEST_ERRNO == texp_err) {
> +				tst_resm(TPASS | TTERRNO, "expected behavior");
> +			} else {
> +				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
> +				    " - expected errno %d - Got", texp_err);
> +			}
> +		}
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	int fd;
> +
> +	tst_require_root(NULL);
> +
> +	tst_tmpdir();
> +
> +	/* Test for xattr support */
> +	fd = creat("testfile", 0644);
> +	if (fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create testfile failed");
> +	close(fd);
> +	if (setxattr("testfile", "user.test", "test", 4, XATTR_CREATE) == -1)
> +		if (errno == ENOTSUP)
> +			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
> +			    "mount without user_xattr option");
> +	unlink("testfile");
> +
> +	/* Create test files */
> +	fd = creat(file, 0644);
> +	if (fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create test file(%s) failed",
> +		    file);
> +	close(fd);
> +
> +	if (mkdir(dir, 0644) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create test dir(%s) failed",
> +		    dir);
> +
> +	if (symlink(file, sym) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create symlink(%s->%s)"
> +		    " failed", sym, file);
> +
> +	if (mknod(fifo, S_IFIFO | 0777, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create fifo(%s) failed",
> +		    fifo);
> +
> +	if (mknod(chr, S_IFCHR | 0777, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create char special(%s)"
> +		    " failed", chr);
> +
> +	if (mknod(blk, S_IFBLK | 0777, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create block special(%s)"
> +		    " failed", blk);
> +
> +	if (mknod(sock, S_IFSOCK | 0777, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create socket(%s) failed",
> +		    sock);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	tst_rmdir();
> +}


------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
