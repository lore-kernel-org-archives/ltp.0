Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45F6C25B10
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 20:02:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6322D3CDB56
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 22:02:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87CAD3CD961
 for <ltp@lists.linux.it>; Mon,  6 May 2024 22:02:13 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D4FE322657F
 for <ltp@lists.linux.it>; Mon,  6 May 2024 22:02:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEEB81FD55;
 Mon,  6 May 2024 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715025731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4npifJTp1LPdtVL9pD9QWSRw3967mV8I2eIxXf+KKj8=;
 b=wUTbuXoIuDQUA4zaMxvzRCp4T0Rw+W+dhhqhErhrwfSqr23GFfdsMVyYlJYWlQdR5yNtRQ
 YAIBvykcLxu0sxJdntDJQG/Cb6KBN3hxhydlEQT/mhCiwhNqDadzu9xIPnoDjhtiZB0wTf
 VjLD/a3ChKDvddfBcQXAOlhBdm/tkmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715025731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4npifJTp1LPdtVL9pD9QWSRw3967mV8I2eIxXf+KKj8=;
 b=jQXZSIC+JiWHKk2pJIIsvPZr+aHHKBupTPjsmlIvTOuek290i230V9MsoKecvJ/2pnMGQd
 jyhVISM7TgMcm6Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715025731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4npifJTp1LPdtVL9pD9QWSRw3967mV8I2eIxXf+KKj8=;
 b=wUTbuXoIuDQUA4zaMxvzRCp4T0Rw+W+dhhqhErhrwfSqr23GFfdsMVyYlJYWlQdR5yNtRQ
 YAIBvykcLxu0sxJdntDJQG/Cb6KBN3hxhydlEQT/mhCiwhNqDadzu9xIPnoDjhtiZB0wTf
 VjLD/a3ChKDvddfBcQXAOlhBdm/tkmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715025731;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4npifJTp1LPdtVL9pD9QWSRw3967mV8I2eIxXf+KKj8=;
 b=jQXZSIC+JiWHKk2pJIIsvPZr+aHHKBupTPjsmlIvTOuek290i230V9MsoKecvJ/2pnMGQd
 jyhVISM7TgMcm6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B01CE13A25;
 Mon,  6 May 2024 20:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YR2EKUM3OWZiXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 May 2024 20:02:11 +0000
Date: Mon, 6 May 2024 22:02:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
Message-ID: <20240506200210.GB38981@pevik>
References: <20220421123351.17645-1-mdoucha@suse.cz>
 <20220421123351.17645-3-mdoucha@suse.cz>
 <20240506191739.GA36275@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240506191739.GA36275@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add test for CVE 2021-38198
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, Cyril,

> Hi Martin, Cyril,

> > +static struct tst_test test = {
> > +	.test_all = tst_kvm_run,
> > +	.setup = setup,
> > +	.cleanup = tst_kvm_cleanup,
> > +	.needs_root = 1,

> This test was merged some time ago.

> FYI this .needs_root generates -Wsingle-bit-bitfield-constant-conversion error.
> Nothing important, maybe you see an easy way to fix it.

> kvm_pagefault01.c:218:16: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
>         .needs_root = 1,
>                       ^
> 1 warning generated.

I'm sorry, this is not specific to KVM tests (and indeed, I was not able to find
how this could be specific), but to any test built with clang (gcc simply does
not issue this error). Obviously the problem is for any 1 bit field member in
struct tst_test. The fix is quite simple - turn them to unsigned int.

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=eab9100d9898cbd37882b04415b12156f8942f18

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
