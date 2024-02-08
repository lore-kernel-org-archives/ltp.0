Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29879C48260
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 16:43:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 765773CF530
	for <ltp@archiver.kernel.org>; Thu,  8 Feb 2024 17:43:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCE073CAB54
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 17:43:04 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B0CA014010E2
 for <ltp@lists.linux.it>; Thu,  8 Feb 2024 17:43:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1FF222216;
 Thu,  8 Feb 2024 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707410581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AzULIF8ItWHcHSmRjGV1KfvdGyaT13QX3Zc4r/NM+40=;
 b=rDyourW43h8Utebv/PzzluKXNV83pypdp7AfVIy9oT43JkxaFCDjAh5btAz0in7fLcKMaI
 RJi4aMPCMSyStSo+HVhZ3cfzpDIY83OCRiXMZhIhJsfjWhEgCjwYsCA4BKEcsouTJODCOg
 fjaE0q2vNDBeg8cZPwzakKTfqRajA4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707410581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AzULIF8ItWHcHSmRjGV1KfvdGyaT13QX3Zc4r/NM+40=;
 b=0tlcsaA4x4v1X38c85DQJuKoQHQM2xeNnAhQqS8987t1U4A+rLS72wYl77XVaTkCZudW/r
 zYB3ptDs65J92/BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707410580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AzULIF8ItWHcHSmRjGV1KfvdGyaT13QX3Zc4r/NM+40=;
 b=3als962D7W25xLQBx1pB0mzd/x30g5i5mVGPHr9I8HTBuz8Ag1j3ri4aiq69vFHm1aqsfg
 lr5HNESwoM7uiYHRJ1r4L3ZDZD73Q3cGba+UozIFCD5z2Sx/6IxbsPlDgstYP3RHZqdxb4
 CuE4eZ8NlZfxhVm5bee64OrEMQkDSns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707410580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AzULIF8ItWHcHSmRjGV1KfvdGyaT13QX3Zc4r/NM+40=;
 b=t7mTXR90glsFrDpiG+hcOjB/GhGPXfwoslal8y4utdC2mHlWzkT1Zf+JgF8lZS61z1JWq8
 E7e4JYMzD4fXQzCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFCDB1326D;
 Thu,  8 Feb 2024 16:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dW6uKpQExWWkDwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 08 Feb 2024 16:43:00 +0000
Message-ID: <6213d21f-73cf-4b5a-84d5-7ea42653368b@suse.cz>
Date: Thu, 8 Feb 2024 17:43:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20231124123118.20441-1-andrea.cervesato@suse.de>
 <20231124123118.20441-2-andrea.cervesato@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20231124123118.20441-2-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,wipro.com:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor mount02 test using new LTP API
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
suggestions below.

On 24. 11. 23 13:31, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/kernel/syscalls/mount/mount02.c | 222 ++++++++--------------
>   1 file changed, 74 insertions(+), 148 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
> index 392b4fd3a..965e75fe9 100644
> --- a/testcases/kernel/syscalls/mount/mount02.c
> +++ b/testcases/kernel/syscalls/mount/mount02.c
> @@ -1,76 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> - *  AUTHOR: Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
> - * Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

The correct SPDX header for this test is:
// SPDX-License-Identifier: GPL-2.0-only

We cannot change the test licence without permission from the original 
author.

> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *               Nirmala Devi Dhanasekar <nirmala.devi@wipro.com>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>    *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + * Check for basic errors returned by mount(2) system call.
>    *
> + * - ENODEV if filesystem type not configured
> + * - ENOTBLK if specialfile is not a block device
> + * - EBUSY if specialfile is already mounted or it  cannot  be remounted
> + *   read-only, because it still holds files open for writing.
> + * - EINVAL if specialfile or device is invalid or a remount was attempted,
> + *   while source was not already mounted on target.
> + * - EFAULT if special file or device file points to invalid address space.
> + * - ENAMETOOLONG if pathname was longer than MAXPATHLEN.
> + * - ENOENT if pathname was empty or has a nonexistent component.
> + * - ENOTDIR if not a directory.
>    */
>   
> -/*
> -
> -   DESCRIPTION
> -	Check for basic errors returned by mount(2) system call.
> -
> -	Verify that mount(2) returns -1 and sets errno to
> -	1) ENODEV if filesystem type not configured
> -	2) ENOTBLK if specialfile is not a block device
> -	3) EBUSY if specialfile is already mounted or
> -		it  cannot  be remounted read-only, because it still holds
> -		files open for writing.
> -	4) EINVAL if specialfile or device is invalid or
> -		 a remount was attempted, while source was not already
> -		 mounted on target.
> -	5) EFAULT if specialfile or device file points to invalid address space.
> -	6) ENAMETOOLONG if pathname was longer than MAXPATHLEN.
> -	7) ENOENT if pathname was empty or has a nonexistent component.
> -	8) ENOTDIR if not a directory.
> -*/
> -
> -#include <errno.h>
> +#include "tst_test.h"
>   #include <sys/mount.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
>   #include <sys/sysmacros.h>
> -#include <fcntl.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void cleanup(void);
>   
> -char *TCID = "mount02";
> -
> -#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
> -#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
> +#define MNTPOINT "mntpoint"
>   
>   static char path[PATH_MAX + 2];
>   static const char *long_path = path;
> +static const char *device;
>   static const char *fs_type;
> +static const char *null;
>   static const char *wrong_fs_type = "error";
> -static const char *mntpoint = "mntpoint";
> -static const char *device;
> -static const char *null = NULL;
> -static const char *fault = (void*)-1;
> +static const char *mntpoint = MNTPOINT;
> +static const char *fault = (void *)-1;
>   static const char *nonexistent = "nonexistent";
>   static const char *char_dev = "char_device";
>   static const char *file = "filename";
>   static int fd;
>   
> -static void do_umount(void);
> -static void close_umount(void);
> -static void do_mount(void);
> -static void mount_open(void);
> +static void pre_mount(void);
> +static void post_umount(void);
> +static void pre_create_file(void);
> +static void post_delete_file(void);
>   
>   static struct test_case {
>   	const char **device;
> @@ -80,12 +54,11 @@ static struct test_case {
>   	int exp_errno;
>   	void (*setup)(void);
>   	void (*cleanup)(void);
> -} tc[] = {
> +} test_cases[] = {
>   	{&device, &mntpoint, &wrong_fs_type, 0, ENODEV, NULL, NULL},
>   	{&char_dev, &mntpoint, &fs_type, 0, ENOTBLK, NULL, NULL},
> -	{&device, &mntpoint, &fs_type, 0, EBUSY, do_mount, do_umount},
> -	{&device, &mntpoint, &fs_type, MS_REMOUNT | MS_RDONLY, EBUSY,
> -	 mount_open, close_umount},
> +	{&device, &mntpoint, &fs_type, 0, EBUSY, pre_mount, post_umount},
> +	{&device, &mntpoint, &fs_type, MS_REMOUNT | MS_RDONLY, EBUSY, pre_create_file, post_delete_file},
>   	{&null, &mntpoint, &fs_type, 0, EINVAL, NULL, NULL},
>   	{&device, &mntpoint, &null, 0, EINVAL, NULL, NULL},
>   	{&device, &mntpoint, &fs_type, MS_REMOUNT, EINVAL, NULL, NULL},
> @@ -96,117 +69,70 @@ static struct test_case {
>   	{&device, &file, &fs_type, 0, ENOTDIR, NULL, NULL},
>   };
>   
> -int TST_TOTAL = ARRAY_SIZE(tc);
> -
> -static void verify_mount(struct test_case *tc)
> +static void pre_mount(void)
>   {
> -	if (tc->setup)
> -		tc->setup();
> -
> -	TEST(mount(*tc->device, *tc->mntpoint, *tc->fs_type, tc->flag, NULL));
> -
> -	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "mount() succeded unexpectedly (ret=%li)",
> -		         TEST_RETURN);
> -		goto cleanup;
> -	}
> -
> -	if (TEST_ERRNO != tc->exp_errno) {
> -		tst_resm(TFAIL | TTERRNO,
> -		         "mount() was expected to fail with %s(%i)",
> -		         tst_strerrno(tc->exp_errno), tc->exp_errno);
> -		goto cleanup;
> -	}
> -
> -	tst_resm(TPASS | TTERRNO, "mount() failed expectedly");
> -
> -cleanup:
> -	if (tc->cleanup)
> -		tc->cleanup();
> +	SAFE_MOUNT(device, mntpoint, fs_type, 0, NULL);
>   }
>   
> -int main(int ac, char **av)
> +static void post_umount(void)
>   {
> -	int lc, i;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < TST_TOTAL; ++i)
> -			verify_mount(tc + i);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	if (tst_is_mounted(MNTPOINT))
> +		SAFE_UMOUNT(MNTPOINT);
>   }
>   
> -static void do_mount(void)
> +static void pre_create_file(void)
>   {
> -	if (mount(device, mntpoint, fs_type, 0, NULL))
> -		tst_brkm(TBROK | TERRNO, cleanup, "Failed to mount(mntpoint)");
> +	pre_mount();
> +	fd = SAFE_OPEN("mntpoint/file", O_CREAT | O_RDWR, 0700);
>   }
>   
> -static void mount_open(void)
> +static void post_delete_file(void)
>   {
> -	do_mount();
> -
> -	fd = SAFE_OPEN(cleanup, "mntpoint/file", O_CREAT | O_RDWR, S_IRWXU);
> +	SAFE_CLOSE(fd);
> +	post_umount();
>   }
>   
> -static void close_umount(void)
> +static void setup(void)
>   {
> -	SAFE_CLOSE(cleanup, fd);
> -	do_umount();
> +	device = tst_device->dev;
> +	fs_type = tst_device->fs_type;
> +
> +	memset(path, 'a', PATH_MAX + 1);
> +
> +	SAFE_MKNOD(char_dev, S_IFCHR | 0777, 0);
> +	SAFE_TOUCH(file, 0777, 0);
>   }
>   
> -static void do_umount(void)
> +static void cleanup(void)
>   {
> -	if (tst_umount(mntpoint))
> -		tst_brkm(TBROK | TERRNO, cleanup, "Failed to umount(mntpoint)");
> +	if (tst_is_mounted(MNTPOINT))
> +		SAFE_UMOUNT(MNTPOINT);
>   }
>   
> -static void setup(void)
> +static void run(unsigned int i)
>   {
> -	dev_t dev;
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	tst_require_root();
> -
> -	tst_tmpdir();
> -
> -	SAFE_TOUCH(cleanup, file, FILE_MODE, NULL);
> -
> -	fs_type = tst_dev_fs_type();
> -	device = tst_acquire_device(cleanup);
> -
> -	if (!device)
> -		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> +	struct test_case *tc = &test_cases[i];
>   
> -	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
> -
> -	SAFE_MKDIR(cleanup, mntpoint, DIR_MODE);
> -
> -	memset(path, 'a', PATH_MAX + 1);
> +	if (tc->setup)
> +		tc->setup();
>   
> -	dev = makedev(1, 3);
> -	if (mknod(char_dev, S_IFCHR | FILE_MODE, dev)) {
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "failed to mknod(char_dev, S_IFCHR | FILE_MODE, %lu)",
> -			 dev);
> -	}
> +	TST_EXP_FAIL(mount(*tc->device, *tc->mntpoint, *tc->fs_type, tc->flag, NULL),
> +		tc->exp_errno,
> +		"Expecting %s",
> +		tst_strerrno(tc->exp_errno));

This will print something like:
TPASS: Expecting ENOTBLK : ENOTBLK
TPASS: Expecting EBUSY : EBUSY
TPASS: Expecting EBUSY : EBUSY
TPASS: Expecting EINVAL : EINVAL
TPASS: Expecting EINVAL : EINVAL
TPASS: Expecting EINVAL : EINVAL

Could you add a bit more useful testcase descriptions? Something like
- mounting device with wrong FS type
- mounting character device
- mounting NULL path

>   
> -	TEST_PAUSE;
> +	if (tc->cleanup)
> +		tc->cleanup();
>   }
>   
> -static void cleanup(void)
> -{
> -	if (device)
> -		tst_release_device(device);
> -
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_device = 1,

.needs_device is forced by .format_device.

> +	.needs_tmpdir = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +};

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
