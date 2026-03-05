Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49085F33A6B
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 14:09:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89A2C3C2CA3
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 15:09:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 614923C2CC6
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 15:09:08 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B53A01A00A41
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 15:09:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23B4F216CF;
 Thu,  5 Mar 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 133583EA68;
 Thu,  5 Mar 2026 14:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NnjNA4COqWnfXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 05 Mar 2026 14:09:04 +0000
Date: Thu, 5 Mar 2026 15:09:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aamOijT3cpbg89yj@yuki.lan>
References: <20260304-fork_refactoring-v2-0-016c47c90bc1@suse.com>
 <20260304-fork_refactoring-v2-1-016c47c90bc1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304-fork_refactoring-v2-1-016c47c90bc1@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 23B4F216CF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] syscalls: refactor fork09 using new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> - * ALGORITHM
> - *	Parent opens a maximum number of files
> - *	Child closes one and attempts to open another, it should be
> - *	available

This is different description than the new one below.

> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include <unistd.h>		/* for _SC_OPEN_MAX */
> -#include "test.h"
> -#include "tso_safe_macros.h"
> -
> -char *TCID = "fork09";
> -int TST_TOTAL = 1;
> +/*\
> + * Verify that a forked child can close all the files which have been open by
> + * the parent process.
> + */

Which is a different assertion from what the test did before.

I would keep the code we have after the conversion but we should close a
file in the child and ten open another one before we attemp to close all
the files in the child.

> +	tst_res(TINFO, "Opening files from parent");
> +
> +	for (nfiles = 0; nfiles < file_open_max; nfiles++) {
> +		memset(name, 0, PATH_MAX);

I wonder what is this memset() needed for?

snprintf() always terminates the string

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
