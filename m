Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A033C4708C
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 16:14:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C08CC3CDBD4
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 17:14:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B93E43CC165
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 17:14:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 416CA60007C
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 17:14:29 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8175F21C56;
 Tue,  6 Dec 2022 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670343269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvyk3tI2nPaIFsBTyRaWJT4qjM2u327zGai2a5sg70g=;
 b=CmDGtiwoXhH8AYf/3AcCri0sOL1j+GbUheKlHy9xo1QLxqDR7EXymnhrY/E+SVNU1PL/L4
 2A6yOTO2X9yIYTlSOAfbSnDChUYIxAqf9PjnnkKk3uRvKURIjMkbxhNTc1QES/EowjR0TO
 UtAaBr2cZdfItVZ8Gz74JJ0UEDQVCNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670343269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvyk3tI2nPaIFsBTyRaWJT4qjM2u327zGai2a5sg70g=;
 b=2uphq6sFBACFDWyqLFiDqrQqh9Ukd+Q4m3dr7AoI6lbmcm04dekP31CE0Hbm9eLwbAO1pX
 XZB0sXZTTumiFwBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 55D4C132F3;
 Tue,  6 Dec 2022 16:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id MqqXD2Vqj2OsXwAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Tue, 06 Dec 2022 16:14:29 +0000
Date: Tue, 6 Dec 2022 17:15:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y49qssvWl2g+rvOu@yuki>
References: <20221206115329.17760-1-rpalethorpe@suse.com>
 <20221206115329.17760-2-rpalethorpe@suse.com>
 <Y49EjvZHd1npsXS7@rei> <87edtctuos.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87edtctuos.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fill_fs: Ensure written data is not easily
 compressed
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
> I suppose that instead of writing random lengths we could just copy
> /dev/urandom to <path> in static chunks of a reasonable size.

Actually it would make sense to do random length writes as well, at
least for a subset of files. I guess that in real life scenario we would
encounter both, block writes and randomly sized writes for files.

I would do something as:

#define BLOCK_SIZE 4096

..
	char buf[2*BLOCK_SIZE];

	fd = SAFE_OPEN("/dev/urandom", O_RDONLY);
	SAFE_READ(1, fd, buf, sizeof(buf));
	SAFE_CLOSE(fd);

	...

	random_size = random() % 2;

	while (len) {
		if (random_size)
			len = random() % BOCK_SIZE;
		else
			len = BLOCK_SIZE;

		off = random() % BLOCK_SIZE;

		ret = write(fd, buf + off, len);

	...


But feel free to implement anything that you find sensible.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
