Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 206EBC0218A
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 20:07:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914D73C79FA
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 21:07:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DED13C718E
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 21:07:40 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CC0EF1BC4B62
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 21:07:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0F582116F;
 Thu, 30 Jan 2025 20:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738267658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+bIdYOgXqxaq+Tb7iQckcfAF+U06LgjlJgQc5RyfF4=;
 b=blTLF7j1i+2pXF0WvOSzu/6ydp14FP/JpQd37alxrWdp+Ikk3lOouUtLchilv4LpCbeGOf
 Nha4+j3hgzWT9yeHkUMehZI9gYYxQTsB8tugRxZcUBMhdFAcjqUxCTY+b7EOTVzygyoNr0
 z0JKINZaCzcJb6TVR3IB9FsGPz3rHWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738267658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+bIdYOgXqxaq+Tb7iQckcfAF+U06LgjlJgQc5RyfF4=;
 b=qut7aloGUPqHgjjPZSMZlIoS+syAif6GQ5jI7B+zbcVTKLdhHkWyZ657EVR9E8hjaMbP4E
 v00mm125SCA35MDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738267657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+bIdYOgXqxaq+Tb7iQckcfAF+U06LgjlJgQc5RyfF4=;
 b=iJ+lpkHgvGwtvXOWlX9NARtDK/E+jBmoOvZzZhxXahXq7i2cGV5l1709nozdgoj0SRHXcW
 +vWiohb2R9c5c8xJPLdUMM9ySrgZrgIJYEvxoQ7yvH0zzucZ3mIQb9mFSpN/LBvQoAcf+d
 VELnovhmfwbuL47pz21oD6a0ZKprm7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738267657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+bIdYOgXqxaq+Tb7iQckcfAF+U06LgjlJgQc5RyfF4=;
 b=G4bPT084lzOUnhN9cDLgJRyGOX4VsbNv4LHGbvGEq8eU2T54v4etMya4hdFn9l0WeWfFKP
 fGhl3iGC5s32ytCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A7441366F;
 Thu, 30 Jan 2025 20:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JAsWEwncm2eTUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Jan 2025 20:07:37 +0000
Date: Thu, 30 Jan 2025 21:07:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250130200731.GA513192@pevik>
References: <20250122172440.506677-1-amir73il@gmail.com>
 <20250122205023.GA48906@pevik> <Z5NveZVCczMxwDpP@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z5NveZVCczMxwDpP@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] LTP fanotify tests for v6.13
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > We have git freeze before new release. But IMHO this should go in.
> > It works well on v6.13, I'll retest it on SLES kernels.

> We are going to release LTP next week, I would say that it's not enough
> time to properly test these changes and that the timing was too
> unfortunate this time. I would deffer merging after the release.

LTP was released, therefore merging the tests. Thanks, Amir!

I'm not sure if you plan to split the tests (hopefully you got enough info about
the goal). If not, I or Martin should do it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
