Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB3BC83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 14:11:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DC7C3CCD2B
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 16:11:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B60F33CAD64
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 16:11:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AD658600CC7
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 16:11:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C4952116B;
 Tue, 22 Jul 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BC27132EA;
 Tue, 22 Jul 2025 14:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Or97Cfqbf2gsIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 14:11:06 +0000
Date: Tue, 22 Jul 2025 16:11:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250722141104.GC84869@pevik>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-2-4be1e52e97c6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250722-xattr_bug_repr-v4-2-4be1e52e97c6@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 5C4952116B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Add listxattr04 reproducer
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
Cc: linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Paul Eggert <eggert@cs.ucla.edu>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

FYI Andrea's LTP reproducer for a bug introduced in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b0ba61df5a1
and fixed in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=800d0b9b6a8b

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
> simple_xattr_list to always include security.* xattrs").

> Bug can be reproduced when SELinux and ACL are activated on inodes as
> following:

>     $ touch testfile
>     $ setfacl -m u:myuser:rwx testfile
>     $ getfattr -dm. /tmp/testfile
>     Segmentation fault (core dumped)

> The reason why this happens is that simple_xattr_list() always includes
> security.* xattrs without resetting error flag after
> security_inode_listsecurity(). This results into an incorrect length of the
> returned xattr name if POSIX ACL is also applied on the inode.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/listxattr/.gitignore    |   1 +
>  testcases/kernel/syscalls/listxattr/Makefile      |   2 +
>  testcases/kernel/syscalls/listxattr/listxattr04.c | 108 ++++++++++++++++++++++
>  3 files changed, 111 insertions(+)

> diff --git a/testcases/kernel/syscalls/listxattr/.gitignore b/testcases/kernel/syscalls/listxattr/.gitignore
> index be0675a6df0080d176d53d70194442bbc9ed376c..0d672b6ea5eec03aab37ee89316c56e24356c1d9 100644
> --- a/testcases/kernel/syscalls/listxattr/.gitignore
> +++ b/testcases/kernel/syscalls/listxattr/.gitignore
> @@ -1,3 +1,4 @@
>  /listxattr01
>  /listxattr02
>  /listxattr03
> +/listxattr04
> diff --git a/testcases/kernel/syscalls/listxattr/Makefile b/testcases/kernel/syscalls/listxattr/Makefile
> index c2f84b1590fc24a7a98f890ea7706771d944aa79..e96bb3fa4c2c6b14b8d2bc8fd4c475e4789d72fe 100644
> --- a/testcases/kernel/syscalls/listxattr/Makefile
> +++ b/testcases/kernel/syscalls/listxattr/Makefile
> @@ -6,4 +6,6 @@ top_srcdir		?= ../../../..

>  include $(top_srcdir)/include/mk/testcases.mk

> +listxattr04: LDLIBS	+= $(ACL_LIBS)
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/listxattr/listxattr04.c b/testcases/kernel/syscalls/listxattr/listxattr04.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..473ed45b5c2da8ff8e49c513eeb82158ec2dc066
> --- /dev/null
> +++ b/testcases/kernel/syscalls/listxattr/listxattr04.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test reproducer for a bug introduced in 8b0ba61df5a1 ("fs/xattr.c: fix
> + * simple_xattr_list to always include security.* xattrs").
> + *
> + * Bug can be reproduced when SELinux and ACL are activated on inodes as
> + * following:
> + *
> + *     $ touch testfile
> + *     $ setfacl -m u:myuser:rwx testfile
> + *     $ getfattr -dm. /tmp/testfile
> + *     Segmentation fault (core dumped)
> + *
> + * The reason why this happens is that simple_xattr_list() always includes
> + * security.* xattrs without resetting error flag after
> + * security_inode_listsecurity(). This results into an incorrect length of the
> + * returned xattr name if POSIX ACL is also applied on the inode.
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +
> +#if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
> +
> +#include <pwd.h>
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

The original verifier from RH bugreport check sizes and also works if size > -1
is returned, but I guess it's not necessary, because Andrea's reproducer works
as expected (fails on affected 6.16-rc1 based openSUSE kernel, works on 6.15.x).

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2369561
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
> +
> +	if (!tst_selinux_enabled())
> +		tst_brk(TCONF, "SELinux is not enabled");
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
> +#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
