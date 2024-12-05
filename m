Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF67AE7716C
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 11:10:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027353DF992
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 12:10:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944593DF7B1
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 12:10:26 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85851610239
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 12:10:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA03A211FF;
 Thu,  5 Dec 2024 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733397024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6iIn/mE17lGYuZciwE2eUpDxiqLBntLebffdmFECXk=;
 b=UY8mPYE65jV9/VZ9/Am6R1jVPeEVOeTorqTSZI1qJsK1pqPSqf+8/LqAC9WDFqPAMXodFX
 SzxsoaWUJ+b7OhIsWhB7Vv48ecYd/QjNyYB86DN5lpy8oOjvTB1cgU81qP64YkO1BjIz/E
 o2bl10waRc941uEsYeu2rldy2qu5V9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733397024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6iIn/mE17lGYuZciwE2eUpDxiqLBntLebffdmFECXk=;
 b=Kx3abLNDt6Zls9cFIsfBI7JMKHA8XNlVEy0Th+20gnWfqUvkvuc1/JOxmuO6LDT5qXULZo
 z/FzqYsh9FyGv8BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733397024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6iIn/mE17lGYuZciwE2eUpDxiqLBntLebffdmFECXk=;
 b=UY8mPYE65jV9/VZ9/Am6R1jVPeEVOeTorqTSZI1qJsK1pqPSqf+8/LqAC9WDFqPAMXodFX
 SzxsoaWUJ+b7OhIsWhB7Vv48ecYd/QjNyYB86DN5lpy8oOjvTB1cgU81qP64YkO1BjIz/E
 o2bl10waRc941uEsYeu2rldy2qu5V9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733397024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6iIn/mE17lGYuZciwE2eUpDxiqLBntLebffdmFECXk=;
 b=Kx3abLNDt6Zls9cFIsfBI7JMKHA8XNlVEy0Th+20gnWfqUvkvuc1/JOxmuO6LDT5qXULZo
 z/FzqYsh9FyGv8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DF13132EB;
 Thu,  5 Dec 2024 11:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gfk2GyCKUWd0IQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Dec 2024 11:10:24 +0000
Date: Thu, 5 Dec 2024 12:10:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241205111014.GB28204@pevik>
References: <20241204172312.34099-1-mdoucha@suse.cz>
 <20241204172312.34099-2-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241204172312.34099-2-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add test for data integrity over NFS
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

> Add NFS test which checks data integrity of random writes into a file,
> with both buffered and direct I/O.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---

> Changes since v1: Added TST_TIMEOUT

> Changes since v2: Force NFS blocksize to the underlying FS blocksize

> By default, NFS uses very large blocksize (up to 1MB) to optimize network
> communication. For the FS integrity test this means a significant slowdown
> because the size of the test file and I/O operations increase with
> blocksize. Autodetect the blocksize of the underlying filesystem and force
> the same value during NFS mount to speed things up.

> The TST_TIMEOUT value is calculated as worst-case scenario for 64KB
> blocksize. On reasonably modern x86_64 machines, the new tests take about
> 6 minutes to complete in total (with Btrfs, Ext4 and XFS being tested).

+1. I also did some testing. BTW TST_TIMEOUT is for single filesystem, thus 11
min is really safe enough even for slow machines like emulated risc-v.

> +++ b/testcases/network/nfs/nfs_stress/nfs10.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
> +#
> +# DESCRIPTION: Verify data integrity over NFS, with and without O_DIRECT
> +
> +TST_CNT=4
> +TST_SETUP="nfs10_setup"
> +TST_TESTFUNC="do_test"
> +TST_DEVICE_SIZE=1024
> +TST_TIMEOUT=660
> +
> +nfs10_setup()
> +{
> +	local bsize=$(stat -f -c %s .)
> +
> +	bsize=$(( $bsize < 1024 ? 1024 : $bsize ))

nit: this would work if stat is not installed (minimal systems) or fails for
some reason:

if [ -z "$bsize" ] || [ "$bsize" -lt 1024 ]; then
	bsize=1024
fi

If you agree, I can change it during merge.
Otherwise LGTM.

Thank you!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	NFS_MOUNT_OPTS="rsize=$bsize,wsize=$bsize"
> +	nfs_setup

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
