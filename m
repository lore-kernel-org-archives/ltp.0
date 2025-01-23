Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE290C0218B
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 15:13:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CFEF3C4E21
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 16:13:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C2F03C4CAD
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 16:13:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A05811BE66DA
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 16:13:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AEEE81F365;
 Thu, 23 Jan 2025 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737645208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GymMNmZUeQbYYqZKGLO/jI7tXgKmtS6Xq9P0f0pRHJQ=;
 b=ACsknAeAxY5fR0my6P7xI+Ie7d3CPOLo31C3+kHdgDej4H9aRiWBEZWz5ltS3tGdVkSK+T
 2EkeHbg5+AVCXKRyke59+mvnIPYULLgxk3YXN7GP88BVWXt6M0Lx1b4Y4faHEmGhdN/3s/
 1fbYhqA4osG7ekLU+JUqHiG/HvIe7fc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737645208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GymMNmZUeQbYYqZKGLO/jI7tXgKmtS6Xq9P0f0pRHJQ=;
 b=IUFaQ7mkH/yd52eYeMQ9TnPsKLRSy0ZmetxvvywlQytbA8kJz3gkd7SrX5FCR/qlhbQKRZ
 tYO2xYIiiB3bPyDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737645207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GymMNmZUeQbYYqZKGLO/jI7tXgKmtS6Xq9P0f0pRHJQ=;
 b=hnjobIZ9cpshTt3vKELYfDzQws1MJYXtTvEGRs+BuwiSwe2y2bx3M0/YgI5T9pMHTM5hA6
 JvapANNpEWEyQcu+qrop1Q30Iobi6FgYEMR527GiselHX72t26m0DMNWGGbxkTnRP2pGuK
 dDiQZRl9Lem/n9x/pj3EhOhoNC1CyJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737645207;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GymMNmZUeQbYYqZKGLO/jI7tXgKmtS6Xq9P0f0pRHJQ=;
 b=noquvJCshWj6nfcWUS63gvQUNctzNxwtm0FwWvN1W6OYGxEdFSfYByMWAPH5Y+4nzS6wTo
 h/2Imol1WKQm/eAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80A08136A1;
 Thu, 23 Jan 2025 15:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HoYfHpdckmfSUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Jan 2025 15:13:27 +0000
Date: Thu, 23 Jan 2025 16:13:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250123151318.GB92460@pevik>
References: <20250122-cyril_script_update_timeouts-v2-0-c29846cc0925@suse.com>
 <Z5IVdjsKwcGqBZa2@yuki.lan> <20250123142325.GA92460@pevik>
 <Z5JYWemZ_-DsF_xL@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z5JYWemZ_-DsF_xL@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Update test timeouts in an automated way
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

> Hi!
> > nit: scripts/calctimeouts.py could have some copyright (not needed).

> Ah right, sorry I tend to forget about that. Should have added GPLv2.0
> or later SPDX in there.

NOTE: license is added there (SPDX-License-Identifier: GPL-2.0-or-later),
that's IMHO required. Copyright (e.g. who created it + year) is IMHO not
required, but good to be added.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
