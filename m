Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A19C48291
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 17:05:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADCAF3CE503
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 18:05:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9853C12A7
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 18:05:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D2A7D10005A7
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 18:05:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7AC5B21F6D;
 Fri,  2 Feb 2024 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706893540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4tXHtvTbgQ/ilSF+rBCAQXjU9rA7R9Y7y0kz33sTNc=;
 b=GGHPo55eMeGBHxXQNl8JnkdoKoSbjR8W8qBI7VX8yI6xsPLrM0Du2mOUlG+lPgL+9k5PVk
 HuR+Kr3GZUib2X7/xuRiLxlnf7nf/Lwc21RvJ5d+aixGU+v2JRNMsjl6dlILhBqoYxlRhm
 sSDZ5FASPNTxHsG6Lwh7PWyOaD/26cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706893540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4tXHtvTbgQ/ilSF+rBCAQXjU9rA7R9Y7y0kz33sTNc=;
 b=adzepxnJ4tJ91vs+oI+0gE7Wsu4Gb3KVtCc2KnF0pBOqFgBJgBMPEmbqpzAMPd8qLxa56U
 h5W5a7zBff4XtFBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706893540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4tXHtvTbgQ/ilSF+rBCAQXjU9rA7R9Y7y0kz33sTNc=;
 b=GGHPo55eMeGBHxXQNl8JnkdoKoSbjR8W8qBI7VX8yI6xsPLrM0Du2mOUlG+lPgL+9k5PVk
 HuR+Kr3GZUib2X7/xuRiLxlnf7nf/Lwc21RvJ5d+aixGU+v2JRNMsjl6dlILhBqoYxlRhm
 sSDZ5FASPNTxHsG6Lwh7PWyOaD/26cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706893540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4tXHtvTbgQ/ilSF+rBCAQXjU9rA7R9Y7y0kz33sTNc=;
 b=adzepxnJ4tJ91vs+oI+0gE7Wsu4Gb3KVtCc2KnF0pBOqFgBJgBMPEmbqpzAMPd8qLxa56U
 h5W5a7zBff4XtFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D4FF139AB;
 Fri,  2 Feb 2024 17:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tjMbFeQgvWV0SQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 02 Feb 2024 17:05:40 +0000
Date: Fri, 2 Feb 2024 18:05:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zb0g9hwYvk2MmqeT@yuki>
References: <20240118152438.15668-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240118152438.15668-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.06 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email,linux.it:url];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.26)[73.55%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add lstat03 test
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
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that lstat() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include "tst_test.h"
> +
> +static void test_lstat(void)
> +{
> +	char *symname = "my_symlink0";
> +
> +	TST_EXP_PASS(symlink(tst_get_tmpdir(), symname));
> +
> +	struct stat path_stat;
> +	struct stat link_stat;
> +
> +	SAFE_LSTAT(tst_get_tmpdir(), &path_stat);
> +	SAFE_LSTAT(symname, &link_stat);

Apart from the leakage of memory does this even work correctly?

If we request information about the link itself via lstat() we get the
stat results for the link. If we call lstat() on the target of the
symlink we get the info about the target. How are these two supposed to
yield the same result?

I suppose that if we do stat() on the link and stat() on the link
tharget then we would end up with an identical results, but not for
lstat().

> +	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
> +	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
> +	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
> +	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
> +	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
> +	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
> +	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
> +
> +	TST_EXP_EXPR(path_stat.st_mode != link_stat.st_mode,
> +		"object and symbolic link have different st_mode");
> +	TST_EXP_EXPR(path_stat.st_size != link_stat.st_size,
> +		"object and symbolic link have different st_size");
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_lstat_no_path(void)
> +{
> +	char *symname = "my_symlink1";
> +	struct stat link_stat;
> +
> +	TST_EXP_PASS(symlink("bc+eFhi!k", symname));
> +
> +	SAFE_LSTAT(symname, &link_stat);

So this is a lstat() test, right? So it should rather be SAFE_SYMLIK()
then TST_EXP_PASS(lstat(...))

> +	TST_EXP_EXPR((link_stat.st_mode & S_IFMT) == S_IFLNK,
> +		"can read symlink file information");
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void run(void)
> +{
> +	test_lstat();
> +	test_lstat_no_path();
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
