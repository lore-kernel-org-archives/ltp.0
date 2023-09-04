Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA7AC71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 08:41:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 787A93CB88D
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 10:41:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD86C3CB850
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 10:41:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A04A11000C75
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 10:41:20 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 07E7E1F8A8;
 Mon,  4 Sep 2023 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693816880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qpVOPBQqLD3BWotz2TLO0Lz294R0zvYV0CqAU0IyqZw=;
 b=faYTwLNRHLQLRunvjvTfH+bGtnLfoZHuqn5yPGP4rXWIgEZFSdk5jiMVJqJa/cxApN6hZ0
 rQS063dHWWX8IkzJJdpQBfwmSB+hnnT0TtpFNoCxX9lr3zb7WlQYrVvX4Fz6K0aKmrxZG5
 tVb3zehp4HlAWyAV5yRqxBnQcrRlGK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693816880;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qpVOPBQqLD3BWotz2TLO0Lz294R0zvYV0CqAU0IyqZw=;
 b=ZKvuufEl2bko2X850lJbBToA6XxbNQzvKAJk9VyxyGN2cliAbKFt5OWO5EYnruDtAOxWvu
 t+UJulKfatiCBJDA==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5A3C92C142;
 Mon,  4 Sep 2023 08:41:19 +0000 (UTC)
References: <20230817003947.16029-1-wegao@suse.com>
 <20230902030354.14107-1-wegao@suse.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Mon, 04 Sep 2023 09:01:59 +0100
Organization: Linux Private Site
In-reply-to: <20230902030354.14107-1-wegao@suse.com>
Message-ID: <87y1hmfhzn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] splices06.c: Add splice check on proc files
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

Thanks this is much easier to understand, but see comments below.

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/splice/splice06.c | 212 ++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/splice/splice06.c
>
> diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
> new file mode 100644
> index 000000000..2d2403055
> --- /dev/null
> +++ b/testcases/kernel/syscalls/splice/splice06.c
> @@ -0,0 +1,212 @@
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
> +#define BUF_SIZE 100
> +#define PIPE_MAX_INIT_SIZE 65536
> +#define PIPE_MAX_TEST_SIZE 4096
> +#define DOMAIN_INIT_NAME "LTP_INIT"
> +#define DOMAIN_TEST_NAME "LTP_TEST"
> +#define INTEGER_PROCFILE "/proc/sys/fs/pipe-max-size"
> +#define STRING_PROCFILE "/proc/sys/kernel/domainname"
> +
> +static int splice_read_num(char file[])

Why are you passing a char array instead of a pointer? I see this so
rarely that I'm not sure if it is the same as a pointer or if the memory
will be copied.

I think it should be char *const.


> +{
> +	int pipes[2];
> +	int fd_in;
> +	int ret;
> +	int num;
> +	char buf[BUF_SIZE];
> +
> +	memset(buf, '\0', sizeof(buf));
> +	fd_in = SAFE_OPEN(file, O_RDONLY);
> +	SAFE_PIPE(pipes);
> +
> +	ret = splice(fd_in, NULL, pipes[1], NULL, BUF_SIZE, 0);

As a general rule you shouldn't write into the whole buffer from an
untrusted source if it is expected to be a null terminated string. So it
should be (BUF_SIZE - 1).

> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
> +
> +	SAFE_READ(0, pipes[0], buf, BUF_SIZE);
> +
> +	/* Replace LF to '\0' otherwise tst_parse_int will report error */
> +	buf[strlen(buf)-1] = '\0';

What if there is no LF, is that a bug? I don't know if the file is
guaranteed to contain LF at the end.

In any case I think it would be better to search for the first non
numeric character and replace it with \0. If it's not there print a fail
or warning, because maybe we didn't get the whole file.

> +
> +	if (tst_parse_int(buf, &num, 0, INT_MAX))
> +		tst_brk(TBROK, "Invalid buffer num %s", buf);
> +
> +	SAFE_CLOSE(fd_in);
> +	SAFE_CLOSE(pipes[0]);
> +	SAFE_CLOSE(pipes[1]);
> +
> +	return num;
> +}
> +
> +static char *splice_read_str(char file[], char *dest)

Again an array of char and dest could be const.

> +{
> +	int pipes[2];
> +	int fd_in;
> +	int ret;
> +
> +	fd_in = SAFE_OPEN(file, O_RDONLY);
> +	SAFE_PIPE(pipes);
> +
> +	ret = splice(fd_in, NULL, pipes[1], NULL, BUF_SIZE, 0);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
> +
> +	SAFE_READ(0, pipes[0], dest, BUF_SIZE);
> +
> +	SAFE_CLOSE(fd_in);
> +	SAFE_CLOSE(pipes[0]);
> +	SAFE_CLOSE(pipes[1]);
> +
> +	return dest;
> +}
> +
> +
> +static void splice_write_num(char file[], int num)

