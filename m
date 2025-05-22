Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637B9C54E90
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 20:57:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2EC13CC837
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 22:57:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDBC13CC837
 for <ltp@lists.linux.it>; Thu, 22 May 2025 22:56:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 23F8E1000231
 for <ltp@lists.linux.it>; Thu, 22 May 2025 22:56:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D3201F393;
 Thu, 22 May 2025 20:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747947403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2R//f2/Mg4yfBQGhVNLkXxt/guE5m0e1p9lNeDyo/C0=;
 b=Vrxh5GiBZhgS8idnk1xZuMI+8MG80oiS6dqkSRHMEhqsucJrTt1u+VCEni7fJk3wjoW/LQ
 DJ0gbIQFNKR6K+j0rqfaxudAwwgUFovhgwkWjWh0hh4pZuEVyGqM6RowXZWZ40XtG5CLx9
 4fjl/UF5u1WuKfDP6lGdBGjnSJsH19k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747947403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2R//f2/Mg4yfBQGhVNLkXxt/guE5m0e1p9lNeDyo/C0=;
 b=6Bi0aOum+An9ESk5aSYCO3YT1dSaHwQ7+jBFOy/2T8wYPOXX5zW8ooX+EDUEU+wga+eeDO
 lBzQtz7Pi7BFUEBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747947403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2R//f2/Mg4yfBQGhVNLkXxt/guE5m0e1p9lNeDyo/C0=;
 b=Vrxh5GiBZhgS8idnk1xZuMI+8MG80oiS6dqkSRHMEhqsucJrTt1u+VCEni7fJk3wjoW/LQ
 DJ0gbIQFNKR6K+j0rqfaxudAwwgUFovhgwkWjWh0hh4pZuEVyGqM6RowXZWZ40XtG5CLx9
 4fjl/UF5u1WuKfDP6lGdBGjnSJsH19k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747947403;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2R//f2/Mg4yfBQGhVNLkXxt/guE5m0e1p9lNeDyo/C0=;
 b=6Bi0aOum+An9ESk5aSYCO3YT1dSaHwQ7+jBFOy/2T8wYPOXX5zW8ooX+EDUEU+wga+eeDO
 lBzQtz7Pi7BFUEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5CBE137B8;
 Thu, 22 May 2025 20:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 65TmMYqPL2jeAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 May 2025 20:56:42 +0000
