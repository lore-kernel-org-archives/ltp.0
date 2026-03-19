Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D531C1090255
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 16:50:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CDAB3E30BB
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 17:50:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C76B83C940A
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:49:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39E5D1400066
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:49:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE79F5BEE6;
 Thu, 19 Mar 2026 16:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773938981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfZo9KMQ9oeh4nIJXQMl+05F1RJARWVqwdws33IEL78=;
 b=L/D5eq4mZ3p0K6kwWmlc93mLkqfxt+V0R2noncdpHAzF4auA3cBAPU59CdIOvK542+8cMH
 nkdY562Q4ezYUHblZ6Yje5MLqTEk2QKbLGDGB3CLRMmIdEAFX7PNG0FHdsLS4cSpLfgjuN
 yhGTjpERu5pg5YYw4c/3ZgOyzm2dJHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773938981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfZo9KMQ9oeh4nIJXQMl+05F1RJARWVqwdws33IEL78=;
 b=7btosqUXIE9OuZsqf1fBFTu51HlM7Vcb2PGyCteYZvTkhMEwtcXAJIN1f/sJW9Ef4atnA6
 fEfQ8J7UVV/zHnAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZltmJ1sT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zqB8MXaf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773938980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfZo9KMQ9oeh4nIJXQMl+05F1RJARWVqwdws33IEL78=;
 b=ZltmJ1sTTRT5q+CBw1GfduTr2tNmZsC5bz9EKgHzxHUPjzfist1FxwNwKcKCjkjGrG+JgR
 M1Pv0QjGn8EtuLW2AP+Udq5Y4FnEXOQXh5D+pNcQhMn4wqxyBOnwN3RqM0dMrad3dV+spq
 F8pGm20m1estRweu8328+W0R0EHjBYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773938980;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FfZo9KMQ9oeh4nIJXQMl+05F1RJARWVqwdws33IEL78=;
 b=zqB8MXafjNKIfTEdxpF40LG/14+Q82vuWH4TzkTVusStUVevGgJhLmcbrqzt5x6xtfAZmz
 N7k4dgZVuMnVRzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE28F4273C;
 Thu, 19 Mar 2026 16:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id is8yLSQpvGm8DQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Mar 2026 16:49:40 +0000
Date: Thu, 19 Mar 2026 17:49:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <abwpJ3bR2lwM6Ru3@yuki.lan>
References: <20260318110328.52031-1-sachinp@linux.ibm.com>
 <20260318110328.52031-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318110328.52031-2-sachinp@linux.ibm.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: CE79F5BEE6
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] [PATCH 1/2] io_uring: Test IORING READ and WRITE
 operations
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  # Tests below may cause kernel memory leak
>  perf_event_open03 perf_event_open03
> diff --git a/testcases/kernel/syscalls/io_uring/.gitignore b/testcases/kernel/syscalls/io_uring/.gitignore
> index 749db17db..9382ae413 100644
> --- a/testcases/kernel/syscalls/io_uring/.gitignore
> +++ b/testcases/kernel/syscalls/io_uring/.gitignore
> @@ -1,2 +1,3 @@
>  /io_uring01
>  /io_uring02
> +/io_uring03
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring03.c b/testcases/kernel/syscalls/io_uring/io_uring03.c
> new file mode 100644
> index 000000000..53d4feae5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 IBM
> + * Author: Sachin Sant <sachinp@linux.ibm.com>
> + *
> + * Test IORING_OP_READ and IORING_OP_WRITE operations.
> + *
> + * This test validates basic read and write operations using io_uring.
> + * It tests:
> + * 1. IORING_OP_WRITE - Writing data to a file
> + * 2. IORING_OP_READ - Reading data from a file
> + * 3. Data integrity verification
> + */

The second half of the comment should be doc comment (starts with /*\)
so that it's picked up by the documentation parser and exported into the
online documentation.

> +#include "io_uring_common.h"
> +
> +#define TEST_FILE "io_uring_test_file"
> +#define QUEUE_DEPTH 2
> +#define BLOCK_SZ 4096
> +
> +static char write_buf[BLOCK_SZ];
> +static char read_buf[BLOCK_SZ];
> +static struct io_uring_submit s;
> +static sigset_t sig;
> +
> +static void test_write_read(void)
> +{
> +	int fd;
> +	size_t i;
> +
> +	/* Prepare write buffer with pattern */

There a lot of comments like this that are commenting the
obvious. Comments that comment obvious does not add any value and
shouldn't be added.

> +	for (i = 0; i < BLOCK_SZ; i++)
> +		write_buf[i] = 'A' + (i % 26);

This should be done only once in the test setup.

> +	/* Open file for writing */
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	/* Test IORING_OP_WRITE */
> +	tst_res(TINFO, "Testing IORING_OP_WRITE");
> +	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf, BLOCK_SZ, 0);



