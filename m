From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Oct 2016 17:23:31 +0200
Subject: [LTP] [PATCH 1/2] syscalls: new test writev07
In-Reply-To: <c6be7469f0f59fa5c0d65e9466d0d9686a1251b3.1475670993.git.jstancek@redhat.com>
References: <c6be7469f0f59fa5c0d65e9466d0d9686a1251b3.1475670993.git.jstancek@redhat.com>
Message-ID: <20161005152331.GC23476@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define TESTFILE "testfile"
> +#define CHUNK 64
> +#define BUFSIZE (CHUNK * 8)
> +
> +static void *bad_addr;
> +
> +static void dump_buf(unsigned char *buf, int len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++) {
> +		printf("0x%02x ", *(buf + i));
> +		if (i % 16 == 15)
> +			printf("\n");
> +	}
> +	printf("\n");
> +}

Hmm, we have tst_resm_hexd() in the old library exactly for this purpose
but it's not exported to the new library at this point. We should fix
that and make use of it here.

> +static void test_partially_valid_iovec(int initial_file_offset)
> +{
> +	int i, fd;
> +	unsigned char buffer[BUFSIZE], fpattern[BUFSIZE], tmp[BUFSIZE];
> +	long off_after;
> +	struct iovec wr_iovec[] = {
> +		{ buffer + CHUNK, CHUNK * 2 },
> +		{ bad_addr, CHUNK },
> +		{ buffer + CHUNK * 3, CHUNK },
> +		{ buffer + CHUNK * 2, CHUNK * 2 },
> +	};

Hmm, I fail to see the logic after the buffer and CHUNK here. Why don't
we start from the start of the buffer for the first iovec record?

Why is the BUFSIZE defined as CHUNK * 8 while the only CHUNK * 4 could
be reached here?

> +	tst_res(TINFO, "starting test with initial file offset: %d ",
> +		initial_file_offset);
> +
> +	for (i = 0; i < BUFSIZE; i++)
> +		buffer[i] = i % (CHUNK - 1);
> +
> +	memset(fpattern, 0xff, BUFSIZE);
> +	tst_fill_file(TESTFILE, 0xff, CHUNK, BUFSIZE / CHUNK);
> +
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR, 0644);
> +	SAFE_LSEEK(fd, initial_file_offset, SEEK_SET);
> +	TEST(writev(fd, wr_iovec, ARRAY_SIZE(wr_iovec)));
> +	off_after = (long) SAFE_LSEEK(fd, 0, SEEK_CUR);
> +
> +	/* bad errno */
> +	if (TEST_RETURN == -1 && TEST_ERRNO != EFAULT) {
> +		tst_res(TFAIL | TTERRNO, "unexpected errno");
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	/* nothing has been written */
> +	if (TEST_RETURN == -1 && TEST_ERRNO == EFAULT) {
> +		tst_res(TINFO, "got EFAULT");
> +		/* initial file content remains untouched */
> +		SAFE_LSEEK(fd, 0, SEEK_SET);
> +		SAFE_READ(1, fd, tmp, BUFSIZE);
> +		if (memcmp(tmp, fpattern, BUFSIZE))
> +			tst_res(TFAIL, "file was written to");
> +		else
> +			tst_res(TPASS, "file stayed untouched");
> +
> +		/* offset hasn't changed */
> +		if (off_after == initial_file_offset)
> +			tst_res(TPASS, "offset stayed unchanged");
> +		else
> +			tst_res(TFAIL, "offset changed to %ld",
> +				off_after);
> +
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	/* writev() wrote more bytes than bytes preceding invalid iovec */
> +	tst_res(TINFO, "writev() has written %ld bytes", TEST_RETURN);
> +	if (TEST_RETURN > (long) wr_iovec[0].iov_base) {
> +		tst_res(TFAIL, "writev wrote more than expected");
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	/* file content matches written bytes */
> +	SAFE_LSEEK(fd, initial_file_offset, SEEK_SET);
> +	SAFE_READ(1, fd, tmp, TEST_RETURN);
> +	if (memcmp(tmp, wr_iovec[0].iov_base, TEST_RETURN) == 0) {
> +		tst_res(TPASS, "file has expected content");
> +	} else {
> +		tst_res(TFAIL, "file has unexpected content");
> +		tst_res(TINFO, "expected:");
> +		dump_buf(wr_iovec[0].iov_base, TEST_RETURN);
> +		tst_res(TINFO, "actual file content:");
> +		dump_buf(tmp, TEST_RETURN);
> +	}
> +
> +	/* file offset has been updated according to written bytes */
> +	if (off_after == initial_file_offset + TEST_RETURN)
> +		tst_res(TPASS, "offset at %ld as expected", off_after);
> +	else
> +		tst_res(TFAIL, "offset unexpected %ld", off_after);
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void test_writev(void)
> +{
> +	test_partially_valid_iovec(0);
> +	test_partially_valid_iovec(CHUNK + 1);
> +	test_partially_valid_iovec(getpagesize());
> +	test_partially_valid_iovec(getpagesize() + 1);
> +}
> +
> +static void setup(void)
> +{
> +	bad_addr = SAFE_MMAP(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS,
> +			0, 0);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "access05",
                  ^
		  writev07
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.test_all = test_writev,
> +};

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
