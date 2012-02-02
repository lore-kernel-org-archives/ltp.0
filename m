Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RsyED-0007cF-Cf
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 15:05:37 +0000
Date: Thu, 2 Feb 2012 16:19:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120202151900.GB3605@saboteur.suse.cz>
References: <1327888994-4884-1-git-send-email-caspar@casparzhang.com>
	<1328174935-9294-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1328174935-9294-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v2 1/2] mm/vma03: new testcase
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		fd = open(TESTFILE, O_RDWR);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TCONF, NULL, "open %s", TESTFILE);

I know that we don't have a clear definition for these particular
bitflags (which I would like to fix), however TCONF|TBROK seems strange
to me. As TCONF is "testcase not appropriate for your system" and TBROK
"testcase broken". I think that only TRBOK is better result here.

Other than that it's ready for commit.

> +		pgoff = ULONG_MAX - 1;
> +		map = mmap2(NULL, pgsz, PROT_READ|PROT_WRITE, MAP_PRIVATE,
> +				fd, pgoff);
> +		if (map == MAP_FAILED)
> +			tst_brkm(TBROK|TERRNO, cleanup, "mmap2");
> +
> +		remap = mremap(map, pgsz, 2 * pgsz, 0);
> +		if (remap == MAP_FAILED) {
> +			if (errno == EINVAL)
> +				tst_resm(TPASS,	"mremap failed as expected.");
> +			else
> +				tst_resm(TFAIL|TERRNO, "mremap");
> +		} else {
> +			tst_resm(TFAIL, "mremap succeeded unexpectedly.");
> +		}
> +
> +		close(fd);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void *mmap2(void *addr, size_t length, int prot,
> +		int flags, int fd, off_t pgoffset)
> +{
> +	return (void *)syscall(SYS_mmap2, addr, length, prot,
> +			flags, fd, pgoffset);
> +}
> +
> +static void setup(void)
> +{
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	fd = creat(TESTFILE, 0644);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TCONF, NULL, "creat %s", TESTFILE);

Here as well.

> +	close(fd);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	tst_rmdir();
> +}
> +#else /* __NR_mmap2 */
> +int main(int argc, char *argv[])
> +{
> +	tst_brkm(TCONF, NULL, "__NR_mmap2 is not defined on your system");
> +}
> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz

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
