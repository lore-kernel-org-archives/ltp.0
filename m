Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DFFC433F5
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 10:33:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A842F3C54C9
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 11:33:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 931D23C1044
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 11:33:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D86F1A0091C
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 11:33:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B50471FD38;
 Mon, 29 Nov 2021 10:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638182018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bH7+HRfhZkegvhBJmgLuzNoH5jNFpWJbNKq8GUzsbE=;
 b=FAs9VYtGqQASx4g/SLALIsWIjnYelNMfAlKNPUzIFcdHpU2h5fzxC52jJVsImFLqVkD46/
 jhn/0TuoMuReEWCicGJ7fh9IdXaikL2eslo44Qk3wy5tln4NISPg5DI20pMF9ulqIEXgQ9
 RfR/6oGtxM8avxIq0d7ynIImV38o5/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638182018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2bH7+HRfhZkegvhBJmgLuzNoH5jNFpWJbNKq8GUzsbE=;
 b=aHvZ/qgqKbZpzmzaJfge2cJTveOVpiGqATjqYKaNK6tSAvz93b1VX3+gOr7PLdQybJRFb0
 8AYUD9VZ+Up+nbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7094613B80;
 Mon, 29 Nov 2021 10:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eZJPGYKspGEjdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Nov 2021 10:33:38 +0000
Date: Mon, 29 Nov 2021 11:33:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YaSsgBZnShdzXkp7@pevik>
References: <20211123124348.31073-1-rpalethorpe@suse.com>
 <20211123124348.31073-3-rpalethorpe@suse.com>
 <YZ3nXUuDjePQxOt6@pevik> <YaSov/lABpoDlsXN@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YaSov/lABpoDlsXN@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] doc: Add LTP-003 and LTP-004 static and tst
 API prefix rules
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > BTW It'd be nice to have some check for shell library (maybe shellcheck would be
> > able to do it).

> Actually the check is in the shell library script.
I'm avare only about the check in tst_run() which check that tests are not using
variables starting with TST or _tst_ prefix, which is important.

My remark was about "LTP-003: Externally visible library symbols have the tst_
prefix", which is slightly different think. Not sure if can be scripted, thus
feel free to ignore it.

I have more remarks on shell checking, but post it as a separate thread.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
