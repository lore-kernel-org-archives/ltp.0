Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF276CCA476
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 11:30:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A20F3CEB86
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 13:30:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2B563CB3AF
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 13:29:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19C2060081A
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 13:29:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEC1B21A07;
 Mon, 13 Oct 2025 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760354989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=olOHkVxk8NPFFXnJanu3Ms3V//hGH5Gen0juoWUyRsc=;
 b=tltCtQ0bidl0xH18mZrUBVp8cGUCbxuXHsQIpF4FEbFH83tu+IlpKgky09KqUaZhBPRV05
 jSWMantQFEcsNczoCgb0NfZTUqEX53vHC3LZd4YFMoDiqB9jehq1DCxu8lJTTA9JlUlCQA
 zX7LDnsHNA1/vTZe4/iIZYq02P7zdkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760354989;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=olOHkVxk8NPFFXnJanu3Ms3V//hGH5Gen0juoWUyRsc=;
 b=rHpDsifp3rlitGcJ4qFppHql2ocK1wTBE0CySDoSgJNdebxH/e2XTVWpUGUE/rzWFGOLl0
 BuXE+o93SJ+EL9Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760354988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=olOHkVxk8NPFFXnJanu3Ms3V//hGH5Gen0juoWUyRsc=;
 b=o64WoLkctm4fnEa5AWkCjV1GCDCNRabBYFvP2EWoUmIscPZrcdxX7DUTjxBWnL0mE0N9Pk
 7Wkmh4rj39nCi3mjzWaOUL1jULYUH7qF2E5tbkRrT5jWHRuYsP9z/QuTJfXBHffuSCtuhd
 a1OomnAkFBhWs8BOn/XeMoK51nlFkLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760354988;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=olOHkVxk8NPFFXnJanu3Ms3V//hGH5Gen0juoWUyRsc=;
 b=p8bMP7hEsPJ/7pRHsuD6P4J2TJWwP9uWAkSfaF+G4jKFBMtgbW1K/k8Z51iKoUkH28qlL4
 mguauoMxMfeh8lDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98E0F1374A;
 Mon, 13 Oct 2025 11:29:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id extlJKzi7Gi2ZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Oct 2025 11:29:48 +0000
Date: Mon, 13 Oct 2025 13:29:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251013112947.GA78221@pevik>
References: <aOODn-CZ7F1A777o@yuki.lan> <20251007143207.27848-1-akumar@suse.de>
 <6213145.lOV4Wx5bFT@thinkpad> <20251007213713.GB160168@pevik>
 <DDH3SBAZQOWD.PPCDX4YW7KBZ@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDH3SBAZQOWD.PPCDX4YW7KBZ@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: update invalid clock id to
 accomodate new auxiliary clock ids
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

Hi 

...
> Maybe we should merge this patch, WDYT?

> Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

FYI I'm waiting for Cyril's ack (he did the review of v1, all the changes are
based on his comment). I suppose he will do it today.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
