Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEB1E68958
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 06:46:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21B1E3CBBBC
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 07:46:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05BCA3CBB14
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 07:46:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 69BD31440BC1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 07:46:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B41E1F806;
 Thu, 31 Oct 2024 06:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730357165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1ZnB6oachhndTzDwL8pcW1jVA781QjixLONciyW+1E=;
 b=svuzKSTpvTSQ/c64PsSWVIdbmKkmgbTCyL9rKzQQ0N1ho8FBEXi5L897GAxGV4Qiaolu0k
 Qy4+tDppNx88hZuXmCAghAfM37VVwgfnJJZgdH6Lc1nWYMKeUOf0iFMlJZa3A5jauxQkNK
 yH9+fuY/GCSeMFoht+rziksYkxjaTtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730357165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1ZnB6oachhndTzDwL8pcW1jVA781QjixLONciyW+1E=;
 b=Xb3NO5tsDA8QQsUFxQtEpaodQeUOvE9WY4KXijPQwnhNrZ6LepNOwmMD5nDHPC+HHXDOrS
 ws4/2X8PbBSGR4Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730357164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1ZnB6oachhndTzDwL8pcW1jVA781QjixLONciyW+1E=;
 b=2wdZR1Eq+QETvAEFI6Va4fwUR9qWeiCPrtHCKM0tewNiOtkSjbndEl89cPTlNYv/Ri10Nx
 oYViTLulKkOTC7mjbnU3scuwl6Fb5X8xflTzRlPo4mbiGqXQAOOJMENVksOao2yLnHFXfa
 Q3dFyyYMZSIhq2T0LStMIbIEdy4Hn2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730357164;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1ZnB6oachhndTzDwL8pcW1jVA781QjixLONciyW+1E=;
 b=UyAiSTvbzUvRp5Oa51K3eZFTWmwh9yX292/liYtHZB6bRgBb3RK9+Nfa4grIeWvO2JwSKX
 Ud4xJsA+A7Re+aAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ECB7136A5;
 Thu, 31 Oct 2024 06:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /HOVHawnI2fHegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Oct 2024 06:46:04 +0000
Date: Thu, 31 Oct 2024 07:45:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <20241031064548.GA970568@pevik>
References: <20241030214534.539684-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030214534.539684-1-raj.khem@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-0.997]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_attr: Do not define for glibc >= 2.41
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

Hi Khem,

> +/* sched_attr is not defined in glibc < 2.41 */
> +#ifndef SCHED_ATTR_SIZE_VER0

Thank you for the fix.

This is faster than traditional AC_CHECK_MEMBERS(struct sched_attr) check,
that's why I merged it. I suppose once musl adds the struct it also adds
SCHED_ATTR_SIZE_VER0. If not we will need to use AC_CHECK_MEMBERS check.

Bionic uses kernel headers anyway, thus it will work.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
