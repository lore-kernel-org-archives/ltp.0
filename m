From: Cui Bixuan <cuibixuan@huawei.com>
Date: Thu, 1 Dec 2016 14:36:58 +0800
Subject: [LTP] [PATCH v2 1/3] syscalls: new test writev07
In-Reply-To: <81176684cd5c6bf764a070b79783f03f0037658a.1475827191.git.jstancek@redhat.com>
References: <81176684cd5c6bf764a070b79783f03f0037658a.1475827191.git.jstancek@redhat.com>
Message-ID: <583FC50A.3010605@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/10/7 16:11, Jan Stancek wrote:
> +				off_after);
> +
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	/* writev() wrote more bytes than bytes preceding invalid iovec */
> +	tst_res(TINFO, "writev() has written %ld bytes", TEST_RETURN);
> +	if (TEST_RETURN > (long) wr_iovec[0].iov_base) {
Hi, why TEST_RETURN(the return of writev) compare with wr_iovec[0].iov_base(the address) here?

I run it in armv7 (with printf("TEST_RETURN:%ld, wr_iovec[0].iov_base:%ld\n", TEST_RETURN, (long) wr_iovec[0].iov_base) for debug):

# ./writev07
tst_test.c:760: INFO: Timeout per run is 0h 05m 00s
writev07.c:60: INFO: starting test with initial file offset: 0
writev07.c:104: INFO: writev() has written 64 bytes
writev07.c:106: FAIL: writev wrote more than expected
TEST_RETURN:64, wr_iovec[0].iov_base:-1092708152
writev07.c:60: INFO: starting test with initial file offset: 65
writev07.c:104: INFO: writev() has written 64 bytes
writev07.c:106: FAIL: writev wrote more than expected
TEST_RETURN:64, wr_iovec[0].iov_base:-1092708152
writev07.c:60: INFO: starting test with initial file offset: 4096
writev07.c:104: INFO: writev() has written 64 bytes
writev07.c:106: FAIL: writev wrote more than expected
TEST_RETURN:64, wr_iovec[0].iov_base:-1092708152
writev07.c:60: INFO: starting test with initial file offset: 4097
writev07.c:104: INFO: writev() has written 64 bytes
writev07.c:106: FAIL: writev wrote more than expected
TEST_RETURN:64, wr_iovec[0].iov_base:-1092708144

So the case fail at all time.

Thanks,
Cui Bixuan

> +		tst_res(TFAIL, "writev wrote more than expected");
> +		SAFE_CLOSE(fd);
> +		return;
> +	}
> +
> +	/* file content matches written bytes */
> +	SAFE_LSEEK(fd, initial_file_offset, SEEK_SET);
> +	SAFE_READ(1, fd, tmp, TEST_RETURN);

