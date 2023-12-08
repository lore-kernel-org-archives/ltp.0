Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0604C4167B
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 15:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F05823CF08B
	for <ltp@archiver.kernel.org>; Fri,  8 Dec 2023 16:33:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 222053C8AD1
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 16:33:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA1F16011FA
 for <ltp@lists.linux.it>; Fri,  8 Dec 2023 16:33:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B67E21C3C;
 Fri,  8 Dec 2023 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702049625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5lV5WQk4gMfRQIsLX+3NMKG6EK7XJloEfCq/o2EYxk=;
 b=1IWB7rTYiE/fwO05JJwnqXy1+fqPnXAQ2H+6wZOXrSmuwXozkH2zOV7eJtrrA2A1VGajcQ
 2rKaFKS94mCGU6i14fnvhKTEAEvjyaqA00+zU6wJ916pgn3gIxLbUqnBJ/gVDNKX3HqB/r
 DHbfOuqNnBUbMvyOrr/XgJOpPuPfWLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702049625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5lV5WQk4gMfRQIsLX+3NMKG6EK7XJloEfCq/o2EYxk=;
 b=GO9nf6jsmU+YpHT0fNteLX1Pi0k25pySbBsVPcAPxAWh9qDDEhdHZ/4EFficrX8NWtRKsb
 m98qZx73mvkNNsBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702049625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5lV5WQk4gMfRQIsLX+3NMKG6EK7XJloEfCq/o2EYxk=;
 b=1IWB7rTYiE/fwO05JJwnqXy1+fqPnXAQ2H+6wZOXrSmuwXozkH2zOV7eJtrrA2A1VGajcQ
 2rKaFKS94mCGU6i14fnvhKTEAEvjyaqA00+zU6wJ916pgn3gIxLbUqnBJ/gVDNKX3HqB/r
 DHbfOuqNnBUbMvyOrr/XgJOpPuPfWLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702049625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5lV5WQk4gMfRQIsLX+3NMKG6EK7XJloEfCq/o2EYxk=;
 b=GO9nf6jsmU+YpHT0fNteLX1Pi0k25pySbBsVPcAPxAWh9qDDEhdHZ/4EFficrX8NWtRKsb
 m98qZx73mvkNNsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F51F13335;
 Fri,  8 Dec 2023 15:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hrcaD1k3c2XeewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 08 Dec 2023 15:33:45 +0000
Date: Fri, 8 Dec 2023 16:34:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZXM3iwdvy4-XoIdB@yuki>
References: <20231009112047.2359-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231009112047.2359-1-wegao@suse.com>
X-Spamd-Result: default: False [7.14 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 BAYES_SPAM(1.31)[84.40%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 R_SPF_SOFTFAIL(4.60)[~all]; NEURAL_HAM_SHORT(-0.17)[-0.834];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:dkim,suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spamd-Bar: +++++++
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 7B67E21C3C
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1IWB7rTY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GO9nf6js;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of chrubis@suse.cz)
 smtp.mailfrom=chrubis@suse.cz; dmarc=none
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] open15: allow restricted O_CREAT of FIFOs and
 regular files
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
> +// SPDX-License-Identifier: GPL-2.0-only

The default license should be GPL-2.0-or-later for new tests.

> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify disallows open of FIFOs or regular files not owned by the user in world
> + * writable sticky directories
> + *
> + * Linux commit 30aba6656f61ed44cba445a3c0d38b296fa9e8f5
> + */
> +
> +#include <pwd.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "tst_safe_file_at.h"
> +
> +#define  FILENAME  "setuid04_testfile"
> +#define  DIR "ltp_tmp_check1"
> +#define  TEST_FILE "test_file_1"
> +#define  TEST_FIFO "test_fifo_1"
> +#define  LTP_USER1 "ltp_user1"
> +#define  LTP_USER2 "ltp_user2"
> +#define  CONCAT(dir, filename) dir "/" filename
> +#define  PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
> +#define  PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
> +
> +static int LTP_USER1_UID;
> +static int LTP_USER2_UID;
> +static int dir_fd;
> +
> +static void run(void)
> +{
> +	int pid;
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 0);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 0);
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USER1_UID);
> +
> +		int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
> +
> +		SAFE_CLOSE(fd);
> +		fd = SAFE_MKFIFO(CONCAT(DIR, TEST_FIFO), 0777);
> +		SAFE_CLOSE(fd);
> +
> +		TST_CHECKPOINT_WAKE(0);
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);

