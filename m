Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EBFD1BDC0
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 16:20:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E07D63D0DA0
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 17:20:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B91153D0DBF
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 17:20:08 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 395F21BCAEED
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 17:20:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6DE4521BFA;
 Mon,  4 Nov 2024 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730737206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmpCpXGwkBBsuGC7nSvxZcsFreqexEk/4SQ/Prwab8E=;
 b=Z+WuzsfU4B6LtTjcmpzKgZ5gPQcewGKt4ugBNoQOPXtuHzsMna2TbTzv1x2eM8quEWCVDg
 Aq4AP2lEIi5nSvpW0UrbMyKmflxuQmGPtA/Wlg7RhCk3RTjZf2MAOhYS38UwLXe56noEMM
 HiFHtCqdvopGsETkFGKdRyfcBkUOKes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730737206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmpCpXGwkBBsuGC7nSvxZcsFreqexEk/4SQ/Prwab8E=;
 b=nssFGlkbVnYqKW793exq0JnyGrDE0Id9gisWP7sO8+fy6glR4r30edRJBPcnTMKpVUXNpS
 +kBzwsBKsTn/WBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730737206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmpCpXGwkBBsuGC7nSvxZcsFreqexEk/4SQ/Prwab8E=;
 b=Z+WuzsfU4B6LtTjcmpzKgZ5gPQcewGKt4ugBNoQOPXtuHzsMna2TbTzv1x2eM8quEWCVDg
 Aq4AP2lEIi5nSvpW0UrbMyKmflxuQmGPtA/Wlg7RhCk3RTjZf2MAOhYS38UwLXe56noEMM
 HiFHtCqdvopGsETkFGKdRyfcBkUOKes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730737206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmpCpXGwkBBsuGC7nSvxZcsFreqexEk/4SQ/Prwab8E=;
 b=nssFGlkbVnYqKW793exq0JnyGrDE0Id9gisWP7sO8+fy6glR4r30edRJBPcnTMKpVUXNpS
 +kBzwsBKsTn/WBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54FB913503;
 Mon,  4 Nov 2024 16:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d5OVEzb0KGfWJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Nov 2024 16:20:06 +0000
Date: Mon, 4 Nov 2024 17:20:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241104162000.GB1416606@pevik>
References: <20240918100344.21316-1-wegao@suse.com>
 <20240925035756.14873-1-wegao@suse.com>
 <20241015193958.GC46536@pevik> <Zw8vZlmv2R0BngBY@wegao.216.228.5>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zw8vZlmv2R0BngBY@wegao.216.228.5>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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

Hi Wei, all,

we agreed that ftp01.sh can be removed and this happen [1], thus setting this
in patchwork "Not applicable". Also there is an issue for other FTP tests.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/b8531debea4f08c7c97927eb16c0152549d2ab0a
[2] https://github.com/linux-test-project/ltp/issues/1207

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
