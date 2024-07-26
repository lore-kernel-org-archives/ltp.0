Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E5FC3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 13:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C6853D1C99
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 15:07:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C8B33CBC79
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:06:44 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B1AB3100097F
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:06:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2BF31F8A3;
 Fri, 26 Jul 2024 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721999202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lPvkKjthzgNvANoNH7SNSDRVtxjt+AzZQXt3BB40dMQ=;
 b=LqSdysfpjTOJZYoZok/zgmRbjEUG42AI5BYOmDZSm+wTL7iVRwXVA8UndAvgBodh1RbUop
 BGoHRxK8C11a3Bp48KVZjScZYtWFhwS1ifQ7Gm59xWlPJxZ8nGeyknp2leIL3zNnzV+xyO
 Tok1XatxHj3F33rLChsBU3h82XUXBCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721999202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lPvkKjthzgNvANoNH7SNSDRVtxjt+AzZQXt3BB40dMQ=;
 b=BmofwC/i8AurO9SEE1l2FqDoTQmcbTJLXki6qbDBF8feqwXFnj1VVSQ1wDBKxnGI1QNtHE
 cAgZUlE6zJ8j6BDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2iH+UFg7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dXLF987N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721999201;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lPvkKjthzgNvANoNH7SNSDRVtxjt+AzZQXt3BB40dMQ=;
 b=2iH+UFg7erWLHqgAi1rASZ+OWx5h7vCGrZq9ynLqtxl6klAUUKzrtz89CPB6BKWStuuhZo
 9bmuRdR4qXVxP6PSxmz+ed+t36/n1a6vse7w/sTh0xhVQY5agXyG+PDDXejJrNDtgh0kF6
 Y+P1dptgMW6ck80H2wDbZFf5Qok0y5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721999201;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lPvkKjthzgNvANoNH7SNSDRVtxjt+AzZQXt3BB40dMQ=;
 b=dXLF987NQaxL57fkoJ/KD4redY4tIsROjgRdOBYn2eEilPK8kYesYiHqFE+o63vpv1DUNp
 vMx0uXEL50mtfkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F452138A7;
 Fri, 26 Jul 2024 13:06:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z65pJWGfo2aCCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 13:06:41 +0000
Date: Fri, 26 Jul 2024 15:06:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240726130638.GA1066866@pevik>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
 <20240725-landlock-v4-3-66f5a1c0c693@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240725-landlock-v4-3-66f5a1c0c693@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E2BF31F8A3
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] Add landlock04 test
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
Cc: mic@digikod.net, gnoack@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

unfortunately one minor things: cleanup needed to fix running with -i
(obviously on all filesystems):

LTP_SINGLE_FS_TYPE=btrfs ./landlock04 -i2 2>&1 |grep TFAIL
landlock_tester.h:206: TFAIL: rmdir(DIR_RMDIR) failed: ENOENT (2)
landlock_tester.h:216: TFAIL: unlink(FILE_UNLINK) failed: ENOENT (2)
landlock_tester.h:217: TFAIL: remove(FILE_REMOVE) failed: ENOENT (2)
landlock_tester.h:233: TFAIL: mknod(path, type | 0400, dev) failed: EEXIST (17)
landlock_tester.h:233: TFAIL: mknod(path, type | 0400, dev) failed: EEXIST (17)
landlock_tester.h:233: TFAIL: mknod(path, type | 0400, dev) failed: EEXIST (17)
landlock_tester.h:233: TFAIL: mknod(path, type | 0400, dev) failed: EEXIST (17)
landlock_tester.h:233: TFAIL: mknod(path, type | 0400, dev) failed: EEXIST (17)
landlock_tester.h:243: TFAIL: symlink(FILE_SYM0, FILE_SYM1) failed: EEXIST (17)

_test_symbolic() and other test functions in landlock_tester.h need to unlink()
after creating files.

TL;DR
The test itself LGTM. Interesting, quite extensive testing, thanks for that!

With:
* fixing on -i
* replaced TST_TO_STR_() instead of ACCESS_NAME()
* lower .max_runtime (or none .max_runtime)
* removing .format_device = 1 and .needs_tmpdir = 1
* add #define LANDLOCK_TESTER_H + append '__' to the definition

you can merge with my:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Some notes below.

...
> +++ b/testcases/kernel/syscalls/landlock/landlock04.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that all landlock filesystem rules are working properly.
> + * The way we do it is to verify that all disabled syscalls are not working but
> + * the one we enabled via specifc landlock rules.
very nit (ignore): I would avoid "This" (bogus word) and use passive form "we do
it". If you look on generated docs, it'd be nice to use a bit consistent style.
But it's minor (the least important thing).

