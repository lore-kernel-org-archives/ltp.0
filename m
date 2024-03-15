Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9459AC54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 10:31:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 293FF3D0A23
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 11:31:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1798E3CDE00
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 11:31:15 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6522462D1B8
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 11:31:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5612921BC9;
 Fri, 15 Mar 2024 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710498672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efP16KjphPKjahmmrWdr2w4SejGaqs+BGLIbZAN1eaI=;
 b=zFO+AEeAOoA+ZQPX/mEXwSI373Vpmn74J9MJBgb53t4UTqLgMNpw55dMNQReu7FMUFzk17
 xuXcfu3ts2FPC5p44URfSdDPblt5DBCjQmwVThDhJ6vRTxo/1omLC5lAkjBzcdVxxjFEKh
 IkRSq2pEs8SYb6O8Xv1L4AzFJgOEYnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710498672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efP16KjphPKjahmmrWdr2w4SejGaqs+BGLIbZAN1eaI=;
 b=x0lKzZnAw+JAppIHXlx8embodJ46SCTLwkbZ0UHbLh57c+/EeYHyX/QtvkeLCkr8gWKOo/
 9N68gZA9Jbsy64BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710498672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efP16KjphPKjahmmrWdr2w4SejGaqs+BGLIbZAN1eaI=;
 b=zFO+AEeAOoA+ZQPX/mEXwSI373Vpmn74J9MJBgb53t4UTqLgMNpw55dMNQReu7FMUFzk17
 xuXcfu3ts2FPC5p44URfSdDPblt5DBCjQmwVThDhJ6vRTxo/1omLC5lAkjBzcdVxxjFEKh
 IkRSq2pEs8SYb6O8Xv1L4AzFJgOEYnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710498672;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efP16KjphPKjahmmrWdr2w4SejGaqs+BGLIbZAN1eaI=;
 b=x0lKzZnAw+JAppIHXlx8embodJ46SCTLwkbZ0UHbLh57c+/EeYHyX/QtvkeLCkr8gWKOo/
 9N68gZA9Jbsy64BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A83613460;
 Fri, 15 Mar 2024 10:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nwRHCXAj9GX4bQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Mar 2024 10:31:12 +0000
Date: Fri, 15 Mar 2024 11:31:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240315103110.GA181874@pevik>
References: <20240306104609.17141-1-wegao@suse.com>
 <20240308083220.19332-1-wegao@suse.com>
 <bf366ebf-dc06-46bc-9a16-bf4831f785ca@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf366ebf-dc06-46bc-9a16-bf4831f785ca@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zFO+AEeA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x0lKzZnA
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.85 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.14)[67.92%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5612921BC9
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] safe_macros.c: set umask to 0 within safe_mount
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

Hi Martin, Wei,

> Hi,
> the doc change is not needed. For the lib change alone:

+1. Merged only change in the library, reworded commit message.

Thanks to both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
