Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4622AC25B10
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 11:35:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 511223CE3BE
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 13:35:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B355B3CD1CA
 for <ltp@lists.linux.it>; Fri, 10 May 2024 13:35:19 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 962BF140836B
 for <ltp@lists.linux.it>; Fri, 10 May 2024 13:35:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CA9E61469;
 Fri, 10 May 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4867139AA;
 Fri, 10 May 2024 11:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UTbQNnMGPmZ4XwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 May 2024 11:35:15 +0000
Date: Fri, 10 May 2024 13:35:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240510113514.GA417271@pevik>
References: <20240510002331.31431-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240510002331.31431-1-wegao@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0CA9E61469
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] chmod02.c: Block mode changes of symlinks
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

...
>  testcases/kernel/syscalls/chmod/chmod02.c  | 68 ++++++++++++++++++++++
nit: original chmod02.c was removed in eab36ea01, now you are using this
filename again. I don't remember if there is any consensus about reusing test
name (maybe it's ok), but I would prefer to create new file (i.e. chmod08.c),
because reusing names can lead to confusion (people may not notice when looking
into git history that these 2 tests are completely unrelated. If nothing,
different GPL version can be taken by mistake (e.g. original chmod02.c used GPL
2 only license).

...
> +/*\
> + * [Description]
> + *
> + * Test for kernel commit 5d1f903f75a80daa4dfb3d84e114ec8ecbf29956
> + * "attr: block mode changes of symlinks".
nit: 5d1f903f75a8 ("attr: block mode changes of symlinks")
> + *
nit: please remove this blank line above.
> + */
> +
> +#include "lapi/fcntl.h"
> +#include "tst_test.h"
> +
> +#define MODE 0644
> +#define TESTFILE "testfile"
> +#define TESTFILE_SYMLINK "testfile_symlink"
> +
> +static void run(void)
> +{
> +	struct stat stat_file, stat_sym;
> +	int mode = 0;
> +	char fd_path[100];
> +
> +	int fd = SAFE_OPEN(TESTFILE_SYMLINK, O_PATH | O_NOFOLLOW);
> +
> +	sprintf(fd_path, "/proc/self/fd/%d", fd);
> +
> +	TST_EXP_FAIL(chmod(fd_path, mode), ENOTSUP, "chmod(%s, %04o)",
> +			TESTFILE_SYMLINK, mode);
> +
> +	SAFE_STAT(TESTFILE, &stat_file);
> +	SAFE_LSTAT(TESTFILE_SYMLINK, &stat_sym);
> +
> +	stat_file.st_mode &= ~S_IFREG;
> +	stat_sym.st_mode &= ~S_IFLNK;
> +
> +	if (stat_file.st_mode == (unsigned int)mode) {
> +		tst_res(TFAIL, "stat(%s) mode=%04o",
> +				TESTFILE, stat_file.st_mode);
> +	} else {
> +		tst_res(TPASS, "stat(%s) mode=%04o",
> +				TESTFILE, stat_file.st_mode);
> +	}
Maybe using TST_EXP_EXPR() to not repeat yourself?
> +
> +	if (stat_sym.st_mode == (unsigned int)mode) {
> +		tst_res(TFAIL, "stat(%s) mode=%04o",
> +				TESTFILE_SYMLINK, stat_sym.st_mode);
> +	} else {
> +		tst_res(TPASS, "stat(%s) mode=%04o",
> +				TESTFILE_SYMLINK, stat_sym.st_mode);
> +	}
And here as well?

Missing SAFE_CLOSE(fd); causes EMFILE (Too many open files) failure on high -i
(e.g. -i 1100).

> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(TESTFILE, MODE, NULL);
> +	SAFE_SYMLINK(TESTFILE, TESTFILE_SYMLINK);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +	.min_kver = "6.6",
Looking into kernel commit [1] it's in VFS therefore it should be safe to test
it on single filesystem which is in TMPDIR (i.e. not using .all_filesystems).

But "If this causes any regressions" and "It's a simple patch that can be easily
reverted." suggests that we should think twice when not running it with
.all_filesystems (if used, exfat and vfat fails with EPERM, but it works
on NTFS).

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d1f903f75a80daa4dfb3d84e114ec8ecbf29956

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
