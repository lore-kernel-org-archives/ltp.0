Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41CBC433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:50:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 721F33C58E7
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 14:50:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85A0C3C1B14
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:49:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C21951A0048C
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:49:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1964B1FDFE;
 Tue,  7 Dec 2021 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638884991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GWQ0epV1t3gQHnMC2B53MIAXVJKghtUsf8WaUOsGKgM=;
 b=rakXB6vqV1NXSZVKLEIFI0eSelhPotrnQoPEbqyxMNIfnkta+Cg2Gp5fPT62gUDZMIxbID
 g9e6cqUEH3ZPh/NKNOaOoS8QVfIHH/a4oyl/bmjHh9oG5h9utex+8Fu8HSxF/AjYvQwrts
 ThkXHB1tGp8vot2akNc673opEkHbXzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638884991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GWQ0epV1t3gQHnMC2B53MIAXVJKghtUsf8WaUOsGKgM=;
 b=YyTOfQ2kN8TPDCd101z9Rob3i1vkJL4sPek/N03fEr01pND/4DScRoNDvu2BCx3/kt4Ntt
 1yS5aGteds20N+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC71513A82;
 Tue,  7 Dec 2021 13:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aBEgOH5mr2G7VQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Dec 2021 13:49:50 +0000
Date: Tue, 7 Dec 2021 14:51:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Ya9my0FdHXLqvkJr@yuki>
References: <1638825434-10768-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1638825434-10768-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/write06: Add new test
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
> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> ---
>  runtest/syscalls                           |  1 +
>  testcases/kernel/syscalls/write/.gitignore |  1 +
>  testcases/kernel/syscalls/write/write06.c  | 94 ++++++++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/write/write06.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bcf3d56..32fcda4 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1699,6 +1699,7 @@ write02 write02
>  write03 write03
>  write04 write04
>  write05 write05
> +write06 write06
>  
>  writev01 writev01
>  writev02 writev02
> diff --git a/testcases/kernel/syscalls/write/.gitignore b/testcases/kernel/syscalls/write/.gitignore
> index 7f36194..8529aae 100644
> --- a/testcases/kernel/syscalls/write/.gitignore
> +++ b/testcases/kernel/syscalls/write/.gitignore
> @@ -3,3 +3,4 @@
>  /write03
>  /write04
>  /write05
> +/write06
> diff --git a/testcases/kernel/syscalls/write/write06.c b/testcases/kernel/syscalls/write/write06.c
> new file mode 100644
> index 0000000..c62a266
> --- /dev/null
> +++ b/testcases/kernel/syscalls/write/write06.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Test the write() system call with O_APPEND.
> + *
> + * Writing 2k data to the file, close it and reopen it with O_APPEND.
> + * Verify that the file size is 3k and offset is moved to the end of the file.
> + */
> +
> +#include <stdlib.h>
> +#include <inttypes.h>
> +#include "tst_test.h"
> +#include "tst_safe_prw.h"
> +
> +#define K1              1024
> +#define K2              (K1 * 2)
> +#define K3              (K1 * 3)
> +#define DATA_FILE       "write06_file"
> +
> +static int fd = -1;
> +static char *write_buf[2];
> +
> +static void l_seek(int fdesc, off_t offset, int whence, off_t checkoff)
> +{
> +	off_t offloc;
> +
> +	offloc = SAFE_LSEEK(fdesc, offset, whence);
> +	if (offloc != checkoff) {
> +		tst_res(TFAIL, "%" PRId64 " = lseek(%d, %" PRId64 ", %d) != %" PRId64,
> +			(int64_t)offloc, fdesc, (int64_t)offset, whence, (int64_t)checkoff);
> +	}
> +}
> +
> +static void verify_write(void)
> +{
> +	int fail = 0;
> +	struct stat statbuf;
> +
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_CREAT | O_TRUNC, 0666);
> +	SAFE_WRITE(1, fd, write_buf[0], K2);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(DATA_FILE, O_RDWR | O_APPEND, 0666);
                                                     ^
						     No need to pass
						     mode without
						     O_CREAT
> +	SAFE_FSTAT(fd, &statbuf);
> +	if (statbuf.st_size != K2) {
> +		fail++;
> +		tst_res(TFAIL, "file size is %ld != K2", statbuf.st_size);
> +	}
> +
> +	l_seek(fd, K1, SEEK_SET, K1);

Why do we do the seek here?

Wouldn't it make much more sense just to write the write_buf[1] then
check that the st_size is K3?

That way we would check that O_APPEND opened file has correct position
associated with the file descriptor.

> +	SAFE_WRITE(1, fd, write_buf[1], K1);
> +	l_seek(fd, 0, SEEK_CUR, K3);

And here as well, why the seek? This is actually the place that
increases the size not the write() as it should have been.

> +	SAFE_FSTAT(fd, &statbuf);
> +	if (statbuf.st_size != K3) {
> +		fail++;
> +		tst_res(TFAIL, "file size is %ld != K3", statbuf.st_size);
> +	}

Really the whole test should do:

	open(FILE, O_RDWR | O_CREAT | O_TRUNC, 0666)
	write()
	close()

	open(FILE, O_RDWR | O_APPEND)
	check size
	write()
	check size
	close()

	open(FILE, O_RDONLY);
	read()
	verify data
	close()


> +	if (!fail)
> +		tst_res(TPASS, "O_APPEND test passed.");
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	write_buf[0] = SAFE_MALLOC(K2);
> +	memset(write_buf[0], 0, K2);
> +	write_buf[1] = SAFE_MALLOC(K1);
> +	memset(write_buf[0], 1, K1);
                         ^
			 1

Also can you please switch these two buffers to a guarded buffers?

See:

https://github.com/linux-test-project/ltp/wiki/C-Test-API#131-guarded-buffers

> +}
> +
> +static void cleanup(void)
> +{
> +	free(write_buf[0]);
> +	free(write_buf[1]);
> +
> +	if (fd > -1)

Probably fd != -1 would be a bit clearer.

> +		SAFE_CLOSE(fd);
> +
> +	SAFE_UNLINK(DATA_FILE);
> +}
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_write,
> +};
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
