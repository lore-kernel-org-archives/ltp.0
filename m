Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40C0C88E53
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 19:24:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3B583EA4A8
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 21:24:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E21E63E96CB
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 21:24:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B520B600AAC
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 21:24:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D3D8721C46;
 Fri, 11 Sep 2026 19:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789154670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emH64KnlyGa24N69izHkKhgXDLS41k/e2/Vbyaw1XLo=;
 b=1iVHRjYj1SwPq3G4mB4fgwZN03oSlcofdu5FOSuh9HmWSDqhfxLBQZZgo4OXUPZLSTed1t
 9ezuffU9TnD9jZZcgQEElNx+DrenqOfYPpf7crsrHMhCUcrlOKa1fTngDgs5h+iWaBJt+4
 BZ0LV//nCJWeESVJzI92ZLLsYl4F3co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789154670;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emH64KnlyGa24N69izHkKhgXDLS41k/e2/Vbyaw1XLo=;
 b=CpAkjiDJz2XsZSGk4nuT0w2sKzI87X2qkH8aZMikQ0Fhnc/IJC1QbTUAk4WYyqOKQgw1GM
 8IrMp4GDpacDV3Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QpPEYMV9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zeuqtaEu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789154665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emH64KnlyGa24N69izHkKhgXDLS41k/e2/Vbyaw1XLo=;
 b=QpPEYMV9uGNxKu/UL1csLA1oulayMAmchm3mc6WZqZdUVarq0YXVrvGxgmbP/0oxdXivB4
 nMFKDopEUbD+TTcJQA8Wm6DQR2t4YM18sUQgQkcThokaqzBF7BYUPXyn3POdyk4mFPIrHv
 ZQr51hQBToD7Xv7NtABZshfDALBgerI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789154665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emH64KnlyGa24N69izHkKhgXDLS41k/e2/Vbyaw1XLo=;
 b=zeuqtaEuycPIafqAZzO1txml5Qp5AgZ2/fwg2hc0MZigtAL5V9ZXnL1tvVd4eBr/YSBbdw
 echbp/KtQnVQO7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BC113715;
 Fri, 11 Sep 2026 19:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BmI1MWhVpGoSKQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 19:24:24 +0000
Date: Fri, 11 Sep 2026 21:24:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260911192418.GA274129@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-7-43b78b15ef9f@suse.com>
 <aqO53U7noZHaIDj1@yuki.lan> <20260911091110.GB1435339@pevik>
 <aqQfc9EcNWtYscjY@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aqQfc9EcNWtYscjY@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D3D8721C46
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 07/33] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


> Hi!
> > > TST_EXP_POSITIVE()?

> > Well, it would not help much because Andrea wanted to use tst_brk().
> > I've been thinking for a while to add TST_EXP_*_BRK() variants.

> > Therefore it would need to check the result anyway:

> > TST_EXP_POSITIVE(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0));
> > if (TST_PASS)
> > 	tst_brk(TBROK | TTERRNO, "KEYCTL_GET_SECURITY failed");

> > (And I ignore that we don't have TST_EXP_POSITIVE_SILENT() and probably we don't
> > want to call TST_EXP_POSITIVE_() to make it quiet on TPASS).

> Why can't we just do:

> 	TST_EXP_POSITIVE(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0));
> 	if (!TST_PASS)
> 		return;

Right, return would work here as well. And generally it would work unless code
is more structured (i.e. test macro is not directly in .test_all/.test function.
That should eliminate many of TST_*_BRK() potential use.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
