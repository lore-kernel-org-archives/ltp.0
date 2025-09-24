Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04883CAC5B3
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 10:19:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32FFB3CDF84
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 11:53:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 382A73CDF18
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 11:53:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 953E4200AFE
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 11:53:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0E9E21F3C;
 Wed, 24 Sep 2025 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758707599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UK+RgMauKlPmIPrevxzLjs8pNT9e0TAtKJv33qBf/6Y=;
 b=rMF48t9U/8oO+mBbHIaRfeqIMIHwBjMyv/4+4X4UM7A/kSPx/9Z+4ipn03lKoUeNLbhVZG
 8ZWjEMoMPDjkD2KBzZP7d+bFZdRWaBf+uGjtYtFMD1XCh1eaIPB5hL0BJCZvCcUh58ABnm
 tFwpY7+uejiYY0SIDiZkznZ/9xZCrdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758707599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UK+RgMauKlPmIPrevxzLjs8pNT9e0TAtKJv33qBf/6Y=;
 b=IeQeSem5NixZsI/EnoHsd00R9U+SEaf55u132P6P+Yhp0m0l8qdKbW5I/U3a32ZVZj+pPC
 aVKiRDj4pDECfGAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rMF48t9U;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IeQeSem5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758707599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UK+RgMauKlPmIPrevxzLjs8pNT9e0TAtKJv33qBf/6Y=;
 b=rMF48t9U/8oO+mBbHIaRfeqIMIHwBjMyv/4+4X4UM7A/kSPx/9Z+4ipn03lKoUeNLbhVZG
 8ZWjEMoMPDjkD2KBzZP7d+bFZdRWaBf+uGjtYtFMD1XCh1eaIPB5hL0BJCZvCcUh58ABnm
 tFwpY7+uejiYY0SIDiZkznZ/9xZCrdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758707599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UK+RgMauKlPmIPrevxzLjs8pNT9e0TAtKJv33qBf/6Y=;
 b=IeQeSem5NixZsI/EnoHsd00R9U+SEaf55u132P6P+Yhp0m0l8qdKbW5I/U3a32ZVZj+pPC
 aVKiRDj4pDECfGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E17D13647;
 Wed, 24 Sep 2025 09:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R/IfIY+/02hcHQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Sep 2025 09:53:19 +0000
Date: Wed, 24 Sep 2025 11:54:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aNO_uJvhPaZUSR1s@yuki.lan>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost> <20250918145335.GA432906@pevik>
 <aMwms-DHHeF5U7PG@yuki.lan> <aNNWzGWH56SLSXza@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aNNWzGWH56SLSXza@localhost>
X-Rspamd-Queue-Id: A0E9E21F3C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,gmail.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> What's difference between needs_foo and wants_foo? wants_foo means we do
> not do brk if not exist foo?
> I guess we need wants_parted support for .needs_cmds like following
> change? Could you give me more guidance
> 
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -147,6 +147,10 @@ static struct tst_test test = {
>                 "loop",
>                 NULL
>         },
> +       .needs_cmds= (const char *const []) {
> +               "wants_parted",
> +               NULL
> +       },

As Peter explained support for this is not in the test library yet.

My proposal was either of:

1. Add .wants_cmd key to the tst_test structure
  - pros: easy to add, easy to handle
  - cons: the number of tst_test structure members will eventually
    double

2. Add a flag to the needs_cmd, i.e. convert needs_cmd into an array of
   structures, we do that for other cases like saving and restoring
   proc/sys files
   - pros: we will keep the number of members of tst_test
           this is easily expandable, e.g. adding support for
	   minimal version
   - cons: all tests that have needs cmds will need to be adjusted

This would look like:

struct tst_cmd {
	const char *cmd;
	unsigned int required:1;
};


After thinking about this I've started to lean towards option 2.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
