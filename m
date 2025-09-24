Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BAFCAC5B0
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 12:55:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26C053CDF80
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 14:55:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6AF73CDF18
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 14:55:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1DB4A6006D9
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 14:55:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39854345E7;
 Wed, 24 Sep 2025 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758718503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMmZLkbJXa2GVgr8dAswAwR+KrMsesyDwBBGdpQiCdU=;
 b=EXy1HmyDQV4ugOKgaf9wpXYts+acGh0sCQ7UTqsNN2REaUH6YURjL8r1DngtWBAYovnqCm
 hyK3u9hTCUNrMoV6o81V6hUUFudJDB6f1Y5dH9AhcLU/mEmfPcjyVp4LEdnDT+b/z0POCS
 0WanHCa1iLB0JBPEJ2PaWi6xiV7DyXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758718503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMmZLkbJXa2GVgr8dAswAwR+KrMsesyDwBBGdpQiCdU=;
 b=EPg+elKLbt9fdh0FPVC+JlGtE1cw9bJ8RO1sIiF2d+ZsSVgPvkVOhMMLxG7xghcdKzLl6w
 SLJOP6xgTecBtoAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EXy1HmyD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EPg+elKL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758718503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMmZLkbJXa2GVgr8dAswAwR+KrMsesyDwBBGdpQiCdU=;
 b=EXy1HmyDQV4ugOKgaf9wpXYts+acGh0sCQ7UTqsNN2REaUH6YURjL8r1DngtWBAYovnqCm
 hyK3u9hTCUNrMoV6o81V6hUUFudJDB6f1Y5dH9AhcLU/mEmfPcjyVp4LEdnDT+b/z0POCS
 0WanHCa1iLB0JBPEJ2PaWi6xiV7DyXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758718503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bMmZLkbJXa2GVgr8dAswAwR+KrMsesyDwBBGdpQiCdU=;
 b=EPg+elKLbt9fdh0FPVC+JlGtE1cw9bJ8RO1sIiF2d+ZsSVgPvkVOhMMLxG7xghcdKzLl6w
 SLJOP6xgTecBtoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E61F613A61;
 Wed, 24 Sep 2025 12:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qrHANibq02ikXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Sep 2025 12:55:02 +0000
Date: Wed, 24 Sep 2025 14:55:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250924125501.GA70531@pevik>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost> <20250918145335.GA432906@pevik>
 <aMwms-DHHeF5U7PG@yuki.lan> <aNNWzGWH56SLSXza@localhost>
 <aNO_uJvhPaZUSR1s@yuki.lan> <aNPKtagFqkL_dIZ-@localhost>
 <aNPN9N-Zadq0h7Vs@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aNPN9N-Zadq0h7Vs@yuki.lan>
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,lists.linux.it,gmail.com,suse.cz,redhat.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 39854345E7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for
 partitioning
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > If we select option 2 then we have following setting for all related
> > test cases.
> > +       .needs_cmds = (const struct tst_cmd[]) {
> > +               {"parted", "0"},
> > +               {}
> > +       },

> > But how to get "parted" command support status? In ioctl_loop01.c there
> > is a local var "parted_sup" which flag parted command support or not, and
> > use this flag to decide which sub test needed. 
> > If we do this logic in test lib then we need create another
> > flag in tst_cmd used for give status of command support or not.
> > During test lib logic will set tst_cmd.support flag.

> >  struct tst_cmd {
> >  	const char *cmd;
> >  	unsigned int required:1;
> >  	unsigned int support:1;
> >  };

> > Correct me if any misunderstanding, many thanks.

> Sounds reasonable and we could also add a nice function to the test
> library:

> bool tst_cmd_present(const char *cmd);

> that would loop over the tst_cmd array and return the supported flag
> value.

+1, although not sure if we want to finish this before the release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
