Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33EDC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 12:22:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DF5E3CF964
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 13:22:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 446353C8E42
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:21:56 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7132A1001858
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 13:21:56 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC97C22040;
 Tue, 30 Jan 2024 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ls1vlbZDTsQLUufyq0ABKd1feXUgNEL5/7THjAuMjM=;
 b=AifPd8W0DkXYjFP1GNjcM4Ac2Jbq5qx9tTykkpCjLHrRWT0aOApTRXmJr+NWgjH+wShH2W
 QrMqKI9fS2fGFMLTYlaYB4xAzQ0UEsQiEm3d+986ZJxeipnIDKcKGXGN6oZ0PQAfg9AFKp
 Gq1i5fKjjbCF+mkXOPnjoFvd73wwP1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ls1vlbZDTsQLUufyq0ABKd1feXUgNEL5/7THjAuMjM=;
 b=AYyXuZOnWvmEpV81Coly1404N3iuzR2ZFUgs06nsP1mQ004Kb/moW+FUicqknb4invbD38
 tgNgSbmeMnpOaXBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706617315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ls1vlbZDTsQLUufyq0ABKd1feXUgNEL5/7THjAuMjM=;
 b=AifPd8W0DkXYjFP1GNjcM4Ac2Jbq5qx9tTykkpCjLHrRWT0aOApTRXmJr+NWgjH+wShH2W
 QrMqKI9fS2fGFMLTYlaYB4xAzQ0UEsQiEm3d+986ZJxeipnIDKcKGXGN6oZ0PQAfg9AFKp
 Gq1i5fKjjbCF+mkXOPnjoFvd73wwP1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706617315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ls1vlbZDTsQLUufyq0ABKd1feXUgNEL5/7THjAuMjM=;
 b=AYyXuZOnWvmEpV81Coly1404N3iuzR2ZFUgs06nsP1mQ004Kb/moW+FUicqknb4invbD38
 tgNgSbmeMnpOaXBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A57313462;
 Tue, 30 Jan 2024 12:21:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Tl9EIOPpuGU8GwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 12:21:55 +0000
Date: Tue, 30 Jan 2024 13:21:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
Message-ID: <20240130122154.GD766274@pevik>
References: <20240111012650.9731-1-wegao@suse.com>
 <20240117080446.9663-1-wegao@suse.com>
 <20240117094921.GE2665992@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117094921.GE2665992@pevik>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AifPd8W0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AYyXuZOn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.85 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.14)[67.95%]
X-Rspamd-Queue-Id: AC97C22040
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add TST_EXP_FAIL_PTR
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Wei,

> subject should be: "lib: TST_EXP_{FAIL,PASS}_PTR"
I'm sorry, I did not concentrate enough. It was supposed to be

"lib: Add TST_EXP_FAIL_PTR{,_ARR}"

Kind regards,
Petr

> (can be changed before merge)

> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Thanks for adding a library test.

> If you send a patch for a test which actually uses these, we can merge it before
> the release. Otherwise I would wait for the merge after the release.

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
