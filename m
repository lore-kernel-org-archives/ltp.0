Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E53C021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 09:35:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 630F73C2F29
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 10:35:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BCED3C050F
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 10:35:05 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CECCD100DEB4
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 10:35:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1D9A210F2;
 Thu, 20 Feb 2025 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740044103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DgU2WvSuFYa/OVTYlWBnebTC9qNwZdDIvjfOBnVg/dA=;
 b=IBLwHjRew/aULfyEGn1plovsjxvuYN9XD1xxFWz1XPO4BfOilCt9TNTHKQQlK/zJ36dU8Q
 HnAjWge0M3e/O1Ue9RkhMAGaxFOolRrFb/wTMrLEJ1sMyPPdd8rzDfwAil5EKoHKp6gcTa
 85E7tT8OyORfHxRBNgNTi+jQK50j5ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740044103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DgU2WvSuFYa/OVTYlWBnebTC9qNwZdDIvjfOBnVg/dA=;
 b=MWcq66WgyQ5CpTNA0gEBUFrT7FuNFw/qxxmgcP0u9DZl+6TkBePFKaxdGyz/tEJchsOyg4
 nlO7Hyr9Au7zQrBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2vzbfOpb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hUaI8yQf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740044102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DgU2WvSuFYa/OVTYlWBnebTC9qNwZdDIvjfOBnVg/dA=;
 b=2vzbfOpb2KxR80MRlVTpZL41SDYaVKVsdxs4G3dB8WB3Llhmq3IZZtJnswwUGbJMn+GocW
 p1y+q+0hSDAuzIdkjk5ZSH6rMWijUrz7JHpkyjvVUls+gsUvglypbqv7OLjPtpB+2lzzdd
 4vIYP3x+bLE/cw0EfljLQwa5gnCp92I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740044102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DgU2WvSuFYa/OVTYlWBnebTC9qNwZdDIvjfOBnVg/dA=;
 b=hUaI8yQft2rTH0WBxMwX/5kqywNfYCrS4iw0ZiQVkAOSniiWyTyxMnj8tssO2h4y6nXVAt
 dgAA+anJrTLd56AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32B7013A42;
 Thu, 20 Feb 2025 09:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cVG/BUb3tmeodgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Feb 2025 09:35:02 +0000
Date: Thu, 20 Feb 2025 10:35:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250220093500.GA2654481@pevik>
References: <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
 <20250219064804.1313358-1-chwen@redhat.com>
 <20250219164449.GB2590174@pevik>
 <CAEemH2fOu4FeMMEQmVWDi+tSQEVzPK0-b8-yZONt137ix8Ttkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fOu4FeMMEQmVWDi+tSQEVzPK0-b8-yZONt137ix8Ttkw@mail.gmail.com>
X-Rspamd-Queue-Id: A1D9A210F2
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test case to cover the setting resource
 limit64 for process
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
Cc: ltp@lists.linux.it, Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Chunfu Wen,
...
> > > +static int setrlimit_u64(int resource, const struct rlimit64 *rlim)
> > > +{
> > > +        return tst_syscall(__NR_prlimit64, 0, resource, rlim, NULL);
> > I suppose using raw syscall is really needed, right?

> Yes, using the raw syscall for prlimit64 is necessary in this case.

> From what I know, Chufu is working oin an environment where glibc's
> wrapper might interfere, using tst_syscall(__NR_prlimit64, ...) ensures
> that the raw syscall is executed without relying on glibc behavior.

Li, thanks for info.

> @chuwen, this new case is quite similar to setrlimit06.c, maybe we
> can combine into one and use .test_variants to traverse all syscalls.
> e.g. syscalls/stime/stime_var.h.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