> + */
> +
> +#include "landlock_common.h"
> +#include "landlock_tester.h"
> +#include "tst_safe_stdio.h"
> +
> +#define ACCESS_NAME(x) #x
We have TST_TO_STR_() for this, could you please use it?

> +
> +static struct landlock_ruleset_attr *ruleset_attr;
> +static struct landlock_path_beneath_attr *path_beneath_attr;
> +
> +static struct tvariant {
> +	int access;
> +	char *desc;
> +} tvariants[] = {
> +	{
> +		LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_EXECUTE,
> +		ACCESS_NAME(LANDLOCK_ACCESS_FS_EXECUTE)
s/ACCESS_NAME/TST_TO_STR_/
> +	},
...
> +};
...
> +static void enable_exec_libs(const int ruleset_fd)
> +{
> +	FILE *fp;
> +	char line[1024];
> +	char path[PATH_MAX];
> +	char dependency[8][PATH_MAX];
> +	int count = 0;
> +	int duplicate = 0;
> +
> +	fp = SAFE_FOPEN("/proc/self/maps", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, ".so") == NULL)
> +			continue;
> +
> +		SAFE_SSCANF(line, "%*x-%*x %*s %*x %*s %*d %s", path);
> +
> +		for (int i = 0; i < count; i++) {
> +			if (strcmp(path, dependency[i]) == 0) {
> +				duplicate = 1;
> +				break;
> +			}
> +		}
> +
> +		if (duplicate) {
> +			duplicate = 0;
> +			continue;
> +		}
> +
> +		strncpy(dependency[count], path, PATH_MAX);
> +		count++;
> +
> +		tst_res(TINFO, "Enable read/exec permissions for %s", path);
> +
> +		path_beneath_attr->allowed_access =
> +			LANDLOCK_ACCESS_FS_READ_FILE |
> +			LANDLOCK_ACCESS_FS_EXECUTE;
> +		path_beneath_attr->parent_fd = SAFE_OPEN(path, O_PATH | O_CLOEXEC);
> +
> +		SAFE_LANDLOCK_ADD_RULE(
> +			ruleset_fd,
> +			LANDLOCK_RULE_PATH_BENEATH,
> +			path_beneath_attr,
> +			0);
very nit (ignore): for me would be more readable:
		SAFE_LANDLOCK_ADD_RULE(
			ruleset_fd, LANDLOCK_RULE_PATH_BENEATH, path_beneath_attr, 0);

The same applies to landlock_tester.h below:
static void _test_make(
	const char *path,
	const int type,
	const int dev,
	const int result)

> +
> +		SAFE_CLOSE(path_beneath_attr->parent_fd);
> +	}
> +
> +	SAFE_FCLOSE(fp);
> +}
> +
> +static void setup(void)
> +{
> +	struct tvariant variant = tvariants[tst_variant];
> +	int ruleset_fd;
> +
> +	verify_landlock_is_enabled();
> +	tester_create_fs_tree();
> +
> +	tst_res(TINFO, "Testing %s", variant.desc);
> +
> +	ruleset_attr->handled_access_fs = tester_get_all_fs_rules();
> +
> +	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
> +		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
> +
> +	/* since our binary is dynamically linked, we need to enable dependences
> +	 * to be read and executed
> +	 */
> +	enable_exec_libs(ruleset_fd);
> +
> +	path_beneath_attr->allowed_access = variant.access;
> +	path_beneath_attr->parent_fd = SAFE_OPEN(
> +		SANDBOX_FOLDER, O_PATH | O_CLOEXEC);
> +
> +	SAFE_LANDLOCK_ADD_RULE(
> +		ruleset_fd,
> +		LANDLOCK_RULE_PATH_BENEATH,
> +		path_beneath_attr,
> +		0);
> +
> +	SAFE_CLOSE(path_beneath_attr->parent_fd);
> +
> +	enforce_ruleset(ruleset_fd);
> +	SAFE_CLOSE(ruleset_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.min_kver = "5.13",
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,

If you generate docs, you will see:
testcases/kernel/syscalls/landlock/landlock04.c: useless tag: format_device
testcases/kernel/syscalls/landlock/landlock04.c: useless tag: needs_tmpdir

Please remove them (implied by .all_filesystems and others).

> +	.needs_root = 1,
> +	.test_variants = ARRAY_SIZE(tvariants),
> +	.resource_files = (const char *[]) {
> +		TESTAPP,
> +		NULL,
> +	},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_SECURITY_LANDLOCK=y",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
> +		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
> +		{},
> +	},
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
> +		TST_CAP(TST_CAP_REQ, CAP_MKNOD),
> +		{}
> +	},
> +	.format_device = 1,
> +	.mount_device = 1,
> +	.mntpoint = SANDBOX_FOLDER,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *[]) {
> +		"vfat",
> +		"exfat",

Interesting, ntfs over FUSE works.

> +		NULL
> +	},
> +	.max_runtime = 3600,

