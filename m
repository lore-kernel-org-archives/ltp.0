Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A423C021A0
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 07:55:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B3323C9A5C
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 08:55:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55BEC3C7831
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 08:54:59 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C42F11A04332
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 08:54:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CED171F387;
 Thu, 13 Feb 2025 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739433298;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfzcAsBv7o54E/OMPO0ODZdVwWTlT9RPsEJfmNqvOpY=;
 b=pWi/kZGcMOXF00Vl3ii+VsnKuK48IJ0C/7cbDgclrHm/JunFvX4illYtXJ6j6kUESQp9QM
 6tKAa+SxT8a5MOwHF4hzq/l0pteDyOTU8QiC2o2Z5az+V2E5b1pjLsHUvOoK316VhO30Oa
 khM5oZbQlV7tMTZVup5GTCTOOF53FJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739433298;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfzcAsBv7o54E/OMPO0ODZdVwWTlT9RPsEJfmNqvOpY=;
 b=INZ4CoqOFGqfBqaC9kSAIufNIgmHZLcBiTOVOGEK+AqnpJ/NhXj41IvDMLekCdwiRkF0p+
 5ZOC4zqRztYEtXDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qGgDcFu3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J+ElTBJy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739433297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfzcAsBv7o54E/OMPO0ODZdVwWTlT9RPsEJfmNqvOpY=;
 b=qGgDcFu3kPKe7QkH2j6CXvPfDzHEVvgRfJL1m/d+AdxoLxdJOApdY6IVYsHuzdXVV6xuF+
 C5MehrTJgjG9UQ40DCB+JPGvXJ5APTW5uirO5h9yvHAX9rLQ2YonvDJT5HpX/MhzFVzT2C
 0xaJME38xwZG7kVp//hN1tV+Lb7L1c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739433297;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfzcAsBv7o54E/OMPO0ODZdVwWTlT9RPsEJfmNqvOpY=;
 b=J+ElTBJyFgTQoDBp+Jh2YNoBpGZ1worBOi4bu2dS0t6NUMZoBg4Ag9SodBfu9UTdvAwdk7
 Jk0+4Os9ohOUzKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8346613874;
 Thu, 13 Feb 2025 07:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7h6sHVGlrWdvYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 13 Feb 2025 07:54:57 +0000
Date: Thu, 13 Feb 2025 08:54:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20250213075455.GA2148266@pevik>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-3-amir73il@gmail.com>
 <betolcydydpyyd45jncnozi6g7phk32anhn4kx3jvgrk4kvwzx@5covq3yufbp3>
 <CAOQ4uxgu16dOsU4uuq66CGqXw6wY8c8jK7sL1QheB8kTPU=X+g@mail.gmail.com>
 <20250211175639.GB1911494@pevik>
 <boqw2unsm67yetv42vrn4q2d4xsfwxhys5fdfjsei7k526ltmu@zkkhjvfj3bvj>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <boqw2unsm67yetv42vrn4q2d4xsfwxhys5fdfjsei7k526ltmu@zkkhjvfj3bvj>
X-Rspamd-Queue-Id: CED171F387
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] fanotify03: Add test cases for permission
 events on children
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

Hi Amir, Jan,
...
> > > You are right.
> > > I was "backported" from the pre-content test.
> > > The two else statements can be removed in this patch.

> > FYI I'm going to merge with the diff below (discussed change).

> > Jan, may I add your RBT?

> Yes. Feel free to add:

> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, merged with the change above.

Kind regards,
Petr

> 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
