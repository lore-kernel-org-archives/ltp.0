Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE8C10ED677
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 13:19:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387073CF76D
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 14:19:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2947B3C1E06
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 14:19:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B595F201DDE
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 14:19:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0654A5BDE9;
 Fri, 27 Mar 2026 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774617552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s29jBi1tdnznzXLLaojRq/iuNEeL2Z9Oes0ADWpZtPE=;
 b=R6azUcSRtvAz1JhYcUfcTJllbs8Xsvf6DoRK7dVaF1FdxzIzp3EC33997KXAhFeFJaSj0q
 Oul419b/5zX7g8Ty/sePkD1mTFFX+gDunbjjbl38U9ONwsqSk5zhxrPg3bCoMssksMi9qA
 aOZEDmuguxjPS83hd4MxXqGaGUArWFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774617552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s29jBi1tdnznzXLLaojRq/iuNEeL2Z9Oes0ADWpZtPE=;
 b=vNrE7UO6mfAyH3pP5FZQo47YCu9mg70slXZMFtHXIQ0KAxubRkOowqKd+A/1Dj3hrTwCV6
 FzmltRh2AiJjp6Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R6azUcSR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vNrE7UO6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774617552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s29jBi1tdnznzXLLaojRq/iuNEeL2Z9Oes0ADWpZtPE=;
 b=R6azUcSRtvAz1JhYcUfcTJllbs8Xsvf6DoRK7dVaF1FdxzIzp3EC33997KXAhFeFJaSj0q
 Oul419b/5zX7g8Ty/sePkD1mTFFX+gDunbjjbl38U9ONwsqSk5zhxrPg3bCoMssksMi9qA
 aOZEDmuguxjPS83hd4MxXqGaGUArWFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774617552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s29jBi1tdnznzXLLaojRq/iuNEeL2Z9Oes0ADWpZtPE=;
 b=vNrE7UO6mfAyH3pP5FZQo47YCu9mg70slXZMFtHXIQ0KAxubRkOowqKd+A/1Dj3hrTwCV6
 FzmltRh2AiJjp6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E37714A0A2;
 Fri, 27 Mar 2026 13:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4YijNc+DxmlYCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 27 Mar 2026 13:19:11 +0000
Date: Fri, 27 Mar 2026 14:19:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acaDztrhBMninsBV@yuki.lan>
References: <20260326125216.159239-1-pvorel@suse.cz>
 <acYYc47HXGYa5Mqj@redhat.com> <20260327090505.GA40147@pevik>
 <acaDd9VjQX-FtCkb@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acaDd9VjQX-FtCkb@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 0654A5BDE9
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd03.c: Require kernel 6.1
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
> > > Anyway, back to the topic, what is the point of creating this patch?
> > > Anything I missed?
> > 
> > Nothing besides trying to fix 6.11 (which was not the case) and trying to
> > simplify. But whole effort is somehow relevant to general checking test
> > requirements cleanup (we had a discussion runtime checks vs. kconfig/min_kver
> > which resulted in Cyril's "lib: tst_kconfig: Add runtime checks" [2]).
> 
> I guess that the check for all userfaultfd tests should be moved to the
> tst_kconfig.c once my patch that adds runtime checks there is in.

Or I can send a V3 that adds that check as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
