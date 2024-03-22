Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B33AC47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 05:32:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 858813CD60E
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 06:32:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62FC03C81C3
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:32:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5B3A600C3B
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:32:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A82738074;
 Fri, 22 Mar 2024 05:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711085539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ilAhWal9Lo/Gw9rnmeuV/2MEoVkPkklww3jjVYdZU0=;
 b=MR3N0WhDCZ7j5S8OUL7NkIOv1sHjUvFFcnPZfzulw1X63i8742JTO9pGyHu8NR13AXf2oZ
 GRNdoTwZxMPHpvqkiQIyjvfpYSYU7tCZWO4zxCNKCh6a1LgWOZIa5xJHQ3pHey6oKT6Mr4
 pUuLUh7rU1xLazYE9cOXZ2qE+pGiLWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711085539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ilAhWal9Lo/Gw9rnmeuV/2MEoVkPkklww3jjVYdZU0=;
 b=CjHGuMFb0b0mFljUcDFysGZ79qQkKY12cMLa79tjY6mAPW5p+gF5SYSOBCeXDUj75Aahh4
 NHfJem/EjTifaLBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711085539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ilAhWal9Lo/Gw9rnmeuV/2MEoVkPkklww3jjVYdZU0=;
 b=MR3N0WhDCZ7j5S8OUL7NkIOv1sHjUvFFcnPZfzulw1X63i8742JTO9pGyHu8NR13AXf2oZ
 GRNdoTwZxMPHpvqkiQIyjvfpYSYU7tCZWO4zxCNKCh6a1LgWOZIa5xJHQ3pHey6oKT6Mr4
 pUuLUh7rU1xLazYE9cOXZ2qE+pGiLWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711085539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ilAhWal9Lo/Gw9rnmeuV/2MEoVkPkklww3jjVYdZU0=;
 b=CjHGuMFb0b0mFljUcDFysGZ79qQkKY12cMLa79tjY6mAPW5p+gF5SYSOBCeXDUj75Aahh4
 NHfJem/EjTifaLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE236136AD;
 Fri, 22 Mar 2024 05:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Yy5LOeIX/WW+eQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Mar 2024 05:32:18 +0000
Date: Fri, 22 Mar 2024 06:32:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240322053217.GA588706@pevik>
References: <20240322030208.3278120-1-liwang@redhat.com>
 <20240322050046.GA572447@pevik>
 <CAEemH2c3SNktFnPpsnbXvtTvfEv84byRrNmjcz3YyQHem9mcGg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c3SNktFnPpsnbXvtTvfEv84byRrNmjcz3YyQHem9mcGg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MR3N0WhD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CjHGuMFb
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[32.02%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0A82738074
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] libswap: add two methods to create swapfile
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

Hi Li,

> > -       char mnt_path[100];
> > +       char mnt_path[128];

> > nit: why this increase to 128? Why not PATH_MAX?


> No special meaning, I just thought of using 2 raised to the nth power.
> But you're right, PATCH_MAX will be safer.

+1

...

> Thanks, I would give the patch set more time in case others have comments.

Sure. Thanks for a nice work!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
