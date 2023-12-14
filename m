Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA845C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 09:40:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C8263CF4B4
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 10:40:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06C5A3CB3BC
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 10:40:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 370BF602A14
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 10:40:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3A391F7B9;
 Thu, 14 Dec 2023 09:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702546800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H8K2x2S3Z1dAYAtJaLUiGQul8hu7pFl0lP6D5IzJw7c=;
 b=fXNnhCBtdBJSDrMfZdufjmxhc/YD9cyIiYT7uhZXP6wTShWeKtJ0NXH+ZXvAWJgTYTap4f
 kQAnXnybN9Q4sASJZMMqasWudTsq1iAchvovr92N8mLEfD4EWhqNnyqM0LPID3aW5nLVBI
 q9sl3gFDC934Bl35jKx3s30/+FVlnPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702546800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H8K2x2S3Z1dAYAtJaLUiGQul8hu7pFl0lP6D5IzJw7c=;
 b=Zvc3OgZ+KBrgGunDLIqoUACxjFawiGL7AJ3BEoot1uS4DQ76JnvNFfgpd4AD4KUc6JFP0E
 b/G41WL61L8oJkCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702546800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H8K2x2S3Z1dAYAtJaLUiGQul8hu7pFl0lP6D5IzJw7c=;
 b=fXNnhCBtdBJSDrMfZdufjmxhc/YD9cyIiYT7uhZXP6wTShWeKtJ0NXH+ZXvAWJgTYTap4f
 kQAnXnybN9Q4sASJZMMqasWudTsq1iAchvovr92N8mLEfD4EWhqNnyqM0LPID3aW5nLVBI
 q9sl3gFDC934Bl35jKx3s30/+FVlnPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702546800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H8K2x2S3Z1dAYAtJaLUiGQul8hu7pFl0lP6D5IzJw7c=;
 b=Zvc3OgZ+KBrgGunDLIqoUACxjFawiGL7AJ3BEoot1uS4DQ76JnvNFfgpd4AD4KUc6JFP0E
 b/G41WL61L8oJkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D16301379A;
 Thu, 14 Dec 2023 09:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GY5OMW/NemXGTQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 14 Dec 2023 09:39:59 +0000
Date: Thu, 14 Dec 2023 10:39:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZXrNXP5IJoUausna@rei>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-3-pvorel@suse.cz> <ZXoC6LUE8ePDPRIU@rei>
 <20231213234827.GC774490@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213234827.GC774490@pevik>
X-Spamd-Result: default: False [0.20 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[44.19%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] lib: Add support for TDEBUG tst_res() flag
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Maybe this should now be called -d since we call it TDEBUG and that will
> > avoid having a bit confusing parameters with both -v and -V used.
> 
> Also, I have forgotten, I would prefer to enable TDEBUG messages also via
> environment variable (e.g. TST_ENABLE_DEBUG). This will be easier for openQA and
> possibly other testing frameworks to rerun runtest with debug info (-d is enough
> to run locally, but it would require to change runtest to add it to particular
> test, but exporting variable will work on unmodified sources).

Sure.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
