Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CCDC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 13:49:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 164443CDC0F
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 14:49:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D17223CC2FA
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:49:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 062E3600058
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:49:14 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7B791F74B;
 Tue, 28 Nov 2023 13:49:13 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 91EF0133B5;
 Tue, 28 Nov 2023 13:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id g//1ItnvZWVVJQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 13:49:13 +0000
Date: Tue, 28 Nov 2023 14:49:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231128134912.GB401671@pevik>
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
 <20231102080535.63847-2-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231102080535.63847-2-xuyang2018.jy@fujitsu.com>
X-Spamd-Bar: +++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: A7B791F74B
X-Spamd-Result: default: False [11.99 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 ARC_NA(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all];
 DMARC_NA(1.20)[suse.cz];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; NEURAL_SPAM_LONG(3.50)[1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.990];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add error tests for pathconf() system call
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

Hi Xu,

> +/*\
> + * [Description]
> + *
> + * Verify that,
> + *
> + * - pathconf() fails with ENOTDIR if A component used as a directory
nit: s/if A/if a/

> + *   in path is not in fact a directory.
> + * - pathconf() fails with ENOENT if path is an empty string.
> + * - pathconf() fails with ENAMETOOLONG if path is too long.
> + * - pathconf() fails with EINVA if name is invalid.
> + * - pathconf() fails with EACCES if search permission is denied for
> + *   one of the directories in the path prefix of path.
> + * - pathconf() fails with ELOOP if too many symbolic links were
> + *   encountered while resolving path.
> + */
> +
> +#define FILEPATH "testfile/testfile_1"
> +#define TESTELOOP "test_eloop1"
> +
> +#include <stdlib.h>
> +#include <pwd.h>
> +#include "tst_test.h"
> +
> +static char *fpath;
> +static char *emptypath;
> +static char path[PATH_MAX + 2];
Maybe define some constant and use it also on other place?
e.g.:

#define PATH_LEN (PATH_MAX + 2)

> +static char *long_path = path;
> +static char *abs_path;
> +static char *testeloop;
> +static struct passwd *user;
> +
> +static struct tcase {
> +	char **path;
> +	int name;
> +	int exp_errno;
> +	char *desc;
> +} tcases[] = {
> +	{&fpath, 0, ENOTDIR, "path prefix is not a directory"},
> +	{&emptypath, 0, ENOENT, "path is an empty string"},
> +	{&long_path, 0, ENAMETOOLONG, "path is too long"},
> +	{&abs_path, -1, EINVAL, "name is invalid"},
> +	{&abs_path, 0, EACCES, "without full permissions of the path prefix"},
> +	{&testeloop, 0, ELOOP, "too many symbolic links"},
> +};
> +
> +static void verify_fpathconf(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	if (tc->exp_errno == EACCES)
> +		SAFE_SETEUID(user->pw_uid);
> +
> +	TST_EXP_FAIL(pathconf(*tc->path, tc->name), tc->exp_errno,
> +		     "pathconf() fail with %s", tc->desc);
> +
> +	if (tc->exp_errno == EACCES)
> +		SAFE_SETEUID(0);
> +}
> +
> +static void setup(void)
> +{
> +	user = SAFE_GETPWNAM("nobody");
> +
> +	SAFE_TOUCH("testfile", 0777, NULL);
> +
> +	char *tmpdir =  tst_get_tmpdir();
> +
> +	abs_path = tst_aprintf("%s/%s", tmpdir, FILEPATH);
> +
> +	SAFE_CHMOD(tmpdir, 0);
> +	free(tmpdir);
> +
> +	memset(path, 'a', PATH_MAX + 2);
> +
> +	SAFE_SYMLINK("test_eloop1", "test_eloop2");
> +	SAFE_SYMLINK("test_eloop2", "test_eloop1");
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_fpathconf,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&fpath, .str = FILEPATH},
> +		{&emptypath, .str = ""},
> +		{&testeloop, .str = TESTELOOP},
> +		{},
> +	},
> +	.needs_root = 1,
> +};

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
