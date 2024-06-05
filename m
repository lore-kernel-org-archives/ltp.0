Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33569C27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:23:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783FB3D09A3
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 15:23:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0977B3D0988
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:23:28 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ED6DE20EB43
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:23:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0221F1F80B;
 Wed,  5 Jun 2024 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717593807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iEI/OTuuzdRKWPUUrjsAQMdM4vH+Ou+UhKEbSYKAtU=;
 b=AIr6okHF2b4D5sWrJ20Pu7d8fES7Dth505C33bYz49pzj7/nyPbeC1Hnr8Htdj3QECtvlB
 X28cXtiDpezLlIi0KUx18ZFjP0p32BHb4wF7m+LAQoO4tMcvh6m3cEHwnynf2V00vw6OzU
 cNtJGgwU9GZpuVW/csI5S+ZpmUj5PwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717593807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iEI/OTuuzdRKWPUUrjsAQMdM4vH+Ou+UhKEbSYKAtU=;
 b=XEBI6kW3DHlqtW1L3qfbWHAeD2ctTf1stLKDQKSGFwKi6ugK3sTtJj+ckINljXD/llT91i
 kSRj+8bdGqBMMMDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AIr6okHF;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XEBI6kW3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717593807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iEI/OTuuzdRKWPUUrjsAQMdM4vH+Ou+UhKEbSYKAtU=;
 b=AIr6okHF2b4D5sWrJ20Pu7d8fES7Dth505C33bYz49pzj7/nyPbeC1Hnr8Htdj3QECtvlB
 X28cXtiDpezLlIi0KUx18ZFjP0p32BHb4wF7m+LAQoO4tMcvh6m3cEHwnynf2V00vw6OzU
 cNtJGgwU9GZpuVW/csI5S+ZpmUj5PwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717593807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iEI/OTuuzdRKWPUUrjsAQMdM4vH+Ou+UhKEbSYKAtU=;
 b=XEBI6kW3DHlqtW1L3qfbWHAeD2ctTf1stLKDQKSGFwKi6ugK3sTtJj+ckINljXD/llT91i
 kSRj+8bdGqBMMMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E3E13AA1;
 Wed,  5 Jun 2024 13:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Raf4Ks5mYGZCHQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 13:23:26 +0000
Date: Wed, 5 Jun 2024 15:23:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>, sebastian.chlad@suse.com,
 schlad@suse.de, ltp@lists.linux.it
Message-ID: <20240605132325.GB393734@pevik>
References: <CAJCsO8fTwOsVwhCdBksStaPVjXHBi8m3g+_b-ZAnKByUR3cqyA@mail.gmail.com>
 <20240603124653.31967-1-akumar@suse.de>
 <20240605071101.GC348321@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605071101.GC348321@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0221F1F80B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unlink09: Fix open syscall flags
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

Hi all,

just to document, we agreed in discussion of alternative patch, that more fixes
are needed, thus setting this in patchwork as changes requested.

https://lore.kernel.org/ltp/ad6558e0-e834-4b35-923a-7b519384f436@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