> +	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_WRITE, &sig) == 0)
> +		tst_res(TPASS, "IORING_OP_WRITE completed successfully");
> +
> +	/* Sync to ensure data is written */
> +	SAFE_FSYNC(fd);
> +
> +	/* Test IORING_OP_READ */
> +	tst_res(TINFO, "Testing IORING_OP_READ");
> +	memset(read_buf, 0, BLOCK_SZ);
> +	io_uring_submit_sqe(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0);
> +
> +	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_READ, &sig) == 0)
> +		tst_res(TPASS, "IORING_OP_READ completed successfully");
> +
> +	/* Verify data integrity */
> +	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0) {
> +		tst_res(TPASS, "Data integrity verified");
> +	} else {
> +		tst_res(TFAIL, "Data mismatch after read");
> +		for (i = 0; i < BLOCK_SZ && i < 64; i++) {
> +			if (write_buf[i] != read_buf[i]) {
> +				tst_res(TINFO, "First mismatch at offset %zu: "
> +					"wrote 0x%02x, read 0x%02x",
> +					i, write_buf[i], read_buf[i]);
> +				break;
> +			}
> +		}
> +	}

This should really be put into a function and used in both test cases.

> +	SAFE_CLOSE(fd);
> +}
> +
> +static void test_partial_io(void)
> +{
> +	int fd;
> +	size_t half = BLOCK_SZ / 2;
> +	size_t i;
> +
> +	tst_res(TINFO, "Testing partial I/O operations");
> +
> +	/* Prepare buffer */
> +	for (i = 0; i < BLOCK_SZ; i++)
> +		write_buf[i] = 'a' + (i % 26);
> +
> +	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT | O_TRUNC, 0644);
> +
> +	/* Write first half */
> +	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf, half, 0);
> +	if (io_uring_wait_cqe(&s, half, IORING_OP_WRITE, &sig) == 0)
> +		tst_res(TPASS, "Partial write (first half) succeeded");
> +
> +	/* Write second half */
> +	io_uring_submit_sqe(&s, fd, IORING_OP_WRITE, write_buf + half,
> +			    half, half);
> +	if (io_uring_wait_cqe(&s, half, IORING_OP_WRITE, &sig) == 0)
> +		tst_res(TPASS, "Partial write (second half) succeeded");
> +
> +	SAFE_FSYNC(fd);
> +
> +	/* Read back in one operation */
> +	memset(read_buf, 0, BLOCK_SZ);
> +	io_uring_submit_sqe(&s, fd, IORING_OP_READ, read_buf, BLOCK_SZ, 0);
> +	if (io_uring_wait_cqe(&s, BLOCK_SZ, IORING_OP_READ, &sig) == 0)
> +		tst_res(TPASS, "Full read after partial writes succeeded");
> +
> +	/* Verify */
> +	if (memcmp(write_buf, read_buf, BLOCK_SZ) == 0)
> +		tst_res(TPASS, "Partial I/O data integrity verified");
> +	else
> +		tst_res(TFAIL, "Partial I/O data mismatch");
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void run(void)
> +{
> +	io_uring_setup_queue(&s, QUEUE_DEPTH);
> +	test_write_read();
> +	test_partial_io();
> +	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
> +}
> +
> +static void setup(void)
> +{
> +	io_uring_setup_supported_by_kernel();
> +	sigemptyset(&sig);
> +	memset(&s, 0, sizeof(s));
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/kernel/io_uring_disabled", "0",
> +			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "5d17b4a4b48c"},

This commit does not appear to exist in linux kernel git tree.

> +		{"linux-git", "2b188cc1bb85"},

And this is a commit that added io_uring. Commit hashes in tests are
used only for cases where the test is a regression test for some bug and
point to a commit that fixed the problem.

> +		{}
> +	}
> +};
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring_common.h b/testcases/kernel/syscalls/io_uring/io_uring_common.h

Since you are pulling the common code into header it would be nice to
convert the io_uring01.c so that it uses the common header as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
