Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F10C2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 09:33:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E1AE3D123A
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:33:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E67D3D0FAF
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:33:20 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A1FB1000A5C
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:33:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E66B91FBB1;
 Thu, 27 Jun 2024 09:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719480798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OVVkY4Vzub+/mD34dKmS+tyJyQ+I2a5W9uJEYzA3DY=;
 b=UtdBfLMLX7oj0AWeT36iXXF/yt0MZfL9LPn8067cpi5NKxemV1wiZd/N5kL3nzjH+WLd+a
 Ev3MGK8/1dP4iQyK73VFhSANxB8vsj1JJ+1WBNAgU+f44FLVLurfz2cVo+egbuYbIab+h4
 iqKgt0+wU30iAU9W9fqxRNBorTs2dI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719480798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OVVkY4Vzub+/mD34dKmS+tyJyQ+I2a5W9uJEYzA3DY=;
 b=XMwXCBQ2QfJjN77eqAGf1/IszoRMhjugcrN9C3Fs2l3FCSjycj9CKg5cFVDRdZK+CqBof/
 /Wf4ZV8Ow29ay2Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Om7iL9v4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dJDkPOi3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719480797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OVVkY4Vzub+/mD34dKmS+tyJyQ+I2a5W9uJEYzA3DY=;
 b=Om7iL9v4vTePLc7G7fYtKXcq9+BvCzmaH5Do7D29vcI1JsN7sFlfTgLILwgGnC+diy6mQ+
 hfzJbxS/s9g6YINDArQNc7qFcm0O65nhX5lnkC2VzhgRbCtSNjHsTT/KhRweQi6Q9EhlKv
 DK0o7N+NCdY1Ne2eUEjduyfG1HxYti4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719480797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OVVkY4Vzub+/mD34dKmS+tyJyQ+I2a5W9uJEYzA3DY=;
 b=dJDkPOi3oLr92hbjFvhAaU5sk9PrFM61zNn/KO7VH5w0LV5nd1KjRjMeBe9/yLpk45bpj5
 lGJv9L5+x81+7lAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5DAB1384C;
 Thu, 27 Jun 2024 09:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wqkULtwxfWYHHQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jun 2024 09:33:16 +0000
Date: Thu, 27 Jun 2024 11:33:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zn0x0RN9SWJaDs84@yuki>
References: <20240220131319.11761-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240220131319.11761-1-andrea.cervesato@suse.de>
X-Rspamd-Queue-Id: E66B91FBB1
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.it:url];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add chmod08 test
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
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/chmod/chmod08.c | 61 +++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/chmod/chmod08.c
> 
> diff --git a/testcases/kernel/syscalls/chmod/chmod08.c b/testcases/kernel/syscalls/chmod/chmod08.c
> new file mode 100644
> index 000000000..f9ca4e45a
> --- /dev/null
> +++ b/testcases/kernel/syscalls/chmod/chmod08.c
> @@ -0,0 +1,61 @@
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
> + * This test verifies that chmod() is working correctly on symlink()
> + * generated files.
> + */
> +
> +#include "tst_test.h"
> +
> +#define PERMS 01777
> +#define TESTFILE "myobject"
> +
> +static char testfile[PATH_MAX];
> +
> +static void run(void)
> +{
> +	char *symname = "my_symlink0";
> +	struct stat oldsym_stat;
> +	struct stat newsym_stat;
> +
> +	SAFE_TOUCH(testfile, 0644, NULL);
> +	SAFE_SYMLINK(testfile, symname);
> +	SAFE_STAT(symname, &oldsym_stat);
> +
> +	TST_EXP_PASS(chmod(symname, PERMS));
> +	SAFE_STAT(symname, &newsym_stat);
> +
> +	TST_EXP_EQ_LI(newsym_stat.st_mode & PERMS, PERMS);
> +	TST_EXP_EXPR(oldsym_stat.st_mode != newsym_stat.st_mode,
> +		"file mode has changed");
> +
> +	SAFE_UNLINK(symname);
> +	remove(testfile);

This should be SAFE_UNLINK() as well.

> +}
> +
> +static void setup(void)
> +{
> +	int tmplen;
> +	char *tmpdir;
> +
> +	tmpdir = tst_get_tmpdir();
> +	tmplen = strlen(tmpdir);
> +
> +	testfile[tmplen] = '/';
> +	memcpy(testfile, tmpdir, tmplen);
> +	memcpy(testfile + tmplen + 1, TESTFILE, strlen(TESTFILE));

This can easily overflow. If you want to use absolute path you should
allocate the buffer based on the tmpdir lenght...

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
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
