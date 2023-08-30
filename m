Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453D4C6FA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 10:35:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99AFC3CE048
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 12:35:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7AA13C6D29
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 12:35:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD66A20175B
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 12:35:32 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C13FA1F45F;
 Wed, 30 Aug 2023 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693391731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Iu8SOoVFj68MBECvYKFLpiAy7KNn1j4wxExlGujzYw=;
 b=lb5LafXuUBZTj5RDzPIwVJdEQfgzQ5RQU6L1ebR4YM/IZcGq9JkDSjqA+rX2IPtrwnHBtd
 j94lDJPhMJRz+YbBKUJjvADay6PBWLX6357KbLUNUVKEoy2aW1aProb3JYBAD2Sn/DVzSr
 EFlMAyCpljSecRK2x53q+UK4Y5x+fUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693391731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Iu8SOoVFj68MBECvYKFLpiAy7KNn1j4wxExlGujzYw=;
 b=h/Q2vDzGokTD8dadm2/SxYfx7hFUI3dWRIQDFncD46tuQFlrPFotTITjsSVc/CxiFsNOzo
 Q8m1OoLac4XXfVBQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1CDDB2C142;
 Wed, 30 Aug 2023 10:35:30 +0000 (UTC)
References: <20230817003947.16029-1-wegao@suse.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Wed, 30 Aug 2023 10:45:57 +0100
Organization: Linux Private Site
In-reply-to: <20230817003947.16029-1-wegao@suse.com>
Message-ID: <875y4wizri.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] splice06.c: Add splice check on proc files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Subject had a typo s/splices/splice/.

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/splice/splice06.c | 134 ++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/splice/splice06.c
>
> diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
> new file mode 100644
> index 000000000..f14fd84c5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/splice/splice06.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test is cover splice() on proc files.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +
> +#include "tst_test.h"
> +#include "lapi/splice.h"
> +
> +#define TEST_BLOCK_SIZE 100
> +#define NAME_SPACES_NUM 1024
> +#define PROCFILE "/proc/sys/user/max_user_namespaces"

This file is not available on a lot of configs. I'd suggest using
instead /proc/kernel/domainname which lets you read/write up to 64
bytes and is often not set. See kernel/utsname_sysctl.c

We should probably also test an integer based one like
/proc/sys/fs/pipe-max-size.

> +#define TESTFILE1 "splice_testfile_1"
> +#define TESTFILE2 "splice_testfile_2"

Why do we need these files? We should be able to write to a pipe then
splice it to the proc file(s). Splicing to/from a regular file is
handled in other tests.

Also splice from the proc file to a pipe then read the pipe.

> +
> +static int fd_in, fd_out;
> +static int origin_name_spaces_num;
> +static char line[TEST_BLOCK_SIZE];

Why are these global variables?

It's not because you make sure they are closed during cleanup.

> +
> +static void splice_file(void)
> +{
> +	int pipes[2];
> +	int ret;
> +
> +	SAFE_PIPE(pipes);
> +
> +	ret = splice(fd_in, NULL, pipes[1], NULL, TEST_BLOCK_SIZE, 0);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
> +
> +	ret = splice(pipes[0], NULL, fd_out, NULL, TEST_BLOCK_SIZE, 0);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "splice(pipe, fd_out) failed");
> +
> +	SAFE_CLOSE(fd_in);
> +	SAFE_CLOSE(fd_out);
> +	SAFE_CLOSE(pipes[0]);
> +	SAFE_CLOSE(pipes[1]);
> +}



> +
> +static void set_value(char file[], int num)
> +{
> +	int fd;
> +	int len = snprintf(NULL, 0, "%d", num);
> +
> +	memset(line, '\0', sizeof(line));
> +	sprintf(line, "%d", num);
> +
> +	fd = SAFE_OPEN(file, O_RDWR | O_CREAT | O_TRUNC, 0777);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, line, len);
> +	SAFE_CLOSE(fd);

We have library functions to open then read, scan or write a
file. (SAFE_FILE_*).

> +}
> +
> +static int get_value(char file[])
> +{
> +	int fd, num, ret;
> +
> +	memset(line, '\0', sizeof(line));
> +
> +	fd = SAFE_OPEN(file, O_RDONLY);
> +	SAFE_READ(0, fd, line, TEST_BLOCK_SIZE);
> +	SAFE_CLOSE(fd);
> +
> +	ret = sscanf(line, "%d", &num);
> +	if (ret == EOF)
> +		tst_brk(TBROK | TERRNO, "sscanf error");
> +
> +	return num;
> +}
> +
> +static void splice_test(void)
> +{
> +
> +	int name_spaces_num_setting = get_value(PROCFILE);
> +
> +	fd_in = SAFE_OPEN(PROCFILE, O_RDONLY);
> +	fd_out = SAFE_OPEN(TESTFILE2, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> +	splice_file();

The control flow is unecessarily hard to follow here. You are opening
fds in the outer scope then closing them inside splice_file().

Given that I don't think it is necessary to have TESTFILE1/2 I'll skip
the rest of the function. However you need to make the control flow or
data flow clearer.

> +
> +	if (name_spaces_num_setting == get_value(TESTFILE2))
> +		tst_res(TPASS, "Written data has been read back correctly");
> +	else
> +		tst_brk(TBROK | TERRNO, "Written data has been read back failed");
> +
> +	if (get_value(PROCFILE) != NAME_SPACES_NUM)
> +		name_spaces_num_setting = NAME_SPACES_NUM;
> +	else
> +		name_spaces_num_setting = NAME_SPACES_NUM + 1;
> +
> +	set_value(TESTFILE1, name_spaces_num_setting);
> +
> +	fd_in = SAFE_OPEN(TESTFILE1, O_RDONLY, 0777);
> +	fd_out = SAFE_OPEN(PROCFILE, O_WRONLY, 0777);
> +
> +	splice_file();
> +
> +	if (name_spaces_num_setting == get_value(PROCFILE))
> +		tst_res(TPASS, "Written data has been written correctly");
> +	else
> +		tst_brk(TBROK | TERRNO, "Written data has been written failed");
> +}
> +
> +static void setup(void)
> +{
> +	origin_name_spaces_num = get_value(PROCFILE);

We have a save and restore feature in tst_test (tst_test.save_restore).

> +}
> +
> +static void cleanup(void)
> +{
> +	set_value(PROCFILE, origin_name_spaces_num);
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "5.11",
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = splice_test,
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
