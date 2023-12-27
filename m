Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA49CC46CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 14:26:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 899533CEC2C
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 15:26:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 74A343C94EA
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 15:26:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8749B200973
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 15:26:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 551C321EAA;
 Wed, 27 Dec 2023 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703687166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4PTrHaPxOlDYApN0fu/U6KMaQvMsYhM1VuUQP5N37w=;
 b=FGHw7BjjfMouwV0o4ki9junmkQzv8cIK6DRW3223olxoib6+Exag1J0jtvZYOEJa7CDYkR
 goSwxzncgxT6UfDj1HKenHbws/B7ukNDyCnuwdnAiE41mQ1NhVzYTaEPjJTLnOL/yeQsmF
 95Jf2wsMbHXEVSSQx9alkEaX45CqeHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703687166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4PTrHaPxOlDYApN0fu/U6KMaQvMsYhM1VuUQP5N37w=;
 b=0V0cykELEvZF2ZLaOHNMX72e+ZhrztR5Z2gzH1rclc9Tlkh0/G/SwZw0/7AzGXUGxF5KeM
 ifvovC2qALvmEJCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703687166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4PTrHaPxOlDYApN0fu/U6KMaQvMsYhM1VuUQP5N37w=;
 b=FGHw7BjjfMouwV0o4ki9junmkQzv8cIK6DRW3223olxoib6+Exag1J0jtvZYOEJa7CDYkR
 goSwxzncgxT6UfDj1HKenHbws/B7ukNDyCnuwdnAiE41mQ1NhVzYTaEPjJTLnOL/yeQsmF
 95Jf2wsMbHXEVSSQx9alkEaX45CqeHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703687166;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4PTrHaPxOlDYApN0fu/U6KMaQvMsYhM1VuUQP5N37w=;
 b=0V0cykELEvZF2ZLaOHNMX72e+ZhrztR5Z2gzH1rclc9Tlkh0/G/SwZw0/7AzGXUGxF5KeM
 ifvovC2qALvmEJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01A0313635;
 Wed, 27 Dec 2023 14:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ohk8OP0zjGXdLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 Dec 2023 14:26:05 +0000
Date: Wed, 27 Dec 2023 15:26:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231227142600.GA760315@pevik>
References: <20230913101542.18550-1-wegao@suse.com>
 <20231227000430.30224-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231227000430.30224-1-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FGHw7Bjj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0V0cykEL
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 551C321EAA
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] move_mount03: check allow to mount beneath top
 mount
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

I suppose there was no v1, right?

-i2 fails, please fix it.

# move_mount03 -i2
move_mount03.c:79: TINFO: Mounting none to /tmp/LTP_movcovMfK/LTP_DIR_A fstyp=tmpfs flags=0
move_mount03.c:80: TINFO: Mounting none to /tmp/LTP_movcovMfK/LTP_DIR_B fstyp=tmpfs flags=0
move_mount03.c:92: TPASS: move_mount(fda, "", fdb, "", MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH) passed
move_mount03.c:98: TPASS: access(DIRB "/B", F_OK) passed
move_mount03.c:99: TINFO: Umounting /tmp/LTP_movcovMfK/LTP_DIR_B
move_mount03.c:100: TPASS: access(DIRB "/A", F_OK) passed
move_mount03.c:102: TINFO: Umounting /tmp/LTP_movcovMfK/LTP_DIR_B
move_mount03.c:103: TINFO: Umounting /tmp/LTP_movcovMfK/LTP_DIR_A
move_mount03.c:77: TBROK: mkdir(LTP_DIR_A, 0777) failed: EEXIST (17)

NOTE: you can speed up the review process, if you check list of common errors
before sending patch to ML 
https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist#how-to-find-clear-errors

make check-move_mount03
CHECK testcases/kernel/syscalls/move_mount/move_mount03.c
move_mount03.c:92:9: error: undefined identifier 'MOVE_MOUNT_BENEATH'

I see false positive from checkpatch.pl, it would be interesting to check if it
can be fixed.

> diff --git a/testcases/kernel/syscalls/move_mount/move_mount03.c b/testcases/kernel/syscalls/move_mount/move_mount03.c
> new file mode 100644
> index 000000000..dadb19178
> --- /dev/null
> +++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Christian Brauner <brauner@kernel.org>
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify allow to mount beneath top mount base following commit:
This will be very badly formatted in docs.
> + * commit 6ac392815628f317fcfdca1a39df00b9cc4ebc8b
> + * Author: Christian Brauner <brauner@kernel.org>
> + * Date:   Wed May 3 13:18:42 2023 +0200
> + *     fs: allow to mount beneath top mount
> + *
> + * Above commit has heavily commented but i found following commit
> + * contain simple summary of this feature for easy understanding:
> + *
> + * commit c0a572d9d32fe1e95672f24e860776dba0750a38
> + * Author: Linus Torvalds <torvalds@linux-foundation.org>
> + *       TL;DR:
> + *

