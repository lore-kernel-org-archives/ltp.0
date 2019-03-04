From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Mar 2019 15:40:00 +0100
Subject: [LTP] [PATCH 1/2] syscalls/sync_file_range: add partial file
 sync test-case
In-Reply-To: <1551428901-30162-1-git-send-email-sumit.garg@linaro.org>
References: <1551428901-30162-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190304144000.GA15696@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void verify_sync_partial_file(void)
> +{
> +	int fd;
> +	unsigned long written;
> +
> +	fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
> +
> +	lseek(fd, FILE_SIZE/4, SEEK_SET);
> +
> +	tst_dev_bytes_written(tst_device->dev);
> +
> +	tst_fill_fd(fd, 0xff, TST_MB, FILE_SIZE_MB/2);

Any reason why we don't do full FILE_SIZE_MB write here and then check
that the result was somewhere between FILE_SIZE/2 +-10% ?

Other than that the patch looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
