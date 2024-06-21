Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CC6C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 12:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 808E93D0ECB
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 14:47:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586773D0C8B
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:47:43 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1D046003CA
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:47:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1370F1FB74;
 Fri, 21 Jun 2024 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718974060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ktr7FSx3PPT4G47A3wUEU0uukUWS9Rndi1RDLg6uZ44=;
 b=1Rctx5jpnPqSBlcsJKX/fInQy0HjNpG6849wzrLshtsJSb2SRMUehsKvP62M5xVdlRVzOf
 FlToqng0Y26sdFPWE1FF9FwC7CmV5oR3wzga5DGKDPbB29TVDwiQaMH0wEiR+bMuLM0tgX
 uTL/Dk64TTPEu4/ran8ooRvxSGIJnDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718974060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ktr7FSx3PPT4G47A3wUEU0uukUWS9Rndi1RDLg6uZ44=;
 b=7v10OCMxWC/LNTiDBdn/g3oUOACBZ5S1wPsXOT9KT/bIeM/ctCoz2XlnKYyjT37Up85YqC
 MJ+G/jYdHeGggMBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1Rctx5jp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7v10OCMx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718974060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ktr7FSx3PPT4G47A3wUEU0uukUWS9Rndi1RDLg6uZ44=;
 b=1Rctx5jpnPqSBlcsJKX/fInQy0HjNpG6849wzrLshtsJSb2SRMUehsKvP62M5xVdlRVzOf
 FlToqng0Y26sdFPWE1FF9FwC7CmV5oR3wzga5DGKDPbB29TVDwiQaMH0wEiR+bMuLM0tgX
 uTL/Dk64TTPEu4/ran8ooRvxSGIJnDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718974060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ktr7FSx3PPT4G47A3wUEU0uukUWS9Rndi1RDLg6uZ44=;
 b=7v10OCMxWC/LNTiDBdn/g3oUOACBZ5S1wPsXOT9KT/bIeM/ctCoz2XlnKYyjT37Up85YqC
 MJ+G/jYdHeGggMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFC6413ACE;
 Fri, 21 Jun 2024 12:47:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HW0yOWt2dWZpBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jun 2024 12:47:39 +0000
Date: Fri, 21 Jun 2024 14:47:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240621124738.GA689389@pevik>
References: <20240620021635.489505-1-liwang@redhat.com>
 <CAEemH2ctF+3AEZkm4Y+KkcTUgYGM4XD24pkfwdJo=6ynQ-Wgxg@mail.gmail.com>
 <20240620052100.GC537887@pevik>
 <CAEemH2fd-b-apt-ifnAMDcq5ogCD1FJm+rHpq6R_6D9yvxuDbA@mail.gmail.com>
 <CAEemH2dv-LfYvEtD=1F+4wQkXwwvLwVZ8O=sd-VpBicOZhDYog@mail.gmail.com>
 <20240621110320.GB668048@pevik>
 <CAEemH2fJ3MweAWbAy1yatfHE1KNK=NJLv8w3RVsnAJtJ+K-k+w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fJ3MweAWbAy1yatfHE1KNK=NJLv8w3RVsnAJtJ+K-k+w@mail.gmail.com>
X-Rspamd-Queue-Id: 1370F1FB74
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_kconfig: Avoid reporting buffer overflow
 when parsing /proc/cmdline
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

> Hi Petr, All,


> > I'll add macros to my TODO list, working on it sometimes during July.


> The tricky part may be for TFAIL (TBROK) to distinguish from TERRNO or
> TTERRNO in one macro.

>   tst_res(TFAIL, " ")
>   tst_res(TFAIL | TTERRNO, " ")
>   tst_res(TFAIL | TERRNO, " ");

> I haven't got a better idea unless we allow creating more macros like:

>  TST_RES_TFAIL()
>  TST_RES_TFAIL_TTERRNO()
>  TST_RES_TFAIL_TERRNO()

> But TBH, this looks a bit messy and not good for memories.

Yeah :(. And I don't see any good name either.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
