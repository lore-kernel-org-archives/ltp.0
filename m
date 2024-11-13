Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B51D637D1
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 23:12:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BD133D6A5F
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 00:12:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20E023C5717
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 00:12:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 515E3228E25
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 00:12:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A8C12115C;
 Wed, 13 Nov 2024 23:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731539522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AwyhfFNxuQ52zUMnvjgYtWLWtttKzMsl0o5Fzr1hYK4=;
 b=IBICwP6U8/toaiixUutQoLDrUdo07Mwhp0YJd94nEKTh/oXJ3483dTQecPt/WewiAdXsmx
 U82+09hO61OGeVFHMEVc/MbSPQu41Olx2KP18y4qVcNevOs5gbxIwGWWigoAIy4bgJl78x
 /dloSI+eL43VBhzrh2dhojRB0pt+jVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731539522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AwyhfFNxuQ52zUMnvjgYtWLWtttKzMsl0o5Fzr1hYK4=;
 b=al1yDtN3ZiBuqxAnFZg3mmm06EAkQDAleD0q2C03f7dGLabhd0ybjeZa6wTQgbeya7jTdt
 sRpjW+c9QPklH7Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IBICwP6U;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=al1yDtN3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731539522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AwyhfFNxuQ52zUMnvjgYtWLWtttKzMsl0o5Fzr1hYK4=;
 b=IBICwP6U8/toaiixUutQoLDrUdo07Mwhp0YJd94nEKTh/oXJ3483dTQecPt/WewiAdXsmx
 U82+09hO61OGeVFHMEVc/MbSPQu41Olx2KP18y4qVcNevOs5gbxIwGWWigoAIy4bgJl78x
 /dloSI+eL43VBhzrh2dhojRB0pt+jVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731539522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AwyhfFNxuQ52zUMnvjgYtWLWtttKzMsl0o5Fzr1hYK4=;
 b=al1yDtN3ZiBuqxAnFZg3mmm06EAkQDAleD0q2C03f7dGLabhd0ybjeZa6wTQgbeya7jTdt
 sRpjW+c9QPklH7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 410AB13301;
 Wed, 13 Nov 2024 23:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id utv4DkIyNWdaLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 Nov 2024 23:12:02 +0000
Date: Thu, 14 Nov 2024 00:11:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241113231156.GA306618@pevik>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-1-e293a8d99cf6@suse.com> <ZzMRKZdtyIbsy0cN@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzMRKZdtyIbsy0cN@wegao>
X-Rspamd-Queue-Id: 5A8C12115C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] Add fallback definitions of LSM syscalls
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

Hi all,

...
> > +#ifdef HAVE_LINUX_LSM_H
> > +#include <linux/lsm.h>
> > +#endif
> I guess s/#endif/#else ?

IMHO this is correct. This guards just <linux/lsm.h> (added in 6.7).
All other fallback definitions are guarded by other checks, because UAPI headers
evolve over time, thus it would not help to guard all fallback definitions just
by HAVE_LINUX_LSM_H. Check other lapi headers, vast majority of those who
include header add fallback definitions will do it this way.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
