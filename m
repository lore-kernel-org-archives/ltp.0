Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D57BC44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 08:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 013DD3CB27D
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 09:02:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DCFE3CB1A6
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 09:02:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 32EA26008C8
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 09:02:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CEE03368C;
 Thu, 22 Jan 2026 08:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769068930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7RU8J08ZKOyLd8sTcFQmfAPLw3rgHv4qELx9T4HxeAQ=;
 b=mEexXcSfc9Wgew/3Ux0j3iMJImXjGlr0mTVK8jhYGPv9CQT4NIonTtyEt251ZRry/0n+v0
 Am0JLgMvtXvp19qHE+p/0WKce8xNSZ1EKNJYLBnkhz1Vepn5hGJX0LXq7420L14NiqXIsQ
 WOs3pOwz9Der34dBDgxbHF9kXDQu5NU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769068930;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7RU8J08ZKOyLd8sTcFQmfAPLw3rgHv4qELx9T4HxeAQ=;
 b=CB0w8az15ljg5qNt35ihw+pEi7kAXPUUpyogCkQkt+FQQsRoHEVdeSumqmX9FbGqGRxZJP
 IAjA2ZNt8KyBhdBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769068929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7RU8J08ZKOyLd8sTcFQmfAPLw3rgHv4qELx9T4HxeAQ=;
 b=xiZHva2jvR7JVjiTQAtOUJRAr6VGmA/sLYXG3Q3vl/DreggZ0nXOPurd/1+q2h3Ip0JqBa
 XX5g1yxhNGfmD9MoM4gl0ufovqXhMAPMOq5N23QH+dYPebf2QTttV8P1P1xjdSrU5iXZur
 QQYXPSik2UUTS7WnvQtUAIOckWf5rcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769068929;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7RU8J08ZKOyLd8sTcFQmfAPLw3rgHv4qELx9T4HxeAQ=;
 b=H+NiITLrpAI4ct9vEoGKDGYfpyibxoqFB37rZ92Z18xLPOcNzP+tYu1kldEgHTjanUs1Ti
 WNGTVXkowQCSg5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 378293EA63;
 Thu, 22 Jan 2026 08:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PfxwDIHZcWnWTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jan 2026 08:02:09 +0000
Date: Thu, 22 Jan 2026 09:02:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260122080204.GA47888@pevik>
References: <20251101012320.24972-1-wegao@suse.com>
 <20251113015242.799-1-wegao@suse.com>
 <20251113015242.799-2-wegao@suse.com>
 <CAEemH2ckPaOroqTW5q42AqT6=PO1N=6kbpKa2kej=kP8+S36ag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ckPaOroqTW5q42AqT6=PO1N=6kbpKa2kej=kP8+S36ag@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] tst_filesystems01.c: Add test for
 .filesystems
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

> > +       .needs_cmds = (const char *[]) {
> > +               "tune2fs",
> > +               "dumpe2fs",
> > +               NULL
> > +       },

> We need to adjust 'char*[]' to new 'struct tst_cmd[]' since commit 39a284442.

Good point, Li. Wei, will you send v5?

Also whole patchset LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
