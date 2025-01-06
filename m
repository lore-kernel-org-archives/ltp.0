Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F6AE77198
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 15:16:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BF3D3C4D21
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 16:15:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8334A3C0277
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 16:15:41 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E455C1A09B17
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 16:15:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0478D1F392;
 Mon,  6 Jan 2025 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736176538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SkYGfGCnQ9rlk+1IfRe5pDh+8FjD5LH59LbeKcFjmQ=;
 b=zpm8SM3SQZtKA7CfbbyWEVe41IdmOBZmG1e969xN1RCgOsOLyDij7FnINynH5fXHpL9/++
 h8yRiucRgbqXA+1WHWzSUn9fAwSYzO8xixB+15cYbdatlD+I4jWdJ52dxWi5srvqVLGjF6
 H9KubH2NhXi0dxpsh69OjjUMsttXgmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736176538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SkYGfGCnQ9rlk+1IfRe5pDh+8FjD5LH59LbeKcFjmQ=;
 b=FVSPC0efjOWx2lou0zWpoy/MFQUVTWBORtYappawViQh0yqnmc5fYLMNXxv/vr6WyLzRPJ
 VGBKsL2pi4sim5Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736176538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SkYGfGCnQ9rlk+1IfRe5pDh+8FjD5LH59LbeKcFjmQ=;
 b=zpm8SM3SQZtKA7CfbbyWEVe41IdmOBZmG1e969xN1RCgOsOLyDij7FnINynH5fXHpL9/++
 h8yRiucRgbqXA+1WHWzSUn9fAwSYzO8xixB+15cYbdatlD+I4jWdJ52dxWi5srvqVLGjF6
 H9KubH2NhXi0dxpsh69OjjUMsttXgmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736176538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SkYGfGCnQ9rlk+1IfRe5pDh+8FjD5LH59LbeKcFjmQ=;
 b=FVSPC0efjOWx2lou0zWpoy/MFQUVTWBORtYappawViQh0yqnmc5fYLMNXxv/vr6WyLzRPJ
 VGBKsL2pi4sim5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1D22139AB;
 Mon,  6 Jan 2025 15:15:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m3ghKJnze2dFRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 Jan 2025 15:15:37 +0000
Date: Mon, 6 Jan 2025 16:15:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250106151532.GA328413@pevik>
References: <20250106132607.25627-1-chrubis@suse.cz>
 <20250106132607.25627-7-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106132607.25627-7-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/6] mem/vma05.sh: Convert to the new shell
 library
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

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Thanks for these improvements. Few notes below.

> To run the test from the test directory do:

> PATH=$PATH:$PWD/../../../lib/:$PWD/testcases/lib/:: ./vma05.sh
very nit: safer example would be to have $PATH at the end of the list.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/mem/vma/vma05.sh | 96 ++++++++++++++++---------------
>  1 file changed, 49 insertions(+), 47 deletions(-)

> diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> index e1ef1014e..1876d7663 100755
> --- a/testcases/kernel/mem/vma/vma05.sh
> +++ b/testcases/kernel/mem/vma/vma05.sh
> @@ -1,6 +1,15 @@
>  #!/bin/sh
> +#
>  # SPDX-License-Identifier: GPL-2.0-or-later
> +#
very nit: I would not add these new lines.

>  # Copyright (C) 2017 Red Hat, Inc.
> +# Copyright (C) 2024 Cyril Hrubis <chrubis@suse.cz>
> +#
> +# ---
> +# doc
> +#
> +# [Description]
> +#
>  # Regression test if the vsyscall and vdso VMA regions are reported correctly.

>  # While [vsyscall] is mostly deprecated with newer systems, there is
> @@ -15,58 +24,51 @@
>  # VM_ALWAYSDUMP)). As a consequence of this bug, VMAs were not included
>  # in core dumps which resulted in eg. incomplete backtraces and invalid
>  # core dump files created by gdb.
> +# ---
> +#
> +# ---
> +# env
> +# {
> +#  "needs_root": true,
> +#  "needs_tmpdir": true,
> +#  "needs_cmds": ["gdb"],
Maybe also "uname"?

> +#  "save_restore": [
> +#   ["/proc/sys/kernel/core_pattern", "core", "TBROK"],
> +#   ["/proc/sys/kernel/core_uses_pid", "0", "TBROK"]
> +#  ],
> +#  "tags": [
> +#   ["linux-git", "103efcd9aac1"],
> +#   ["linux-git", "b6558c4a2378"],
> +#   ["linux-git", "e5b97dde514f"]

I wonder how hard to add shell support (with help of ujson) to metadata/metaparse.c.

I created a ticket for it:
https://github.com/linux-test-project/ltp/issues/1216

> +#  ]
> +# }
> +# ---

> -TST_SETUP=setup
> -TST_CLEANUP=cleanup


> -TST_TESTFUNC=vma_report_check
> -TST_NEEDS_ROOT=1
> -TST_NEEDS_TMPDIR=1
> -TST_NEEDS_CMDS="gdb"
> -
> -CORE_LIMIT=$(ulimit -c)
> -CORE_PATTERN=$(cat /proc/sys/kernel/core_pattern)
> -CORE_USES_PID=$(cat /proc/sys/kernel/core_uses_pid)
> -
> -setup()
> -{
> -	ulimit -c unlimited
> -	echo "core" > /proc/sys/kernel/core_pattern
> -	echo 0 > /proc/sys/kernel/core_uses_pid
> -	unset DEBUGINFOD_URLS
> -}
We don't need setup and cleanup at all. But I see we don't have a support for
them in testcases/lib/tst_run_shell.c yet. I might need to add it for
netstress.c.

...

FYI testcases/lib/tests/shell_loader*.sh would deserve SPDX and copyright.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
