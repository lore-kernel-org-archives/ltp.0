Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EDEFD5F8D
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 07:06:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C63743E26A7
	for <ltp@archiver.kernel.org>; Wed,  8 Apr 2026 09:06:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E2063CA219
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 09:06:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CCF946003CC
 for <ltp@lists.linux.it>; Wed,  8 Apr 2026 09:06:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61B095BD01;
 Wed,  8 Apr 2026 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775631975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6nxtpJVXJWFBPS742QjtnjaUvBpE4OXDuE1ycWkhfw=;
 b=GHTuJxz1tzT+pYgchcZDaXE6zdelJc59R2xWK8g9/0dwzAKf+0nIPKIxWsohdmBMJt+s2q
 27fKQfRlmQ7XgSgYRkI6lG6wqZ317OmDG939qk8PXvl6IaWM+ihQtsWFnnLnR6u3ax4ZvE
 YLUnF4xps+mu5YnyF2i/qxbAufQDHGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775631975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6nxtpJVXJWFBPS742QjtnjaUvBpE4OXDuE1ycWkhfw=;
 b=yl1jvU+Hb44xTDiuXhxQXr4SAQv7Sk4yWeyRDmCs+IPwKsvb5ip/k3eXtLn4SM+ManzkwV
 pUp03D1vaZHTpfAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775631975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6nxtpJVXJWFBPS742QjtnjaUvBpE4OXDuE1ycWkhfw=;
 b=GHTuJxz1tzT+pYgchcZDaXE6zdelJc59R2xWK8g9/0dwzAKf+0nIPKIxWsohdmBMJt+s2q
 27fKQfRlmQ7XgSgYRkI6lG6wqZ317OmDG939qk8PXvl6IaWM+ihQtsWFnnLnR6u3ax4ZvE
 YLUnF4xps+mu5YnyF2i/qxbAufQDHGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775631975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6nxtpJVXJWFBPS742QjtnjaUvBpE4OXDuE1ycWkhfw=;
 b=yl1jvU+Hb44xTDiuXhxQXr4SAQv7Sk4yWeyRDmCs+IPwKsvb5ip/k3eXtLn4SM+ManzkwV
 pUp03D1vaZHTpfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B0814A0B3;
 Wed,  8 Apr 2026 07:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJxWEWf+1WlBHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Apr 2026 07:06:15 +0000
Date: Wed, 8 Apr 2026 09:06:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260408070609.GA35030@pevik>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-4-chrubis@suse.cz>
 <20260402214727.GE225068@pevik> <adTRqJao6jxdg-J1@yuki.lan>
 <20260407111501.GA25645@pevik> <adTpbV8itMBpCvnD@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adTpbV8itMBpCvnD@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/17] lib: tst_kernel: Add
 tst_check_module_driver()
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
> > > > Thinking about it twice, could we check for the module by reading
> > > > /sys/module/? Our current approach shows what module *should* be available, but
> > > > that might not be true for some reason (i.e. loadable module not installed).

> > > The modules.dep file contains names of all modules installed in
> > > particular kernel modules directory. We cannot do anything better than
> > > parsing that file because it's (re)genrated on the system each time
> > > packages with modules have been installed/removed. If that wasn't the
> > > case modprobe that depends on that file wouldn't work either.

> > We effectively ask users to install modules.dep and modules.builtin. While this
> > is ok for distros and nobody has complained, I can imagine special embedded
> > systems can have problem. If everything was reliably detectable via /sys or
> > /proc I'd move to it. But even it's not working for all modules, checking first
> > /sys/module/ and fallback using modules.{builtin,dep} wouldn't take much effort.

> My code does not add any new dependencies. The check for module.dep has
> been in LTP since:

> 8f7013ba6917 ('tst_check_driver(): Fix kernel module detection on BusyBox')

> which was introduced five years ago.

> The only thing that changes is that the check is being moved from
> needs_drivers to needs_kconfigs.

Sure, it's not new dependency and I like this cleanup. My point is not directly
related to the these changes, but to the fact that I probably did not know about
/sys/module/ back then. But I knew the limitations (no detection on Android,
possible problems on embedded).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
