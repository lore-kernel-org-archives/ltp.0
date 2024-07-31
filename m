Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F8C3DA7F
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 19:31:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FFE63D1EBC
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 21:31:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D90653D0934
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 21:30:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7A86200322
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 21:30:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B703521A56;
 Wed, 31 Jul 2024 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722454250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlGroECRQiNtMmsXbFFmqbsRqftaHI/HvReW+l2elWA=;
 b=ZPGvaAWJzYp+IvuwrFL8EewYVH8H7xPFLhG9cRT44XVPIueHM+iY/JLs4RmAYyJojt+aeu
 1Ec9DAvBvqsXCsi4/407uGHJqKzfpbSJViMU1sBj1yXMpvixzRQsxXHBsYUFhz6c+uoglv
 BBKj5ECfbsPV3ryS1sdnGZql4Yx51rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722454250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlGroECRQiNtMmsXbFFmqbsRqftaHI/HvReW+l2elWA=;
 b=Q3dqaM1NMN7ry2GcmHFBEJW6hq0A94NG+gTfr8AA6+osM5sPKVVirk0WT/O3lWpflEoiQK
 T/SFou3pvIRFhdBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722454250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlGroECRQiNtMmsXbFFmqbsRqftaHI/HvReW+l2elWA=;
 b=ZPGvaAWJzYp+IvuwrFL8EewYVH8H7xPFLhG9cRT44XVPIueHM+iY/JLs4RmAYyJojt+aeu
 1Ec9DAvBvqsXCsi4/407uGHJqKzfpbSJViMU1sBj1yXMpvixzRQsxXHBsYUFhz6c+uoglv
 BBKj5ECfbsPV3ryS1sdnGZql4Yx51rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722454250;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlGroECRQiNtMmsXbFFmqbsRqftaHI/HvReW+l2elWA=;
 b=Q3dqaM1NMN7ry2GcmHFBEJW6hq0A94NG+gTfr8AA6+osM5sPKVVirk0WT/O3lWpflEoiQK
 T/SFou3pvIRFhdBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9262313297;
 Wed, 31 Jul 2024 19:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v4HmIeqQqmaiSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jul 2024 19:30:50 +0000
Date: Wed, 31 Jul 2024 21:30:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240731193051.GA1428673@pevik>
References: <20240731073403.1406035-1-pvorel@suse.cz> <ZqoSvzmu3vmJugC7@yuki>
 <ZqoUaJ4sc30EHzNm@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqoUaJ4sc30EHzNm@yuki>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] cachestat01: Reduce required space on 64kb
 page size
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

> Hi!
> > > +	num_shift = MIN(tst_device->size*1024*2.6/page_size, 15);

> > I guess that we can make it future proof by rounding the 2.6 to 3 just

> And that is on the wrong side obviously, so we should do rounding down
> to 2 or 2.2 or something along the lines.

Yes, 3* would fail.

FYI df on good, after last run:

2* => max num_shift < 9 => 1 << 8 (256 pages)
/dev/loop0     xfs      241664   20304    221360   9% /var/tmp/LTP_cacSuoazD/mntpoint
/dev/loop0     btrfs    307200   22368    207872  10% /var/tmp/LTP_cacSuoazD/mntpoint

2.5* => max num_shift < 11 => 1 << 10 (1024 pages)
Highest usage (others have 1% or even 0%):
/dev/loop0     xfs      241664   20304    221360   9% /var/tmp/LTP_cacanBaAa/mntpoint
/dev/loop0     btrfs    307200   71648    158720  32% /var/tmp/LTP_cacanBaAa/mntpoint

2.6* (or 2.7) => max num_shift < 12 => 1 << 11 (2048 pages) => last OK
Highest usage (others have 1% or even 0%):
/dev/loop0     xfs      241664   20304    221360   9% /var/tmp/LTP_cacFYiONa/mntpoint
/dev/loop0     btrfs    307200  137344     93184  60% /var/tmp/LTP_cacrzr4vk/mntpoint

Failures:
2.8* => max num_shift < 13: 1 << 12 (4096 pages) => FAIL on XFS, Btrfs
3* => max num_shift < 14 => 1 << 13 (8192 pages) FAIL on all filesystems

Problem is only with Btrfs and XFS. Others have between 0-1% (including
Bcachefs). Therefore 2.6* (or 2.7*) is IMHO still secure.
If you worry, we can have 2.5* (more secure).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
