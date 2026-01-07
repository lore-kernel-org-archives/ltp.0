Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27761CF6BF7
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 08:06:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E7113C2E95
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:06:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D98FC3C2CC4
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:05:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84D8D2005FB
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 09:05:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5479933AEB;
 Wed,  7 Jan 2026 08:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767773147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g//xqT0xhk3vElFJz88l2F0XKo8GP9K9DSgBhg9v/GE=;
 b=jFu1ItluM1Rna6XIu4w96wkLerGDKAm1QIJdj43c+iK1Gid3WLJNke7a3NLkV9eV3WgnRT
 Db0gaEkaeu4Cn5Bqsi4/sAhijkYn2NB/YUZEesEC7I/Nx/Kr+rqpEpYQaKBrs+A9cXSkkN
 QyQ+E1V5/QW2AIBOBmrUrSjaFSHX0VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767773147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g//xqT0xhk3vElFJz88l2F0XKo8GP9K9DSgBhg9v/GE=;
 b=8Fze/jSLqTqEq4BXOB9hteRAd8+CJTEYV2WCk6QzmcomP/dO2wYYofuXO4tCbaR+uhs1Ls
 A5HISky8C+Q46DBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jFu1Itlu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="8Fze/jSL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767773147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g//xqT0xhk3vElFJz88l2F0XKo8GP9K9DSgBhg9v/GE=;
 b=jFu1ItluM1Rna6XIu4w96wkLerGDKAm1QIJdj43c+iK1Gid3WLJNke7a3NLkV9eV3WgnRT
 Db0gaEkaeu4Cn5Bqsi4/sAhijkYn2NB/YUZEesEC7I/Nx/Kr+rqpEpYQaKBrs+A9cXSkkN
 QyQ+E1V5/QW2AIBOBmrUrSjaFSHX0VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767773147;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g//xqT0xhk3vElFJz88l2F0XKo8GP9K9DSgBhg9v/GE=;
 b=8Fze/jSLqTqEq4BXOB9hteRAd8+CJTEYV2WCk6QzmcomP/dO2wYYofuXO4tCbaR+uhs1Ls
 A5HISky8C+Q46DBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3985A3EA63;
 Wed,  7 Jan 2026 08:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5EIKDdsTXmkSSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 08:05:47 +0000
Date: Wed, 7 Jan 2026 09:05:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260107080545.GC727950@pevik>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com> <aTvu4GJBC_G5kSNi@yuki.lan>
 <20251212111618.GA125889@pevik>
 <aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5479933AEB
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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

> On Fri, Dec 12, 2025 at 12:16:18PM +0100, Petr Vorel wrote:
> > > Hi!
> > > > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > > > index da5314c50..67553f65d 100644
> > > > --- a/lib/tst_test.c
> > > > +++ b/lib/tst_test.c
> > > > @@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
> > > >  	return tst_dev_fs_type();
> > > >  }

> > > > +bool tst_cmd_present(const char *cmd)
> > > > +{
> > > > +	struct tst_cmd *pcmd = tst_test->needs_cmds;
> > > > +
> > > > +	while (pcmd->cmd) {
> > > > +		if (!strcmp(pcmd->cmd, cmd))
> > > > +			return pcmd->present;
> > > > +
> > > > +		pcmd++;
> > > > +	}
> > > > +	return false;

> > > Once again, we should tst_brk(TBROK, "Unexpected command '%s'", cmd) here since we asked for
> > > something that we haven't checked for!

> > Good point. I'm sorry to overlook this in my review.

> > Also, strictly speaking tst_cmd_present() is only defined, not used. The commit
> > is about changing .needs_cmds from char array (string) to struct tst_cmd.
> > Therefore it could be in a separate commit. We don't have to be too strict, but
> > given how many tests needed to be adapted adding tst_cmd_present() is somehow
> > buried with other changes.

> Thanks all for detail feedback. Let's me give some explaination why skip
> tst_brk in above function:
> tst_cmd_present will be used in latest ioctl_loop01.c and it should not
> use tst_brk otherwise we will brk out of test in setup() too early.
> The new support needs_cmds.optional in current patch is used for support 
> tst_cmd_present scenario in ioctl_loop01.c.
> Correct me if any mistake.

> ioctl_loop01.c code:
> static void setup(void)
> {
>         parted_sup = tst_cmd_present("parted");  <=====

> .....
>         if (parted_sup)
>                 SAFE_CMD(cmd_parted, NULL, NULL);  <===

>         sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
> }

And also:

static struct tst_test test = {
	...
	.needs_cmds = (struct tst_cmd[]) {
		{.cmd = "parted", .optional = 1},
		{}

Therefore IMHO you are wrong.

+	while (pcmd->cmd) {
+		if (!strcmp(pcmd->cmd, cmd))
We always match this for programs which we checked via .needs_cmds (regardless
true or false return).
+			return pcmd->present;
+
+		pcmd++;
+	}

If we get here that means that we ask in tst_cmd_present("...") for program we
did not add .needs_cmds. That's why Cyril asked for tst_brk().
+	return false;

Kind regards,
Petr

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