Please generate metadata and have look at result. The output below looks ugly.

Either you find a way to preformat it as generated output (put extra space after
* in the comment - equivalent of <pre>... </pre> HTML output) or put it into /*
* */, so that it's not in docs (good for some info useful in C source but more
related to the test implementation so that it does not have to be in generated docs).

> + *         > mount -t ext4 /dev/sda /mnt
> + *           |
> + *           --/mnt    /dev/sda    ext4
> + *
> + *         > mount --beneath -t xfs /dev/sdb /mnt
> + *           |
> + *           --/mnt    /dev/sdb    xfs
> + *             --/mnt  /dev/sda    ext4
> + *
> + *         > umount /mnt
> + *           |
> + *           --/mnt    /dev/sdb    xfs
> + *
> + * So base above scenario design following scenario for LTP check:
> + *
> + *         > mount -t tmpfs /DIRA
> + *           |
> + *           --/DIRA(create A file within DIRA)
> + *
> + *         > mount -t tmpfs /DIRB
> + *           |
> + *           --/DIRA(create B file within DIRB)
> + *
> + *         > move_mount --beneath /DIRA /DIRB
> + *           |
> + *           --/mnt    /DIRA /DIRB
> + *             --/mnt  /DIRB
> + *
> + *         If you check content of /DIRB, you can see file B
> + *
> + *         > umount /DIRB
> + *           |
> + *           --/mnt    /DIRA /DIRB
> + *         Check content of /DIRB, you can see file A exist since
> + *         current /DIRB mount source is already become /DIRA
> + *
> + * More detail can be found in following link:
> + * Link: https://lwn.net/Articles/930591/
> + * Link: https://github.com/brauner/move-mount-beneath
Link is bogus (we use it only as tag in the git commit message, not in docs).

 * See also:
 * https://lwn.net/Articles/930591/
 * https://github.com/brauner/move-mount-beneath
 */

> + */
> +
> +#include <stdio.h>
> +
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "lapi/sched.h"
> +
> +#define DIRA "LTP_DIR_A"
> +#define DIRB "LTP_DIR_B"
> +
> +static void run(void)
> +{
> +	int fda, fdb;
> +
> +	SAFE_MKDIR(DIRA, 0777);
> +	SAFE_MKDIR(DIRB, 0777);
> +	SAFE_MOUNT("none", DIRA, "tmpfs", 0, 0);
> +	SAFE_MOUNT("none", DIRB, "tmpfs", 0, 0);
> +	SAFE_TOUCH(DIRA "/A", 0, NULL);
> +	SAFE_TOUCH(DIRB "/B", 0, NULL);
Maybe whole code in above could be in setup() function, it can be created only
once even we run test more times with -iN, right? Setup function is for test
speedup (imagine somebody run test with -i10000, why to create files all the
time?
> +
> +	TEST(fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> +
> +	if (fda == -1) {
> +		tst_res(TFAIL | TTERRNO, "open_tree() failed");
> +		return;
> +	}
Maybe this should also be in the setup function. also not using TEST() for it?


fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
if (fda > 0)
	tst_brk(TBROK | TERRNO, "open_tree() failed");

> +
> +	fdb = SAFE_OPEN(DIRB, O_PATH | O_NOFOLLOW, 0666);
> +	TST_EXP_PASS(move_mount(fda, "", fdb, "",
> +				MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH |
> +				MOVE_MOUNT_T_EMPTY_PATH));

I wonder what happen if any of the following SAFE_*() functions fail.
There will be unrelated errors and left mount directories. IMHO at least
SAFE_UMOUNT() should be in cleanup functions and guarded by flags (e.g. not
trying to umount() when nothing was mounted because tst_brk() earlier).

Kind regards,
Petr

> +	SAFE_CLOSE(fda);
> +	SAFE_CLOSE(fdb);
> +
> +	TST_EXP_PASS(access(DIRB "/B", F_OK));
> +	SAFE_UMOUNT(DIRB);
> +	TST_EXP_PASS(access(DIRB "/A", F_OK));
> +
> +	SAFE_UMOUNT(DIRB);
> +	SAFE_UMOUNT(DIRA);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.min_kver = "6.5.0",
> +	.needs_tmpdir = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