This shouldn't be checkpoint, but rather you should wait for the child
process with tst_reap_children() and the same in all the other cases.

> +	pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USER2_UID);
> +
> +		int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);

This can't be SAFE_OPENAT() since it will TBROK instead of TFAIL in a
case of a failure. You have to do the TST_EXP_FD(openat(...)) instead.

And the same for all the cases that shouldn't fail.

> +		tst_res(TPASS, "check protect_regural == 0 pass");
> +		SAFE_CLOSE(fd);
> +
> +		fd = SAFE_OPEN(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT);
> +		tst_res(TPASS, "check protect_fifos == 0 pass");
> +		SAFE_CLOSE(fd);
> +
> +		TST_CHECKPOINT_WAKE(1);
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(1);
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 1);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 1);
> +
> +	pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USER2_UID);
> +
> +		TEST(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777));
> +		if (TST_RET == -1 && TST_ERR == EACCES)
> +			tst_res(TPASS, "check protect_regural == 1 pass");
> +		else
> +			tst_res(TFAIL | TERRNO, "check protect_regural == 1 failed");


And here you have to do TST_EXP_FAIL(openat(...)) and in all the failing
cases as well.

> +		TEST(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777));
> +		if (TST_RET == -1 && TST_ERR == EACCES)
> +			tst_res(TPASS, "check protect_fifos == 1 pass");
> +		else
> +			tst_res(TFAIL | TERRNO, "check protect_fifos == 1 failed");
> +
> +		TST_CHECKPOINT_WAKE(2);
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(2);
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 2);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 2);
> +	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
> +
> +	pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		SAFE_SETUID(LTP_USER2_UID);
> +
> +		TEST(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777));
> +		if (TST_RET == -1 && TST_ERR == EACCES)
> +			tst_res(TPASS, "check protect_regural == 2 pass");
> +		else
> +			tst_res(TFAIL | TERRNO, "check protect_regural == 2 failed");
> +
> +		TEST(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777));
> +		if (TST_RET == -1 && TST_ERR == EACCES)
> +			tst_res(TPASS, "check protect_fifos == 2 pass");
> +		else
> +			tst_res(TFAIL | TERRNO, "check protect_fifos == 2 failed");
> +
> +		TST_CHECKPOINT_WAKE(3);
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(3);
> +}
> +
> +static int add_user(char *username)
> +{
> +	const char *const cmd_useradd[] = {"useradd", username, NULL};
> +	struct passwd *ltpuser;
> +	int rc, uid = -1;
> +
> +	switch ((rc = tst_cmd(cmd_useradd, NULL, NULL, TST_CMD_PASS_RETVAL))) {
> +	case 0:
> +	case 9:
> +		ltpuser = SAFE_GETPWNAM(username);
> +		uid = ltpuser->pw_uid;
> +		break;
> +	default:
> +		tst_brk(TBROK, "Useradd failed (%d)", rc);
> +	}
> +
> +	return uid;
> +}
> +
> +static void del_user(char *username)
> +{
> +	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
> +
> +	tst_cmd(cmd_userdel, NULL, NULL, TST_CMD_PASS_RETVAL);
> +
> +}
> +
> +static void setup(void)
> +{
> +	umask(0);
> +	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
> +
> +	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
> +
> +	LTP_USER1_UID = add_user(LTP_USER1);
> +	LTP_USER2_UID = add_user(LTP_USER2);

We actually does not need to add users for these tests, we can just
choose two random UIDs and use them, since all the kernel does is to
compare the UIDs of the processes...

So we can just do:

#define LTP_USR_UID1 1000
#define LTP_USR_UID2 1001

> +}
> +
> +static void cleanup(void)
> +{
> +	del_user(LTP_USER1);
> +	del_user(LTP_USER2);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{PROTECTED_REGULAR, NULL, TST_SR_SKIP},
> +		{PROTECTED_FIFOS, NULL, TST_SR_SKIP},
                                         ^
					 TST_SR_TCONF

Since we want to skip the test if these files are missing.

> +		{}
> +	},
> +	.needs_checkpoints = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
