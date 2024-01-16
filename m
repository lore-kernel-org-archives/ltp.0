Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01044C47077
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 16:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F7F23CF0AC
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 17:10:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3854E3C05D8
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 17:10:11 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8BB0100126F
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 17:10:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3989222108;
 Tue, 16 Jan 2024 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705421409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=19NJ5zqjrhehAfBg7QN9Fg5SxLPxMrynlEsBeUm7b4s=;
 b=Vk4MsZnV8En2b7y8ifA0HZ1NK4kh/OBWVv5EaAGhp1rRNjXXpKByizErkgfF4zIw3gkGru
 MbgL38EUi1CIz7D+YrHROtx5tzjI8nVsdy+X5wjGa0ijdXo3Q73nd7tiEnCaOce0xQOs6b
 WgVpnaFPzr/cinZ82SvVbdzBB+TtP4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705421409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=19NJ5zqjrhehAfBg7QN9Fg5SxLPxMrynlEsBeUm7b4s=;
 b=lkNbuX2dteTiFboZze7wOILICDQn0SeUuzSH0fqvGdfhVLsszv336EZUZcb2Lt0u55APIp
 Lf8f3+Ejk52Q7qDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705421409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=19NJ5zqjrhehAfBg7QN9Fg5SxLPxMrynlEsBeUm7b4s=;
 b=Vk4MsZnV8En2b7y8ifA0HZ1NK4kh/OBWVv5EaAGhp1rRNjXXpKByizErkgfF4zIw3gkGru
 MbgL38EUi1CIz7D+YrHROtx5tzjI8nVsdy+X5wjGa0ijdXo3Q73nd7tiEnCaOce0xQOs6b
 WgVpnaFPzr/cinZ82SvVbdzBB+TtP4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705421409;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=19NJ5zqjrhehAfBg7QN9Fg5SxLPxMrynlEsBeUm7b4s=;
 b=lkNbuX2dteTiFboZze7wOILICDQn0SeUuzSH0fqvGdfhVLsszv336EZUZcb2Lt0u55APIp
 Lf8f3+Ejk52Q7qDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2D0F132FA;
 Tue, 16 Jan 2024 16:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EU/jMmCqpmUaGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jan 2024 16:10:08 +0000
Date: Tue, 16 Jan 2024 17:10:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240116161007.GA2606232@pevik>
References: <20240116031728.2500892-1-liwang@redhat.com>
 <00ba5590-fe40-485a-9b3f-6e0950747208@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00ba5590-fe40-485a-9b3f-6e0950747208@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Vk4MsZnV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lkNbuX2d
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[41.35%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3989222108
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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
Cc: jhs@mojatatu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Martin,

thanks for your review, Martin!

> Hi,
> thanks for the fix. I agree that this doesn't need to go into LAPI headers
> since we probably won't add another test for tcindex.

And if yes, we would simply move it to lapi.
Li, please go ahead and merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
