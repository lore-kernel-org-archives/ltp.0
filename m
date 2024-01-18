Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35018C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 13:39:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B94DE3CEFD1
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 14:39:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F8C33CC8FB
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 14:38:50 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7FC9D6019B4
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 14:38:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57DCF222DB;
 Thu, 18 Jan 2024 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705585128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZAReluj4h1GUnWliL2TR+DtabBWb8o9dHKkIZdBzDE=;
 b=ilxTPaaHyQCqkLpT2QAeEwp9dkyIz8X7bUs6q95dLwldde9Y4RxAtsT7CqE8Ia7dnZq+c6
 HYlBUOnoBP5UkR5ulJLTJOSWU9oGnhwsQjHj9XztP3q0wnHzhVqWMoc0ekvWpBDlkNfpBj
 +fXnSLuN9XVnzs6G0mt4QfAGWuzFrAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705585128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZAReluj4h1GUnWliL2TR+DtabBWb8o9dHKkIZdBzDE=;
 b=A2tgbKLqKl+mJ2kHpFML5lNuOegPRSGGQ9BPHA8NpSX17wNdlZEQLeq8HNRfUSazqijoNV
 ZM2JUjE2T4eTJqBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705585128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZAReluj4h1GUnWliL2TR+DtabBWb8o9dHKkIZdBzDE=;
 b=ilxTPaaHyQCqkLpT2QAeEwp9dkyIz8X7bUs6q95dLwldde9Y4RxAtsT7CqE8Ia7dnZq+c6
 HYlBUOnoBP5UkR5ulJLTJOSWU9oGnhwsQjHj9XztP3q0wnHzhVqWMoc0ekvWpBDlkNfpBj
 +fXnSLuN9XVnzs6G0mt4QfAGWuzFrAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705585128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZAReluj4h1GUnWliL2TR+DtabBWb8o9dHKkIZdBzDE=;
 b=A2tgbKLqKl+mJ2kHpFML5lNuOegPRSGGQ9BPHA8NpSX17wNdlZEQLeq8HNRfUSazqijoNV
 ZM2JUjE2T4eTJqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3433913874;
 Thu, 18 Jan 2024 13:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S9dRC+gpqWV1CgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Jan 2024 13:38:48 +0000
Date: Thu, 18 Jan 2024 14:38:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240118133846.GA2774347@pevik>
References: <20240111094530.1893262-1-pvorel@suse.cz> <ZakWJ0ZqrLWTQFty@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZakWJ0ZqrLWTQFty@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.79 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.29)[74.57%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl05: Add modprobe dns_resolver
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

Hi Cyril, all,

> Hi!
> > This avoids TCONF when module not loaded:
> > keyctl05.c:99: TCONF: kernel doesn't support key type 'dns_resolver'

> > There is no way to trigger module loading automatically.

> I just checked the kernel add_key() syscall and indeed there is no way
> the sycall would load a module, all it does is to loop over already
> registered kernel key types.

Thanks for checking this!

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > a candidate to merge before release (simple enough).

> > I'll try to send a patchset for .modprobe_module before the release, but
> > I suppose we should merge it after the release anyway. That's why I
> > added this simple patch. And therefore I don't bother with 'modprobe -r',
> > neither with requiring modprobe (will be in .modprobe_module).

> Sounds like a plan. Let's go for this workaround before the release
> then.

+1

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
