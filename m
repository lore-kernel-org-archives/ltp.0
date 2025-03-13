Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D020C282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 09:36:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 060A53CA4ED
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 10:36:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21A953C0574
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:35:46 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 81C3E60066C
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:35:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8241621192;
 Thu, 13 Mar 2025 09:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741858544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMs3TzS08U6zRyXb1IDYUq1EAAgZzfkVPwAiWcc4yPE=;
 b=JObcwbvNx+le5cdGkDtn9wL29FbcX+jiNwPcqtfU3fq7bSHREJPp39tU22z3gdo+GdUlo0
 glAnhB9gWFiaCWig2xlFsr1wTJJkgLOWQtRc943KIT34adKIOcb5XCelvffVeHDbXIWuQU
 IUdNVlN/WZlUlWzl+tSO8/fcH46yGDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741858544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMs3TzS08U6zRyXb1IDYUq1EAAgZzfkVPwAiWcc4yPE=;
 b=kp8NKBh+Rhxpo/E8S0yoKtAIAQTKM4485QG+5OFwjc3uwn6bC12D6YdL7t2BcbDyi/dCoF
 3MdiNoeTUnUJssCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741858544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMs3TzS08U6zRyXb1IDYUq1EAAgZzfkVPwAiWcc4yPE=;
 b=JObcwbvNx+le5cdGkDtn9wL29FbcX+jiNwPcqtfU3fq7bSHREJPp39tU22z3gdo+GdUlo0
 glAnhB9gWFiaCWig2xlFsr1wTJJkgLOWQtRc943KIT34adKIOcb5XCelvffVeHDbXIWuQU
 IUdNVlN/WZlUlWzl+tSO8/fcH46yGDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741858544;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMs3TzS08U6zRyXb1IDYUq1EAAgZzfkVPwAiWcc4yPE=;
 b=kp8NKBh+Rhxpo/E8S0yoKtAIAQTKM4485QG+5OFwjc3uwn6bC12D6YdL7t2BcbDyi/dCoF
 3MdiNoeTUnUJssCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77A79137BA;
 Thu, 13 Mar 2025 09:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hj7gHPCm0mdpOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 13 Mar 2025 09:35:44 +0000
Date: Thu, 13 Mar 2025 10:35:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <20250313093543.GA135222@pevik>
References: <20250312092809.1668719-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250312092809.1668719-1-lufei@uniontech.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unshare01: add EINVAL check
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

Hi lufei,

Please next time have a look on other tests, if the same thing is already
being tested or not.  EINVAL is already tested in unshare02.c (as -1).

That's why is this patch not needed (if really high value should be tested,
which I don't think so, it should be in unshare02.c).

Also, we try to not mixing positive tests (e.g. CLONE_FILES) with negative ones
(e.g. EINVAL), we put negative to separate test.

> ---
>  testcases/kernel/syscalls/unshare/unshare01.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

> diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
> index 6e6315b11..ce1ed2e14 100644
> --- a/testcases/kernel/syscalls/unshare/unshare01.c
> +++ b/testcases/kernel/syscalls/unshare/unshare01.c
> @@ -28,21 +28,30 @@
>  #include "config.h"

>  #ifdef HAVE_UNSHARE
> +#define INV_FLAG 0x0123
> +

>  static struct test_case_t {
>  	int mode;
>  	const char *desc;
> +	const int eno;
nit: "eno" is not much descriptive, we usually use exp_errno.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
