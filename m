Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D55FCDC173
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 12:02:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1F7E3C29B6
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 13:02:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A47943C29B6
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 13:02:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3681600207
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 13:02:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B92BA339E6;
 Tue,  6 Jan 2026 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767700950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=duMbtdx2QnJuH7fmlmlly7g3TWNz8IlQOVzBfDDmvpw=;
 b=HLQr3Jp6GZxXQHg+VigrxahIAhr9hKsOVXX24yKduXosjarEvz9+DmgoSsqBmQupGSgObW
 vm+7p6AYlHlyO9mLCV5WUoSrufV0mTYLdfHMD2v5glUiLud/vKmqPUvcpX6XWCjtoVrLt5
 4IOptcRH/IM082xwoAYg5FWTmIf/DYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767700950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=duMbtdx2QnJuH7fmlmlly7g3TWNz8IlQOVzBfDDmvpw=;
 b=wglRq6IBlmsc/kwfuYx0djnAsd5s6xTN8w/Pt1fumwGR3KBZWE6JEgD2xOxAln2uH4pkIN
 xU4/7Doru7PNBEAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767700950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=duMbtdx2QnJuH7fmlmlly7g3TWNz8IlQOVzBfDDmvpw=;
 b=HLQr3Jp6GZxXQHg+VigrxahIAhr9hKsOVXX24yKduXosjarEvz9+DmgoSsqBmQupGSgObW
 vm+7p6AYlHlyO9mLCV5WUoSrufV0mTYLdfHMD2v5glUiLud/vKmqPUvcpX6XWCjtoVrLt5
 4IOptcRH/IM082xwoAYg5FWTmIf/DYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767700950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=duMbtdx2QnJuH7fmlmlly7g3TWNz8IlQOVzBfDDmvpw=;
 b=wglRq6IBlmsc/kwfuYx0djnAsd5s6xTN8w/Pt1fumwGR3KBZWE6JEgD2xOxAln2uH4pkIN
 xU4/7Doru7PNBEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D7E13EA63;
 Tue,  6 Jan 2026 12:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kyAdHdb5XGlgcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Jan 2026 12:02:30 +0000
Date: Tue, 6 Jan 2026 13:02:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260106120228.GA712536@pevik>
References: <20260105130359.647879-1-pvorel@suse.cz>
 <DFHG4OY28ZPJ.3QDAR7P7FND1Q@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFHG4OY28ZPJ.3QDAR7P7FND1Q@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] make check: b3: Use --strict when run
 checkpatch.pl
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

> Also, please change the commit title, because it's b4, not b3.

Lol, I guess accidental ctrl+x press in vim.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
