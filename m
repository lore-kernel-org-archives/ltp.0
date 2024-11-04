Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B91D132A6
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 10:31:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAC493D0631
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 11:31:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5187A3D0279
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 11:31:11 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CC2F212FFE
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 11:31:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4C7F1FDCB;
 Mon,  4 Nov 2024 10:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730716266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsYS7ZE4kG6OIrMA8jyl/as8R2QCqtDQpdLFL+QAMgE=;
 b=Cqp6J/8LMymuiHgPI31WSC0J00GFzVdX5qBRyzbK+NAtvniHnc40oK3VMtpgbOWIxng7K5
 tqD0C/PP17HjHVYsrsRqKJWuv3US/79BjYgiKsWiNh3G7xguI3Y9A8GBRhrpbOy8S3O2cy
 pbJ9U6csnRxtJmPHLV8GdnfvxIqgPp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730716266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsYS7ZE4kG6OIrMA8jyl/as8R2QCqtDQpdLFL+QAMgE=;
 b=KKBrx5YjFaP410dtFneDf2ZpYtJ8Jxx3kKHptwHWBhfhMq62PCgb2oYga2junw57S48ueU
 z7MN4V0Glxxh2uBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bYiJhILb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NWP0ci3G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730716265;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsYS7ZE4kG6OIrMA8jyl/as8R2QCqtDQpdLFL+QAMgE=;
 b=bYiJhILbAQ9zF40cdvaeUNzAdW9mfQbid0aXmH6A3sBX8LktTj5YsPkvKPgqz5iy4/bdvf
 iwioJo5EZjdN2WY3hu3aySOeMZze4UqCfhx3MjmB6mmg/VWKcHaPVYMF/bA+IgI4lEaxju
 Umm9zI8aFgwpBjm7MvIwzSdBQVxkQ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730716265;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsYS7ZE4kG6OIrMA8jyl/as8R2QCqtDQpdLFL+QAMgE=;
 b=NWP0ci3G2j6Pwfwc8ki9/APEdiHkzPFIT/RCw8wheiGJRYCEOnihEcyLb8LWjJIXlaLnUP
 7okO5dIBrD9vz4Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C277513736;
 Mon,  4 Nov 2024 10:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RSnTLWmiKGfgMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Nov 2024 10:31:05 +0000
Date: Mon, 4 Nov 2024 11:31:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20241104103104.GA1388681@pevik>
References: <5be090bd107e8cff5823fc35d9c0b9c8ee082ec6.1730466072.git.jstancek@redhat.com>
 <CAEemH2fp41P8f1_BG=3uTgCo3eG49Bq8_kntz0+oj=pDS5DxPA@mail.gmail.com>
 <20241104091305.GA1382167@pevik>
 <CAASaF6xLYzU8o8qn-X1k8p00yV76fLNt695OSfb2XD5c7C6pew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xLYzU8o8qn-X1k8p00yV76fLNt695OSfb2XD5c7C6pew@mail.gmail.com>
X-Rspamd-Queue-Id: E4C7F1FDCB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sched_getattr02: use a fixed size for
 EINVAL test
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

Hi Jan,

...
> > +++ include/lapi/sched.h
> > @@ -46,6 +46,8 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
> >  {
> >         return syscall(__NR_sched_getattr, pid, attr, size, flags);
> >  }
> > +#else
> > +# define SCHED_ATTR_SIZE_VER0  48      /* sizeof first published struct */

> ^^ not in else branch, the check is "ifndef", so that's where it needs
> to be defined

I'm sorry, thanks for catching my error.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
