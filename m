Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BF7D5CCB9
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 15:15:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C342C3CB1C5
	for <ltp@archiver.kernel.org>; Wed, 30 Oct 2024 16:15:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2328D3CB1B9
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 16:15:24 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 57675655CDF
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 16:15:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BDD61FDE5;
 Wed, 30 Oct 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82864136A5;
 Wed, 30 Oct 2024 15:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /aTLHopNImfIFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Oct 2024 15:15:22 +0000
Date: Wed, 30 Oct 2024 16:15:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241030151513.GA915069@pevik>
References: <20241030-generate_syscalls-v5-0-eed6a87dc787@suse.com>
 <20241030-generate_syscalls-v5-2-eed6a87dc787@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030-generate_syscalls-v5-2-eed6a87dc787@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9BDD61FDE5
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/3] Add script to generate arch(s) dependant
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


> From: Andrea Cervesato <andrea.cervesato@suse.com>

> Add generate_arch.sh script which can be used to generate arch(s)
> dependant syscalls file. The way it works is pretty simple: for each
> architecture defined into supported-arch.txt, compile kernel headers,
> extract the list of syscalls and generate a .in file containing all of
> them, associated with their own syscall's number.
> The way syscalls files are generated, passes through a C application
> which is automatically checking the availability of the syscalls in
> the user space environment.

Thanks for this!

...
> --- /dev/null
> +++ b/include/lapi/syscalls/generate_arch.sh
> @@ -0,0 +1,211 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# This is an adaptation of the update-tables.sh script, included in the
> +# syscalls-table project (https://github.com/hrw/syscalls-table) and released
> +# under the MIT license.
I was surprised you use shell instead of python, but I see the original author
also use shell [1]. I wish he would have used python for this part, but good
that you reuse what was available.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/include/lapi/syscalls/supported-arch.txt
> @@ -1,13 +1,13 @@
> -aarch64
>  arc
> +arm64
>  arm
> -hppa
>  i386
>  ia64
> -loongarch
> -mips_n32
> -mips_n64
> -mips_o32
> +loongarch64
> +mips64n32
> +mips64
> +mipso32
> +parisc
>  powerpc64
>  powerpc
>  s390x

Interesting enough how many archs the original project supports [2], which makes
sense for it as he products HTML table as reference [3].

Kind regards,
Petr

[1] https://github.com/hrw/syscalls-table/blob/master/scripts/update-tables.sh
[2] https://github.com/hrw/syscalls-table/blob/master/system_calls/architectures_in_kernel.py
[3] https://gpages.juszkiewicz.com.pl/syscalls-table/syscalls.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
