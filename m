Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1D5C5478C
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 17:07:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 822ED3D0E7C
	for <ltp@archiver.kernel.org>; Wed, 28 Feb 2024 18:07:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0963D06D5
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 18:07:33 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21E65200C96
 for <ltp@lists.linux.it>; Wed, 28 Feb 2024 18:07:32 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61CD01F7C5;
 Wed, 28 Feb 2024 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709140051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1b8cjIoowrexYlXC+c74bUHBAaZMhCGBnS+sn96vANI=;
 b=KDRVFj5S5OSbBdvH8B/iqNVyoucIhbPq1SIqssQYfMDF9Wof2qXn1uJ+Y8vcmkxkE1Hh59
 RZ67zbJ6oU4BmAG77jOuZkXXnS0JrhkucpX4YFYyYne4lN/izKBttUbeAlYHhy957D7XT0
 etGOJQYXzax6WkH4P7TS1V/ugMrmS3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709140051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1b8cjIoowrexYlXC+c74bUHBAaZMhCGBnS+sn96vANI=;
 b=5ifa5bFc1naGVZjVj6Ftku/6p6xURKiEqYD8NdGB4TFAFATBAJSdwe7+sO1tVgAcMfm7cF
 1z1WGEYPUMuhWXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709140051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1b8cjIoowrexYlXC+c74bUHBAaZMhCGBnS+sn96vANI=;
 b=KDRVFj5S5OSbBdvH8B/iqNVyoucIhbPq1SIqssQYfMDF9Wof2qXn1uJ+Y8vcmkxkE1Hh59
 RZ67zbJ6oU4BmAG77jOuZkXXnS0JrhkucpX4YFYyYne4lN/izKBttUbeAlYHhy957D7XT0
 etGOJQYXzax6WkH4P7TS1V/ugMrmS3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709140051;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1b8cjIoowrexYlXC+c74bUHBAaZMhCGBnS+sn96vANI=;
 b=5ifa5bFc1naGVZjVj6Ftku/6p6xURKiEqYD8NdGB4TFAFATBAJSdwe7+sO1tVgAcMfm7cF
 1z1WGEYPUMuhWXBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 53847134FB;
 Wed, 28 Feb 2024 17:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 1OBjE1No32WCOwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 28 Feb 2024 17:07:31 +0000
Date: Wed, 28 Feb 2024 18:07:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240228170729.GA1618063@pevik>
References: <20231018054357.29035-1-wegao@suse.com>
 <20240118073215.10026-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240118073215.10026-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_fiemap01: New test for fiemap ioctl()
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Fixes: #535

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
> new file mode 100644
> index 000000000..a626bb03c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify basic fiemap ioctl
> + *
nit: missing space and dot at the end.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/fiemap.h>
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +
> +#define TESTFILE "testfile"
> +#define NUM_EXTENT 2
> +#define FILE_OFFSET ((rand() % 8 + 2) * getpagesize())
> +
> +static char *buf;
> +
> +static void print_extens(struct fiemap *fiemap)
> +{
> +
nit: please no space above.
> +	tst_res(TDEBUG, "File extent count: %u", fiemap->fm_mapped_extents);
nit: please add space here (readability)
> +	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
> +		tst_res(TDEBUG, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
> +				i + 1,
> +				fiemap->fm_extents[i].fe_logical,
> +				fiemap->fm_extents[i].fe_physical,
> +				fiemap->fm_extents[i].fe_flags,
> +				fiemap->fm_extents[i].fe_length);
> +	}
> +}
> +
> +static void verify_ioctl(void)
> +{
> +	int fd;
> +	struct fiemap *fiemap;
> +
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +
> +	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
> +	fiemap->fm_start = 0;
> +	fiemap->fm_length = ~0ULL;
> +	fiemap->fm_extent_count = 1;
> +
> +	fiemap->fm_flags =  -1;
> +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);

I get on Tumbleweed with 6.8.0-rc4-1.g9b23bf2-default EOPNOTSUPP:
ioctl_fiemap01.c:52: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
What is the missing dependency for FS_IOC_FIEMAP? Or is there wrong fiemap use
which causes that?

> +
> +	fiemap->fm_flags =  0;
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
And on the same kernel another EOPNOTSUPP:

ioctl_fiemap01.c:55: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) | ((('f')) << (0+8)) | (((11)) << 0) | ((((sizeof(struct fiemap)))) << ((0+8)+8)))),...) failed: EOPNOTSUPP (95)
> +	print_extens(fiemap);
> +	if (fiemap->fm_mapped_extents == 0)
> +		tst_res(TPASS, "Check fiemap iotct zero fm_mapped_extents pass");
s/iotct/ioctl/

> +	else
> +		tst_res(TFAIL, "Check fiemap iotct zero fm_mapped_extents failed");
s/iotct/ioctl/
> +
> +	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, getpagesize());
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +	print_extens(fiemap);
Maybe print only on failure?
> +	if ((fiemap->fm_mapped_extents == 1) && (fiemap->fm_extents[0].fe_physical == 0))
NOTE: brackets are not needed (== has higher precedence than &&), thus:
	if (fiemap->fm_mapped_extents == 1 && fiemap->fm_extents[0].fe_physical == 0)

> +		tst_res(TPASS, "Check fiemap iotct one fm_mapped_extents pass");
s/iotct/ioctl/
> +	else
> +		tst_res(TFAIL, "Check fiemap iotct one fm_mapped_extents failed");
s/iotct/ioctl/
> +
> +	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +	print_extens(fiemap);
> +	if ((fiemap->fm_mapped_extents == 1) &&
nit: again == does not need to be in ()
> +		(fiemap->fm_extents[0].fe_flags == FIEMAP_EXTENT_LAST) &&
> +		(fiemap->fm_extents[0].fe_physical > 0) &&
> +		(fiemap->fm_extents[0].fe_length == (__u64)getpagesize()))
> +		tst_res(TPASS, "Check fiemap iotct FIEMAP_FLAG_SYNC fm_flags pass");
s/iotct/ioctl/
> +	else
> +		tst_res(TFAIL, "Check fiemap iotct FIEMAP_FLAG_SYNC fm_flags failed");
s/iotct/ioctl/
There are 4x checks, I guess instead it would be worth to write what exactly failed.

> +
> +	fiemap->fm_extent_count = NUM_EXTENT;
> +	srand(time(NULL));
> +	SAFE_LSEEK(fd, FILE_OFFSET, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, getpagesize());
> +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> +	print_extens(fiemap);
> +	if ((fiemap->fm_mapped_extents == NUM_EXTENT) &&
nit: If this check was repeated more than twice, I would put it into separate
function.
> +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_flags == FIEMAP_EXTENT_LAST) &&
> +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_physical > 0) &&
> +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_length == (__u64)getpagesize()))
> +		tst_res(TPASS, "Check fiemap iotct multiple fm_mapped_extents pass");
> +	else
> +		tst_res(TFAIL, "Check fiemap iotct multiple fm_mapped_extents failed");
> +
> +	free(fiemap);
> +	SAFE_CLOSE(fd);
> +	unlink(TESTFILE);
> +}
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
