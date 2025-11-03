Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12EDCCFA05
	for <ltp@archiver.kernel.org>; Mon,  3 Nov 2025 14:58:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2125B3CE0FA
	for <ltp@archiver.kernel.org>; Mon,  3 Nov 2025 15:58:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABD1D3CDF07
 for <ltp@lists.linux.it>; Mon,  3 Nov 2025 15:58:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35E52200927
 for <ltp@lists.linux.it>; Mon,  3 Nov 2025 15:58:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FBE121CB5;
 Mon,  3 Nov 2025 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762181882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rm3vULzzbdOhweYXdRV9CLCIMZwbtsDfSz4t9hFXII=;
 b=E0vuqFZCgLXyETBJwwd/xkvjOlbF0DW1WqtrFHA1PIgYNedNZERR1F+SGKE2WktcnJX6+C
 8D/254OekfvQGKojrS8vlBHGnNFwodMAMwLCqy7klOxRet5PVdV0yiqL5fq4QyvyTbEGVq
 VALpscKpXEF56m4McI4Ff/S1EQkzTTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762181882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rm3vULzzbdOhweYXdRV9CLCIMZwbtsDfSz4t9hFXII=;
 b=Vj1npjUj2zm9hZaysKmFyqo6TseJ7TTUKcIcy1wGss/ziDhf4nxsLSTrp48SEuoOzlNT2k
 P+KtRSFzLhVr6/BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762181882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rm3vULzzbdOhweYXdRV9CLCIMZwbtsDfSz4t9hFXII=;
 b=E0vuqFZCgLXyETBJwwd/xkvjOlbF0DW1WqtrFHA1PIgYNedNZERR1F+SGKE2WktcnJX6+C
 8D/254OekfvQGKojrS8vlBHGnNFwodMAMwLCqy7klOxRet5PVdV0yiqL5fq4QyvyTbEGVq
 VALpscKpXEF56m4McI4Ff/S1EQkzTTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762181882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2rm3vULzzbdOhweYXdRV9CLCIMZwbtsDfSz4t9hFXII=;
 b=Vj1npjUj2zm9hZaysKmFyqo6TseJ7TTUKcIcy1wGss/ziDhf4nxsLSTrp48SEuoOzlNT2k
 P+KtRSFzLhVr6/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 549BD139A9;
 Mon,  3 Nov 2025 14:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id knioEvrCCGk2ewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 03 Nov 2025 14:58:02 +0000
Date: Mon, 3 Nov 2025 15:58:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aQjDJx6c4sC0_P1e@yuki.lan>
References: <20251022095740.8747-1-mdoucha@suse.cz>
 <20251022095740.8747-2-mdoucha@suse.cz> <aQHkSPsLyx4O_VXk@rei>
 <efda5be9-5c28-4371-bb9a-481edb72893c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efda5be9-5c28-4371-bb9a-481edb72893c@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ioctl_sg01: Print buffer contents on failure
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
> I didn't known about tst_res_hexd(). Please merge patch 1 and I'll send 
> patch v2 for the hexdump afterwards.

Too late for that, Petr already merged both, so please send a follow up
that replaces the hexdump function with tst_res_hexd()

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