Is it really needed for test to run 1 hour? On random VM with 6.5 kernel it runs
with the default (which is 30s).


> +};
> diff --git a/testcases/kernel/syscalls/landlock/landlock_exec.c b/testcases/kernel/syscalls/landlock/landlock_exec.c
> new file mode 100644
> index 000000000..aae5c76b2
> --- /dev/null
> +++ b/testcases/kernel/syscalls/landlock/landlock_exec.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +int main(void)
> +{
> +	return 0;
> +}
> diff --git a/testcases/kernel/syscalls/landlock/landlock_tester.h b/testcases/kernel/syscalls/landlock/landlock_tester.h
> new file mode 100644
> index 000000000..b4a4c1f7d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/landlock/landlock_tester.h
> @@ -0,0 +1,343 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef LANDLOCK_TESTER_H
You need to have here definition:
#define LANDLOCK_TESTER_H

otherwise the guarder does not work.

While at it, could you please rename it to LANDLOCK_TESTER_H__
(we usually append '__' to avoid clashes with random headers?
See my other fix: 2d24a286f1e35fe6ad7e1e307b86375658e23bee.

> +
> +#include "tst_test.h"
> +#include "lapi/landlock.h"
> +#include <sys/sysmacros.h>
> +
> +#define PERM_MODE 0700
> +
> +#define SANDBOX_FOLDER	"sandbox"
> +#define TESTAPP			"landlock_exec"
> +
> +#define FILE_EXEC		SANDBOX_FOLDER"/"TESTAPP
> +#define FILE_READ		SANDBOX_FOLDER"/file_read"
> +#define FILE_WRITE		SANDBOX_FOLDER"/file_write"
> +#define FILE_REMOVE		SANDBOX_FOLDER"/file_remove"
> +#define FILE_UNLINK		SANDBOX_FOLDER"/file_unlink"
> +#define FILE_UNLINKAT	SANDBOX_FOLDER"/file_unlinkat"
> +#define FILE_TRUNCATE	SANDBOX_FOLDER"/file_truncate"
> +#define FILE_REGULAR	SANDBOX_FOLDER"/regular0"
> +#define FILE_SOCKET		SANDBOX_FOLDER"/socket0"
> +#define FILE_FIFO		SANDBOX_FOLDER"/fifo0"
> +#define FILE_SYM0		SANDBOX_FOLDER"/symbolic0"
> +#define FILE_SYM1		SANDBOX_FOLDER"/symbolic1"
> +#define DIR_READDIR		SANDBOX_FOLDER"/dir_readdir"
> +#define DIR_RMDIR		SANDBOX_FOLDER"/dir_rmdir"
> +#define DEV_CHAR0		SANDBOX_FOLDER"/chardev0"
> +#define DEV_BLK0		SANDBOX_FOLDER"/blkdev0"
> +
> +#define ALL_RULES (\
> +	LANDLOCK_ACCESS_FS_EXECUTE | \
> +	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> +	LANDLOCK_ACCESS_FS_READ_FILE | \
> +	LANDLOCK_ACCESS_FS_READ_DIR | \
> +	LANDLOCK_ACCESS_FS_REMOVE_DIR | \
> +	LANDLOCK_ACCESS_FS_REMOVE_FILE | \
> +	LANDLOCK_ACCESS_FS_MAKE_CHAR | \
> +	LANDLOCK_ACCESS_FS_MAKE_DIR | \
> +	LANDLOCK_ACCESS_FS_MAKE_REG | \
> +	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
> +	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
> +	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
> +	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> +	LANDLOCK_ACCESS_FS_REFER | \
> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> +	LANDLOCK_ACCESS_FS_IOCTL_DEV)

