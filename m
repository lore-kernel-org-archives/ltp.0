Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF8DEFB7F9
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:25:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D58E13D0F67
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 10:25:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C51E3CA689
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:24:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5357600821
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 10:24:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F19525BCD9;
 Tue, 24 Feb 2026 09:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771925095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdwfYolUgPBPQEKpMfvWkaELL5TQUsEGOWIX19ruI7g=;
 b=FtjQrImXVbXODReCns2/+dJab+p1etWx61j9Dkz8EDao+AoJfrqG0Il/Lq1fEc3ptOQDQw
 rN1Cmern4Z7xDia9N0mwbq3EMUFx4CtISIV2Jxal/cKqireDhE3TEM5XEOa2qfzjy5y5Y3
 dhgydvCm5r8GozbfmcQD3AO8ZUdIGgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771925095;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdwfYolUgPBPQEKpMfvWkaELL5TQUsEGOWIX19ruI7g=;
 b=cFWx/TotK7RY0Mv5r4+XyrPZTtCn+CxfFjf/rQt8WPo9VtBvHnOav0HMfH9y75nP+ac0M+
 ISoEJyH7OddxywCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771925094;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdwfYolUgPBPQEKpMfvWkaELL5TQUsEGOWIX19ruI7g=;
 b=SwgWIDv3xoOZxTTdXYwuGFf6YFYo0NYmUBD8RMxaNnuOyYtoo2ijTOjkrAa0lf8nLqp5s4
 +c5l87kS4Xs7N+0bBy2V/efwUPDUjaD5mGNDADBbhazgYpAZaQhWs0ccD4MpFoyUwc3EaQ
 /JE2YnHCgQygwM/Kf/GLjz6Ls394W50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771925094;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdwfYolUgPBPQEKpMfvWkaELL5TQUsEGOWIX19ruI7g=;
 b=7sqYbTRCneBu4k6TPX1PoondUcqMwo3fNWREs0M2oKjfbcT46k2xJeX89MiuOdG3/HtZSC
 eAeJprXefMb9+yCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C014C3EA68;
 Tue, 24 Feb 2026 09:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bS3RLWZunWksewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 09:24:54 +0000
Date: Tue, 24 Feb 2026 10:24:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <20260224092449.GA37421@pevik>
References: <CAJCsO8eTiS5Z1Upon-gUj6R9f=TW3BJaRqmDwdxEwSMyvnwB1A@mail.gmail.com>
 <20260223105556.31129-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260223105556.31129-1-sebastian.chlad@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] nfs: Adapt the lib to allow to test in 2-host
 mode
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

> nfs_lib.sh checked key server_side prerequisites on the system under test.
> In 2_host setup this incorrectly required server_side tools on lhost.

> Switch exportfs and rpc.mountd/rpc.statd checks in nfs_setup() to
> tst_rhost_run(). This aligns netns and 2-host handling in one path and
> keeps 2-host checks on rhost.

Thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
