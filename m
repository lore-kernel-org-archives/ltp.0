Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5FFD1BDC1
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 16:00:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68D253D0D90
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 17:00:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD1633C6112
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 16:59:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D346C6067A9
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 16:59:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 568311FDE6;
 Mon,  4 Nov 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B15813503;
 Mon,  4 Nov 2024 15:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EmtwDXXvKGcWHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Nov 2024 15:59:49 +0000
Date: Mon, 4 Nov 2024 16:59:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241104155947.GC1388681@pevik>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-6-mdoucha@suse.cz>
 <20241101233221.GC1324664@pevik> <ZyjGiQ7-oyBZBG-S@yuki.lan>
 <ZyjJ9iywT4boYavJ@yuki.lan> <ZyjM_1iwp58EbHwh@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyjM_1iwp58EbHwh@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 568311FDE6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] Add test for data integrity over NFS
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!

> > I'm looking at the nfs_lib.sh, we do have a lot there actually since it
> > runs for all filesystems and we run the nfs tests for different nfs
> > versions as well. This does not seem that would integrate well into the
> > tst_test all_filesystems testing.

Yes (found that as well when replied to your first email).
I thought you want to integrate NFS just for a shake of other tests, which use
.all_filesystems (e.g. some NFS to be added into fs_type_whitelist[], e.g.
"nfsv4), which would of course require u specific setup.

That would, of course did not cover all range of NFS versions + also using UDP,
which is used for current NFS tests (including this one).

> > I will think a bit how to integrate things better, because having LTP
> > test inside LTP test will never work well.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Looks usable + later on tests which use netstress.c could be converted to use it
as well.

Kind regards,
Petr

> So one posibility is to use the new shell test library that integrates
> cleanly with C, then we can have a shell nfs test that runs for all
> filesystems, mounts the nfs and then runs the C fsplough itself.

> Minimal example how to do that is:

> From b48184d4fa1918afe6c84d0e691f8d46c986e92c Mon Sep 17 00:00:00 2001
> From: Cyril Hrubis <chrubis@suse.cz>
> Date: Mon, 4 Nov 2024 14:29:24 +0100
> Subject: [PATCH] shell lib: Add example how to run C child

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/lib/run_tests.sh                  |  2 +-
>  testcases/lib/tests/.gitignore              |  1 +
>  testcases/lib/tests/shell_c_child.c         | 16 ++++++++++++++
>  testcases/lib/tests/shell_loader_c_child.sh | 24 +++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/lib/tests/shell_c_child.c
>  create mode 100755 testcases/lib/tests/shell_loader_c_child.sh

> diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
> index 8ea615f96..40d415e6c 100755
> --- a/testcases/lib/run_tests.sh
> +++ b/testcases/lib/run_tests.sh
> @@ -14,7 +14,7 @@ for i in shell_loader.sh shell_loader_all_filesystems.sh shell_loader_no_metadat
>  	 shell_loader_wrong_metadata.sh shell_loader_invalid_metadata.sh\
>  	 shell_loader_supported_archs.sh shell_loader_filesystems.sh\
>  	 shell_loader_tcnt.sh shell_loader_kconfigs.sh shell_loader_tags.sh \
> -	 shell_loader_invalid_block.sh; do
> +	 shell_loader_invalid_block.sh shell_loader_c_child.sh; do
>  	echo
>  	echo "*** Running $i ***"
>  	echo
> diff --git a/testcases/lib/tests/.gitignore b/testcases/lib/tests/.gitignore
> index da967c4d6..e9e163d13 100644
> --- a/testcases/lib/tests/.gitignore
> +++ b/testcases/lib/tests/.gitignore
> @@ -4,3 +4,4 @@ shell_test03
>  shell_test04
>  shell_test05
>  shell_test06
> +shell_c_child
> diff --git a/testcases/lib/tests/shell_c_child.c b/testcases/lib/tests/shell_c_child.c
> new file mode 100644
> index 000000000..fda5133a6
> --- /dev/null
> +++ b/testcases/lib/tests/shell_c_child.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Shell test C child example.
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +int main(void)
> +{
> +	tst_reinit();
> +
> +	tst_res(TPASS, "C child works fine!");
> +
> +	return 0;
> +}
> diff --git a/testcases/lib/tests/shell_loader_c_child.sh b/testcases/lib/tests/shell_loader_c_child.sh
> new file mode 100755
> index 000000000..d190be6e2
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_c_child.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +#
> +# ---
> +# doc
> +#
> +# [Description]
> +#
> +# This is an example how to run C child from shell.
> +# ---
> +#
> +# ---
> +# env
> +# {
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +if [ -n "LTP_IPC_PATH" ]; then
> +	tst_res TPASS "LTP_IPC_PATH=$LTP_IPC_PATH!"
> +fi
> +
> +tst_res TINFO "Running C child"
> +shell_c_child

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
