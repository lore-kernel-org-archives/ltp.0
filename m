Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C44E9D416
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 17:00:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2B133CE1B8
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 17:59:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C38D03CB064
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 17:59:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 132111A001D3
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 17:59:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C8885BE24;
 Wed,  4 Feb 2026 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770224380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwG4iaNxSAxNVXmDTi3l2IXMp5T8VgpuwSKl+BcDz3w=;
 b=rvxg2VrNLLCDICwkEoM7vozdVZKULZr42CxYAjZKacsUbvz3cqdFP/8vqgrjRsxT6PUWDI
 IKpC8yaKQwVyUyqO50CmpvIVavaMy0J/NcNdaP8TftRA3i8Ze7GbY52oYw4y53KfR2qe2V
 pOI9Xmpj5xlgOkgHw+gZBQ6YLgRkGP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770224380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwG4iaNxSAxNVXmDTi3l2IXMp5T8VgpuwSKl+BcDz3w=;
 b=Y2+THEu1GNQ5Lk92wNhpO1EDCkIRfynkQfRDuDA5v3zPRgT7vDyyBHylHDLlqEqB0Job/Z
 uxLMvzccRm49VUAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770224380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwG4iaNxSAxNVXmDTi3l2IXMp5T8VgpuwSKl+BcDz3w=;
 b=rvxg2VrNLLCDICwkEoM7vozdVZKULZr42CxYAjZKacsUbvz3cqdFP/8vqgrjRsxT6PUWDI
 IKpC8yaKQwVyUyqO50CmpvIVavaMy0J/NcNdaP8TftRA3i8Ze7GbY52oYw4y53KfR2qe2V
 pOI9Xmpj5xlgOkgHw+gZBQ6YLgRkGP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770224380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwG4iaNxSAxNVXmDTi3l2IXMp5T8VgpuwSKl+BcDz3w=;
 b=Y2+THEu1GNQ5Lk92wNhpO1EDCkIRfynkQfRDuDA5v3zPRgT7vDyyBHylHDLlqEqB0Job/Z
 uxLMvzccRm49VUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 856DC3EA63;
 Wed,  4 Feb 2026 16:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JbHEHvt6g2ljOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 16:59:39 +0000
Date: Wed, 4 Feb 2026 17:59:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260204165938.GA251768@pevik>
References: <20260204115339.224261-1-pvorel@suse.cz>
 <20260204115339.224261-5-pvorel@suse.cz>
 <DG664MTNCKXU.10ZGQ5CGF7DC9@suse.com>
 <20260204124640.GA244528@pevik>
 <DG6814Q4J502.2XCN7VBF3513Q@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DG6814Q4J502.2XCN7VBF3513Q@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[free.fr];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.de,suse.cz,redhat.com,virtuozzo.com,lists.yoctoproject.org,sony.com,free.fr,bootlin.com,linaro.org];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] kirk: Remove runltp-ng symlink
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> > Do you agree with removing 'runltp-ng' symlink?


> In general I would say yes. If we want to keep the `runtltp` script
> name, tho, we can do something like:

> 	install -m 00775 $(abs_srcdir)/kirk-src/kirk $(BASE_DIR)/runltp

> inside the `tools/kirk/Makefile`. In this way we keep the same structure
> of the previous LTP installation, having a script name that is also more
> clear for the regular user. I'm pretty sure a lot of people won't
> understand what `kirk` is, inside the main installation folder.

I'm not sure if kirk installed as runltp would not cause even more confusion.
I'd prefer even not have a symlink.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
