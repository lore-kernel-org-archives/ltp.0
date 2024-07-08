Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5576EC3DA42
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 14:29:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAABB3D3A2D
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 16:29:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 821553D39E1
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 16:29:15 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CEA5260083C
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 16:29:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A66F9218FC;
 Mon,  8 Jul 2024 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720448953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nsV/gxv28+x2PY7zCpx7yfbxCOXpnGOw4yvEqF7FJ8=;
 b=XlHmhL92B2q74MvrdNIMOGCWSMs+HTmfMfayN0k9PgU4wluecqYXyK6aFcl8u+F/Wjk0x4
 ojYwAYFvR5zCXRuJu68rXbqMRww0vxiqKfoUwALCoFTBndKDcd682UAXZfMasdNiQNeb9V
 lLnHX5yhhUhzPtPT+ebnpe00m+WRAaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720448953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nsV/gxv28+x2PY7zCpx7yfbxCOXpnGOw4yvEqF7FJ8=;
 b=7YrdsSnGJUQ7pFGWmxGt5psPvim2iKqcbLRg7j9YIqZMT1MG3Swm/fV4l+AwUTvf+jaLVX
 j09KKCko2wHq3yAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720448953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nsV/gxv28+x2PY7zCpx7yfbxCOXpnGOw4yvEqF7FJ8=;
 b=XlHmhL92B2q74MvrdNIMOGCWSMs+HTmfMfayN0k9PgU4wluecqYXyK6aFcl8u+F/Wjk0x4
 ojYwAYFvR5zCXRuJu68rXbqMRww0vxiqKfoUwALCoFTBndKDcd682UAXZfMasdNiQNeb9V
 lLnHX5yhhUhzPtPT+ebnpe00m+WRAaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720448953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/nsV/gxv28+x2PY7zCpx7yfbxCOXpnGOw4yvEqF7FJ8=;
 b=7YrdsSnGJUQ7pFGWmxGt5psPvim2iKqcbLRg7j9YIqZMT1MG3Swm/fV4l+AwUTvf+jaLVX
 j09KKCko2wHq3yAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9632A1396E;
 Mon,  8 Jul 2024 14:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Mh2JI7n3i2bnEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jul 2024 14:29:13 +0000
Date: Mon, 8 Jul 2024 16:29:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zov3tFe64kj19dAZ@yuki>
References: <20240516104227.25381-1-andrea.cervesato@suse.de>
 <20240516104227.25381-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516104227.25381-3-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] Add cachestat01 and cachestat01A tests
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
> diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
> new file mode 100644
> index 000000000..7362a9dcf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that cachestat() syscall is properly counting cached pages
> + * written inside a file. If storage device synchronization is requested, test
> + * will check if the number of dirty pages is zero.
> + *
> + * [Algorithm]
> + *
> + * * create a file with specific amount of pages
> + * ** synchronize storage device, if needed
> + * * monitor file with cachestat()
> + * * check if the right amount of pages have been moved into cache
> + * ** if storage device synchronization is requested, check that dirty pages is
> + *    zero
> + */
> +
> +#include "cachestat.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define FILENAME MNTPOINT "/myfile.bin"
> +#define NUMPAGES 32
> +
> +static char *data;
> +static int file_size;
> +static struct cachestat *cs;
> +static struct cachestat_range *cs_range;
> +static char *run_fsync;
> +
> +static void run(void)
> +{
> +	int fd;
> +
> +	memset(cs, 0, sizeof(struct cachestat));
> +
> +	fd = SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, 0600);
> +	SAFE_WRITE(0, fd, data, file_size);
> +
> +	if (run_fsync)
> +		fsync(fd);
> +
> +	TST_EXP_PASS(cachestat(fd, cs_range, cs, 0));
> +	print_cachestat(cs);
> +
> +	TST_EXP_EQ_LI(cs->nr_cache + cs->nr_evicted, NUMPAGES);
> +
> +	if (run_fsync)
> +		TST_EXP_EQ_LI(cs->nr_dirty, 0);
> +
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(FILENAME);
> +}
> +
> +static void setup(void)
> +{
> +	int page_size;
> +
> +	page_size = (int)sysconf(_SC_PAGESIZE);
> +	file_size = page_size * NUMPAGES;
> +
> +	data = SAFE_MALLOC(file_size);
> +	memset(data, 'a', file_size);

I would just allocate a single page and run the write in a loop in the
test. That way we can make the number of pages command line parameter
and try with a bigger mapping as well.

> +	cs_range->off = 0;
> +	cs_range->len = file_size;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (data)
> +		free(data);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.min_kver = "6.5",
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		"tmpfs",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&cs, .size = sizeof(struct cachestat)},
> +		{&cs_range, .size = sizeof(struct cachestat_range)},
> +		{}
> +	},
> +	.options = (struct tst_option[]) {
> +		{"s", &run_fsync, "Synchronize file with storage device"},
> +		{},
> +	},

Can we, rather than adding a command line option, change the test so
that it has two subtests with .tcnt = 2?

I think that it's better that the test runs all testcases by default and
the command like parameters should be used to change parameters of the
test (such as number of pages) rather than to enable/disable tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
