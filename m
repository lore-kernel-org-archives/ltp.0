Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8354C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 08:32:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B07583CDB94
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 10:32:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EB413C8658
 for <ltp@lists.linux.it>; Tue,  7 May 2024 10:31:48 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 480CD6216DC
 for <ltp@lists.linux.it>; Tue,  7 May 2024 10:31:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D71833BB3;
 Tue,  7 May 2024 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715070707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGlw6t+uhfRl6/yBqDxjkBhTdxms0MprjdGVvwR7u/E=;
 b=rUem5S+e1m8IytQQUKoIGhyDXFBmhVWA1R2CS7mKzojz97J0rWAk0y95wEpeXzXHxfLvPe
 VHajZc17APt0fbJ31jt+Cqss5yB9ApQkFcQHjSzlO3jq4rh59PO/l7f68lh+nOpiJKj9Cp
 ztfUEz1KjDc7m+3d6+0wlvecMn2Z9Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715070707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGlw6t+uhfRl6/yBqDxjkBhTdxms0MprjdGVvwR7u/E=;
 b=FFqC9zUKJAblrBA5O/D6mSxr0/LiW5qc/+Hyq/SIkyikPslGrPLh6qXDVV5it4RECxdMC3
 DZv0Z7iuC9CLYkDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715070707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGlw6t+uhfRl6/yBqDxjkBhTdxms0MprjdGVvwR7u/E=;
 b=rUem5S+e1m8IytQQUKoIGhyDXFBmhVWA1R2CS7mKzojz97J0rWAk0y95wEpeXzXHxfLvPe
 VHajZc17APt0fbJ31jt+Cqss5yB9ApQkFcQHjSzlO3jq4rh59PO/l7f68lh+nOpiJKj9Cp
 ztfUEz1KjDc7m+3d6+0wlvecMn2Z9Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715070707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JGlw6t+uhfRl6/yBqDxjkBhTdxms0MprjdGVvwR7u/E=;
 b=FFqC9zUKJAblrBA5O/D6mSxr0/LiW5qc/+Hyq/SIkyikPslGrPLh6qXDVV5it4RECxdMC3
 DZv0Z7iuC9CLYkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B948139CB;
 Tue,  7 May 2024 08:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id isN3GfPmOWaDOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 08:31:47 +0000
Date: Tue, 7 May 2024 10:31:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240507083146.GD90516@pevik>
References: <20240426042851.333269-1-pvorel@suse.cz>
 <3b2f3b29-153f-4921-bd51-cc32d2749881@suse.com>
 <CAEemH2dzzZp5kMF5cQPQQ=Z-Eb55JkEtqvh2E8UOt6UOE7gr7w@mail.gmail.com>
 <20240426182557.GD6871@pevik>
 <2a1c0336-c383-41e8-a42d-ba29511cdb17@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a1c0336-c383-41e8-a42d-ba29511cdb17@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
Subject: Re: [LTP] [PATCH 1/1] doc: libltpswap: Add kerneldoc
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

Hi Andrea, Li,

> Hi!

> LGTM with fix

Thanks for your review, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
