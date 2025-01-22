Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA576C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 11:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CDAF3C2E01
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 12:02:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85AE73C2BA8
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 12:01:55 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35AC0237B73
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 12:01:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D786F1F7BA;
 Wed, 22 Jan 2025 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737543713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mv5X4l3TeQ8ldhQRzJwXDsct+vZLqbhcyhtDEjlf6yQ=;
 b=R+9SbCCowk41F3V7DbQTafR0BN5ThotMN/MIgT/859+01LPsPOEmWbUdvMAMK50PZCp7zg
 9Q3XtaDQGm40vsE/Z/hoHSFG+3llIv5WIsRKcdXLP+7Tr56R/mjBartLTAj/2LeEL/o7Px
 hSLUbXQtsFdpSRrPUeu7yMPaNtt4yZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737543713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mv5X4l3TeQ8ldhQRzJwXDsct+vZLqbhcyhtDEjlf6yQ=;
 b=+0phfZyz3IxTFUjT9Wm7EkPGKN7sRoI/I4IZC3rvnBKUudgRIGEVN0FFr4idFKjJHovrCd
 PMrblNALTXtzqzAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737543712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mv5X4l3TeQ8ldhQRzJwXDsct+vZLqbhcyhtDEjlf6yQ=;
 b=lUX0erHvkPv1F2gn7r8y9u6j7k8ikiKqM3U/JOgT1vmRXUrHAUEuPOOTiwaE3/mr12fv6q
 pYcYSr4cKnVcgpmLlamHsNxGuyak8SO9haZcq6ltmiKi9WGnxuB4OdqTHMZNw4Vix5kJky
 8IyhGE1TJIKNXtRgGOLuyrUFWNHC760=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737543712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mv5X4l3TeQ8ldhQRzJwXDsct+vZLqbhcyhtDEjlf6yQ=;
 b=UhnjWy3jufPIwHcIIUgKzRvAcnm4ZSXXAsPlixN7CDtrhLtCQ8TANNsgDdWcoDor77BxSE
 24pq/Ce0OvF4EECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C90ED136A1;
 Wed, 22 Jan 2025 11:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tA8uMCDQkGeAAQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 22 Jan 2025 11:01:52 +0000
Date: Wed, 22 Jan 2025 12:01:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z5DQFuQiIAGAqtK4@yuki.lan>
References: <20250122100915.3126008-1-svens@linux.ibm.com>
 <20250122102648.GA29598@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250122102648.GA29598@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap01: initialize buffer in check_file()
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
Cc: Sven Schnelle <svens@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > mmap01 reported random test failures. Turns out the
> > the temporary buffer in check_file() isn't initialized.
> > The SAFE_READ reads less then sizeof(buf) bytes so the
> > rest stays initialized and might contain bytes check_file()
> > is looking for.
> 
> Looks reasonable to me.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> @Cyril a candidate for merge before the release.

Alternatively we could use the return value from the SAFE_READ() instead
of the buf_len. Also I suppose that we could check that we read at least
something.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
