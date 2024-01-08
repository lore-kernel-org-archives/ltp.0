Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B93C3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 11:20:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CA513CFE24
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 12:19:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FE5E3C8B55
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 12:19:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52AE360066F
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 12:19:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57D8B21DA5;
 Mon,  8 Jan 2024 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704708081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlWShqjOKUBsu8m1F+QnDCfvDJCg/ee5PVLq5rTSE6o=;
 b=BmeQ3US+1vod9O83ekeM5WVxVpQysq1l9qsEy6tRtwVWgU/K+EHpslvoqWzM4zBDt7KKff
 oRjqiTgqnVRAGkZzQ8BV9b2ts4qwEEcygeBcnEEEQXpnVgRn4hLsU6zvFAlbtMzqiDW5Me
 vP4rIjDiKu/J1byXglWYAheNsyOwHJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704708081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlWShqjOKUBsu8m1F+QnDCfvDJCg/ee5PVLq5rTSE6o=;
 b=HeyWBfslA3ykwlwSkmajFoq2ZiXj639ON/RYlojA7OkrHaxZHr10F7XVVWFATLmAYfJHpd
 QxbrnWxo8zNHgbAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704708081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlWShqjOKUBsu8m1F+QnDCfvDJCg/ee5PVLq5rTSE6o=;
 b=BmeQ3US+1vod9O83ekeM5WVxVpQysq1l9qsEy6tRtwVWgU/K+EHpslvoqWzM4zBDt7KKff
 oRjqiTgqnVRAGkZzQ8BV9b2ts4qwEEcygeBcnEEEQXpnVgRn4hLsU6zvFAlbtMzqiDW5Me
 vP4rIjDiKu/J1byXglWYAheNsyOwHJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704708081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jlWShqjOKUBsu8m1F+QnDCfvDJCg/ee5PVLq5rTSE6o=;
 b=HeyWBfslA3ykwlwSkmajFoq2ZiXj639ON/RYlojA7OkrHaxZHr10F7XVVWFATLmAYfJHpd
 QxbrnWxo8zNHgbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 488B91392C;
 Mon,  8 Jan 2024 10:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0UUWEfHHm2WeNAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jan 2024 10:01:21 +0000
Date: Mon, 8 Jan 2024 11:01:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Message-ID: <ZZvIBO-a1b_nIHJ8@yuki>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 57D8B21DA5
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BmeQ3US+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HeyWBfsl
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[13];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,redhat.com,suse.com,fujitsu.com,vger.kernel.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[28.56%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] statx04: Skip STATX_ATTR_COMPRESSED on
 Bcachefs
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> On Thu, Dec 07, 2023 at 08:40:11PM +0100, Petr Vorel wrote:
> > STATX_ATTR_COMPRESSED is not supported on Bcachefs, thus skip it
> > (it's already skipped on tmpfs and XFS).
> 
> Hang on, bcachefs most definitely does hae compression. This would be
> just because statx isn't plumbed through?

Quite likely, other filesystems does have an inode flag that is set when
file has been compressed and simply report that in the foo_getattr()
callback. Looking at bcachefs I supose that we need to figure out if the
inode is v3 and then unpack the v3 info to get to the compressed flag,
you probably know best how to do that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
