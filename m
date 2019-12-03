From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Dec 2019 13:15:22 +0100
Subject: [LTP] [PATCH] Add vmsplice03 test
In-Reply-To: <20191126135434.3196-1-jcronenberg@suse.de>
References: <20191126135434.3196-1-jcronenberg@suse.de>
Message-ID: <20191203121522.GB2844@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice03.c b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
> new file mode 100644
> index 000000000..54dace1b6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/vmsplice/vmsplice03.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Jorik Cronenberg <jcronenberg@suse.de>
> + *
> + * Test vmsplice() from a pipe into user memory
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "lapi/fcntl.h"
> +#include "lapi/vmsplice.h"
> +
> +
> +#define TEST_BLOCK_SIZE (64*1024)	/* 64K */
> +
> +static char buffer[TEST_BLOCK_SIZE];
> +static off64_t offset;
> +
> +static void vmsplice_test(void)
> +{
> +	int written, i;
> +	int pipes[2];
> +	struct iovec iov;
> +	char arr_write[TEST_BLOCK_SIZE];
> +	char *arr_read;
> +
> +	iov.iov_base = arr_write;
> +	iov.iov_len = TEST_BLOCK_SIZE;
> +	offset = sizeof(struct iovec);

It may be a good idea to memset the arr_write[] array with well defined
data, e.g. 0 just to be sure that kernel really filled it.

> +	SAFE_PIPE(pipes);
> +	SAFE_WRITE(1, pipes[1], buffer, TEST_BLOCK_SIZE);
> +	written = vmsplice(pipes[0], &iov, 1, 0);
> +	arr_read = (char *)&iov;

This only works by accident because the arr_write is put on the stack
after the iovec structure and there is no padding in between them.

What you really should do is to use the arr_write pointer in the
comparsion instead. The struc iovec is just a description of an buffer
that starts in memory at arr_write address and is iov_len long because
the kernel has to know its lenght.

> +	if (written < 0)
> +		tst_brk(TBROK | TERRNO, "vmsplice() failed");
> +	else if (written == 0)

There is no need for an else branch after tst_brk() because tst_brk()
will exit the test immediately.

> +		tst_res(TFAIL, "vmsplice() didn't write anything");
> +	else {
> +		for (i = 0; i < written; i++) {
> +			if (arr_read[i+offset] != buffer[i]) {
> +				tst_res(TFAIL,
> +					"Wrong data in user memory at %i", i);
> +				break;
> +			}
> +		}
> +		if (i == written)
> +			tst_res(TPASS, "Spliced correctly into user memory");
> +	}
> +
> +	SAFE_CLOSE(pipes[1]);
> +	SAFE_CLOSE(pipes[0]);
> +}
> +
> +static void setup(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < TEST_BLOCK_SIZE; i++)
> +		buffer[i] = i & 0xff;
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = vmsplice_test,
> +	.min_kver = "2.6.23",
> +};

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
