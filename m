Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72307C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 07:43:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2AC93CE669
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:43:36 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0980C3CE65C
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:43:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4CC33201DC7
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 08:43:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D7C5A33EED;
 Wed, 20 Mar 2024 07:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710920587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DStU0z5wC51zLBAq+2vduDJRynhqqAa+iZJ1MTaP844=;
 b=bI3to7nQo1Z4PUmSrXHVnW/6s4CkLn/fuYEVEyaaldwJxb2g3Qgi08wdzOjCoW/1bs3hw/
 uyVppzQlPSr0snBl6gWGFE1LNTPOD6ND2vsMn+3VztEpRfhg26k+YHCjplOL46ciEB1bPt
 HZQ3qJWTZCMVh9dMR/j9KnjrXsRL//A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710920587;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DStU0z5wC51zLBAq+2vduDJRynhqqAa+iZJ1MTaP844=;
 b=QdWvDTI9bY9JqrXZhIHempBz1RP8goz6s9zGtcmzMgeED2nDZMMxZo62ccNapJ56+TULBK
 wE+kDkwlaq+ix5Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710920586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DStU0z5wC51zLBAq+2vduDJRynhqqAa+iZJ1MTaP844=;
 b=FFBtwHsmsU4DGOJBWzFs7pHV1XsNGA0KHVEStr/t/5PdbZgdmdlmTP02W2Xl7B4cRDPOkH
 SFxIBLpAZd7r02wNV5DWxr3oBNI6B+F4iZlEy0DCrUF4mmJNqYSk/dqUF0sAkXfXbBwaHI
 lWcyRE+kPWr/FnTh7YAD8fI3VSoWouM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710920586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DStU0z5wC51zLBAq+2vduDJRynhqqAa+iZJ1MTaP844=;
 b=IhaDaUoTObYIB8KKdQb2PBS3h97F/ziPUlNVvtWg3lf7UFTIx9MGIb1nqLXOYOZUyefS+5
 3H0rZRd+KUmYyOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 946A6136D6;
 Wed, 20 Mar 2024 07:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1SV6H4qT+mXdMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Mar 2024 07:43:06 +0000
Date: Wed, 20 Mar 2024 08:43:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240320074304.GC452876@pevik>
References: <20231227000430.30224-1-wegao@suse.com>
 <20231228025537.28807-1-wegao@suse.com>
 <2cc04819-1bd7-4f24-842d-cf686cda7fa7@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2cc04819-1bd7-4f24-842d-cf686cda7fa7@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FFBtwHsm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IhaDaUoT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: D7C5A33EED
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] move_mount03: check allow to mount beneath top
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

> Hi,
> some comments below.

> On 28. 12. 23 3:55, Wei Gao via ltp wrote:
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >   include/lapi/fsmount.h                        |   4 +
> >   runtest/syscalls                              |   1 +
> >   .../kernel/syscalls/move_mount/.gitignore     |   1 +
> >   .../kernel/syscalls/move_mount/move_mount03.c | 128 ++++++++++++++++++
> >   4 files changed, 134 insertions(+)
> >   create mode 100644 testcases/kernel/syscalls/move_mount/move_mount03.c

> > diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> > index 07eb42ffa..216e966c7 100644
> > --- a/include/lapi/fsmount.h
> > +++ b/include/lapi/fsmount.h
> > @@ -115,6 +115,10 @@ static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned i
> >   }
> >   #endif /* HAVE_MOUNT_SETATTR */
> > +#ifndef MOVE_MOUNT_BENEATH
> > +#define MOVE_MOUNT_BENEATH 		0x00000200
> > +#endif /* MOVE_MOUNT_BENEATH */
> > +
> >   /*
> >    * New headers added in kernel after 5.2 release, create them for old userspace.
> >   */
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index b1125dd75..04b758fd9 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -824,6 +824,7 @@ mount_setattr01 mount_setattr01
> >   move_mount01 move_mount01
> >   move_mount02 move_mount02
> > +move_mount03 move_mount03
> >   move_pages01 move_pages01
> >   move_pages02 move_pages02
> > diff --git a/testcases/kernel/syscalls/move_mount/.gitignore b/testcases/kernel/syscalls/move_mount/.gitignore
> > index 83ae40145..ddfe10128 100644
> > --- a/testcases/kernel/syscalls/move_mount/.gitignore
> > +++ b/testcases/kernel/syscalls/move_mount/.gitignore
> > @@ -1,2 +1,3 @@
> >   /move_mount01
> >   /move_mount02
> > +/move_mount03
> > diff --git a/testcases/kernel/syscalls/move_mount/move_mount03.c b/testcases/kernel/syscalls/move_mount/move_mount03.c
> > new file mode 100644
> > index 000000000..fff95c50b
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/move_mount/move_mount03.c
> > @@ -0,0 +1,128 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2023 Christian Brauner <brauner@kernel.org>
> > + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Test allow to mount beneath top mount feature
> > + */
> > +
> > +/*
> > + * Test create for following commit:
> > + * commit 6ac392815628f317fcfdca1a39df00b9cc4ebc8b
> > + * Author: Christian Brauner <brauner@kernel.org>
> > + * Date:   Wed May 3 13:18:42 2023 +0200
> > + *     fs: allow to mount beneath top mount
> > + *
> > + * Above commit has heavily commented but i found following commit
> > + * contain simple summary of this feature for easy understanding:
> > + *
> > + * commit c0a572d9d32fe1e95672f24e860776dba0750a38
> > + * Author: Linus Torvalds <torvalds@linux-foundation.org>
> > + *       TL;DR:
> > + *
> > + *         > mount -t ext4 /dev/sda /mnt
> > + *           |
> > + *           --/mnt    /dev/sda    ext4
> > + *
> > + *         > mount --beneath -t xfs /dev/sdb /mnt
> > + *           |
> > + *           --/mnt    /dev/sdb    xfs
> > + *             --/mnt  /dev/sda    ext4
> > + *
> > + *         > umount /mnt
> > + *           |
> > + *           --/mnt    /dev/sdb    xfs
> > + *
> > + * So base above scenario design following scenario for LTP check:
> > + *
> > + *         > mount -t tmpfs /DIRA
> > + *           |
> > + *           --/DIRA(create A file within DIRA)
> > + *
> > + *         > mount -t tmpfs /DIRB
> > + *           |
> > + *           --/DIRA(create B file within DIRB)
> > + *
> > + *         > move_mount --beneath /DIRA /DIRB
> > + *           |
> > + *           --/mnt    /DIRA /DIRB
> > + *             --/mnt  /DIRB
> > + *
> > + *         If you check content of /DIRB, you can see file B
> > + *
> > + *         > umount /DIRB
> > + *           |
> > + *           --/mnt    /DIRA /DIRB
> > + *         Check content of /DIRB, you can see file A exist since
> > + *         current /DIRB mount source is already become /DIRA
> > + *
> > + * See also:
> > + * https://lwn.net/Articles/930591/
> > + * https://github.com/brauner/move-mount-beneath
> > + */
> > +
> > +#include <stdio.h>
> > +
> > +#include "tst_test.h"
> > +#include "lapi/fsmount.h"
> > +#include "lapi/sched.h"
> > +
> > +#define DIRA "LTP_DIR_A"
> > +#define DIRB "LTP_DIR_B"
> > +
> > +static void run(void)
> > +{
> > +	int fda, fdb;
> > +
> > +	SAFE_MOUNT("none", DIRA, "tmpfs", 0, 0);
> > +	SAFE_MOUNT("none", DIRB, "tmpfs", 0, 0);
> > +	SAFE_TOUCH(DIRA "/A", 0, NULL);
> > +	SAFE_TOUCH(DIRB "/B", 0, NULL);
> > +
> > +	/* TEST(fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE)); */

> Is the comment needed?

+1

> > +	fda = open_tree(AT_FDCWD, DIRA, OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE);
> > +	if (fda == -1)
> > +		tst_brk(TBROK | TERRNO, "open_tree() failed");
> > +
> > +	fdb = SAFE_OPEN(DIRB, O_PATH | O_NOFOLLOW, 0666);
> > +	TST_EXP_PASS(move_mount(fda, "", fdb, "",
> > +				MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH |
> > +				MOVE_MOUNT_T_EMPTY_PATH));
> > +	SAFE_CLOSE(fda);
> > +	SAFE_CLOSE(fdb);
> > +
> > +	TST_EXP_PASS(access(DIRB "/B", F_OK));

> It'd also make sense the check here that file A still exists in DIRA but not
> in DIRB.

> > +	SAFE_UMOUNT(DIRB);
> > +	TST_EXP_PASS(access(DIRB "/A", F_OK));
> > +
> > +	SAFE_UMOUNT(DIRB);
> > +	SAFE_UMOUNT(DIRA);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	SAFE_MKDIR(DIRA, 0777);
> > +	SAFE_MKDIR(DIRB, 0777);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (tst_is_mounted_at_tmpdir(DIRA))
> > +		SAFE_UMOUNT(DIRA);
> > +
> > +	if (tst_is_mounted_at_tmpdir(DIRB))
> > +		SAFE_UMOUNT(DIRB);

> I believe that DIRB may need to be unmounted twice here. Also please close
> fda and fdb here if they're still open.

What would do the second mount? move_mount() ?

There are SAFE_UMOUNT() in the end of the testing function, that's why usually
even these 2 SAFE_UMOUNT() aren't needed (but obviously we need to add them if
SAFE_TOUCH() or something quits testing early):

move_mount03.c:92: TPASS: move_mount(fda, "", fdb, "", MOVE_MOUNT_BENEATH | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH) passed
move_mount03.c:98: TPASS: access(DIRB "/B", F_OK) passed
move_mount03.c:99: TINFO: Umounting /tmp/LTP_movqeTZGu/LTP_DIR_B
move_mount03.c:100: TPASS: access(DIRB "/A", F_OK) passed
move_mount03.c:102: TINFO: Umounting /tmp/LTP_movqeTZGu/LTP_DIR_B
move_mount03.c:103: TINFO: Umounting /tmp/LTP_movqeTZGu/LTP_DIR_A
tst_device.c:442: TINFO: No device is mounted at /tmp/LTP_movqeTZGu/LTP_DIR_A
tst_device.c:442: TINFO: No device is mounted at /tmp/LTP_movqeTZGu/LTP_DIR_B

Kind regards,
Petr

> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.needs_root = 1,
> > +	.min_kver = "6.5.0",
> > +	.needs_tmpdir = 1,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
