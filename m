Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3297CD343F
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 15:58:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41E033E57E8
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 17:58:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC00F3E20C2
 for <ltp@lists.linux.it>; Fri, 15 May 2026 17:58:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F24171A00654
 for <ltp@lists.linux.it>; Fri, 15 May 2026 17:58:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7473F6BCEB;
 Fri, 15 May 2026 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778860696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/7HDQtHDevKPcleRI8tYsJ/VoIIT0ekwK49i1pJIsk=;
 b=EdtkrxzdML3m+voHCzG7MZ29qMTqWf+9dvIkWBTb5z/l+yH61YGXGlWgHVmDt/4DTavz0v
 CzYCGlzIRiQDaJsaDruCIivFT4DqLQpCKU+6VOwKflfRviUPG8MR5cw5L1sU+LteckBtIF
 kDG5J0pHIYBX+LYQc0GDSF5kGey2e/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778860696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/7HDQtHDevKPcleRI8tYsJ/VoIIT0ekwK49i1pJIsk=;
 b=C8g/LBUZE3bak+qkUdvFpDHspq4Krz12VvRJ4C4hmCLp4NoNZnL5zkY3rLlJUbCUTYmMkm
 wao9EMefjKxbs4Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778860696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/7HDQtHDevKPcleRI8tYsJ/VoIIT0ekwK49i1pJIsk=;
 b=EdtkrxzdML3m+voHCzG7MZ29qMTqWf+9dvIkWBTb5z/l+yH61YGXGlWgHVmDt/4DTavz0v
 CzYCGlzIRiQDaJsaDruCIivFT4DqLQpCKU+6VOwKflfRviUPG8MR5cw5L1sU+LteckBtIF
 kDG5J0pHIYBX+LYQc0GDSF5kGey2e/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778860696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/7HDQtHDevKPcleRI8tYsJ/VoIIT0ekwK49i1pJIsk=;
 b=C8g/LBUZE3bak+qkUdvFpDHspq4Krz12VvRJ4C4hmCLp4NoNZnL5zkY3rLlJUbCUTYmMkm
 wao9EMefjKxbs4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E9D593A9;
 Fri, 15 May 2026 15:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RMRpCphCB2qofwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 May 2026 15:58:16 +0000
Date: Fri, 15 May 2026 17:58:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <li.wang@linux.dev>
Message-ID: <20260515155814.GB45497@pevik>
References: <20260505083016.36843-1-li.wang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260505083016.36843-1-li.wang@linux.dev>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: Introduce tst_path_macros.h to
 consolidate system paths
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

Hi Li,

could you please rebase to master and push branch to your fork?
Patch now does not apply:

Description: [v3] lib: Introduce tst_path_macros.h to consolidate system paths
Applying: lib: Introduce tst_path_macros.h to consolidate system paths
error: patch failed: testcases/kernel/syscalls/newuname/newuname01.c:31
error: testcases/kernel/syscalls/newuname/newuname01.c: patch does not apply

Which is strange, I'm trying to apply on 1e619620eda111cbd94672dd5a0e1cc92567b15d~
(prior Cyril's changes to newuname01.c).

Ideally your for always had rebased version.

I suppose metadata will work with it correctly since Cyril's support for macros
in past (i.e. metadata/ltp.json will have "/proc/sys/kernel/hostname", not
PATH_HOSTNAME, which tells nothing to LTP users).

> We have a lot of hardcoded strings and duplicated macros for /proc
> and /sys paths scattered throughout the testcases.

> This patch introduces a new common header, tst_path_macros.h, to centralize
> and standardize these path definitions. By unifying these macros, we
> reduce code duplication, improve maintainability, and ensure consistent
> path usage across the entire LTP codebase.

> Signed-off-by: Li Wang <li.wang@linux.dev>
> ---

> Notes:
>     v3:
>     	* Rename to tst_path_macros.h to reflect its macro-only content.

I slightly prefer the previous name tst_path.h (for me macros are complex
functions, not just simple definitions, what info gives me "macro-only content"?
I care more about the actual content). I'm ok with it current name, but maybe
kernel_paths.h or proc_sys_paths.h would be more obvious which paths is it
about. Also, it's not just about paths, but also about the content in these
/proc|sys files (e.g. "HugePages_Total:").

>     	* Replaced generic string concatenation macros with explicit.
>     	* Manualy built & Tested all touched tests on my c10s vm.

...

> +/* KERNEL */
> +#define PATH_HOSTNAME			"/proc/sys/kernel/hostname"
> +#define PATH_OSRELEASE			"/proc/sys/kernel/osrelease"
...
> +/* USER */
> +#define PATH_MAX_USER_NAMESPACES	"/proc/sys/user/max_user_namespaces"

I have 2 concerns:

1) we often try to have LTP specific 'TST_' prefix to avoid clash with
whatever definition. Is it ok to ignore it now?

2) I'm pretty sure I will have to look into this file often, because from
definition name I have no idea where exactly file is. I'd be ok with long name
TST_PROC_SYS_KERNEL_HOSTNAME, but understand Cyril wants short names. Maybe at
least TST_PATH_KERNEL_HOSTNAME and TST_PATH_USER_MAX_USER_NAMESPACES(last
directory and file)? That would be similar to what sysctl is using:

	sysctl kernel.hostname
	sysctl user.max_user_namespaces

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
