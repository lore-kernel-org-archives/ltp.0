Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E87CC021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 13:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F4763C8FEA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 14:33:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6FD23C8E99
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 14:33:26 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2034F11F3C43
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 14:33:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C03DE1F83D;
 Fri, 21 Feb 2025 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740144804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WgE0lg82HxnRc3AQ9HMcqV8QzSe8NzYuFqEIPOzX4w=;
 b=lX59hDFqkoIJBmNDKmwuujKZ+bfwrgnaCxCM34Pn0Av3Va4/FqEf0NSanSgl5LaTvm3b9m
 kMrHDzJOA78h9cHtIOXmWjoh1K1MNFvsdlygd07942J54BxJ9j0OYqLo0w8+C9FdgYamNA
 1EeKUPTIVkuiZmoYsMYLlTWi4YLh02Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740144804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WgE0lg82HxnRc3AQ9HMcqV8QzSe8NzYuFqEIPOzX4w=;
 b=PujX2M06rwW2IFmuhdRt7Odm60EH7xV94pFEzZmTNgqWp5HGUb2VAMmODZ6r+XbOcdt5w3
 8rKGiI1AJTQNq5AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740144804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WgE0lg82HxnRc3AQ9HMcqV8QzSe8NzYuFqEIPOzX4w=;
 b=lX59hDFqkoIJBmNDKmwuujKZ+bfwrgnaCxCM34Pn0Av3Va4/FqEf0NSanSgl5LaTvm3b9m
 kMrHDzJOA78h9cHtIOXmWjoh1K1MNFvsdlygd07942J54BxJ9j0OYqLo0w8+C9FdgYamNA
 1EeKUPTIVkuiZmoYsMYLlTWi4YLh02Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740144804;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WgE0lg82HxnRc3AQ9HMcqV8QzSe8NzYuFqEIPOzX4w=;
 b=PujX2M06rwW2IFmuhdRt7Odm60EH7xV94pFEzZmTNgqWp5HGUb2VAMmODZ6r+XbOcdt5w3
 8rKGiI1AJTQNq5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34C46136AD;
 Fri, 21 Feb 2025 13:33:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WqaRCqSAuGf+dAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 13:33:24 +0000
Date: Fri, 21 Feb 2025 14:33:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250221133318.GA2791283@pevik>
References: <20250221121344.2778278-1-pvorel@suse.cz>
 <Z7h8ABTkW3C2ysWZ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z7h8ABTkW3C2ysWZ@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email,suse.com:url,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lsmod01.sh: Whitelist zcrypt
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
Cc: Takashi Iwai <tiwai@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > Fixes: https://bugzilla.suse.com/show_bug.cgi?id=1237399

> I read the bug, I guess that there isn't anything better than doing
> this.

> > Suggested-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/commands/lsmod/lsmod01.sh | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)

> > diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
> > index 8b7a0a7943..1fe399aa06 100755
> > --- a/testcases/commands/lsmod/lsmod01.sh
> > +++ b/testcases/commands/lsmod/lsmod01.sh
> > @@ -14,6 +14,9 @@ TST_NEEDS_CMDS="lsmod"

> >  module_inserted=

> > +# zcrypt has higher refcnt

> Maybe a bit better description:

> # lsmod triggers zcrypt refcount increase if it links against libssl
> # which uses hardware acceleration

Thanks! Merged with this change.

Kind regards,
Petr

> Other than that:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
