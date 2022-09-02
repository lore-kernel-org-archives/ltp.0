Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83801C6FA82
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 22:15:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE6B93CA8E3
	for <ltp@archiver.kernel.org>; Sat,  3 Sep 2022 00:14:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57A5B3C01CC
 for <ltp@lists.linux.it>; Sat,  3 Sep 2022 00:14:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E626F200CF7
 for <ltp@lists.linux.it>; Sat,  3 Sep 2022 00:14:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B79353512D;
 Fri,  2 Sep 2022 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662156881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66DdClu0EOH9ZVYa2FGQ1KlcaRzRm47GeC9E/IsnLWQ=;
 b=joU1vbaNkiee5GKY5TnXGvn1y+D/7PXm9xyb6vtNM5zoW6OT8dRvtnAYy5GuE0/HqmImeR
 TOmAggkjth2r3To8/+p4Y6YOJMIOuHZiBLRunhVd6h6oAiZZsZQysb0kDzdHKxKPRrf/nW
 Wpp1fU9cHBsqVb+fQl9xJsRREush9wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662156881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=66DdClu0EOH9ZVYa2FGQ1KlcaRzRm47GeC9E/IsnLWQ=;
 b=CjyVcPaDRK6RBE+65BeJFCNlWGuFbd1ucOuy0WmWO8e4nR+YPbVGZK8tWvGKMK+plcxHjo
 hZ5w9PN8ndgfqqAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B5A71330E;
 Fri,  2 Sep 2022 22:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QP2YHFGAEmMROAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 02 Sep 2022 22:14:41 +0000
Date: Sat, 3 Sep 2022 00:14:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YxKAT18Z7KWiuA9U@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220902133710.1785-6-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/9] shell: Add $TST_SKIP_FILESYSTEMS + tests
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> C API struct tst_test skip_filesystems member equivalent.

> Now only running on single filesystem (will be improved in the next
> commit)

>  doc/shell-test-api.txt                        |  2 ++
>  .../shell/tst_skip_filesystems.sh             | 35 +++++++++++++++++++
>  .../shell/tst_skip_filesystems_skip.sh        | 17 +++++++++
>  testcases/lib/tst_test.sh                     |  6 ++++
>  4 files changed, 60 insertions(+)
>  create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems.sh
>  create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh

...
> +++ b/lib/newlib_tests/shell/tst_skip_filesystems.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
> +
> +TST_MOUNT_DEVICE=1
> +TST_NEEDS_ROOT=1
> +TST_FS_TYPE=ext4
> +TST_TESTFUNC=test
> +TST_SKIP_FILESYSTEMS="btrfs,ext2,ext3,xfs,vfat,exfat,ntfs,tmpfs"

I suppose I should move this commit after following commit "tst_test.sh:
Introduce TST_FS_TYPE_FUSE" (swap them) so that I can here add "fuse" into
TST_SKIP_FILESYSTEMS.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
