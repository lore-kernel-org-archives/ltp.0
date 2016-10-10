From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Oct 2016 17:54:07 +0200
Subject: [LTP] [PATCH v2 1/3] syscalls: new test writev07
In-Reply-To: <81176684cd5c6bf764a070b79783f03f0037658a.1475827191.git.jstancek@redhat.com>
References: <81176684cd5c6bf764a070b79783f03f0037658a.1475827191.git.jstancek@redhat.com>
Message-ID: <20161010155406.GF1684@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/* file content matches written bytes */
> +	SAFE_LSEEK(fd, initial_file_offset, SEEK_SET);
> +	SAFE_READ(1, fd, tmp, TEST_RETURN);
> +	if (memcmp(tmp, wr_iovec[0].iov_base, TEST_RETURN) == 0) {
> +		tst_res(TPASS, "file has expected content");
> +	} else {
> +		tst_res(TFAIL, "file has unexpected content");
> +		tst_res(TINFO, "expected:");
                     ^
		     This TINFO looks redundant now.

Otherwise it looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
