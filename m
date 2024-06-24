Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6915EC2BD09
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 12:23:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD4613D0DA4
	for <ltp@archiver.kernel.org>; Mon, 24 Jun 2024 14:23:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69CC83CFB81
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 14:23:03 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 649691000640
 for <ltp@lists.linux.it>; Mon, 24 Jun 2024 14:23:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 303E5219FC;
 Mon, 24 Jun 2024 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719231781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Qd2EmL1U4TTo7TUfKXmfrjvHNuecaGnbTn8Ba57IrQ=;
 b=sDd3GMiwCPM6q+x06bFYjF42cn/znr/VkhmxSeS+cinjdiPDyx3GMDmjWRxsqIZ9NMaRt2
 RnNGcBkA5vlQyLLH0Di9J6J6qK60DQFbdc8sOv3tnQfLs0fKlkLvGzV+w5lImkzcFfBhpq
 DGVkHQtGmu/UKGkfP893vHKebaZ1B2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719231781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Qd2EmL1U4TTo7TUfKXmfrjvHNuecaGnbTn8Ba57IrQ=;
 b=R7E4EaQEvMcVC0NpZnno1b3yZMRxIF//7Mu8Se5scGcWQrpYJhRTWWITlPn/u8Vkz/aKTp
 SKRvzF/CcNwl6KDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sDd3GMiw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R7E4EaQE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719231781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Qd2EmL1U4TTo7TUfKXmfrjvHNuecaGnbTn8Ba57IrQ=;
 b=sDd3GMiwCPM6q+x06bFYjF42cn/znr/VkhmxSeS+cinjdiPDyx3GMDmjWRxsqIZ9NMaRt2
 RnNGcBkA5vlQyLLH0Di9J6J6qK60DQFbdc8sOv3tnQfLs0fKlkLvGzV+w5lImkzcFfBhpq
 DGVkHQtGmu/UKGkfP893vHKebaZ1B2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719231781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Qd2EmL1U4TTo7TUfKXmfrjvHNuecaGnbTn8Ba57IrQ=;
 b=R7E4EaQEvMcVC0NpZnno1b3yZMRxIF//7Mu8Se5scGcWQrpYJhRTWWITlPn/u8Vkz/aKTp
 SKRvzF/CcNwl6KDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 156741384C;
 Mon, 24 Jun 2024 12:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id prw+BCVleWaTXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jun 2024 12:23:01 +0000
Date: Mon, 24 Jun 2024 14:22:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZnllGpZEj6TOsWqB@yuki>
References: <20240417144409.11411-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240417144409.11411-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 303E5219FC
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Add stat04 test
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
> +/*\
> + * [Description]
> + *
> + * This test checks that stat() executed on file provide the same information
> + * of symlink linking to it.
> + */
> +
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +static char *tmpdir;
> +
> +static void run(void)
> +{
> +	char *symname = "my_symlink0";
> +
> +	SAFE_SYMLINK(tmpdir, symname);
> +
> +	struct stat path;
> +	struct stat link;
> +
> +	TST_EXP_PASS(stat(tmpdir, &path));
> +	TST_EXP_PASS(stat(symname, &link));
> +
> +	TST_EXP_EQ_LI(path.st_dev, link.st_dev);
> +	TST_EXP_EQ_LI(path.st_mode, link.st_mode);
> +	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);
> +	TST_EXP_EQ_LI(path.st_uid, link.st_uid);
> +	TST_EXP_EQ_LI(path.st_gid, link.st_gid);
> +	TST_EXP_EQ_LI(path.st_size, link.st_size);
> +	TST_EXP_EQ_LI(path.st_atime, link.st_atime);
> +	TST_EXP_EQ_LI(path.st_mtime, link.st_mtime);
> +	TST_EXP_EQ_LI(path.st_ctime, link.st_ctime);

Looking at these, most of the would be the same both for the link and
the actual target. Maybe we should do some extra work in the test setup
to make sure they differ. I would create a file in the temporary
directory as a target for the symlink and use chown() to set a different
owner and group, we can use utime() to change access and modification
time to the beginning of the unix epoch. If we write a megabyte or so to
the file the size should differ as well. If we link() the file it's
nlink counter should increase. And I suppose that if we create either
the file or the symlink on a mounted loop device, it will have different
dev number as well.

I think that the only part that is not changed easily is the creation
time (also called birth time), the rest should be under our control.

> +	SAFE_UNLINK(symname);
> +}
> +
> +static void setup(void)
> +{
> +	tmpdir = tst_get_tmpdir();
> +}
> +
> +static void cleanup(void)
> +{
> +	free(tmpdir);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
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
