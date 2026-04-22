Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F0F9B61D
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 11:34:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 477E53E53B4
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 13:34:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A03C3E4A7E
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:34:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F1569200245
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 13:34:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32D1C5BD36;
 Wed, 22 Apr 2026 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776857659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8r0oV74QWfCkjdvK9OnG/Pzwgz22rSUxCWLwDZzFJ4=;
 b=iiHkNi24iX2yArRP0idt6jsJYfD5J7dgJzjwVw7H+F+sIR3qBQQTmyDwEYIoshuBGV5qy/
 UN/fpCJNVys5ZYKSOZXRp8T7hJm/HqoeHGgzyx+k5Gkzh3UfuBIrG6J46oLn3hlO+JgjJJ
 jSO4Qvi0BOhHpQIiFzfMuR3l/LpgaBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776857659;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8r0oV74QWfCkjdvK9OnG/Pzwgz22rSUxCWLwDZzFJ4=;
 b=Xo9q4ulg5FVo7+Bd9iD4JoRpDq4V1lQ2qqM/wXSzEYpMink4g5TbRRohL61+yn1QacQVi9
 BMHnbui+O+gqvHAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="o/+TE701";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="V+z+/q9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776857658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8r0oV74QWfCkjdvK9OnG/Pzwgz22rSUxCWLwDZzFJ4=;
 b=o/+TE701AsJTozAoqwA7iUkgvL6m8+xvJjhiARzTE78LhZNcfKBm6cbuxuhfGvl9a8JZTJ
 5Yc6fmpbv0i4elFF09TPYEojH6ho6h50mG4Tq7fBAdrMrV0siILerR0k2FCF5zdfHQnHix
 dVblhSwIZ9OS14TuGsv/qP2Yed70vmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776857658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E8r0oV74QWfCkjdvK9OnG/Pzwgz22rSUxCWLwDZzFJ4=;
 b=V+z+/q9H5i3238SRdvUigOFbW043VZFavPfGWimXLo5AL4abS5DSkOKLvY+Vz8halK7QB7
 vEPNub9tH7YACJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 109D6593AF;
 Wed, 22 Apr 2026 11:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v0JJAjqy6Gm4NAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 11:34:18 +0000
Date: Wed, 22 Apr 2026 13:34:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>, ltp@lists.linux.it
Message-ID: <20260422113408.GB402660@pevik>
References: <aehcGRoIxh8yW43y@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aehcGRoIxh8yW43y@gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,lists.linux.it];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 TAGGED_RCPT(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 32D1C5BD36
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] include/lapi: add leaf Makefile
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr, Jinseok,

> Petr Vorel wrote:

> > > Convert include/Makefile to use generic_trunk_target.mk and
> > > add minimal leaf Makefile in include/lapi.

> > add minimal leaf Makefile in include/lapi in order to have 'make check'.

> > FYI AI is correct it's better to describe the reason (although we have a ticket,
> > one day might github disappear and we lost the reason in the ticket).

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Wait little longer if Li has time to ack this.

> The v2 generally looks good (with Petr's suggestion).
> Feel free to merge/refine with:

> Reviewed-by: Li Wang <wangli.ahau@gmail.com>

Good, merged (I wanted to change the subject to have 'make check' but in the end
I kept the original. I dared to add my Suggested-by:.

And you're Cced with follow-up cleanup in include/Makefile.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
