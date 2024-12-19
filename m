Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62C1E77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 14:18:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 594E33ED45E
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 15:18:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7E3F3E4EFC
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 15:17:59 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54473636633
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 15:17:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 156661F44B;
 Thu, 19 Dec 2024 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734617878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/y88HiMTvgwZs7dWnaJmrfnoJI76+QoUoGBp+1KOd6Q=;
 b=AbhCnGgd7Sbz3glAge0m6hDGeUYCDreSLAvdsz8jKbiRdS8gGLEOO20uKAGXrDzjhSxrvx
 +fSUrJNA7SCsPKUqi5GHfm0XkU0SHxOatZK+W0+9EBji/SfOhpldX12bxO9ohZNfjJEQW1
 +VMp5mAjwrHs7QR50kppIRKuJL0uBAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734617878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/y88HiMTvgwZs7dWnaJmrfnoJI76+QoUoGBp+1KOd6Q=;
 b=ozHdKdh75doIS25lO8zUWhrvCuBB1k4SVPVovN75L99n8v9gfHF2QGFSkW7ygdtWkK6GtC
 rA8VplABok9pBvDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AbhCnGgd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ozHdKdh7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734617878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/y88HiMTvgwZs7dWnaJmrfnoJI76+QoUoGBp+1KOd6Q=;
 b=AbhCnGgd7Sbz3glAge0m6hDGeUYCDreSLAvdsz8jKbiRdS8gGLEOO20uKAGXrDzjhSxrvx
 +fSUrJNA7SCsPKUqi5GHfm0XkU0SHxOatZK+W0+9EBji/SfOhpldX12bxO9ohZNfjJEQW1
 +VMp5mAjwrHs7QR50kppIRKuJL0uBAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734617878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/y88HiMTvgwZs7dWnaJmrfnoJI76+QoUoGBp+1KOd6Q=;
 b=ozHdKdh75doIS25lO8zUWhrvCuBB1k4SVPVovN75L99n8v9gfHF2QGFSkW7ygdtWkK6GtC
 rA8VplABok9pBvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC08113A77;
 Thu, 19 Dec 2024 14:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IMe/NhUrZGc5JgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 19 Dec 2024 14:17:57 +0000
Date: Thu, 19 Dec 2024 15:17:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241219141756.GD115746@pevik>
References: <20241218190029.15015-1-chrubis@suse.cz>
 <20241218190029.15015-10-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218190029.15015-10-chrubis@suse.cz>
X-Rspamd-Queue-Id: 156661F44B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 9/9] metadata: parse.sh: Add
 -Itestcases/kernel/include
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

Hi Cyril,

> This does not completely fix macro expansions without the patchset I've
> send that removes the mess in testcases/kernel/mem/{lib,include}/
> library because before the patchset some headers e.g. the ksm_helper.h
> was included indirectly from the testcases/kernel/mem/include/mem.h
> header.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I'll have look on the other patchset tomorrow.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
