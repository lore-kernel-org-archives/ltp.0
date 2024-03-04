Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F071CC5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 14:32:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39DC23CEBF9
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:32:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C80973CE990
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 15:32:28 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD2081001F29
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 15:32:27 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D64F64E971;
 Mon,  4 Mar 2024 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709562744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJKewEg6Qhfb/VcnZJ/QFMJqmp2y6hc1KK+8qFJlZPU=;
 b=xqY4FZfNEcghfaky59ZbREoMO7KtnL1RgE/ksG/D5oZS+BfEyLaITwz20JYSjIY2gd/uk1
 DrvtLfI7kIBEE7wJE+Gha36AvdOWphrFITG9NZTC90louuUv78BzBfpX07KNG6tYyice8K
 DV0rZbPT+vKnNnYmRRashTw+Bc23R6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709562744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJKewEg6Qhfb/VcnZJ/QFMJqmp2y6hc1KK+8qFJlZPU=;
 b=aGDe9FFH/j77GKjOHguhrKqMP/UcgZGnQy9IOlAkM4JBu52WWhUUYlm+ln9kRWVh+zs0TF
 38fQGOnQu5m/zsCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709562744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJKewEg6Qhfb/VcnZJ/QFMJqmp2y6hc1KK+8qFJlZPU=;
 b=xqY4FZfNEcghfaky59ZbREoMO7KtnL1RgE/ksG/D5oZS+BfEyLaITwz20JYSjIY2gd/uk1
 DrvtLfI7kIBEE7wJE+Gha36AvdOWphrFITG9NZTC90louuUv78BzBfpX07KNG6tYyice8K
 DV0rZbPT+vKnNnYmRRashTw+Bc23R6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709562744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qJKewEg6Qhfb/VcnZJ/QFMJqmp2y6hc1KK+8qFJlZPU=;
 b=aGDe9FFH/j77GKjOHguhrKqMP/UcgZGnQy9IOlAkM4JBu52WWhUUYlm+ln9kRWVh+zs0TF
 38fQGOnQu5m/zsCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CC58139C6;
 Mon,  4 Mar 2024 14:32:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id QS+KI3jb5WVFXwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 14:32:24 +0000
Date: Mon, 4 Mar 2024 15:32:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240304143223.GA3115761@pevik>
References: <20240226153754.24998-1-andrea.cervesato@suse.de>
 <20240226153754.24998-3-andrea.cervesato@suse.de>
 <Zdy26zz-_23brAlB@yuki>
 <a1092d18-8f31-49d9-80b8-1436a0c9bd86@suse.com>
 <ZeXYdOwHTND_SVPJ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZeXYdOwHTND_SVPJ@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.68 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.18)[70.43%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add shmat04 SysV IPC bug reproducer
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
> > > Hmm, it's kind of ugly how we wrap the macro here like that...

> > > What about we instead add debugging messages to all the SAFE_MACROS()?

> > > Given that we added TDEBUG flag recently we can do soemthing as:

> > > 	tst_res_(TDEBUG, file, lineno, "mprotect(%p, %d, %s)",
> > > 	         addr, size, prot_to_str(prot));

> > > To the SAFE_MPROTECT() and get the verbose output for free with verbose
> > > flag passed to the test.

> > > We can do that with all SAFE_MACROS() then we do not have to print most
> > > of the messages in this test...
> > Is this comment related with the previous patch of the set?

> Not at all, I'm just complaining that we are adding debuging print to
> the test itself when it would be much cleaner to put it into the test
> library instead.

+1, setting patchset as changes requested, please send v3.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
