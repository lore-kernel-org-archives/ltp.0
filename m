Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rkxmz-0002BP-SF
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 13:00:25 +0000
Date: Wed, 11 Jan 2012 14:11:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120111131154.GE7143@saboteur.suse.cz>
References: <1326135670-18584-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326135670-18584-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/sendfile08: new test case for
 sendfile(2) syscall
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	int ret;
> +	char *msg;
> +	char buf[BUFSIZ];
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		TEST(sendfile(out_fd, in_fd, NULL, strlen(TEST_MSG_IN)));
> +
> +		if (TEST_RETURN == -1)
> +			tst_brkm(TBROK | TTERRNO, cleanup, "sendfile() failed");
> +
> +		ret = lseek(out_fd, 0, SEEK_SET);
> +		if (ret == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup, "lseek %s failed",
> +			    out_file);
> +		ret = read(out_fd, buf, BUFSIZ);
> +		if (ret == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup, "read %s failed",
> +			    out_file);
> +
> +		if (!strcmp(buf, TEST_MSG_OUT TEST_MSG_IN))
> +			tst_resm(TPASS, "sendfile(2) copies data correctly");
> +		else
> +			tst_resm(TFAIL, "sendfile(2) copies data incorrectly."
> +			    " Expect \"%s%s\", got \"%s\"", TEST_MSG_OUT,
> +			    TEST_MSG_IN, buf);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	int ret;
> +
> +	TEST_PAUSE;
> +
> +	/* make a temporary directory and cd to it */

Please avoid such comments.

Correct place for this information in include/test.h. Looking there, we
should probably documment the test interface there at least a bit...

> +	tst_tmpdir();
> +
> +	in_fd = creat(in_file, 0700);
> +	if (in_fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed", in_file);
> +
> +	ret = write(in_fd, TEST_MSG_IN, strlen(TEST_MSG_IN));
> +	if (ret == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", in_file);
> +	close(in_fd);
> +
> +	in_fd = open(in_file, O_RDONLY);
> +	if (in_fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Open %s failed", in_file);
> +
> +	out_fd = open(out_file, O_TRUNC | O_CREAT | O_RDWR, 0777);
> +	if (out_fd == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Open %s failed", out_file);
> +	ret = write(out_fd, TEST_MSG_OUT, strlen(TEST_MSG_OUT));
> +	if (ret == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", out_file);
> +}
> +
> +static void cleanup(void)
> +{
> +	close(out_fd);
> +	close(in_fd);
> +
> +	TEST_CLEANUP;
> +
> +	/* delete the test directory created in setup() */

And this one as well.

> +	tst_rmdir();
> +
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

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
