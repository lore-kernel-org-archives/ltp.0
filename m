Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9F1CCFA05
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 10:33:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387F03CF028
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 11:33:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F15F33CD279
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:33:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 608DF140111A
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 11:33:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B27A1F461;
 Fri,  7 Nov 2025 10:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWTAOCDNkCwhYA/pweGxf6dyU48ghkOQ7ZUD3G3x9S4=;
 b=bruTcG/WbFd4tGAZxYu5hujHDWF553W+4sen9MORL+X0MEz6Qh+cci1x4l0iWtKe22XCEG
 RBcXjxOYnsoCItrNZLUugpvfepXcdKp2PDMKkC+l5zip69v0itEYxanGc233T/bvvgcdQp
 qOX6SJFNseKFLZgXzDcldvIbV6PVkT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWTAOCDNkCwhYA/pweGxf6dyU48ghkOQ7ZUD3G3x9S4=;
 b=QxKBijfHhx1qYt324AMbQD+tZ3ByI2pJO0IorxeeVeAsvbXhoBu2CZU4kJPVy/YJ1cO4cA
 dKvb0qK3bTEq5aBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762511612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWTAOCDNkCwhYA/pweGxf6dyU48ghkOQ7ZUD3G3x9S4=;
 b=bruTcG/WbFd4tGAZxYu5hujHDWF553W+4sen9MORL+X0MEz6Qh+cci1x4l0iWtKe22XCEG
 RBcXjxOYnsoCItrNZLUugpvfepXcdKp2PDMKkC+l5zip69v0itEYxanGc233T/bvvgcdQp
 qOX6SJFNseKFLZgXzDcldvIbV6PVkT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762511612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aWTAOCDNkCwhYA/pweGxf6dyU48ghkOQ7ZUD3G3x9S4=;
 b=QxKBijfHhx1qYt324AMbQD+tZ3ByI2pJO0IorxeeVeAsvbXhoBu2CZU4kJPVy/YJ1cO4cA
 dKvb0qK3bTEq5aBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 608DE132DD;
 Fri,  7 Nov 2025 10:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id o+NiFfzKDWm1RAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 10:33:32 +0000
Date: Fri, 7 Nov 2025 11:33:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251107103330.GA1088923@pevik>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251107003041.28929-1-wegao@suse.com>
 <20251107003041.28929-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251107003041.28929-2-wegao@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] tst_cmd.c: Check brk_nosupp when
 tst_get_path failed
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

Hi Wei,

> Fixes: 257394e4e3 ("Filter mkfs version in tst_fs")
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_cmd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

> diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
> index 2faf7c743..716029c9b 100644
> --- a/lib/tst_cmd.c
> +++ b/lib/tst_cmd.c
> @@ -265,8 +265,14 @@ bool tst_check_cmd(const char *cmd, const int brk_nosupp)
>  	version_token = strtok_r(NULL, " ", &next);
>  	str = strtok_r(NULL, " ", &next);

> -	if (tst_get_path(cmd_token, path, sizeof(path)))
> -		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +	if (tst_get_path(cmd_token, path, sizeof(path))) {
> +		if (brk_nosupp) {
> +			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +		} else {
> +			tst_resm(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
> +			return 1;

Function now returns 'bool', therefore 'true' or 'false' should be returned.
IMHO this should be false, therefore I resent it:
https://lore.kernel.org/ltp/20251107102939.1111074-3-pvorel@suse.cz/

and set this patch "changes requested".

Also, I found a fix in the change I introduced, therefore send a patch which
fixes it:
https://lore.kernel.org/ltp/20251107102939.1111074-2-pvorel@suse.cz/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
