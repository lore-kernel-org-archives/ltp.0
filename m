Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB5DC433F5
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDF3A3CA6BB
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 22:43:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C4113CA63C
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 22:43:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5807C2009C6
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 22:43:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2220F1F380;
 Wed, 20 Apr 2022 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650487388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wd2PqYOQNo+DjwPIfJZIUWx2KUhdB8jS3BiA32Ji5GU=;
 b=tQYCqDZCfBOUi354eq5j001FZ+YjfbJdD6SflA8XgQcs+usB4Ed5pEU4sSomj7O6e4I6zP
 H8hm7z3Sn6v61/wajzRguHFaOLzojeNAMNGTD8wrqIY1MC5xlLABqej2eYnudrRST+nuyL
 td0BdmziDxB2C2aYvk0QKYBtBudamnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650487388;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wd2PqYOQNo+DjwPIfJZIUWx2KUhdB8jS3BiA32Ji5GU=;
 b=3KfGsgu/W+ga2s6N5ZSOl2ewnaehwnogagpIgw1aLvd5D2NOBnuAdDI0JbEr6MD+47MkbP
 FrL/0cdryiNp7sAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E325B13AD5;
 Wed, 20 Apr 2022 20:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +hInNVtwYGLVIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Apr 2022 20:43:07 +0000
Date: Wed, 20 Apr 2022 22:43:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chen Hanxiao <chenhx.fnst@cn.fujitsu.com>
Message-ID: <YmBwWqS0GEuwnb/d@pevik>
References: <20220420102926.866-1-chenhx.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220420102926.866-1-chenhx.fnst@cn.fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mount_setattr01: Add basic functional
 test
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

Hi Chen, Dai,

> From: Chen Hanxiao <chenhx.fnst@fujitsu.com>

> diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
...
> +/*
> + * mount_setattr()
> + */
> +struct mount_attr {
> +	uint64_t attr_set;
> +	uint64_t attr_clr;
> +	uint64_t propagation;
> +	uint64_t userns_fd;
> +};
Interesting enough: in kernel tools/testing/selftests/mount_setattr/mount_setattr_test.c
defines it as __u64 (IMHO should be really uint64_t as that test is userspace as
Cyril pointed out) but real kernel code in fs/namespace.c happily uses "unsigned
int" :).

...
> diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> new file mode 100644
> index 000000000..d63db46fa
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + * Author: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic mount_setattr() test.
> + * Test whether the basic mount attributes are set correctly.
> + *
> + * Verify some MOUNT_SETATTR(2) attributes:
> + * 1) MOUNT_ATTR_RDONLY - makes the mount read-only
> + * 2) MOUNT_ATTR_NOSUID - causes the mount not to honor the
> + *    set-user-ID and set-group-ID mode bits and file capabilities
> + *    when executing programs.
> + * 3) MOUNT_ATTR_NODEV - prevents access to devices on this mount
> + * 4) MOUNT_ATTR_NOEXEC - prevents executing programs on this mount
> + * 5) MOUNT_ATTR_NOSYMFOLLOW - prevents following symbolic links
> + *    on this mount
> + * 6) MOUNT_ATTR_NODIRATIME - prevents updating access time for
> + *    directories on this mount
> + * Minimum Linux version required is v5.12.
Since we don't check for v5.12, it might be better to state "The functionality
was added in v5.12." (although only enterprise kernels would backport new
functionality, mainline stable kernels will not).
> + */

This needs some changes in order to be formatted properly as list and have
paragraphs. Sigh, nobody really runs:

cd metadata/ && make && chromium ../docparse/metadata.html

to have look what output his docs has :(
(can be fixed before merge)

/*\
 * [Description]
 *
 * Basic mount_setattr() test.
 * Test whether the basic mount attributes are set correctly.
 *
 * Verify some MOUNT_SETATTR(2) attributes:
 *
 * 1. MOUNT_ATTR_RDONLY &ndash; makes the mount read-only
 * 2. MOUNT_ATTR_NOSUID &ndash; causes the mount not to honor the
 *    set-user-ID and set-group-ID mode bits and file capabilities
 *    when executing programs.
 * 3. MOUNT_ATTR_NODEV &ndash; prevents access to devices on this mount
 * 4. MOUNT_ATTR_NOEXEC &ndash; prevents executing programs on this mount
 * 5. MOUNT_ATTR_NOSYMFOLLOW &ndash; prevents following symbolic links
 *    on this mount
 * 6. MOUNT_ATTR_NODIRATIME &ndash; prevents updating access time for
 *    directories on this mount
 *
 * Minimum Linux version required is v5.12.
 */

...
> +static void run(unsigned int n)
> +{
> +	int otfd;
> +	struct tcase *tc = &tcases[n];
> +	struct mount_attr attr = {
> +		.attr_set = tc->mount_attrs,
> +	};
> +	struct statvfs buf;
> +
> +	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> +		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
Although Cyril mentioned only TST_EXP_FD_SILENT(), IMHO it should be followed with:
	if (!TST_PASS)
		return;

Or does it make sense to continue testing when open_tree() fails?

> +	otfd = (int)TST_RET;
> +
> +	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
> +		"%s set", tc->name);

Shouldn't be here also :
	if (!TST_PASS)
		return;

check? I guess we need SAFE_ variants for not having to check it all the time.

Or does it make sense to continue testing when mount_setattr() fails?

> +	TEST(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "move_mount() failed");
> +		return;
> +	}

Maybe instead of TEST() and if use this?

	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));

	if (!TST_PASS)
		return;

> +
> +	SAFE_CLOSE(otfd);
> +
> +	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
And here as well.
> +
> +	if ((buf.f_flag & tc->expect_attrs) == 0)
> +		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
> +	else
> +		tst_res(TPASS, "%s is actually set as expected", tc->name);
> +
> +	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT))
> +		SAFE_UMOUNT(OT_MNTPOINT);
> +}

The rest LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
