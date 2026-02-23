Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80DEA4FA1
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:00:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E8733CAF9C
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 12:00:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B393B3D0EF2
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:59:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F1BDA140077C
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 11:59:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 842583EC1E;
 Mon, 23 Feb 2026 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771844346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kwerS9YCgIo2JmLKAqYRZnclVbODcBq5QOgDBTA3vc=;
 b=ClPf4Ad+7EPWaz073dDoQC/p8psMMTXZx61Usyambru2LY1ccYDVmvgAOi+DOgVisDDWFR
 zR1OzNoLQSDnRHFOhYjTxgbRl1Mu9D0yxKaRib+yE/FksAccGvKafLsnuzBdZdnzRZUNL8
 gR6VwJGsh1cqqEcr16I08ZZ+hQmTYnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771844346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kwerS9YCgIo2JmLKAqYRZnclVbODcBq5QOgDBTA3vc=;
 b=mbbV6faL+iWQUmnwPocikXnAmGMnw21E4ZRQ9sO7t2oXzxOyl8lapZSGDnxYkTnUoJ6lHy
 ZQ7K4iooylSxt5DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ClPf4Ad+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mbbV6faL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771844346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kwerS9YCgIo2JmLKAqYRZnclVbODcBq5QOgDBTA3vc=;
 b=ClPf4Ad+7EPWaz073dDoQC/p8psMMTXZx61Usyambru2LY1ccYDVmvgAOi+DOgVisDDWFR
 zR1OzNoLQSDnRHFOhYjTxgbRl1Mu9D0yxKaRib+yE/FksAccGvKafLsnuzBdZdnzRZUNL8
 gR6VwJGsh1cqqEcr16I08ZZ+hQmTYnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771844346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kwerS9YCgIo2JmLKAqYRZnclVbODcBq5QOgDBTA3vc=;
 b=mbbV6faL+iWQUmnwPocikXnAmGMnw21E4ZRQ9sO7t2oXzxOyl8lapZSGDnxYkTnUoJ6lHy
 ZQ7K4iooylSxt5DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6520A3EA68;
 Mon, 23 Feb 2026 10:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3crMF/oynGlNBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Feb 2026 10:59:06 +0000
Date: Mon, 23 Feb 2026 11:59:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <aZwzAWcZH3daeTBs@yuki.lan>
References: <20260219225007.218697-1-rbranco@suse.de>
 <DGJWBYPFA8X4.O6DWVQQLRNGT@suse.com>
 <1a05954d-e6b9-4e43-85f2-90ea94e8b68a@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1a05954d-e6b9-4e43-85f2-90ea94e8b68a@suse.de>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 842583EC1E
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add test using UFFDIO_POISON
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> +	uffd =3D SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
> > Maybe this one should be closed inside run(), or even remove it from
> > static variables and passed to the thread, so we keep it inside run().
> =

> But then we'd also have to fix the other tests.
> >> +
> >> +static struct tst_test test =3D {
> >> +	.test_all =3D run,
> >> +	.cleanup =3D cleanup,
> >> +};
> > You ar missing the runtest entry.
> =

> There's no runtest function.=A0 For now I'm using the other tests as temp=
late.

Runtest entry in runtest/syscalls

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
