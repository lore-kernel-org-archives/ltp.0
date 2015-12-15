From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Dec 2015 17:36:26 +0100
Subject: [LTP] [PATCH v2 2/2] pwritev/pwritev01.c: add new testcase
In-Reply-To: <1449142273-10679-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20151103144613.GE5795@rei>
 <1449142273-10679-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1449142273-10679-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20151215163626.GE26217@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static struct test_case_t {
> +	int count;
> +	off_t offset;
> +	ssize_t size;
> +} tc[] = {
> +	{1, 0, CHUNK},
> +	{2, 0, CHUNK},

I've added a test with non-zero offset here.

> +void verify_pwritev(struct test_case_t *tc)
> +{
> +	int i;
> +
> +	SAFE_PWRITE(cleanup, 1, fd, initbuf, tc->size, 0);
> +
> +	SAFE_LSEEK(cleanup, fd, 0, SEEK_SET);
> +
> +	TEST(pwritev(fd, wr_iovec, tc->count, tc->offset));
> +	if (TEST_RETURN < 0) {
> +		tst_resm(TFAIL | TTERRNO, "Pwritev(2) failed");
> +		return;
> +	}
> +
> +	if (TEST_RETURN != tc->size) {
> +		tst_resm(TFAIL, "Pwritev(2) write %li bytes, expected %li",
> +			 TEST_RETURN, tc->size);
> +		return;
> +	}
> +
> +	if (SAFE_LSEEK(cleanup, fd, 0, SEEK_CUR) != 0) {
> +		tst_resm(TFAIL, "Pwritev(2) has changed file offset");
> +		return;
> +	}
> +
> +	SAFE_PREAD(cleanup, 1, fd, preadbuf, tc->size, 0);

Fixed it here to read from tc->offset

> +	for (i = 0; i < tc->size; i++) {
> +		if (preadbuf[i] != 0x61)
> +			break;
> +	}
> +
> +	if (i != tc->size) {
> +		tst_resm(TFAIL, "Buffer wrong at %i have %c expected a",
> +			 i, preadbuf[i]);

Changed the %c to $02x (for the same reason as in the preadv()).

> +		return;
> +	}
> +
> +	tst_resm(TPASS, "Pwritev(2) write %li bytes successfully "
> +		 "with content 'a' expectedly ", tc->size);
> +}
> +
> +void setup(void)
> +{
> +	if ((tst_kvercmp(2, 6, 30)) < 0) {
> +		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> +			"that are 2.6.30 and higher");
> +	}
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	TEST_PAUSE;
> +
> +	tst_tmpdir();
> +
> +	memset(&initbuf, 0x00, CHUNK);

And removed the memset() here since global variables are initialized to
zero automatically.

And pushed the test, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
