From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Sep 2017 04:51:34 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH 06/15] syscalls/fallocate05: New test
In-Reply-To: <20170905160918.6477-6-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
 <20170905160918.6477-6-chrubis@suse.cz>
Message-ID: <1530936082.10130435.1504774294954.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it




----- Original Message -----
> Tests that fallocate() works fine when filesystem is full.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

...

> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include "tst_test.h"

I'm running into build failure:
fallocate05.c: In function ‘run’:
fallocate05.c:43: warning: implicit declaration of function ‘fallocate’
fallocate05.c:72: error: ‘FALLOC_FL_PUNCH_HOLE’ undeclared (first use in this function)
fallocate05.c:72: error: (Each undeclared identifier is reported only once
fallocate05.c:72: error: for each function it appears in.)
make: *** [fallocate05] Error 1

This likely needs:
#include "lapi/fallocate.h"

Regards,
Jan

> +
> +#define MNTPOINT "mntpoint"
> +#define FALLOCATE_SIZE 8192
> +
> +static int fd;
> +
> +static void run(void)
> +{
> +	char buf[FALLOCATE_SIZE];
> +	ssize_t ret;
> +
> +	fd = SAFE_OPEN(MNTPOINT "/test_file", O_WRONLY | O_CREAT);
> +
> +	if (fallocate(fd, 0, 0, FALLOCATE_SIZE)) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_res(TCONF | TERRNO, "fallocate() not supported");
> +			SAFE_CLOSE(fd);
> +			return;
> +		}
> +
> +		tst_brk(TBROK | TERRNO,
> +			"fallocate(fd, 0, 0, %i)", FALLOCATE_SIZE);
> +	}
> +
> +	tst_fill_fs(MNTPOINT);
> +
> +	ret = write(fd, buf, sizeof(buf));
> +
> +	if (ret < 0)
> +		tst_res(TFAIL | TERRNO, "write() failed unexpectedly");
> +	else
> +		tst_res(TPASS, "write() wrote %zu bytes", ret);
> +
> +	ret = fallocate(fd, 0, FALLOCATE_SIZE, FALLOCATE_SIZE);
> +	if (ret != -1)
> +		tst_brk(TFAIL, "fallocate() succeeded unexpectedly");
> +
> +	if (errno != ENOSPC)
> +		tst_brk(TFAIL | TERRNO, "fallocate() should fail with ENOSPC");
> +
> +	tst_res(TPASS | TERRNO, "fallocate() on full FS");
> +
> +	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE, 0, FALLOCATE_SIZE);
> +	if (ret == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF, "fallocate(FALLOC_FL_PUNCH_HOLE)");
> +
> +		tst_brk(TBROK | TERRNO, "fallocate(FALLOC_FL_PUNCH_HOLE)");
> +	}
> +	tst_res(TPASS, "fallocate(FALLOC_FL_PUNCH_HOLE)");
> +
> +	ret = write(fd, buf, 10);
> +	if (ret == -1)
> +		tst_res(TFAIL | TERRNO, "write()");
> +	else
> +		tst_res(TPASS, "write()");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +};
> --
> 2.13.0
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
