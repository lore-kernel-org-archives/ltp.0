Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB6DF327D9
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 11:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98E5D3E2D8C
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 13:48:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41B443C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 13:47:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4D490140076E
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 13:47:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 946846A7F4;
 Tue, 21 Apr 2026 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776772063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6hmpgNQnkyO+pi2rH3TSTkqX7G/wDqVCxX7z3qtxiU=;
 b=mvsY5yh0hhad4DQoYVSEi4ytkT/iFOwF9KC8zF7eu3jAA9yKz2YXhzz236PvskSK/jxDvW
 f03tMKcLtH0thImO4wwoZP/iVeU/AH9qTKW4hKha8s7G8+lBU+NP8t4kr6C3gBttWdVCQG
 evADtfCIxWyYN4zROa9F1wAoj/0SA0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776772063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6hmpgNQnkyO+pi2rH3TSTkqX7G/wDqVCxX7z3qtxiU=;
 b=1rz32wqs+4v463E90/cwEXAolGyLiW9ruv0utt+Dw8UiLdVIHhG1e1bFgijiJZOXxpPelS
 Q3IyO+1mGmjnwlDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mvsY5yh0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1rz32wqs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776772063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6hmpgNQnkyO+pi2rH3TSTkqX7G/wDqVCxX7z3qtxiU=;
 b=mvsY5yh0hhad4DQoYVSEi4ytkT/iFOwF9KC8zF7eu3jAA9yKz2YXhzz236PvskSK/jxDvW
 f03tMKcLtH0thImO4wwoZP/iVeU/AH9qTKW4hKha8s7G8+lBU+NP8t4kr6C3gBttWdVCQG
 evADtfCIxWyYN4zROa9F1wAoj/0SA0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776772063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6hmpgNQnkyO+pi2rH3TSTkqX7G/wDqVCxX7z3qtxiU=;
 b=1rz32wqs+4v463E90/cwEXAolGyLiW9ruv0utt+Dw8UiLdVIHhG1e1bFgijiJZOXxpPelS
 Q3IyO+1mGmjnwlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A004593AF;
 Tue, 21 Apr 2026 11:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id urB0HN9j52lQKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Apr 2026 11:47:43 +0000
Date: Tue, 21 Apr 2026 13:47:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260421114738.GM506589@pevik>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-17-chrubis@suse.cz>
 <CAEemH2c5OfBhcR_KB6LY4yJdxAUDR7HbWAf-V0KjiZMN2Jkarw@mail.gmail.com>
 <adTWHgQO2gLj_bXX@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adTWHgQO2gLj_bXX@yuki.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 TAGGED_RCPT(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 946846A7F4
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 16/17] lib: tst_test: Remove now unused
 needs_drivers
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

Hi Cyril, Li,

> Hi!
> > > --- a/include/tst_test.h
> > > +++ b/include/tst_test.h
> > > @@ -498,10 +498,6 @@ struct tst_fs {
> > >   *                  to the test temporary directory from the LTP datafiles
> > >   *                  directory.
> > >   *
> > > - * @needs_drivers: A NULL terminated array of kernel modules required to run
> > > - *                 the test. The module has to be build in or present in order
> > > - *                 for the test to run.
> > > - *
> > >   * @save_restore: A {} terminated array of /proc or /sys files that should
> > >   *                saved at the start of the test and restored at the end. See
> > >   *                tst_sys_conf_save() and :ref:`struct tst_path_val` for details.

> > As we add runtime_check and module_check, I think we also need to update
> > the descrition comments of @needs_kconfigs in tst_test.h.


> What about something like this:

> diff --git a/include/tst_test.h b/include/tst_test.h
> index 752688c45..f2a5378cd 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -511,6 +511,13 @@ struct tst_fs {
>   *                  and parenthesis are supported, e.g.
>   *                  "CONFIG_X86_INTEL_UMIP=y | CONFIG_X86_UIMP=y" is evaluated
>   *                  to true if at least one of the options is present.
> + *                  For some config options their presence in the config file
> + *                  is not enough to assure the functionality is present or
> + *                  enabled. E.g. config option may be set to 'm' but the
> + *                  module may not be installed or functionality may be
> + *                  disabled on the kernel command line. The kconfig library
> + *                  has a set of additonal checks for a few config options that

s/additonal/additional/

> + *                  are used in the tests and need additional checks.

(Please consider configuring spell checker in your editor setup, or run make
check as I enabled in our checkpatch.pl configuration check for typos.)

AI would reword it, feel free to use some parts or ignore:

	For some config options their presence in the config file is not enough to assure the functionality is present or enabled.
	E.g. config option may be set to 'm' but the module may not be installed or functionality may be disabled on the kernel command line.

	The kconfig library has a set of additional checks for a few config options that are used in the tests and need additional checks.
	Please rebase before adding the text (I fixed typo in include/tst_test.h).

The removal is obviously ok.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
