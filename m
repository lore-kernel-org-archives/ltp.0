Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C6C87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 11:40:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 644623C0F82
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:40:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2AC53C06B4
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 13:40:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26680600288
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 13:40:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E45A1F38F;
 Tue,  5 Aug 2025 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754394030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFSyXAH99L3wpaRBrhyUpBRz5QzSl5KOSHXoZqVIQP4=;
 b=w3Q50C2Ixd2KIqK2Z1xXGIopWfi4Zb9EoDUKL4jcu+MnYXblOW5M/LE1ouN3aJ8JnTSt3I
 5jKkugsKAoOKZ8JoOok3AhYFHNj8jutbVwBgZHQfDuezKBmPWyWrFZGayBlWWQRc8FI1Em
 9sarnDyBuqBFtp7VtQ98AnX4zy5xtlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754394030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFSyXAH99L3wpaRBrhyUpBRz5QzSl5KOSHXoZqVIQP4=;
 b=HEAcmWTHoOhDRmjAAPlPCi9K8grvWv4TbX5qfd+CiNC8YVKCln8x5jDe55DqcVIREA5Gdg
 pKr94lzIQv8IRPBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754394030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFSyXAH99L3wpaRBrhyUpBRz5QzSl5KOSHXoZqVIQP4=;
 b=w3Q50C2Ixd2KIqK2Z1xXGIopWfi4Zb9EoDUKL4jcu+MnYXblOW5M/LE1ouN3aJ8JnTSt3I
 5jKkugsKAoOKZ8JoOok3AhYFHNj8jutbVwBgZHQfDuezKBmPWyWrFZGayBlWWQRc8FI1Em
 9sarnDyBuqBFtp7VtQ98AnX4zy5xtlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754394030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFSyXAH99L3wpaRBrhyUpBRz5QzSl5KOSHXoZqVIQP4=;
 b=HEAcmWTHoOhDRmjAAPlPCi9K8grvWv4TbX5qfd+CiNC8YVKCln8x5jDe55DqcVIREA5Gdg
 pKr94lzIQv8IRPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECDB713A55;
 Tue,  5 Aug 2025 11:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Nq/nOK3tkWgLdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 Aug 2025 11:40:29 +0000
Date: Tue, 5 Aug 2025 13:41:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aJHt3qyVIuhU7Z0X@yuki.lan>
References: <20250805-file_setattr_getattr-v3-0-67a7747d226c@suse.com>
 <20250805-file_setattr_getattr-v3-5-67a7747d226c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250805-file_setattr_getattr-v3-5-67a7747d226c@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 5/6] Add file_attr02 test
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
> Verify that `file_getattr` is correctly reading filesystems additional
> attributes. We are running test on XFS only, since it's the only filesystem
> currently implementing the features we need.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                                  |  1 +
>  testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
>  testcases/kernel/syscalls/file_attr/file_attr02.c | 94 +++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index fed17a38baf0586ec886876b58c04158fa11e8e0..b69e474a6a596359bb1ace30312b55d6bf2b65cc 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -247,6 +247,7 @@ fsetxattr01 fsetxattr01
>  fsetxattr02 fsetxattr02
>  
>  file_attr01 file_attr01
> +file_attr02 file_attr02
>  
>  #posix_fadvise test cases
>  posix_fadvise01                      posix_fadvise01
> diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
> index de06f204d34be482a6401f2a5e7931caa5e3ab12..afe9c2fc9a4218dc032f044c1d317355a784a525 100644
> --- a/testcases/kernel/syscalls/file_attr/.gitignore
> +++ b/testcases/kernel/syscalls/file_attr/.gitignore
> @@ -1 +1,2 @@
>  file_attr01
> +file_attr02
> diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..f8ad8a325966a5c64cdaf45b9fc046e72b89b6fe
> --- /dev/null
> +++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that `file_getattr` is correctly reading filesystems additional
> + * attributes. We are running test on XFS only, since it's the only filesystem
> + * currently implementing the features we need.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +#include <linux/fs.h>
> +
> +#define MNTPOINT "mntpoint"
> +#define FILENAME "ltp_file"
> +#define BLOCKS 1024
> +#define PROJID 16
> +
> +static int fd = -1;
> +static int dfd = -1;
> +static struct fsxattr xattr;
> +static struct file_attr *attr;
> +
> +static void run(void)
> +{
> +	memset(attr, 0, sizeof(*attr));
> +
> +	TST_EXP_PASS(file_getattr(
> +		dfd, FILENAME,
> +		attr, FILE_ATTR_SIZE_LATEST,
> +		0));
> +
> +	TST_EXP_EQ_LI(attr->fa_xflags, xattr.fsx_xflags);
> +	TST_EXP_EQ_LI(attr->fa_extsize, xattr.fsx_extsize);
> +	TST_EXP_EQ_LI(attr->fa_cowextsize, xattr.fsx_cowextsize);
> +	TST_EXP_EQ_LI(attr->fa_nextents, xattr.fsx_nextents);
> +	TST_EXP_EQ_LI(attr->fa_projid, PROJID);
> +	TST_EXP_EQ_LI(attr->fa_projid, xattr.fsx_projid);
> +}
> +
> +static void setup(void)
> +{
> +	int block_size;
> +
> +	block_size = tst_dev_block_size(MNTPOINT);
> +
> +	dfd = SAFE_OPEN(MNTPOINT, O_RDONLY);
> +	fd = SAFE_CREAT(MNTPOINT "/" FILENAME, 0777);
> +
> +	SAFE_IOCTL(fd, FS_IOC_FSGETXATTR, &xattr);
> +
> +	xattr.fsx_xflags |= FS_XFLAG_EXTSIZE;
> +	xattr.fsx_xflags |= FS_XFLAG_COWEXTSIZE;
> +	xattr.fsx_extsize = BLOCKS * block_size;
> +	xattr.fsx_cowextsize = BLOCKS * block_size;
> +	xattr.fsx_projid = PROJID;
> +
> +	SAFE_IOCTL(fd, FS_IOC_FSSETXATTR, &xattr);
> +
> +	/* this will force at least one extent to be allocated */
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
> +
> +	SAFE_IOCTL(fd, FS_IOC_FSGETXATTR, &xattr);
> +	SAFE_CLOSE(fd);
> +	fd = -1;

SAFE_CLOSE() does this for you.


The rest looks fine:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