and here and for the rest.

> +{
> +	int pipes[2];
> +	int fd_out;
> +	int ret;
> +	char buf[BUF_SIZE];
> +
> +	memset(buf, '\0', sizeof(buf));
> +
> +	fd_out = SAFE_OPEN(file, O_WRONLY, 0777);
> +	SAFE_PIPE(pipes);
> +	sprintf(buf, "%d", num);
> +
> +	SAFE_WRITE(SAFE_WRITE_ALL, pipes[1], buf, strlen(buf));
> +
> +	ret = splice(pipes[0], NULL, fd_out, NULL, BUF_SIZE, 0);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "splice write failed");
> +
> +	SAFE_CLOSE(fd_out);
> +	SAFE_CLOSE(pipes[0]);
> +	SAFE_CLOSE(pipes[1]);
> +}
> +
> +static void splice_write_str(char file[], char *dest)
> +{
> +	int pipes[2];
> +	int fd_out;
> +	int ret;
> +
> +	fd_out = SAFE_OPEN(file, O_WRONLY, 0777);
> +	SAFE_PIPE(pipes);
> +
> +	SAFE_WRITE(SAFE_WRITE_ALL, pipes[1], dest, strlen(dest));
> +
> +	ret = splice(pipes[0], NULL, fd_out, NULL, BUF_SIZE, 0);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "splice write failed");
> +
> +	SAFE_CLOSE(fd_out);
> +	SAFE_CLOSE(pipes[0]);
> +	SAFE_CLOSE(pipes[1]);
> +}
> +
> +static void file_write_num(char file[], int num)
> +{
> +	SAFE_FILE_PRINTF(file, "%d", num);
> +}
> +
> +static void file_write_str(char file[], char *dest)
> +{
> +	SAFE_FILE_PRINTF(file, "%s", dest);
> +}
> +
> +static int file_read_num(char file[])
> +{
> +	int num;
> +
> +	SAFE_FILE_SCANF(file, "%d", &num);
> +
> +	return num;
> +}
> +
> +static char *file_read_str(char file[], char *dest)
> +{
> +	SAFE_FILE_SCANF(file, "%s", dest);
> +	return dest;
> +}
> +
> +static void splice_test(void)
> +{
> +
> +	char buf_file[BUF_SIZE];
> +	char buf_splice[BUF_SIZE];
> +
> +	if (file_read_num(INTEGER_PROCFILE) == splice_read_num(INTEGER_PROCFILE))
> +		tst_res(TPASS, "Read num through splice correctly");
> +	else
> +		tst_brk(TBROK | TERRNO, "Read num through splice failed");
> +
> +	splice_write_num(INTEGER_PROCFILE, PIPE_MAX_TEST_SIZE);
> +
> +	if (file_read_num(INTEGER_PROCFILE) == PIPE_MAX_TEST_SIZE)
> +		tst_res(TPASS, "Write num through splice correctly");
> +	else
> +		tst_brk(TBROK | TERRNO, "Write num through splice failed");
> +
> +	memset(buf_file, '\0', sizeof(buf_file));
> +	memset(buf_splice, '\0', sizeof(buf_splice));
> +
> +	file_read_str(STRING_PROCFILE, buf_file);
> +	splice_read_str(STRING_PROCFILE, buf_splice);
> +
> +	if (!strncmp(buf_file, buf_splice, strlen(buf_file)))
> +		tst_res(TPASS, "Read string through splice correctly");
> +	else
> +		tst_brk(TBROK | TERRNO, "Read string through splice failed");
> +
> +	memset(buf_file, '\0', sizeof(buf_file));
> +
> +	splice_write_str(STRING_PROCFILE, DOMAIN_TEST_NAME);
> +	file_read_str(STRING_PROCFILE, buf_file);
> +
> +	if (!strncmp(buf_file, DOMAIN_TEST_NAME, strlen(buf_file)))
> +		tst_res(TPASS, "Write string through splice correctly");
> +	else
> +		tst_brk(TBROK | TERRNO, "Write string through splice failed");
> +}
> +
> +static void setup(void)
> +{
> +	file_write_str(STRING_PROCFILE, DOMAIN_INIT_NAME);
> +	file_write_num(STRING_PROCFILE, PIPE_MAX_INIT_SIZE);
> +}
> +
> +static struct tst_test test = {
> +	.min_kver = "5.11",
> +	.setup = setup,
> +	.test_all = splice_test,
> +	.needs_tmpdir = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{INTEGER_PROCFILE, NULL, TST_SR_TCONF},
> +		{STRING_PROCFILE, NULL, TST_SR_TCONF},
> +		{}
> +	},
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
