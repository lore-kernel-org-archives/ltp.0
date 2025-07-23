Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6990C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 20:04:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E6883CCDDA
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 22:04:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECBE13CCDD5
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 22:03:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A37B1A00E24
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 22:03:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96843218B8;
 Wed, 23 Jul 2025 20:03:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B86713ABE;
 Wed, 23 Jul 2025 20:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wqj3Eh5AgWhvDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Jul 2025 20:03:42 +0000
Date: Wed, 23 Jul 2025 22:03:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250723200336.GF162896@pevik>
References: <20250723-xattr_bug_repr-v5-0-63183d865e97@suse.com>
 <20250723-xattr_bug_repr-v5-2-63183d865e97@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250723-xattr_bug_repr-v5-2-63183d865e97@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 96843218B8
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] Add listxattr04 reproducer
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

Hi Andrea,

First, can you please before merge add
listxattr04 to runtest/syscalls?

With that you may add my RBT
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for the test.

3 very minor notes, up to you if you change it before merge.

> +#include <pwd.h>
I guess this is now not needed, right?

> +#include <sys/acl.h>
> +#include <sys/xattr.h>
> +
> +#define ACL_PERM        "u::rw-,u:root:rwx,g::r--,o::r--,m::rwx"
> +#define TEST_FILE       "test.bin"
> +
> +static acl_t acl;
> +
> +static void verify_xattr(const int size)
> +{
> +	char buf[size];
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	if (listxattr(TEST_FILE, buf, size) == -1) {
> +		if (errno != ERANGE)
> +			tst_brk(TBROK | TERRNO, "listxattr() error");
> +
> +		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "listxattr() correctly read attributes length");
> +}
> +
> +static void run(void)
> +{
> +	int size;
> +
> +	size = listxattr(TEST_FILE, NULL, 0);
> +	if (size == -1)
> +		tst_brk(TBROK | TERRNO, "listxattr() error");
> +
> +	verify_xattr(size);
> +}
> +
> +static void setup(void)
> +{
> +	int res;
> +	int selinux;
> +	int smack;
> +
> +	selinux = tst_lsm_enabled("selinux");
> +	smack = tst_lsm_enabled("smack");
> +
> +	if (!selinux && !smack)
very nit: up to you, but I would avoid variables and just

	if (!tst_lsm_enabled("selinux") && !tst_lsm_enabled("smack"))
		tst_brk(TCONF, "There are no LSM(s) implementing xattr");

> +		tst_brk(TCONF, "There are no LSM(s) implementing xattr");

> +
> +	SAFE_TOUCH(TEST_FILE, 0644, NULL);
> +
> +	acl = acl_from_text(ACL_PERM);
> +	if (!acl)
> +		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
> +
> +	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
> +	if (res == -1) {
> +		if (errno == EOPNOTSUPP)
> +			tst_brk(TCONF | TERRNO, "acl_set_file()");
> +
> +		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (acl)
> +		acl_free(acl);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "800d0b9b6a8b"},
> +		{}
> +	}
> +};
> +
> +#else /* HAVE_SYS_XATTR_H && HAVE_LIBACL */
> +	TST_TEST_TCONF("<sys/xattr.h> or <sys/acl.h> does not exist.");
very very nit: please no dot in LTP messages.

Kind regards,
Petr

> +#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
