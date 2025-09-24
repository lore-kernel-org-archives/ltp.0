Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3FFCAC5B0
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 13:17:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D01C3CDF85
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 15:17:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C824C3CDC15
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 15:17:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 64FED1000796
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 15:17:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9A075C7FD;
 Wed, 24 Sep 2025 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758719828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKG9pMzqRXLGBSTQyYICh95L1OCNKtK2zNfbIWH9TZk=;
 b=lW1+vYtMQvWAC1LLIeGj3L+xvy+JKdE1cI+CRinHPgSMiRHbZetn+c+VdpOWsdVRSRtVgh
 eltGJ/FqgjWeNckX6Gh7oyC4iU0TE4BkQ2Xqa4Gu58zSntOqrh60whc6fqLpijfx2lZk44
 kiuPSxQ+sDdJ4n6CXeVWnuwNbGc8dhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758719828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKG9pMzqRXLGBSTQyYICh95L1OCNKtK2zNfbIWH9TZk=;
 b=Np4H/TWzdVNwoYq0abMcyUfPOivqcG9kdxNWY5QpbaMs2xZhX6V012wQm0S49jh9sVnZa0
 JKs3z2T5SaT0LCCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Fs+fXYKg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1cFhiFVb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758719827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKG9pMzqRXLGBSTQyYICh95L1OCNKtK2zNfbIWH9TZk=;
 b=Fs+fXYKgoEKWSqbDdchvxF73O9Pd14vqjpc+NgYq0gpu4cwTx408K+7NhojCuZ1suv9Tsx
 gqOOb+ZMVAb28sEAw/2shoibvya5DRwbYsKB/etkmDE6pFt8dNoNracL4261BwA7Qtsosy
 6qB8eP3TzaGZi7XCiOAaN0N0clphomU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758719827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKG9pMzqRXLGBSTQyYICh95L1OCNKtK2zNfbIWH9TZk=;
 b=1cFhiFVbfb9ShE02TZ8yneIiHHly/8owxccWCvpW+PF5srISoQeKWTEziBwncJbCLiHof7
 VHrN0ifhXlIQrcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF71D13A61;
 Wed, 24 Sep 2025 13:17:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GjNbK1Pv02iFZAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Sep 2025 13:17:07 +0000
Date: Wed, 24 Sep 2025 15:17:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aNPvgKjN0TY3XZvJ@yuki.lan>
References: <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
 <aMDV1aTCZ--ElqfY@localhost> <20250918145335.GA432906@pevik>
 <aMwms-DHHeF5U7PG@yuki.lan> <aNNWzGWH56SLSXza@localhost>
 <aNO_uJvhPaZUSR1s@yuki.lan> <aNPKtagFqkL_dIZ-@localhost>
 <aNPN9N-Zadq0h7Vs@yuki.lan> <20250924125501.GA70531@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250924125501.GA70531@pevik>
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[suse.com,lists.linux.it,gmail.com,suse.cz,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim]
X-Rspamd-Queue-Id: D9A075C7FD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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
> > > Correct me if any misunderstanding, many thanks.
> 
> > Sounds reasonable and we could also add a nice function to the test
> > library:
> 
> > bool tst_cmd_present(const char *cmd);
> 
> > that would loop over the tst_cmd array and return the supported flag
> > value.
> 
> +1, although not sure if we want to finish this before the release.

This is obviously something to be done later.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
