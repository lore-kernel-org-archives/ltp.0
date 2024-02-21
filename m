Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205DCC48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 14:54:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABD393D0870
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:54:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BC4F3CB2D6
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:54:10 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E10E60276C
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:54:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8368021AE3;
 Wed, 21 Feb 2024 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708527249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEu4A4vusmnUfEtROTp+SEKhfQX+J3cqDwJYoxia+pQ=;
 b=GIIsc+FQUtRcOtftm+RmYuVRM3omB4tHcN+3OenBFzzwv5RE9mHX07tatRMej0sd1T51pv
 iUQJPTYcyCMrUIRIUYyCVOPUHG0Ra95WDFJzqlqIGMmA9pfEGYD2ybHbw8vg+pkj/YVywt
 wTdHNepapnLSKB/SJ2w9NyPeyKcEp5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708527249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEu4A4vusmnUfEtROTp+SEKhfQX+J3cqDwJYoxia+pQ=;
 b=+C2fR1QeIOSaAPTXmgsSdrOuJpS97MkKV7LpMKgDqjAi2QF/M1n40siecrXjdxz05NMDzY
 xpoG40mTIsRByfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708527249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEu4A4vusmnUfEtROTp+SEKhfQX+J3cqDwJYoxia+pQ=;
 b=GIIsc+FQUtRcOtftm+RmYuVRM3omB4tHcN+3OenBFzzwv5RE9mHX07tatRMej0sd1T51pv
 iUQJPTYcyCMrUIRIUYyCVOPUHG0Ra95WDFJzqlqIGMmA9pfEGYD2ybHbw8vg+pkj/YVywt
 wTdHNepapnLSKB/SJ2w9NyPeyKcEp5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708527249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEu4A4vusmnUfEtROTp+SEKhfQX+J3cqDwJYoxia+pQ=;
 b=+C2fR1QeIOSaAPTXmgsSdrOuJpS97MkKV7LpMKgDqjAi2QF/M1n40siecrXjdxz05NMDzY
 xpoG40mTIsRByfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73440139D0;
 Wed, 21 Feb 2024 14:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9tcEG5EO1mV5CQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Feb 2024 14:54:09 +0000
Date: Wed, 21 Feb 2024 15:52:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZdYOSnWJAQzn75bp@yuki>
References: <20240219153155.20527-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240219153155.20527-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GIIsc+FQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+C2fR1Qe
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.55 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.54)[80.66%]
X-Rspamd-Queue-Id: 8368021AE3
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add stat04 test
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner
> + *    Copilot: Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test checks that stat() executed on file provide the same information
> + * of symlink linking to it.
> + */
> +
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	char *symname = "my_symlink0";
> +	char *tmpdir = tst_get_tmpdir();

This is stil a memory leak. I guess that the test will allocate huge
amount of memory with large enough -i parameter.

Either call it once in the test setup() or use "." instead.


> +	SAFE_SYMLINK(tmpdir, symname);
> +
> +	struct stat path_stat;
> +	struct stat link_stat;

I guess that the output of the comparsions below would look better if we
call these variables just path and link.

> +	TST_EXP_PASS(stat(tmpdir, &path_stat));
> +	TST_EXP_PASS(stat(symname, &link_stat));
> +
> +	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
> +	TST_EXP_EQ_LI(path_stat.st_mode, link_stat.st_mode);
> +	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
> +	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
> +	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
> +	TST_EXP_EQ_LI(path_stat.st_size, link_stat.st_size);
> +	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
> +	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
> +	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
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
