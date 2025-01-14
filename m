Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FAFE77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD2813C7AD6
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 16:55:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 843D03C7AD6
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 16:54:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E753460048E
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 16:54:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2E71F37C;
 Tue, 14 Jan 2025 15:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736870093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYyR/xF4g4yBByTvADFYnJAzeoq5d2eibo1nO8qtrzA=;
 b=egooYIuhzagR4D+ja3HH8wV0Qa4jNQX7S/SEFu6exe/SWIiJ1L6oXVZVXKQEmPe0gNz76z
 TLDizFUnP3csK/MCxVG4B79KQ5zwWKYo70XepLfzdqC6P5dpnhtcF7Yt56L3ZGIFJp6HBS
 0QzFjsJkE/AU9s5peCAywJig/hfJmNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736870093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYyR/xF4g4yBByTvADFYnJAzeoq5d2eibo1nO8qtrzA=;
 b=eFniYcqf1z8G6ilNpUVO7s51nOeYQDOfZESSl2sMXKlwmPi9ueg03qTxRJq8jJ0ac2n4l9
 80XKQG+oOgmPkgAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736870093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYyR/xF4g4yBByTvADFYnJAzeoq5d2eibo1nO8qtrzA=;
 b=egooYIuhzagR4D+ja3HH8wV0Qa4jNQX7S/SEFu6exe/SWIiJ1L6oXVZVXKQEmPe0gNz76z
 TLDizFUnP3csK/MCxVG4B79KQ5zwWKYo70XepLfzdqC6P5dpnhtcF7Yt56L3ZGIFJp6HBS
 0QzFjsJkE/AU9s5peCAywJig/hfJmNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736870093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYyR/xF4g4yBByTvADFYnJAzeoq5d2eibo1nO8qtrzA=;
 b=eFniYcqf1z8G6ilNpUVO7s51nOeYQDOfZESSl2sMXKlwmPi9ueg03qTxRJq8jJ0ac2n4l9
 80XKQG+oOgmPkgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0193A139CB;
 Tue, 14 Jan 2025 15:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NLJvO8yIhmcSfAAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 14 Jan 2025 15:54:52 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Jan 2025 16:54:52 +0100
Message-ID: <6145632.lOV4Wx5bFT@thinkpad>
In-Reply-To: <20241021195521.GA493656@pevik>
References: <20240530144406.7626-1-akumar@suse.de>
 <20240530144846.10915-1-akumar@suse.de> <20241021195521.GA493656@pevik>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 CTE_CASE(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] flock: Add test for verifying EINTR errno
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

On Monday, October 21, 2024 9:55:21 PM CET Petr Vorel wrote:
> Hi Avinesh, Yang Xu,
> 
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ...
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/flock/flock07.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> > + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> > + * Copyright (c) 2024 Linux Test Project
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Verify that flock(2) fails with errno EINTR when waiting to acquire a lock,
> > + * and the call is interrupted by a signal.
> 
> Avinesh, you mentioned at Yang Xu's v1 [1] that EINTR test is getting timed out
> randomly. I also experienced timeouts on aarch64 and ppc64le. v1 had 2 tests
> (EINTR and EWOULDBLOCK), you here posted only EINTR. I would expect you would
> put here only the other one - EWOULDBLOCK. Or am I missing something?
Hi Petr,

I am sorry, I completely missed this.
I sent the patch for EWOULDBLOCK case now -
https://lore.kernel.org/ltp/20250114155013.7644-1-akumar@suse.de/T/#u

Regards,
Avinesh
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/ltp/1934768.7Z3S40VBb9@localhost/
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
