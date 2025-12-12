Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA26D4922D
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 14:39:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4C3B3C8515
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 15:39:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2393C7F80
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 15:39:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD6C51000947
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 15:39:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 326AA33728;
 Fri, 12 Dec 2025 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765550346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWduPNwVVIxoGjYnX4Fw53EX6Y7hHVt/mL9fwHTMO5M=;
 b=n2degPokzgaKWSkJeNfrxPj2pad7Jls6rVyhGMgtMRBbGZnhM6JWMekORoDYZ+xp7uYGAg
 361tozdkxqP936RCBVPSBvKjG371YJSUP9+xvvYg87mcr8O/Vo1NyCMPnk/UsvJG+JW87n
 GMuTGzU/KsDcv8rutNuSiImYN/CjzT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765550346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWduPNwVVIxoGjYnX4Fw53EX6Y7hHVt/mL9fwHTMO5M=;
 b=el3OOG1VDLFD49UtsdSKsaMXodkvx0iV/0ksRDTHy/9IGxURMPhxxq07ahlvrAglgxky4q
 fg7nsYxG4F+zd/Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765550346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWduPNwVVIxoGjYnX4Fw53EX6Y7hHVt/mL9fwHTMO5M=;
 b=n2degPokzgaKWSkJeNfrxPj2pad7Jls6rVyhGMgtMRBbGZnhM6JWMekORoDYZ+xp7uYGAg
 361tozdkxqP936RCBVPSBvKjG371YJSUP9+xvvYg87mcr8O/Vo1NyCMPnk/UsvJG+JW87n
 GMuTGzU/KsDcv8rutNuSiImYN/CjzT0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765550346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWduPNwVVIxoGjYnX4Fw53EX6Y7hHVt/mL9fwHTMO5M=;
 b=el3OOG1VDLFD49UtsdSKsaMXodkvx0iV/0ksRDTHy/9IGxURMPhxxq07ahlvrAglgxky4q
 fg7nsYxG4F+zd/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17FEE3EA63;
 Fri, 12 Dec 2025 14:39:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Za9cBAopPGlwTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Dec 2025 14:39:06 +0000
Date: Fri, 12 Dec 2025 15:39:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20251212143904.GE125889@pevik>
References: <20251212104025.15924-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251212104025.15924-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_detach_device: Clear leftover partitions
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

Hi Martin,

> Some kernels have a race condition during loop device release
> which results in partitions being left over on unattached device.
> The partitions then cause mkfs.vfat failures in later tests.

> Check for loop device partitions after detaching it and clear them
> if necessary.

Nice work, thanks!

Looping ioctl_loop01.c and ioctl_ficlone02.c I reproduce the problem after 171
iterations:

ioctl_loop01.c:75: TPASS: access /sys/block/loop0/loop0p1 succeeds
tst_device.c:321: TWARN: Detached device /dev/loop0 has leftover partitions

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
