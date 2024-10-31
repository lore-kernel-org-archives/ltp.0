Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA8FD767CE
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 13:58:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53A1B3CC0C8
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 14:58:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1EAE3CC0AE
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 14:58:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD110218392
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 14:58:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E636E21D3E;
 Thu, 31 Oct 2024 13:58:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C212C13A53;
 Thu, 31 Oct 2024 13:58:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 77tMLv+MI2f0AgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Oct 2024 13:58:23 +0000
Date: Thu, 31 Oct 2024 14:58:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241031135814.GB1049242@pevik>
References: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
 <20241031-generate_syscalls-v7-2-f3e26c06814e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031-generate_syscalls-v7-2-f3e26c06814e@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: E636E21D3E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] Add script to generate arch(s) dependant
 syscalls
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

> --- /dev/null
> +++ b/include/lapi/syscalls/generate_arch.sh
> @@ -0,0 +1,211 @@
> +#!/bin/sh
Also here would be nice to use -eu (I know it's a script originated from
elsewhere)...

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# This is an adaptation of the update-tables.sh script, included in the
> +# syscalls-table project (https://github.com/hrw/syscalls-table) and released
> +# under the MIT license.
> +#
> +# Author: Andrea Cervesato <andrea.cervesato@suse.com>
> +
> +KERNELSRC="$1"

... but that would require instead of this to check like this before using $1:

if [ $# -eq 0 ]
	echo "Please provide kernel sources:"
	echo ""
	echo "$0 path/to/Linux/kernel/sources"
	echo ""
	exit 1
fi

Also running with dash I get failures:

$ ./include/lapi/syscalls/generate_arch.sh ../linux
...
grep: /tmp/tmp.sVfa08a9De/headers/usr/include/asm/unistd*.h: No such file or directory
grep: /tmp/tmp.sVfa08a9De/headers/usr/include/asm-generic/unistd.h: No such file or directory
./include/lapi/syscalls/generate_arch.sh: 73: [: 64: unexpected operator
./include/lapi/syscalls/generate_arch.sh: 85: /tmp/tmp.sVfa08a9De/list-syscalls: not found
grep: /tmp/tmp.sVfa08a9De/headers/usr/include/asm/unistd*.h: No such file or directory
grep: /tmp/tmp.sVfa08a9De/headers/usr/include/asm-generic/unistd.h: No such file or directory
./include/lapi/syscalls/generate_arch.sh: 73: [: 32: unexpected operator
./include/lapi/syscalls/generate_arch.sh: 85: /tmp/tmp.sVfa08a9De/list-syscalls: not found
grep: /tmp/tmp.sVfa08a9De/headers/usr/include/asm/unistd*.h: No such file or directory
grep: /tmp/tmp.sVfa08a9De/headers/usr/include/asm-generic/unistd.h: No such file or directory
./include/lapi/syscalls/generate_arch.sh: 73: [: 32: unexpected operator
/tmp/tmp.sVfa08a9De/list-syscalls.c: In function 'main':
/tmp/tmp.sVfa08a9De/list-syscalls.c:11:32: warning: missing terminating " character
   11 |                         printf("_llseek %d
      |                                ^
/tmp/tmp.sVfa08a9De/list-syscalls.c:12:1: warning: missing terminating " character
   12 | ", __NR__llseek);
      | ^

That fails in generate_table on:
if [ $bits == 32 ]; then

When I use "!/bin/sh -eux" I see:

make -s -C /home/foo/sources/linux ARCH=alpha O=/tmp/tmp.G3HzE6EnFu/headers headers_install
grep: /tmp/tmp.G3HzE6EnFu/headers/usr/include/asm/unistd*.h: No such file or directory

This looks like it requires to have build kernel before running this script,
right? (I have 6.12-rc4 in the kernel directory). As a result of running the
script are empty include/lapi/syscalls/*.in files.

Again, it can be a combination of some problem with my environment (some
variable set or shell setup) + dash as /bin/sh. Changing script to /bin/bash
fixes everything. It would be nice if anybody test it with installed dash and
!#/bin/dash in both scripts.

And successful run changes include/lapi/syscalls/arm.in:

+++ include/lapi/syscalls/arm.in
@@ -1,406 +1,415 @@
-restart_syscall (__NR_SYSCALL_BASE+  0)
-exit (__NR_SYSCALL_BASE+  1)
-fork (__NR_SYSCALL_BASE+  2)
-read (__NR_SYSCALL_BASE+  3)
...
+restart_syscall 0
+exit 1
+fork 2
+read 3
+write 4

Maybe we could update syscalls with generate_arch.sh after we merge this?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
