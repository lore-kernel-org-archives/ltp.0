Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022F9C27C55
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 09:36:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FD253C132A
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 11:36:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A975D3C132A
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 11:36:27 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 15AE2141605E
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 11:36:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC9171FB92;
 Fri,  7 Jun 2024 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717752985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uON4zXB+4FCWhCINxLf05kqrfQnG1drbFaqu9EoXl3c=;
 b=g4FVB564tjH8vwI3CCIrK6I8YeFmPy0nwqHMp75YWC/5La7vm5Reu6OuCXqmAx6S9k89q6
 6C/La5DS5BlnE/ZKswM5CY1yGsmuuFriWSnWcVwfHLMiKrdhcqv6wVo/rsVrKymtNjVSu2
 HrjX8nARPasc3KLe9TvJ5OWXYpfe28M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717752985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uON4zXB+4FCWhCINxLf05kqrfQnG1drbFaqu9EoXl3c=;
 b=YcPJFsHOuVvxD2lYih5EYE08oDMg7lLucy++qQ3yyrwf5zaqKGqB+uWkxAWY42/oCyxCbo
 ZAWrVVis+3p2awDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g4FVB564;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YcPJFsHO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717752985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uON4zXB+4FCWhCINxLf05kqrfQnG1drbFaqu9EoXl3c=;
 b=g4FVB564tjH8vwI3CCIrK6I8YeFmPy0nwqHMp75YWC/5La7vm5Reu6OuCXqmAx6S9k89q6
 6C/La5DS5BlnE/ZKswM5CY1yGsmuuFriWSnWcVwfHLMiKrdhcqv6wVo/rsVrKymtNjVSu2
 HrjX8nARPasc3KLe9TvJ5OWXYpfe28M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717752985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uON4zXB+4FCWhCINxLf05kqrfQnG1drbFaqu9EoXl3c=;
 b=YcPJFsHOuVvxD2lYih5EYE08oDMg7lLucy++qQ3yyrwf5zaqKGqB+uWkxAWY42/oCyxCbo
 ZAWrVVis+3p2awDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90F2E13A42;
 Fri,  7 Jun 2024 09:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MVmnIpnUYmbAIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Jun 2024 09:36:25 +0000
Date: Fri, 7 Jun 2024 11:36:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Message-ID: <20240607093620.GA55162@pevik>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik>
 <20240605-faithful-illegal-aardwolf-db2edd@lemur>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605-faithful-illegal-aardwolf-db2edd@lemur>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BC9171FB92
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Konstantin,

> On Wed, Jun 05, 2024 at 08:57:55AM GMT, Petr Vorel wrote:
> > > base-commit: 66517b89141fc455ed807f3b95e5260dcf9fb90f
> > I see useful b4 feature :).

> > > change-id: 20240604-unlink09-dc4802f872f9
> > But I wonder what is this for (what tool use change-id).

> This allows you to reliably find all revisions of the same series, for example
> to do range-diffs between them.

Welcome to LTP ML :). Thank you for giving a hint, it forced me to look up your
docs ([1] if anybody interested). BTW it'd be great if patchwork supported it
(somebody asked for something similar [2].

I noticed other things - having version in message-id and having somehow
"encrypted" email part before "at" (@), but keep part after "at" the same looks
interesting. I should find time to explore b4 :).

Kind regards,
Petr

[1] https://b4.docs.kernel.org/en/latest/contributor/prep.html#working-with-series-dependencies
[2] https://github.com/getpatchwork/patchwork/issues/583

> -K

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
