Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A55C27C79
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 12:13:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7ACE3D0D4B
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 14:13:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22DD23CDE11
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 14:13:09 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 91FC51000A10
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 14:13:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 073023815D;
 Mon, 17 Jun 2024 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718626387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SHyLXCCUBv09imZDFnfztoE9TFwtC2Hl+Wmgmj+7Lw=;
 b=wrjVP8g4VmrsaJNCzdOR8rCyIRUQUWeadpF7A85Xgp2Kytm5Whn4teQ0/JjQsNibhftH0S
 avStPkQxfdTQ3T9TP1UNHxQfeaAiXMSumd2Wg9/c6ym8uSAhEaEbD4L34n0uSLrYBaHF52
 AmXc92kQRPN+zLqHdfkPCtdE9fPWh84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718626387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SHyLXCCUBv09imZDFnfztoE9TFwtC2Hl+Wmgmj+7Lw=;
 b=Ieu55ngqXaNXThLfO8p/PD1ijKUKed6c8KJDzkmgpfUGEBd78//jIrWTQCESYQaCsXq7dq
 uiqlp+BDdfZEdIAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wrjVP8g4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ieu55ngq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718626387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SHyLXCCUBv09imZDFnfztoE9TFwtC2Hl+Wmgmj+7Lw=;
 b=wrjVP8g4VmrsaJNCzdOR8rCyIRUQUWeadpF7A85Xgp2Kytm5Whn4teQ0/JjQsNibhftH0S
 avStPkQxfdTQ3T9TP1UNHxQfeaAiXMSumd2Wg9/c6ym8uSAhEaEbD4L34n0uSLrYBaHF52
 AmXc92kQRPN+zLqHdfkPCtdE9fPWh84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718626387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/SHyLXCCUBv09imZDFnfztoE9TFwtC2Hl+Wmgmj+7Lw=;
 b=Ieu55ngqXaNXThLfO8p/PD1ijKUKed6c8KJDzkmgpfUGEBd78//jIrWTQCESYQaCsXq7dq
 uiqlp+BDdfZEdIAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF24B139AB;
 Mon, 17 Jun 2024 12:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BuKINVIocGb2KgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jun 2024 12:13:06 +0000
Date: Mon, 17 Jun 2024 14:13:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240617121305.GA265101@pevik>
References: <20240530044029.15474-1-wegao@suse.com>
 <20240613232044.7418-1-wegao@suse.com>
 <20240614125116.GA197913@pevik> <Zmxhq-efWMJa5a-2@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zmxhq-efWMJa5a-2@rei>
X-Rspamd-Queue-Id: 073023815D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] msync04.c: Use direct IO to verify the data is
 stored on disk
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
> > > +static void verify_mmaped(void)
> > > +{
> > > +	char *buffer = SAFE_MEMALIGN(getpagesize(), getpagesize());
> > > +
> > > +	tst_res(TINFO, "Haven't seen dirty bit so we check content of file instead");
> > > +	test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY | O_DIRECT);
> > If this fails we have memory leak, because free() is not run.

> > > +	SAFE_READ(0, test_fd, buffer, getpagesize());
> > Also here. Maybe create buf as static and have conditional free() also at the
> > cleanup?

> If these fail we exit the test, which frees memory anyways...

Thanks for correcting me.  I always forget the basis that exit() frees the
memory (unlike return 0 and unless overwritten). And we call exit() in
tst_brk().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
