Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D9DCCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 10:12:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90B943CE343
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 12:12:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6103C8330
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 12:12:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3D5A1400985
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 12:12:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 959821F44F;
 Tue,  7 Oct 2025 10:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759831933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2jPwPE1zr4mCooz0xJwiTfagLwKnD77IQIkUu5SN+c=;
 b=2Jj/XreQ8dFQXDQT5ucOfnCCBGA5+DUn9eAlp2w+KtCjruSP+1AmhofxatZxaAdXg63ubJ
 HjzRU1GlubP6p7BELkEX61C0eeTYJVvNGdEAcNX6JVcn7LbrfqfqcqiM7npVGcGaWgVOXw
 397DmfUoSyK8HLC1VarV1QctUd6OGGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759831933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2jPwPE1zr4mCooz0xJwiTfagLwKnD77IQIkUu5SN+c=;
 b=Vj6VKFJQX4IO97+GT/gLvtXS9lOyjscq4zQWTpUUzW76EPRLwuF+22gc69U6s6ossq7xQ+
 cbBDCsulxaenCxBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759831932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2jPwPE1zr4mCooz0xJwiTfagLwKnD77IQIkUu5SN+c=;
 b=p10azSI3OWgmtoAhkCJSGRcAn+XkagPRrBAxMIRmjbVkonys1nSsm1rpY2+Jb0hWe4I1GV
 g2ti3GVqP6om2MCSs0CdUkhrBx3ZcxeYuRkjJwLwIyCw2VmZS+TunYkU9njLUBxBAR8rSj
 c3kP1E0WHsi/NzSreVzHcZCzAManVGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759831932;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B2jPwPE1zr4mCooz0xJwiTfagLwKnD77IQIkUu5SN+c=;
 b=R8BUCwmRhVW3G57I10Cpa9TrqetyxZxT7IXKzCLfo2h4mb+vzuk3xGFjR1YkurQOpG132z
 ExOlgk3R6BJH6GCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A42013AAC;
 Tue,  7 Oct 2025 10:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id trYgHHzn5GhkXQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Oct 2025 10:12:12 +0000
Date: Tue, 7 Oct 2025 12:13:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aOTnruayNBq5JYDK@yuki.lan>
References: <20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com>
 <20251007083814.GA109182@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007083814.GA109182@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove TODO
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > TODO file is not updated and it talks about goals we already reached via
> > new LTP documentation. In general, it contains generic and random topics
> > which none is updating anymore, so it's better to remove it in order to
> > create less confusion for new comers. If we really want to have a TODO
> > list, probably the best place would be doc/ folder.
> 
> I vote to have it. So yes, update it and convert it to REST format and move to
> doc/.

Well the TODO list points in there are mostly generic and are not going
to be finished anytime soon. E.g. "write more syscall tests" I'm not
sure how useful such documentation will be. Maybe we need a "where to
start" guide for a new devs, but I'm afraid that it would have to be
written from scratch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
