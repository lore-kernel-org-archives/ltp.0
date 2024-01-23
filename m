Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC92C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 08:37:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A53AF3CC926
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 09:37:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EAA43CC17F
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 09:37:02 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0C0711002026
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 09:37:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 676501FD41;
 Tue, 23 Jan 2024 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705999020;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i5Icr6q+IiBVTGHdUbXDr7KhkLJxEAwpAagiS0H5g1c=;
 b=AjzyuVVHLdlhWNhbddy+iaUe1Qka/4y7IX8XkzspuKPz/Pg6NjTI7etNm9JvL/8uLpMyay
 dxEhm38tjai+KDFzu1rPAMYgFS1itVrh+gVRrO2B0wWMH/LLnJmoB1d94apxLJIHKaa+bH
 HMuh6kcVHe0691h9X4EUq0sdrOSx+Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705999020;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i5Icr6q+IiBVTGHdUbXDr7KhkLJxEAwpAagiS0H5g1c=;
 b=huM4SdEQZUTlEKkJ3Js1T/lKxv0cZQLCCNFS5KL+BoD6/1BFPkZjeU8sJwinILAG1lijsB
 sfI1DJ/Kb9DRAyAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705999020;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i5Icr6q+IiBVTGHdUbXDr7KhkLJxEAwpAagiS0H5g1c=;
 b=AjzyuVVHLdlhWNhbddy+iaUe1Qka/4y7IX8XkzspuKPz/Pg6NjTI7etNm9JvL/8uLpMyay
 dxEhm38tjai+KDFzu1rPAMYgFS1itVrh+gVRrO2B0wWMH/LLnJmoB1d94apxLJIHKaa+bH
 HMuh6kcVHe0691h9X4EUq0sdrOSx+Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705999020;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i5Icr6q+IiBVTGHdUbXDr7KhkLJxEAwpAagiS0H5g1c=;
 b=huM4SdEQZUTlEKkJ3Js1T/lKxv0cZQLCCNFS5KL+BoD6/1BFPkZjeU8sJwinILAG1lijsB
 sfI1DJ/Kb9DRAyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AB8213786;
 Tue, 23 Jan 2024 08:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6BWIEax6r2UhdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 08:37:00 +0000
Date: Tue, 23 Jan 2024 09:36:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240123083654.GA149835@pevik>
References: <20240109065904.18117-1-wegao@suse.com>
 <20240123021928.9721-1-wegao@suse.com>
 <20240123021928.9721-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240123021928.9721-2-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AjzyuVVH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=huM4SdEQ
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[44.02%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 676501FD41
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] lib: Add .ulimit
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

> Fixs: #530
^ typo, it should have been

Fixes: #530

Fortunately github formats properly even there is a typo:
https://github.com/pevik/ltp/commit/2e6289d26c325db796cde27765b6765217541d24

But it would not close the ticket.
Also people sometimes do 'git log --grep=Fixes:' to see changes.

...
> diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
> index db16be36e..e3891d5e8 100644
> --- a/doc/C-Test-API.asciidoc
> +++ b/doc/C-Test-API.asciidoc
> @@ -2426,6 +2426,24 @@ Test can be skipped on various conditions: on enabled SecureBoot
>  ('.skip_in_secureboot = 1'), lockdown ('.skip_in_lockdown = 1') or in 32-bit
>  compat mode ('.skip_in_compat = 1').

> +1.43 Set resource limits
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +'.ulimit' allows to set resource limits on particular resource. NOTE: It sets 'rlim_max'
> +only if it's higher than 'rlim_cur'.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static struct tst_test test = {
> +	...
> +	.ulimit = (const struct tst_ulimit_val[]) {
> +		{RLIMIT_STACK, RLIM_INFINITY},
> +		{}
> +	},
> +};
Here is missing separator, which is required to end formatting, otherwise page
would be horribly broken:
-------------------------------------------------------------------------------

Have look at my fork how it looks like and please, next time test formatting of
doc changes yourself in your fork (preview is enough to see the problems):
https://github.com/pevik/ltp/wiki/TEST#143-set-resource-limits

Both issues can be fixed before merge.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Unless Cyril or Li acks this to be merged before the release, it will be merged
after the release (not a fix).

Kind regards,
Petr

> +
>  2. Common problems
>  ------------------
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
