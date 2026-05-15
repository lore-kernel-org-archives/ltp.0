Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7F3CD4851
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 07:10:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17E063E590B
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 09:10:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15A263C5493
 for <ltp@lists.linux.it>; Fri, 15 May 2026 09:10:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 836081400DAE
 for <ltp@lists.linux.it>; Fri, 15 May 2026 09:10:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EFAA6B409
 for <ltp@lists.linux.it>; Fri, 15 May 2026 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778829027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puuxAOBgvBJ8ERI5l8MNk17YPS+6AcqGXsRhrfGN/X8=;
 b=WW5MV3rO77M0wma+VNgkESeSJcxOOLZHzaEYahO2MaukJGSIsgEHNBNDcVMMu3i1UdmaO2
 22ivyd8jewOFAhb8Dnlf6Wl4lnGNViBmwVcyiAdKkqPLT8n0Yi5YpoaNSa3FTuYZOxraYo
 i8vUuKz1Fe+mKvtfGN2ebj+cpKwA0ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778829027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puuxAOBgvBJ8ERI5l8MNk17YPS+6AcqGXsRhrfGN/X8=;
 b=p9L89sP1mot0bI/jBH/E/GB/ty94OR+QW1Ob1NJ7TLeGxsz4ERztRKhO6B7gBapSek18V6
 BUC0CFXTS2Cpr+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778829027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puuxAOBgvBJ8ERI5l8MNk17YPS+6AcqGXsRhrfGN/X8=;
 b=WW5MV3rO77M0wma+VNgkESeSJcxOOLZHzaEYahO2MaukJGSIsgEHNBNDcVMMu3i1UdmaO2
 22ivyd8jewOFAhb8Dnlf6Wl4lnGNViBmwVcyiAdKkqPLT8n0Yi5YpoaNSa3FTuYZOxraYo
 i8vUuKz1Fe+mKvtfGN2ebj+cpKwA0ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778829027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puuxAOBgvBJ8ERI5l8MNk17YPS+6AcqGXsRhrfGN/X8=;
 b=p9L89sP1mot0bI/jBH/E/GB/ty94OR+QW1Ob1NJ7TLeGxsz4ERztRKhO6B7gBapSek18V6
 BUC0CFXTS2Cpr+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54F53593A9
 for <ltp@lists.linux.it>; Fri, 15 May 2026 07:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kvA9E+PGBmqxYQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 15 May 2026 07:10:27 +0000
Date: Fri, 15 May 2026 09:10:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <agbG09eqwUp9Uwf8@rei.lan>
References: <afNbfCcv83zeMsgZ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afNbfCcv83zeMsgZ@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,rei.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Given that we have a SUSE Labs konference in the week starting 18. May I
> would like to start LTP May release preparations a bit sooner.

If you have anything that isn't a bugfix and should go to the release
please point it out ASAP. I would like to start with the freeze and
pre-release testing starting next week.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
