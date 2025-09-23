Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA9ACAC5AC
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 14:33:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97AEF3CDEB8
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 16:33:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBB0D3C4F80
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 16:32:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 35025600A76
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 16:32:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66A1B222E6;
 Tue, 23 Sep 2025 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758637977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XfcMovvhPyJZdKxSBp1sqUtUJ7fnkiFJBlawsTXEkeg=;
 b=lNAYHN+rvdikUVzuNWOkNVxZD1tW9tcXA6HxkvTK/6H2kE+UcUQFZ6L9jI0csO6Wd1OQhe
 3+TmfyqtxKB54bx9m0P3U9gDvyM+hJF9/aQ5OIumbCY7hTBL7BClL1j7cPOam87jaXVD9S
 k6RiJtI7eYGDShlrg4Cza0tNNoFb2Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758637977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XfcMovvhPyJZdKxSBp1sqUtUJ7fnkiFJBlawsTXEkeg=;
 b=ErJFkKzNDPmgNbv0SxypY3t1f0oWAm0z4BA3fUU7KTNrHKLa1Ts73+0J7F5Ud0RNbnBiRs
 PyFDmhM9NqthvIAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lNAYHN+r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ErJFkKzN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758637977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XfcMovvhPyJZdKxSBp1sqUtUJ7fnkiFJBlawsTXEkeg=;
 b=lNAYHN+rvdikUVzuNWOkNVxZD1tW9tcXA6HxkvTK/6H2kE+UcUQFZ6L9jI0csO6Wd1OQhe
 3+TmfyqtxKB54bx9m0P3U9gDvyM+hJF9/aQ5OIumbCY7hTBL7BClL1j7cPOam87jaXVD9S
 k6RiJtI7eYGDShlrg4Cza0tNNoFb2Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758637977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XfcMovvhPyJZdKxSBp1sqUtUJ7fnkiFJBlawsTXEkeg=;
 b=ErJFkKzNDPmgNbv0SxypY3t1f0oWAm0z4BA3fUU7KTNrHKLa1Ts73+0J7F5Ud0RNbnBiRs
 PyFDmhM9NqthvIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51A25132C9;
 Tue, 23 Sep 2025 14:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9weuE5mv0mj2RQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Tue, 23 Sep 2025 14:32:57 +0000
Message-ID: <773ab737-7841-4560-a505-56437db0b1ed@suse.cz>
Date: Tue, 23 Sep 2025 16:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
References: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
 <20250807-file_setattr_getattr-v6-5-ebe32b282d49@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250807-file_setattr_getattr-v6-5-ebe32b282d49@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, suse.cz:email,
 suse.com:email]
X-Rspamd-Queue-Id: 66A1B222E6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 5/7] Add file_attr02 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I've done pre-release testing and found two issues in this test.

On 8/7/25 09:01, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Verify that `file_getattr` is correctly reading filesystems additional
> attributes. We are running test on XFS only, since it's the only filesystem
> currently implementing the features we need.
> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   runtest/syscalls                                  |  1 +
>   testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
>   testcases/kernel/syscalls/file_attr/file_attr02.c | 92 +++++++++++++++++++++++
>   3 files changed, 94 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index fed17a38baf0586ec886876b58c04158fa11e8e0..b69e474a6a596359bb1ace30312b55d6bf2b65cc 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -247,6 +247,7 @@ fsetxattr01 fsetxattr01
>   fsetxattr02 fsetxattr02
>   
>   file_attr01 file_attr01
> +file_attr02 file_attr02
>   
>   #posix_fadvise test cases
>   posix_fadvise01                      posix_fadvise01
> diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
> index de06f204d34be482a6401f2a5e7931caa5e3ab12..afe9c2fc9a4218dc032f044c1d317355a784a525 100644
> --- a/testcases/kernel/syscalls/file_attr/.gitignore
> +++ b/testcases/kernel/syscalls/file_attr/.gitignore
> @@ -1 +1,2 @@
>   file_attr01
> +file_attr02
> diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4e0d87f0f3edc946bf9cd14e76cce9518bf928d0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
> @@ -0,0 +1,92 @@
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

This is the wrong blocksize. You don't want the physical blocksize from 
the underlying block device. You want the filesystem blocksize reported 
by stat(MNTPOINT).

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
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	if (dfd != -1)
> +		SAFE_CLOSE(dfd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.mntpoint = MNTPOINT,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.filesystems = (struct tst_fs []) {
> +		{.type = "xfs"},
> +		{}
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&attr, .size = sizeof(struct file_attr)},

You also need to enable reflink support with -m reflink=1 mkfs option, 
otherwise setting fsx_cowextsize in setup() will fail on older systems.

> +		{}
> +	}
> +};
> 


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
