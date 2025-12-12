Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C37D44176
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 11:16:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868173C8544
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 12:16:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 314073C6EA9
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 12:16:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B73B41000D98
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 12:16:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 334E15BD67;
 Fri, 12 Dec 2025 11:16:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 071D03EA63;
 Fri, 12 Dec 2025 11:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lkuOOIP5O2mfEQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Dec 2025 11:16:19 +0000
Date: Fri, 12 Dec 2025 12:16:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251212111618.GA125889@pevik>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com> <aTvu4GJBC_G5kSNi@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aTvu4GJBC_G5kSNi@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 334E15BD67
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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

> Hi!
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index da5314c50..67553f65d 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
> >  	return tst_dev_fs_type();
> >  }

> > +bool tst_cmd_present(const char *cmd)
> > +{
> > +	struct tst_cmd *pcmd = tst_test->needs_cmds;
> > +
> > +	while (pcmd->cmd) {
> > +		if (!strcmp(pcmd->cmd, cmd))
> > +			return pcmd->present;
> > +
> > +		pcmd++;
> > +	}
> > +	return false;

> Once again, we should tst_brk(TBROK, "Unexpected command '%s'", cmd) here since we asked for
> something that we haven't checked for!

Good point. I'm sorry to overlook this in my review.

Also, strictly speaking tst_cmd_present() is only defined, not used. The commit
is about changing .needs_cmds from char array (string) to struct tst_cmd.
Therefore it could be in a separate commit. We don't have to be too strict, but
given how many tests needed to be adapted adding tst_cmd_present() is somehow
buried with other changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