Date: Thu, 22 May 2025 22:56:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250522205637.GA32918@pevik>
References: <20250516151028.1254207-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250516151028.1254207-1-wegao@suse.com>
X-Spamd-Result: default: False [-0.50 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fsconfig04.c: Check FSCONFIG_SET_PATH
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

I'm sorry not a real review, just point out obvious API errors.

> Fixes: 1169
Fixes: #1169

> The fsconfig01.c does not test if FSCONFIG_SET_PATH have any effect,
> most of the calls there just set dummy "sync" parameter. This test
> case aims to verify if the FSCONFIG_SET_PATH operation can be used
> to dynamically change the external journal device of ext3 or ext4
> filesystem.

...
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> new file mode 100644
> index 000000000..119b8b175
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + *
This '*' should be '/*\' to be docparse.

> + * This test aims to validate the functionality of fsconfig(FSCONFIG_SET_PATH) in
> + * dynamically altering the external journal device of a ext3 or ext4 filesystem.
> + * Case acquires three loop devices (dev0, dev1, dev2), it formats dev1 and dev2
> + * as external journal devices using the -O journal_dev option and assigns them
> + * the same UUID. Then formats dev0 (the main filesystem) multiple times, first
> + * associating it with dev1, then change to dev2, finally back to dev1 again as
> + * an external journal using the -J device= option.
> + *
> + * 2 workarounds in this case need mention:
And here should be new line, right?

> + * - To avoid "journal UUID does not match" error when switch external journal device
> + *   we have to assign same UUID to dev1/dev2
> + * - Before fsconfig test we have to formats dev0 associating to dev1->dev2->dev1,
> + *   this will make sure both dev1/2's supper block contain correct content. Otherwise
> + *   you will encounter error such as "EXT4-fs (loop0): External journal has more than
> + *   one user (unsupported) - 0" when switch external journal device using fsconfig.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"

> +#include "old/old_device.h"
Why this?

> +
> +#define MNTPOINT	"mntpoint"
> +#define LOOP_DEV_SIZE 10
> +#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
> +
> +static int fd;
> +static const char *dev;
> +static char dev0[NAME_MAX];
> +static char dev1[NAME_MAX];
> +static char dev2[NAME_MAX];
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	TST_EXP_PASS_SILENT(tst_detach_device(dev1));
> +	TST_EXP_PASS_SILENT(tst_detach_device(dev2));
> +}
> +
> +static void setup(void)
> +{
> +	int ret = tst_system("tune2fs");
> +
> +	if (WEXITSTATUS(ret) == 127)
> +		tst_brk(TCONF, "tune2fs does not exist");

We have .needs_cmds

> +
> +	strcpy(dev0, tst_device->dev);
> +	dev = tst_acquire_loop_device(LOOP_DEV_SIZE, "dev1_file");
> +	if (!dev)
> +		tst_brk(TBROK, "acquire loop dev1 failed");
> +
> +	strcpy(dev1, dev);
> +	dev = NULL;
> +
> +	dev = tst_acquire_loop_device(LOOP_DEV_SIZE, "dev2_file");
> +	if (!dev)
> +		tst_brk(TBROK, "acquire loop dev2 failed");
> +	strcpy(dev2, dev);
> +
> +	const char *const *mkfs_opts_set_UUID;
> +	const char *const *mkfs_opts_set_journal_dev1;
> +	const char *const *mkfs_opts_set_journal_dev2;
> +
> +	mkfs_opts_set_UUID = (const char *const []) {"-F",
> +		"-U",
> +		UUID,
> +		"-O journal_dev",
> +		NULL};
very nit: why the args cannot be on a single line?

> +
> +	char device_option_dev1[PATH_MAX];
> +	char device_option_dev2[PATH_MAX];
> +
> +	sprintf(device_option_dev1, "device=%s", dev1);
> +	sprintf(device_option_dev2, "device=%s", dev2);
> +
> +	mkfs_opts_set_journal_dev1 = (const char *const []) {"-F",
> +		"-J",
> +		device_option_dev1,
> +		NULL};
> +
> +	mkfs_opts_set_journal_dev2 = (const char *const []) {"-F",
> +		"-J",
> +		device_option_dev2,
> +		NULL};
> +
> +	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev2, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> +
> +}
> +
> +static void run(void)
> +{
> +	TEST(fd = fsopen(tst_device->fs_type, 0));
> +	if (fd == -1)
> +		tst_brk(TBROK | TTERRNO, "fsopen() failed");
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", dev0, 0));
> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
> +
> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
> +		else
> +			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
> +	}
> +
> +	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +	if (TST_RET == -1)
> +		tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
> +
> +	char loop_name[NAME_MAX];
> +	char path[PATH_MAX];
> +	char device_str[NAME_MAX];
> +	unsigned int major, minor, device_num;
> +	unsigned int found = 0;
> +
> +	int ret = sscanf(dev2, "/dev/%s", loop_name);
> +
> +	if (ret != 1)
> +		tst_brk(TFAIL | TTERRNO, "can not parse loop_name");
> +
> +	sprintf(path, "/sys/block/%s/dev", loop_name);
> +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
> +	device_num = (major << 8) | minor;
> +	sprintf(device_str, "0x%04X", device_num);
> +
> +	char line[PATH_MAX];
> +	FILE *tune2fs;
> +
> +	sprintf(path, "tune2fs -l %s 2>&1", dev0);
> +	tune2fs = popen(path, "r");
> +
> +	while (fgets(line, PATH_MAX, tune2fs)) {
> +		if (*line && strstr(line, "Journal device:") && strstr(line, device_str)) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (found == 1)
> +		tst_res(TPASS, "Journal device set pass");
Maybe "Device found in journal" ?
> +	else
> +		tst_res(TFAIL, "Journal device set failed");
Maybe "Device not found in journal" ?

> +
> +	pclose(tune2fs);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat",
> +		"ext2", "tmpfs", "xfs", "btrfs", NULL},
So you skip nearly everything, right?
Why not use .mount_device = 1 ? That would mount the default filesystem.

Kind regards,
Petr

> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
