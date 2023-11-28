Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D9C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 13:22:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3008E3CDA33
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 14:22:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F47B3CC2FA
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:22:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 352CB1A001FE
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:22:22 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B9F51F85D;
 Tue, 28 Nov 2023 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701177742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQIldMjm4MtPGQxRy5E78LNO4N0BmrqjQYaGlK704ZE=;
 b=xIdw3BjkFY8I1u58zmm9nAXif/AewirWsZwL1ikN48ddZLdIXIfMkP+MVTI7duxX3ezaih
 YXWA1fjIiNV4vKteEybRo/LAHYgMjf/3vuf1qB0PGr7A2DTPrvaVu1Q+N/hv2SUt5VU/sH
 wHvJ4P9egOoXaSSwc0naUVV8dYHYZ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701177742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GQIldMjm4MtPGQxRy5E78LNO4N0BmrqjQYaGlK704ZE=;
 b=C44YQTQ8YdH8q9k+dkBjgVcSn8Vp2JBSbkaOr8AfZBaaYsdoTLsLhfrGFO8PShXXpc+fnL
 O4kpRNVn66Ad2SCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DD500139FC;
 Tue, 28 Nov 2023 13:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 2SbxM43pZWWUHAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 13:22:21 +0000
Date: Tue, 28 Nov 2023 14:22:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231128132216.GD381183@pevik>
References: <20231005085521.10057-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231005085521.10057-1-mkittler@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.51 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(1.79)[0.596];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-0.999];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Port getxattr02.c to new test API
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

Hi Marius,

Please, could you remove HAVE_SYS_XATTR_H check and TST_TEST_TCONF() ?
<sys/xattr.h> has been around for a long time?

I'll send a patch which does it on other files and from configure.

> * Utilize `all_filesystems = 1`-mechanism to test on various file
>   systems instead of relying on the temporary directory's file system
>   to support xattr (which it probably does not as it is commonly a
>   tmpfs)
> * Improve error handling
> * Simplify code and description

> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>  .../kernel/syscalls/getxattr/getxattr02.c     | 192 +++++++-----------
>  1 file changed, 73 insertions(+), 119 deletions(-)

> diff --git a/testcases/kernel/syscalls/getxattr/getxattr02.c b/testcases/kernel/syscalls/getxattr/getxattr02.c
> index a42057d0a..dbbce8f16 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr02.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr02.c
> @@ -1,64 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (C) 2011 Red Hat, Inc.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
This shows it should be GPL-2.0-only.

> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * Copyright (C) 2011  Red Hat, Inc.
nit: Test has been updated by LTP in 2012-2022.
> + * Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
>   */

> -/*
> +/*\
> + * [Description]
> + *
>   * In the user.* namespace, only regular files and directories can
>   * have extended attributes. Otherwise getxattr(2) will return -1
>   * and set errno to ENODATA.
>   *
>   * There are 4 test cases:
There needs to be a blank line, otherwise test list will not be formated (it
will be inline)

> - * 1. Get attribute from a FIFO, setxattr(2) should return -1 and
> + * - Get attribute from a FIFO, setxattr(2) should return -1 and
>   *    set errno to ENODATA
> - * 2. Get attribute from a char special file, setxattr(2) should
> + * - Get attribute from a char special file, setxattr(2) should
>   *    return -1 and set errno to ENODATA
> - * 3. Get attribute from a block special file, setxattr(2) should
> + * - Get attribute from a block special file, setxattr(2) should
>   *    return -1 and set errno to ENODATA
> - * 4. Get attribute from a UNIX domain socket, setxattr(2) should
> + * - Get attribute from a UNIX domain socket, setxattr(2) should
>   *    return -1 and set errno to ENODATA
>   */

...
> +static struct test_case {
> +	char *fname;
> +	int mode;
> +} tcases[] = {
> +	{ /* case 00, get attr from fifo */
Maybe, instead of this comments, could you add
char *desc to struct test_case and,, instead of this comment, specify below:

> +	 .fname = FNAME FIFO,
> +	 .mode = S_IFIFO,
     .desc = "get attr from fifo"
> +	},
> +	{ /* case 01, get attr from char special */
> +	 .fname = FNAME CHR,
> +	 .mode = S_IFCHR,
> +	},
> +	{ /* case 02, get attr from block special */
> +	 .fname = FNAME BLK,
> +	 .mode = S_IFBLK,
> +	},
> +	{ /* case 03, get attr from UNIX domain socket */
> +	 .fname = FNAME SOCK,
> +	 .mode = S_IFSOCK,
> +	},
>  };

...
> +	struct test_case *tc = &tcases[i];
> +	dev_t dev = tc->mode == S_IFCHR ? makedev(1, 3) : 0u;
> +
> +	if (mknod(tc->fname, tc->mode | 0777, dev) < 0)
> +		tst_brk(TBROK | TERRNO, "create %s (mode %i) failed", tc->fname, tc->mode);
> +
> +	TEST(getxattr(tc->fname, XATTR_TEST_KEY, buf, BUFSIZ));
> +	if (TST_RET == -1 && TST_ERR == ENODATA)
> +		tst_res(TPASS | TTERRNO, "expected return value");
> +	else
> +		tst_res(TFAIL | TTERRNO, "unexpected return value"
> +				" - expected errno %d - got", ENODATA);
>  }

>  static void setup(void)
>  {
...
> +	/* assert xattr support in the current filesystem */
> +	SAFE_TOUCH(FNAME, 0644, NULL);
> +	SAFE_SETXATTR(FNAME, "user.test", "test", 4, XATTR_CREATE);
>  }

> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> -#else /* HAVE_SYS_XATTR_H */
> -int main(int argc, char *argv[])
> -{
> -	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
> -}
> +static struct tst_test test = {
> +	.all_filesystems = 1,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
> +	.skip_filesystems = (const char *const []) {
> +			"exfat",
> +			"tmpfs",
tmpfs got xattrs support in kernel 6.6
https://kernelnewbies.org/LinuxChanges#Linux_6.6.TMPFS
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2daf18a7884dc03d5164ab9c7dc3f2ea70638469
And test works on 6.7.0-rc3-3.ge7296f9-default (openSUSE):

LTP_SINGLE_FS_TYPE=tmpfs ./getxattr02
...
tst_test.c:1650: TINFO: === Testing on tmpfs ===
tst_test.c:1105: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1086: TINFO: Limiting tmpfs size to 32MB
tst_test.c:1119: TINFO: Mounting ltp-tmpfs to /tmp/LTP_get5FL6hO/mntpoint fstyp=tmpfs flags=0
getxattr02.c:80: TPASS: expected return value: ENODATA (61)
getxattr02.c:80: TPASS: expected return value: ENODATA (61)
getxattr02.c:80: TPASS: expected return value: ENODATA (61)
getxattr02.c:80: TPASS: expected return value: ENODATA (61)

And it TCONF on older kernels
getxattr02.c:90: TCONF: no xattr support in fs, mounted without user_xattr option or invalid namespace/name format
=> we should skip tmpfs.

vfat, exfat also detect correctly xattr. I don't know if they can even get
support (there might be a technical limitation of the format of their metadata),
but I would still keep them in the list. But maybe others will see it
differently.


> +			"ramfs",
> +			"nfs",
> +			"vfat",
> +			NULL
> +	},
> +	.setup = setup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases)
> +};
> +
> +#else
> +TST_TEST_TCONF("System doesn't have <sys/xattr.h>");
>  #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