I see we haven't covered LANDLOCK_ACCESS_NET_BIND_TCP and
LANDLOCK_ACCESS_NET_CONNECT_TCP (which we added into the LAPI header). This is
not complaining, but it'd be good to remember that. I wanted to note that in the
ticket, but we have no landlock ticket, thus I created one:

https://github.com/linux-test-project/ltp/issues/1181

> +
> +static char *readdir_files[] = {
> +	DIR_READDIR"/file0",
> +	DIR_READDIR"/file1",
> +	DIR_READDIR"/file2",
> +};
> +
> +static int dev_chr;
> +static int dev_blk;
> +
> +static int tester_get_all_fs_rules(void)
> +{
> +	int abi;
> +	int all_rules = ALL_RULES;
> +
> +	abi = SAFE_LANDLOCK_CREATE_RULESET(
> +		NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
> +
> +	if (abi < 2)
> +		all_rules &= ~LANDLOCK_ACCESS_FS_REFER;
> +
> +	if (abi < 3)
> +		all_rules &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> +
> +	if (abi < 5)
> +		all_rules &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
> +
> +	return all_rules;
> +}
> +
> +static void tester_create_fs_tree(void)
> +{
> +	if (access(SANDBOX_FOLDER, F_OK) == -1)
> +		SAFE_MKDIR(SANDBOX_FOLDER, PERM_MODE);
> +
> +	/* folders */
> +	SAFE_MKDIR(DIR_RMDIR, PERM_MODE);
> +	SAFE_MKDIR(DIR_READDIR, PERM_MODE);
> +	for (size_t i = 0; i < ARRAY_SIZE(readdir_files); i++)
> +		SAFE_TOUCH(readdir_files[i], PERM_MODE, NULL);
> +
> +	/* files */
> +	tst_fill_file(FILE_READ, 'a', getpagesize(), 1);
> +	SAFE_TOUCH(FILE_WRITE, PERM_MODE, NULL);
> +	SAFE_TOUCH(FILE_REMOVE, PERM_MODE, NULL);
> +	SAFE_TOUCH(FILE_UNLINK, PERM_MODE, NULL);
> +	SAFE_TOUCH(FILE_UNLINKAT, PERM_MODE, NULL);
> +	SAFE_TOUCH(FILE_TRUNCATE, PERM_MODE, NULL);
> +	SAFE_TOUCH(FILE_SYM0, PERM_MODE, NULL);
> +	SAFE_CP(TESTAPP, FILE_EXEC);
> +
> +	/* devices */
> +	dev_chr = makedev(1, 3);
> +	dev_blk = makedev(7, 0);
Shouldn't we check makedev result?

i.g.
if (dev_chr != 0 && errno != EEXIST)
	tst_brk("can't create dev_chr");

We probably can ignore it, as we don't test that even in new API tests
(fgetxattr02.c, statx01.c). I suppose it's unlikely to fail (only permissions),
but maybe in the future we should add SAFE_MAKEDEV().

> +}
> +
> +static void _test_exec(const int result)
> +{
> +	int status;
> +	pid_t pid;
> +	char *const args[] = {(char *)FILE_EXEC, NULL};
> +
> +	tst_res(TINFO, "Test binary execution");
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		int rval;
> +
> +		if (result == TPASS) {
> +			rval = execve(FILE_EXEC, args, NULL);
> +			if (rval == -1)
> +				tst_res(TFAIL | TERRNO, "Failed to execute test binary");
> +		} else {
> +			TST_EXP_FAIL(execve(FILE_EXEC, args, NULL), EACCES);
> +		}
> +
> +		_exit(1);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
Why don't we TFAIL on result == TPASS? What am I missing?

> +		return;
> +
> +	tst_res(result, "Test binary has been executed");
> +}
> +
> +static void _test_write(const int result)
> +{
> +	tst_res(TINFO, "Test writing file");
> +
> +	if (result == TPASS)
> +		TST_EXP_FD(open(FILE_WRITE, O_WRONLY, PERM_MODE));
> +	else
> +		TST_EXP_FAIL(open(FILE_WRITE, O_WRONLY, PERM_MODE), EACCES);
> +
> +	if (TST_RET != -1)
> +		SAFE_CLOSE(TST_RET);
> +}
> +
> +static void _test_read(const int result)
> +{
> +	tst_res(TINFO, "Test reading file");
> +
> +	if (result == TPASS)
> +		TST_EXP_FD(open(FILE_READ, O_RDONLY, PERM_MODE));
> +	else
> +		TST_EXP_FAIL(open(FILE_READ, O_RDONLY, PERM_MODE), EACCES);
> +
> +	if (TST_RET != -1)
> +		SAFE_CLOSE(TST_RET);
> +}
> +
> +static void _test_readdir(const int result)
> +{
> +	tst_res(TINFO, "Test reading directory");
> +
> +	DIR *dir;
> +	struct dirent *de;
> +	int files_counted = 0;
> +
> +	dir = opendir(DIR_READDIR);
> +	if (!dir) {
> +		tst_res(result == TPASS ? TFAIL : TPASS,
> +			"Can't read '%s' directory", DIR_READDIR);
> +
> +		return;
> +	}
> +
> +	tst_res(result, "Can read '%s' directory", DIR_READDIR);
> +	if (result == TFAIL)
> +		return;
NOTE the check above is needed only if 'dir = opendir(DIR_READDIR);' passes on
result == TFAIL. I'm not sure if this can happen, but probably better to assume it can.

> +
> +	while ((de = readdir(dir)) != NULL) {
> +		if (de->d_type != DT_REG)
> +			continue;
> +
> +		for (size_t i = 0; i < ARRAY_SIZE(readdir_files); i++) {
> +			if (readdir_files[i] == NULL)
> +				continue;
> +
> +			if (strstr(readdir_files[i], de->d_name) != NULL)
> +				files_counted++;
> +		}
> +	}
> +
> +	SAFE_CLOSEDIR(dir);
> +
> +	TST_EXP_EQ_LI(files_counted, ARRAY_SIZE(readdir_files));
> +}
> +
> +static void _test_rmdir(const int result)
> +{
> +	tst_res(TINFO, "Test removing directory");
> +
> +	if (result == TPASS)
> +		TST_EXP_PASS(rmdir(DIR_RMDIR));
> +	else
> +		TST_EXP_FAIL(rmdir(DIR_RMDIR), EACCES);
> +}
> +
> +static void _test_rmfile(const int result)
> +{
> +	tst_res(TINFO, "Test removing file");
> +
> +	if (result == TPASS) {
> +		TST_EXP_PASS(unlink(FILE_UNLINK));
> +		TST_EXP_PASS(remove(FILE_REMOVE));
> +	} else {
> +		TST_EXP_FAIL(unlink(FILE_UNLINK), EACCES);
> +		TST_EXP_FAIL(remove(FILE_REMOVE), EACCES);
> +	}
> +}
> +
> +static void _test_make(
> +	const char *path,
> +	const int type,
> +	const int dev,
> +	const int result)
...
> +{
> +	tst_res(TINFO, "Test normal or special files creation");
> +
> +	if (result == TPASS)
> +		TST_EXP_PASS(mknod(path, type | 0400, dev));
> +	else
> +		TST_EXP_FAIL(mknod(path, type | 0400, dev), EACCES);

Here I guess we need to remove file to enable running with -i.
> +}
> +
> +static void _test_symbolic(const int result)
> +{
> +	tst_res(TINFO, "Test symbolic links");
> +
> +	if (result == TPASS)
> +		TST_EXP_PASS(symlink(FILE_SYM0, FILE_SYM1));
> +	else
> +		TST_EXP_FAIL(symlink(FILE_SYM0, FILE_SYM1), EACCES);

Also here.
> +}
> +
> +static void _test_truncate(const int result)
> +{
> +	int fd;
> +
> +	tst_res(TINFO, "Test truncating file");
> +
> +	if (result == TPASS) {
> +		TST_EXP_PASS(truncate(FILE_TRUNCATE, 10));
> +
> +		fd = TST_EXP_FD(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE));
Shouldn't we use SAFE_OPEN() here? To quit early on error.

> +		if (fd != -1) {
> +			TST_EXP_PASS(ftruncate(fd, 10));
> +			SAFE_CLOSE(fd);
> +		}
> +
> +		fd = TST_EXP_FD(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE));
> +		if (fd != -1)
> +			SAFE_CLOSE(fd);
> +	} else {
> +		TST_EXP_FAIL(truncate(FILE_TRUNCATE, 10), EACCES);
> +
> +		fd = open(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
> +		if (fd != -1) {
> +			TST_EXP_FAIL(ftruncate(fd, 10), EACCES);
> +			SAFE_CLOSE(fd);
> +		}
> +
> +		TST_EXP_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE),
> +			EACCES);
> +
> +		if (TST_RET != -1)
> +			SAFE_CLOSE(TST_RET);
> +	}
> +}
> +
...

The rest LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
