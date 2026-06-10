Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4437CD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 08:17:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB0543E4E62
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 10:17:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E5E83C30BC
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 10:17:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 63069200261
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 10:17:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D561675848;
 Wed, 10 Jun 2026 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781079424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICrgQyTt1+l1OlKtFmBmBi6SO/+K5hFw7Ush0/Qpkks=;
 b=BxYqCkA377nsF7+xuBHMvgTXGiPPtnV9LIsd2Q4rDCGswfNjlPt50I8f2mND0a8RKfk3/N
 RLH2uY7JPPNlaQM1VPLvwrSawyzes6NxNu83dZoamomJxyIScyvLpeJ8BPsRNXKFkqnw8r
 XIi6pj0Axz2PoZUk8il8fzPkANM9DI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781079424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICrgQyTt1+l1OlKtFmBmBi6SO/+K5hFw7Ush0/Qpkks=;
 b=miBVprEN9ij7PtRSh9JdNXhwxa21YGe5lhUGTrl/1h2IDUprpi4gzyN9qKyIKJUhkqPgkK
 IIUrySobcFEZVADA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781079423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICrgQyTt1+l1OlKtFmBmBi6SO/+K5hFw7Ush0/Qpkks=;
 b=ERnh/kr+2QMim5aC83DNMsy+Sk+oyy0gv9n3uGBlKfB+Alewn+dOWDNXMC+ZjYkhXEXSHu
 /SeW9TQksVDGOyN1npN6fFuYPULk6fLTI59Xvcuo3rf5Ta8yiJnL5mv3MTnnZmOKymayJj
 JOD1SAQJt2Wdo7JdsPoTHYUUGrvY5y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781079423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ICrgQyTt1+l1OlKtFmBmBi6SO/+K5hFw7Ush0/Qpkks=;
 b=qUiVECMThTmG9Y/QU0KM6GzjouPicKT7ZUHSJGx5Ly/7tyt1pXEI3pjBnHTGJ3i5fXV+ZW
 FHBQA3uNXx74eQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C53BF779A7;
 Wed, 10 Jun 2026 08:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7qr9Ln8dKWqJcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jun 2026 08:17:03 +0000
Date: Wed, 10 Jun 2026 10:16:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <aikdelheEgvfx9_O@yuki.lan>
References: <20260609143237.1246776-1-chrubis@suse.cz>
 <CAASaF6wcvPUD38N=9o+MSv6e0oFkURCiCB-s5o+ip-hVg-x4Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wcvPUD38N=9o+MSv6e0oFkURCiCB-s5o+ip-hVg-x4Ew@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, intel.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test: Add needs_cpu_vendor to struct tst_test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This adds a generic implementaiton of needs_cpu_vendor to the tst_test
> > structure that is based on parsing /proc/cpuinfo. It does not likely
> > work for non-x86 CPUs since the /proc/cpuinfo format is different, but
> > we do not care at the moment. For arm we would have to look at the
> > implementer field instead, we will add that if/once needed.
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > CC: Piotr Kubaj <piotr.kubaj@intel.com>
> 
> Acked-by: Jan Stancek <jstancek@redhat.com>
> 
> I'm curios what test needs it.

https://patchwork.ozlabs.org/project/ltp/patch/20260609121840.61087-2-piotr.kubaj@intel.com/

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
