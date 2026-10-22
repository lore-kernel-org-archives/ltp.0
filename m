Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571D606A31B
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=loGleMV3;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pfKow5Vj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GYeLi8b2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=G93A656P
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BA9F3D256C
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:03:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 780C33D2411
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:02:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3B4B601A96
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:02:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 873911F397;
 Thu, 22 Oct 2026 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792674164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOOkCVhjgOLIs5XJ1TsM7WWTG5CObU7P6tcjBxE34TQ=;
 b=loGleMV3VKAQF7vJt56f/MifFuZzAscjAtOWFlTxYmLKBFYk9RFH2PUGp/K6v5KTnsp6S6
 5dWNTFu3TLM+ImvNzWTxIYzAAYRqfnv5XGciQTMkTgnGcuQfjt9YNU4xOWqzQ124rkkieb
 TPqXQ81NPPA7d/uUH7OqtoXxhXeiAj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792674164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOOkCVhjgOLIs5XJ1TsM7WWTG5CObU7P6tcjBxE34TQ=;
 b=pfKow5Vja+TaoxWTCal8d2KVcce6cMHM6rQLaIZJMLF3N9ETImP3OY59HmQ23UjXNbA9f9
 2ork4H5Y9xFEDWDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792674163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOOkCVhjgOLIs5XJ1TsM7WWTG5CObU7P6tcjBxE34TQ=;
 b=GYeLi8b2u3sG38Xjcv574F4+jU7UJMbyZXcEIv94jLPrb/q08Uih/8wRe6uX2dTDN6tt3n
 DxVPGjo96Foxi649wUT7/gHbfpsfFYprPQoVBGruBYxaPTkx9xT4xG2C97f++fSp3fuz9d
 Vbli0BMHRQacOHgvTXG76EZQTQjkq7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792674163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOOkCVhjgOLIs5XJ1TsM7WWTG5CObU7P6tcjBxE34TQ=;
 b=G93A656PKa0xKy13cKBUPJ6pMmDQEhQyFKbelKG764rAadjuTgHS3NPQ+YK5BZscILhdyC
 WaEXd2KsH0bMnQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D5ED134E6;
 Thu, 22 Oct 2026 13:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VgCREHMJ2mpdUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Oct 2026 13:02:43 +0000
