From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Jun 2019 02:56:37 -0400 (EDT)
Subject: [LTP] [PATCH v2 3/3] pkey: add pkey02 test
In-Reply-To: <20190621102628.4800-4-liwang@redhat.com>
References: <20190621102628.4800-4-liwang@redhat.com>
Message-ID: <1186374967.29667455.1561359397802.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Signed-off-by: Li Wang <liwang@redhat.com>
> +
> +static void pkey_tests(int pkey, int prot, int flags, int fd)
> +{
> +	char *buffer;
> +
> +	if (fd == 0) {
> +		fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, 0664);
> +	}
> +
> +	buffer = SAFE_MMAP(NULL, psize, prot, flags, fd, 0);
> +
> +	if (pkey_mprotect(buffer, psize, prot, pkey) == -1)
> +		tst_brk(TBROK, "pkey_mprotect failed");
> +
> +	tst_res(TPASS, "apply pkey to the buffer area success");
> +
> +	if (fd > 0) {
> +		SAFE_CLOSE(fd);
> +	}
> +
> +	SAFE_MUNMAP(buffer, psize);
> +}
> +

Hi,

pkey02 doesn't try to read/write as pkey01, but otherwise two tests look
very similar.

Could we try to read/write here as well for all combinations of map flags?
Then pkey01 could be dropped since pkey02 would cover more than just 1 combination.
Or is there a different reason behind separate tests, that I'm missing?

Regards,
Jan
