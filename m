Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26006C83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 10:26:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62F5B3C7746
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 12:26:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA2E13C7746
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 12:26:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2CB812000FB
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 12:26:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96B311F7DD;
 Thu, 17 Jul 2025 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752747977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVSOfu4mauuHMkZU+EN3M1C0dX9dWrzvSQPi5h0VYzI=;
 b=E5O7XxJDDDgzj8cwX1maiv2b1QG1VdN+42tSUyjP8X5gTB+K8JuycO3Fjkxtf4eNzNvy7z
 7VLr0cNMTxJdt76oOpF82trD8dMz50tNzP7DPg4C7T2vyzloLBpQWC3O48njYGuavScVCY
 GQX6sFXKo+ZsfX/P0kQAYFJDerlwso4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752747977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVSOfu4mauuHMkZU+EN3M1C0dX9dWrzvSQPi5h0VYzI=;
 b=v/DMXm23ykk+2j7Vuhk00DnzbvJ7lkglzz0eTI6aelWQZ9AfSkcmdwfxl03G/TB/AGYIqq
 NUEB2r/WLMtcgMAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E5O7XxJD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="v/DMXm23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752747977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVSOfu4mauuHMkZU+EN3M1C0dX9dWrzvSQPi5h0VYzI=;
 b=E5O7XxJDDDgzj8cwX1maiv2b1QG1VdN+42tSUyjP8X5gTB+K8JuycO3Fjkxtf4eNzNvy7z
 7VLr0cNMTxJdt76oOpF82trD8dMz50tNzP7DPg4C7T2vyzloLBpQWC3O48njYGuavScVCY
 GQX6sFXKo+ZsfX/P0kQAYFJDerlwso4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752747977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVSOfu4mauuHMkZU+EN3M1C0dX9dWrzvSQPi5h0VYzI=;
 b=v/DMXm23ykk+2j7Vuhk00DnzbvJ7lkglzz0eTI6aelWQZ9AfSkcmdwfxl03G/TB/AGYIqq
 NUEB2r/WLMtcgMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DC001392A;
 Thu, 17 Jul 2025 10:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZbCuGcnPeGioaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 17 Jul 2025 10:26:17 +0000
Date: Thu, 17 Jul 2025 12:26:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250717102611.GA905840@pevik>
References: <20250609124506.1454420-1-pvorel@suse.cz>
 <20250609124506.1454420-4-pvorel@suse.cz>
 <CAEemH2coV_yJM5Kg5JN9FVqx6b=_CLTLzhCtCfCwqHnP-_j=yA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2coV_yJM5Kg5JN9FVqx6b=_CLTLzhCtCfCwqHnP-_j=yA@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 96B311F7DD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] shell lib: Add basic support for test setup
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

Hi Li, Cyril, all,

> PM Petr Vorel <pvorel@suse.cz> wrote:
...
> > +if [ -n "$TST_CLEANUP" ]; then
> > +       trap $TST_CLEANUP EXIT
> > +fi
> > +
> > +if [ -n "$TST_SETUP" ]; then
> > +    $TST_SETUP
> > +fi
> > +

@Li first, thanks a lot for your feedback.

> Here maybe better to have a check before the tst_test:

> if ! declare -F tst_test > /dev/null; then
>     tst_brk TBROK "tst_test() function is not defined"
> fi

Sure, I can add a check for function existence. 'declare' is a bashism,
I use 'command -v' which we already use for $TST_SETUP and $TST_CLEANUP
in tst_test.h.

	if [ -n "$TST_SETUP" ]; then
		if command -v $TST_SETUP >/dev/null 2>/dev/null; then
			TST_DO_CLEANUP=1
			$TST_SETUP
		else
			tst_brk TBROK "TST_SETUP=$TST_SETUP declared, but function not defined (or cmd not found)"
		fi
	fi

> > +tst_test
> > --
> > 2.49.0


> Sorry, I should have pointed this out at the first review, but
> the idea came to my mind a little bit delayed :).

No problem :).

@Cyril any more feedback before I'll send a new version (v4)?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
