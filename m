Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E9CCA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:43:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E3BA3CB60C
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 15:43:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E1053C8335
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 15:43:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A7AC560027F
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 15:43:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0CC21F390;
 Tue, 12 Aug 2025 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755006205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHyzL9n/TvyAPwjD154IVgUQ/MphHIolPYpTJmJj4ms=;
 b=QVns2900mHVrT8ZTd1u79hBsVlmPtGeQWgiGud3X4KEjV3GHcYTz2q8ipcec9yaQZ6tXYa
 igtJH7DVDI2UtaFCL5BCw21J5QdMuqkLc/xecWpifA950z5ghYltx+Znqtn9KUcaZpkg4G
 T1u/LEr2tINQpHyBYaXtTgonruMX+pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755006205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHyzL9n/TvyAPwjD154IVgUQ/MphHIolPYpTJmJj4ms=;
 b=wRFGNVCsK7AQ1yHRzj5IKyy02x5vMflpLFBTIjg0/tJC+e604/7hG4a6mEKASQ1F67emLd
 J3SIu4RyCv0XkTAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755006205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHyzL9n/TvyAPwjD154IVgUQ/MphHIolPYpTJmJj4ms=;
 b=QVns2900mHVrT8ZTd1u79hBsVlmPtGeQWgiGud3X4KEjV3GHcYTz2q8ipcec9yaQZ6tXYa
 igtJH7DVDI2UtaFCL5BCw21J5QdMuqkLc/xecWpifA950z5ghYltx+Znqtn9KUcaZpkg4G
 T1u/LEr2tINQpHyBYaXtTgonruMX+pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755006205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fHyzL9n/TvyAPwjD154IVgUQ/MphHIolPYpTJmJj4ms=;
 b=wRFGNVCsK7AQ1yHRzj5IKyy02x5vMflpLFBTIjg0/tJC+e604/7hG4a6mEKASQ1F67emLd
 J3SIu4RyCv0XkTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79BA11378C;
 Tue, 12 Aug 2025 13:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PPo7HP1Em2i+QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 13:43:25 +0000
Date: Tue, 12 Aug 2025 15:43:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250812134316.GA861768@pevik>
References: <20250812-cve_2025_38236-v3-1-48ce90adc216@suse.com>
 <d20c29a5-1852-4eec-964b-5b8f9d1eb851@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d20c29a5-1852-4eec-964b-5b8f9d1eb851@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cve: add CVE-2025-38236 test
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

Hi all,

> I can merge v3, should I add Reviewed-by tag for Cyril and Wei?

I asked Wei to fix leaking file descriptor (I even posted code which fixes it):
./ioctl11 -i2000
ioctl11.c:137: TBROK: open(/proc/self/maps,0,0000) failed: EMFILE (24)

This can be fixed before merge (although v4 is better).

I haven't looked at the new code yet (I'll try to do tomorrow). You don't have
to wait for me, but it would be good if somebody else (Cyril, Li) reviewed the
code before merge.

Kind regards,
Petr

> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