Date: Thu, 22 Oct 2026 15:03:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <atoJhAJSqByxqdeQ@yuki.lan>
References: <20260917024609.20527-1-wegao@suse.com>
 <20261021084933.19097-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021084933.19097-1-wegao@suse.com>
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v17] fsconfig04: Check FSCONFIG_SET_PATH
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 21, 2026 at 08:49:12AM +0000, Wei Gao via ltp wrote:
> The fsconfig01.c does not test if FSCONFIG_SET_PATH has any effect;
> most of the calls there just set a dummy "sync" parameter. This test
> case aims to verify if the FSCONFIG_SET_PATH operation can be used
> to dynamically change the external journal device of an ext3 or ext4
> filesystem.
> 
> Closes: https://github.com/linux-test-project/ltp/issues/1169
> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
>  .../kernel/syscalls/fsconfig/fsconfig04.c     | 169 ++++++++++++++++++
>  3 files changed, 171 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 2bdb4a9a2..1903f1ac6 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -452,6 +452,7 @@ fremovexattr02 fremovexattr02
>  fsconfig01 fsconfig01
>  fsconfig02 fsconfig02
>  fsconfig03 fsconfig03
> +fsconfig04 fsconfig04
>  
>  fsmount01 fsmount01
>  fsmount02 fsmount02
> diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
> index cfedae5f7..bd3754c34 100644
> --- a/testcases/kernel/syscalls/fsconfig/.gitignore
> +++ b/testcases/kernel/syscalls/fsconfig/.gitignore
> @@ -1,3 +1,4 @@
>  /fsconfig01
>  /fsconfig02
>  /fsconfig03
> +/fsconfig04
> diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> new file mode 100644
> index 000000000..bd649717e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * This test aims to validate :manpage:`fsconfig(2)` with the
> + * ``FSCONFIG_SET_PATH`` operation in dynamically altering the external
> + * journal device of an ext3 or ext4 filesystem.
> + *
> + * Root privileges are required because the test creates and formats loop
> + * devices, and configures filesystems.
> + *
> + * [Algorithm]
> + *
> + * - Acquire three loop devices (``tst_device->dev`` from framework, ``dev1``, ``dev2``).
> + * - Format ``dev1`` and ``dev2`` as external journal devices with the same UUID
> + *   (``-O journal_dev -U <uuid>``).
> + * - Format ``tst_device->dev`` three times to cycle journal associations:
> + *   ``dev1`` -> ``dev2`` -> ``dev1``, so both journal superblocks are consistent.
> + * - Open ``tst_device->dev`` via :manpage:`fsopen(2)` and set the source and journal_path using
> + *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_STRING``) and
> + *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_PATH``).
> + * - Apply ``FSCONFIG_CMD_CREATE`` and verify with ``tune2fs`` that ``tst_device->dev``'s
> + *   journal device is now ``dev2``.
> + *
> + * Implementation notes:
> + *
> + * - To avoid ``journal UUID does not match`` error when switching external
> + *   journal device, we have to assign the same UUID to ``dev1``/``dev2``.
> + * - Before the :manpage:`fsconfig(2)` test, we have to format ``tst_device->dev`` associating to
> + *   ``dev1`` -> ``dev2`` -> ``dev1``. This ensures that both ``dev1``/``dev2`` superblocks contain
> + *   correct content. Otherwise, you will encounter errors such as
> + *   ``EXT4-fs (loop0): External journal has more than one user (unsupported)``
> + *   when switching the external journal device using :manpage:`fsconfig(2)`.
> + */
> +
> +#include <stdbool.h>
> +#include <sys/stat.h>
> +#include <sys/sysmacros.h>
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "lapi/fsmount.h"
> +
> +#define LOOP_DEV_SIZE 10
> +#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
> +
> +static int fd = -1;
> +static char dev1[PATH_MAX];
> +static char dev2[PATH_MAX];
> +
> +static const char *const mkfs_opts_set_UUID[] = {"-F", "-U", UUID, "-O", "journal_dev", NULL};
> +
> +static void cleanup(void)
> +{
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
> +
> +	if (dev1[0])
> +		tst_detach_device(dev1);
> +
> +	if (dev2[0])
> +		tst_detach_device(dev2);
> +}
> +
> +static void create_and_attach_loopdev(const char *filename, char *dev_path, size_t dev_path_len)
> +{
> +	if (tst_prealloc_file(filename, 1024 * 1024, LOOP_DEV_SIZE))
> +		tst_brk(TBROK, "Failed to create %s", filename);
> +
> +	if (tst_find_free_loopdev(dev_path, dev_path_len) == -1)
> +		tst_brk(TBROK, "No free loop device found for %s", filename);
> +
> +	if (tst_attach_device(dev_path, filename))
> +		tst_brk(TBROK, "Failed to attach %s to %s", filename, dev_path);
> +}
> +
> +static void format_journal_device(const char *dev, const char *journal)
> +{
> +	char journal_opt[PATH_MAX + 16];
> +	const char *const opts[] = {"-F", "-J", journal_opt, NULL};
> +
> +	snprintf(journal_opt, sizeof(journal_opt), "device=%s", journal);
> +	SAFE_MKFS(dev, tst_device->fs_type, opts, NULL);
> +}
> +
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +
> +	create_and_attach_loopdev("dev1_file", dev1, sizeof(dev1));
> +	create_and_attach_loopdev("dev2_file", dev2, sizeof(dev2));
> +}
> +
> +static void run(void)
> +{
> +	/* Reset dev1, dev2 and tst_device->dev superblocks before each test run iteration */
> +	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> +	format_journal_device(tst_device->dev, dev1);
> +	format_journal_device(tst_device->dev, dev2);
> +	format_journal_device(tst_device->dev, dev1);

I do not get why we have the dev1 and what errors are we working around
here. The dev1 is not used for anything, just formatted again and again.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
