Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDA5C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 10:20:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AA173CE0C8
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 12:20:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76823CAEB6
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:20:04 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5899F1A00CA3
 for <ltp@lists.linux.it>; Thu,  9 May 2024 12:20:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48CD338288;
 Thu,  9 May 2024 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715250003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICRmzEAl+0P1yhky0ve3zm69fksx+a997Df0pvf8oUQ=;
 b=AN4VkKf8GS6gqEn+e6dRrywGkAHvuDXLst24/I+/+9VgUTnK6Vm8YsLoNzVhdGacJQxvLf
 3v3WxkqUmJpQJu6OJxGBmYsUqXYy3As/4WITdiKHexP5fT+TpeSwRVDBtsQdgUf9WRlw33
 e/cK5l8ga3hcYNPJR2hi0FYGHc0xJHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715250003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICRmzEAl+0P1yhky0ve3zm69fksx+a997Df0pvf8oUQ=;
 b=a9CBKgiQeCkdF0u34hcDxbKPDoDYZB+SwXZBVHUeyn736/FZUu3a5UFzCqHvei10wh9En1
 xC+Ymvr5FfQxZ/AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715250003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICRmzEAl+0P1yhky0ve3zm69fksx+a997Df0pvf8oUQ=;
 b=AN4VkKf8GS6gqEn+e6dRrywGkAHvuDXLst24/I+/+9VgUTnK6Vm8YsLoNzVhdGacJQxvLf
 3v3WxkqUmJpQJu6OJxGBmYsUqXYy3As/4WITdiKHexP5fT+TpeSwRVDBtsQdgUf9WRlw33
 e/cK5l8ga3hcYNPJR2hi0FYGHc0xJHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715250003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICRmzEAl+0P1yhky0ve3zm69fksx+a997Df0pvf8oUQ=;
 b=a9CBKgiQeCkdF0u34hcDxbKPDoDYZB+SwXZBVHUeyn736/FZUu3a5UFzCqHvei10wh9En1
 xC+Ymvr5FfQxZ/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FADE13941;
 Thu,  9 May 2024 10:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fUUIBlOjPGZNPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 10:20:03 +0000
Date: Thu, 9 May 2024 12:20:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240509102001.GA243374@pevik>
References: <20240429115419.30614-1-andrea.cervesato@suse.de>
 <CAEemH2dmqSfaMJWNX_vvc1DM6Etho-XSY+nMzGPEwEOwZR9pqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dmqSfaMJWNX_vvc1DM6Etho-XSY+nMzGPEwEOwZR9pqQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.48 / 50.00]; BAYES_HAM(-2.98)[99.89%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite fcnt14 test
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

Hi Andrea, Li,

> Hi Andrea,

...
> > +struct tst_results {
> > +       int num_pass;
> > +       int last_failed;
> > +};


> Well, I do not object to hiding the test outputting during
> each run, but the disadvantage is if we deploy LTP in CI/CD
> typically we get nothing useful on one-off failure logs.
> (thus we have to rerun it with '-D' manually for reproduction)

@Li For CI is more convenient to set LTP_ENABLE_DEBUG=1 environment variable.
-D was meant for runtime testing when developing a test (faster than set
an environment variable).

I updated it in the docs (it was not mentioned there):
https://linux-test-project.readthedocs.io/en/latest/developers/debugging.html

> So I can't tell if the total results are meaningful unless we get PASS
> every run.

> Or, we give more options in the runtest file for user choice?

> # cat /runtest/syscalls
> fcntl14_03  fcntl14 -n 10 -D
> fcntl14_03_64  fcntl14_64 -n 10 -D
> fcntl14_04  fcntl14 -n 10 -D -l
> fcntl14_04_64  fcntl14_64 -n 10 -D -l

> And, "tst_" prefix is only used by LTP common APIs, so here we shouldn't
> abuse it.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
