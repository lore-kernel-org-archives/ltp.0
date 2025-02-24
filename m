Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0360AC021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 16:46:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA0453C99F5
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 17:46:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1795F3C990A
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:45:58 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 57C87609185
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 17:45:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 356302116B;
 Mon, 24 Feb 2025 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740415557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6S1e528udetUwfiDPLYpCQ0qRsM0eOlAdRmq02TLxhE=;
 b=vtQDbyevNMTmBZUrHOxCkdfSg1880S0x0AZymJdi+ED3aUs7Tm6vd+l5XPxggZgb9xLjwv
 4Zy+DllPkrXe2GlrkTHDBNj/scWSrJOjCXKyrgMR8LFTrMtj8mSkdaUBuPgFJYHCi71SwS
 uiVIbWYYBexf52cDI284Ae5FtFFC+Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740415557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6S1e528udetUwfiDPLYpCQ0qRsM0eOlAdRmq02TLxhE=;
 b=eUNXH6gjouaXpkWXJ7OHvWJ9NUlyqnydaLIGPBHizttJgtTIVwgh2iS7lirMub1C+zki1B
 vV2Dn1ZsLOq1A5BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vtQDbyev;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eUNXH6gj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740415557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6S1e528udetUwfiDPLYpCQ0qRsM0eOlAdRmq02TLxhE=;
 b=vtQDbyevNMTmBZUrHOxCkdfSg1880S0x0AZymJdi+ED3aUs7Tm6vd+l5XPxggZgb9xLjwv
 4Zy+DllPkrXe2GlrkTHDBNj/scWSrJOjCXKyrgMR8LFTrMtj8mSkdaUBuPgFJYHCi71SwS
 uiVIbWYYBexf52cDI284Ae5FtFFC+Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740415557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6S1e528udetUwfiDPLYpCQ0qRsM0eOlAdRmq02TLxhE=;
 b=eUNXH6gjouaXpkWXJ7OHvWJ9NUlyqnydaLIGPBHizttJgtTIVwgh2iS7lirMub1C+zki1B
 vV2Dn1ZsLOq1A5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F29713332;
 Mon, 24 Feb 2025 16:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oQKCBUWivGefdAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 24 Feb 2025 16:45:57 +0000
Date: Mon, 24 Feb 2025 17:46:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z7yiUCEMtgIT6lV9@yuki.lan>
References: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
 <20250207-mmap_suite_refactoring-v1-2-d006d921e4d5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250207-mmap_suite_refactoring-v1-2-d006d921e4d5@suse.com>
X-Rspamd-Queue-Id: 356302116B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/8] Refactor mmap10 test
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
>  #ifdef HAVE_DECL_MADV_MERGEABLE
>  	if (opt_ksm) {
> -		if (madvise(x, SIZE + SIZE - ps, MADV_MERGEABLE) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "madvise");
> +		if (madvise(memory, SIZE + SIZE - page_sz, MADV_MERGEABLE) == -1)
> +			tst_brk(TBROK | TERRNO, "madvise error");

We do have MADV_MERGEABLE in lapi/mmap.h I suppose that we can get rid
of the ifdefs as the kernel functionality was included in 2.6.32 which
is way older than anything we support now.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.options = (struct tst_option[]) {
> +		{"a", &opt_anon, "Test anonymous pages"},
> +		{"s", &opt_ksm, "Add to KSM regions"},
> +		{}

Can we get rid of these options too?

I do not see a reason why this cannot implement four different testcases
and that are executed in a row.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
