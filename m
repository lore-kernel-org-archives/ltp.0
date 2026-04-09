Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3061E9DE64
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 08:09:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49D0A3C682F
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:09:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BF203C0372
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:08:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D171A600700
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:08:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CE9A4EE26;
 Thu,  9 Apr 2026 08:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775722126;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2pOjWszcOMI1QBgSIFuCo9ysPwqhohBt1JojTtAzYQ=;
 b=FRiDBFXURgBCYdLi6Zt2GVHUCP2Tw3Y/pW6cL7JizzBm2GuEn/HGiUy7EcZGskp7e4WssP
 qLFvxCM4xQgihQ1CGhPQvpBcnPkc5HG+q1fkhcxDGJ4wraDy9S/Md1t0Vgg1UB5rR7tkE/
 LHOcJGQLvZTg7G/pBU1TC/G1g8KRLzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775722126;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2pOjWszcOMI1QBgSIFuCo9ysPwqhohBt1JojTtAzYQ=;
 b=+CmlPaOF6dqImGUjSdQRMqh5rPS+/RJFSJdtMipfHB8fZZ2he8NOqVfYp6f4SgTxa7HBex
 nF9GwwOhHn7aW6CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775722126;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2pOjWszcOMI1QBgSIFuCo9ysPwqhohBt1JojTtAzYQ=;
 b=FRiDBFXURgBCYdLi6Zt2GVHUCP2Tw3Y/pW6cL7JizzBm2GuEn/HGiUy7EcZGskp7e4WssP
 qLFvxCM4xQgihQ1CGhPQvpBcnPkc5HG+q1fkhcxDGJ4wraDy9S/Md1t0Vgg1UB5rR7tkE/
 LHOcJGQLvZTg7G/pBU1TC/G1g8KRLzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775722126;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2pOjWszcOMI1QBgSIFuCo9ysPwqhohBt1JojTtAzYQ=;
 b=+CmlPaOF6dqImGUjSdQRMqh5rPS+/RJFSJdtMipfHB8fZZ2he8NOqVfYp6f4SgTxa7HBex
 nF9GwwOhHn7aW6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F8A64A0B3;
 Thu,  9 Apr 2026 08:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ppakCo5e12ngegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Apr 2026 08:08:46 +0000
Date: Thu, 9 Apr 2026 10:08:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260409080840.GA96667@pevik>
References: <20260406133134.17238-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260406133134.17238-1-always.starving0@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] close: remove unused headers and fix minor
 style issues
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

Hi Jinseok,

> Remove unused headers (<stdio.h>, <errno.h>, <sys/stat.h>) from close01.c
> and (<stdio.h>, <sys/stat.h>) from close02.c.

> Also make struct test_case_t static and apply minor style fixes.

Thanks, patch merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
