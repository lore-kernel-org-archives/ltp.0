Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58576C54FB3
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 09:55:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DCA23C2B90
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 11:55:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71D933C29BC
 for <ltp@lists.linux.it>; Mon, 26 May 2025 11:55:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8702A1A0093E
 for <ltp@lists.linux.it>; Mon, 26 May 2025 11:55:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A3DF1F769;
 Mon, 26 May 2025 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748253302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/M6ThiGQz0v9L4BY8ZOxezIVEqKKIpQEAj2soFgfoY=;
 b=hxgyrbks455kZE9bn4WH/ZZsZUyqy1YaxZoTUQ6iDRTHoum69srVE0MpOuwWtMZPQjEMim
 +UMdaJfc7rJX6+n9k/sOLSPXVcsHf1O5pqDjj75M20tE37ry9BnU6jHJ1opl6mUynsR6RB
 yejaf7zuT4vnjfavZ3YjLAiSyacSUcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748253302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/M6ThiGQz0v9L4BY8ZOxezIVEqKKIpQEAj2soFgfoY=;
 b=ibKd3Fwiq+Mn4GtRrDma5sI+5twmhEx0BruRCHsPEENWWliqxFdMqncQvUmz6d3axmWEc+
 V13aNo4qq+e6XgCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748253302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/M6ThiGQz0v9L4BY8ZOxezIVEqKKIpQEAj2soFgfoY=;
 b=hxgyrbks455kZE9bn4WH/ZZsZUyqy1YaxZoTUQ6iDRTHoum69srVE0MpOuwWtMZPQjEMim
 +UMdaJfc7rJX6+n9k/sOLSPXVcsHf1O5pqDjj75M20tE37ry9BnU6jHJ1opl6mUynsR6RB
 yejaf7zuT4vnjfavZ3YjLAiSyacSUcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748253302;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N/M6ThiGQz0v9L4BY8ZOxezIVEqKKIpQEAj2soFgfoY=;
 b=ibKd3Fwiq+Mn4GtRrDma5sI+5twmhEx0BruRCHsPEENWWliqxFdMqncQvUmz6d3axmWEc+
 V13aNo4qq+e6XgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32E061397F;
 Mon, 26 May 2025 09:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ubQgC3Y6NGgNaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 26 May 2025 09:55:02 +0000
Date: Mon, 26 May 2025 11:54:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250526095456.GA118123@pevik>
References: <20250516151028.1254207-1-wegao@suse.com>
 <20250526143551.1321709-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250526143551.1321709-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig04.c: Check FSCONFIG_SET_PATH
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

> Fixes:#1169

> The fsconfig01.c does not test if FSCONFIG_SET_PATH have any effect,
> most of the calls there just set dummy "sync" parameter. This test
> case aims to verify if the FSCONFIG_SET_PATH operation can be used
> to dynamically change the external journal device of ext3 or ext4
> filesystem.

Again, I just pointed out common errors (need more time for a proper feature
review). But on the first look LGTM.

...
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> new file mode 100644
> index 000000000..0df16f0ed
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\ This test aims to validate the functionality of fsconfig(FSCONFIG_SET_PATH) in
> + * dynamically altering the external journal device of a ext3 or ext4 filesystem.
/*\
 * This test aims to validate the functionality of fsconfig(FSCONFIG_SET_PATH) in
 * dynamically altering the external journal device of a ext3 or ext4 filesystem.
 ...
> +
> +static void setup(void)
> +{
...
> +	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev2, NULL);
> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> +
Please remove this empty line.
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

Using SAFE_SSCANF() is enough (it checks number of found items), please use it:

	SAFE_SSCANF(dev2, "/dev/%s", loop_name);

> +
> +	sprintf(path, "/sys/block/%s/dev", loop_name);
snprintf() is safer.

> +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
> +	device_num = (major << 8) | minor;
> +	sprintf(device_str, "0x%04X", device_num);
And here as well.
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
> +		tst_res(TPASS, "Device found in journal");
> +	else
> +		tst_res(TFAIL, "Device not found in journal");
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
> +	.needs_cmds = (const char *[]) {
> +		"tune2fs",
> +		NULL
> +	},
> +	.skip_filesystems = (const char *const []){"ntfs", "vfat", "exfat",
> +		"ext2", "tmpfs", "xfs", "btrfs", NULL},
You need to skip also bcachefs:

mkfs.bcachefs: invalid option -- 'F'
fsconfig04.c:82: TBROK: mkfs.bcachefs failed with exit code 1

Having a way to specify just ext3 and ext4 would be better, IMHO we don't have
way to do it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
