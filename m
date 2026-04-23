Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B263F99351
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79F6E3E5377
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:16:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1D1F3E15D7
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:15:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9778C6009D2
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:15:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EA0E6A7DE;
 Thu, 23 Apr 2026 08:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776932142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDknmEhOZXFgMdXG7suM6J5uOMz5fbVnh35agnKsYoA=;
 b=qlgm16L8v45SxJIpGuF+0lZVyMxkXyFe5hPXA99QFpqoTIRqWxpn/3MUk7zG0z9X4rQqnp
 zdniRdBItLUueTE1T8w+TLDyQ0q0vNoLKGjIXl72zCLFpHoM2Eeksgy6ruBJelg591pjAQ
 VAWe2Q5NEbKM8MPL2z5uqGo8u/Xgddc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776932142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDknmEhOZXFgMdXG7suM6J5uOMz5fbVnh35agnKsYoA=;
 b=O1C/uIvd7RvKA+OluZwRSUuf/GuE/dfiXgy7xsG46qyWrApLbSXoiCegnzSKstvP0FXqJi
 vRL4Gce113rGjPBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776932142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDknmEhOZXFgMdXG7suM6J5uOMz5fbVnh35agnKsYoA=;
 b=qlgm16L8v45SxJIpGuF+0lZVyMxkXyFe5hPXA99QFpqoTIRqWxpn/3MUk7zG0z9X4rQqnp
 zdniRdBItLUueTE1T8w+TLDyQ0q0vNoLKGjIXl72zCLFpHoM2Eeksgy6ruBJelg591pjAQ
 VAWe2Q5NEbKM8MPL2z5uqGo8u/Xgddc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776932142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mDknmEhOZXFgMdXG7suM6J5uOMz5fbVnh35agnKsYoA=;
 b=O1C/uIvd7RvKA+OluZwRSUuf/GuE/dfiXgy7xsG46qyWrApLbSXoiCegnzSKstvP0FXqJi
 vRL4Gce113rGjPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD1B1593B1;
 Thu, 23 Apr 2026 08:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /uzcHi3V6WnZZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 08:15:41 +0000
Date: Thu, 23 Apr 2026 10:15:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <wangli.ahau@gmail.com>
Message-ID: <20260423081531.GA646798@pevik>
References: <20260422141234.632195-1-pvorel@suse.cz>
 <20260422141234.632195-6-pvorel@suse.cz>
 <CANgNiRygF3v7V3jAPJ10J+FW1-0fTQf4pq08jJSo8gtKHWmkZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANgNiRygF3v7V3jAPJ10J+FW1-0fTQf4pq08jJSo8gtKHWmkZQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/5] lib: Merge functionality of LTP_QUIET into
 LTP_REPRODUCIBLE_OUTPUT
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
Cc: ltp@lists.linux.it, Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Petr,

> Petr Vorel <pvorel@suse.cz> wrote:

> > LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
> > help valgrind to use LTP for testing. It discards the actual content of
> > the messages printed by the test (removes everything after printing
> > TINFO/TPASS/TFAIL/... flag).

> > Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
> > TINFO, and TDEBUG messages.

> In this patch, I didn't find that it suppresses TWARN messages.
> Should we add it as well?

Thanks to catch this! I'd keep it, it can have valuable info.

> > Valgrind project uses both variables but no need to handle them
> > separately. Therefore merge functionality of LTP_QUIET into
> > LTP_REPRODUCIBLE_OUTPUT.
...
> > +++ b/lib/tst_test.c
> >         break;
...
> > @@ -676,8 +675,8 @@ static void print_help(void)
> >         fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
> >         fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> >         fprintf(stderr, "LTP_DEBUG                Print debug messages (set 1(y) or 2)\n");
> > -       fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
> > -       fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");

> > +       fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TCONF, TWARN, TINFO, and TDEBUG messages and");
> > +       fprintf(stderr, "                         discards the actual content of all other messages");

> I guess this two-line format is a bit strange when printing.
> Maybe we need to combine into a single fprintf()?

OK, but I'd split new line. + Add \n as AI found :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
