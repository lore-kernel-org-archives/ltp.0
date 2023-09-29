Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC129E810D5
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 10:29:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2B9A3CE11E
	for <ltp@archiver.kernel.org>; Fri, 29 Sep 2023 12:29:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D9043C9943
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 12:28:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0839814060D2
 for <ltp@lists.linux.it>; Fri, 29 Sep 2023 12:28:52 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6341A1F390;
 Fri, 29 Sep 2023 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695983332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7hivdhfdbyRwCJ6145MLtql+jtOWGc4sz8qHYdoKALk=;
 b=oQNgExhbP3ciP68+f1o59YcTEApgDiQbEyZ6m7W4Od6ycywaZY3qJQQh0Ocep6BwM9j5xs
 RaAvDkZpNmiB9o6c8PwfjCrYOiz2iTKQtAIm915kvBURdAZzqB0S920xGxqsneXbuEbk0j
 uxOZc+VuOJCl6j1QzRrdG8Dh4l9jHuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695983332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7hivdhfdbyRwCJ6145MLtql+jtOWGc4sz8qHYdoKALk=;
 b=D5/F8SxYl1Ml5imN27cTYamNvTEWvZEIgifEJEOFk1btBMUlUf9yZaEg9/964xFA3nl6Sx
 2AZlspLFZEwAvgBA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1AE7D2C142;
 Fri, 29 Sep 2023 10:28:52 +0000 (UTC)
References: <20230902030354.14107-1-wegao@suse.com>
 <20230904094501.17371-1-wegao@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Fri, 29 Sep 2023 11:27:34 +0100
Organization: Linux Private Site
In-reply-to: <20230904094501.17371-1-wegao@suse.com>
Message-ID: <878r8pe0im.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] splices06.c: Add splice check on proc files
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


nit: still has typo in subject, but that can be fixed at merge.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/splice/splice06.c | 227 ++++++++++++++++++++
>  1 file changed, 227 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/splice/splice06.c
>
> diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
> new file mode 100644
> index 000000000..3139d16db
> --- /dev/null
> +++ b/testcases/kernel/syscalls/splice/splice06.c
> @@ -0,0 +1,227 @@
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
> +#include <ctype.h>
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
> +static void format_str(char *str)
> +{
> +	int i;
> +
> +	for (i = 0; i < BUF_SIZE ; i++) {
> +		if (!isdigit(str[i])) {
> +			str[i] = '\0';
> +			break;
> +		}
> +	}
> +	if (i == BUF_SIZE)
> +		tst_brk(TBROK, "can not find nonnumeric character from input string");
> +}
> +
> +static int splice_read_num(const char *file)
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
> +	ret = splice(fd_in, NULL, pipes[1], NULL, BUF_SIZE - 1, 0);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
> +
> +	SAFE_READ(0, pipes[0], buf, BUF_SIZE);
> +
> +	/* Search for the first nonnumeric character and replace it with \0 */
> +	format_str(buf);
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
> +static char *splice_read_str(const char *file, char *dest)
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
> +static void splice_write_num(const char *file, int num)
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
> +static void splice_write_str(const char *file, char *dest)
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
> +static void file_write_num(const char *file, int num)
> +{
> +	SAFE_FILE_PRINTF(file, "%d", num);
> +}
> +
> +static void file_write_str(const char *file, char *dest)
> +{
> +	SAFE_FILE_PRINTF(file, "%s", dest);
> +}
> +
> +static int file_read_num(const char *file)
> +{
> +	int num;
> +
> +	SAFE_FILE_SCANF(file, "%d", &num);
> +
> +	return num;
> +}
> +
> +static char *file_read_str(const char *file, char *dest)
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
