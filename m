Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B1BC61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:51:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F09C3E9A5D
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:51:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A10A3C0E10
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 15:51:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 156E31000606
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 15:51:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ED3241FE1C;
 Fri, 28 Aug 2026 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787925071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tHAJTryEdluZJo3dsqDD4mvBEm9y5u2bEI6YqV+4uE=;
 b=3GDl6fJZhU55eLKcCrn64ZwetbKo1hNDv90SXh6XqL4Wf0+q2klpNx6E5PJAp/ojZrXOsy
 lQEeTdRK3OCJos7UPeL/IsEm+8tQF+DnL7nZiGFxuLt3DwsNHJcLIKDuvFQjUjC6W66Mdb
 N5YfXGG3sFazCMh8lQ7cDSm9DpnPjQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787925071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tHAJTryEdluZJo3dsqDD4mvBEm9y5u2bEI6YqV+4uE=;
 b=3UCyNz2Kp99feYZs9n5rEGMWqCF+MIW7J6TcE+ufJQdVk6wClbh6cr/KtOxzQaSjck1xrz
 9nXrlUdwxOfvEzBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uxHk1YQ/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rOsSi8VA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787925066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tHAJTryEdluZJo3dsqDD4mvBEm9y5u2bEI6YqV+4uE=;
 b=uxHk1YQ/raSlnuD5v1gRFgBUrpK/Pf+NIkOIBN+KiJFKzhvIRjTFo/3XlRQqOkwAxeUSLT
 6fABXkOFmmlNej8zaB7MYMAfrexNySuefZJsKJ+Bp92QKy3iU+Wc+XwMR0MVH+nCn6Ctcp
 Szf6oBh/zWnLb34QdJiMFkpA6N4SXmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787925066;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tHAJTryEdluZJo3dsqDD4mvBEm9y5u2bEI6YqV+4uE=;
 b=rOsSi8VAOgyAOzX/ghSd61rwCMomKOvBiVGW11t5DnKduWwDdD63VL21cMBRJ3E4iHcJH0
 O94KDkW1adoSbHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C95351352D;
 Fri, 28 Aug 2026 13:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ftwcMUqSkWo/BgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Aug 2026 13:51:06 +0000
Date: Fri, 28 Aug 2026 15:51:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <apGSSZrHmOe4M4yO@yuki.lan>
References: <aocM-vVTSlaqdXve@yuki.lan>
 <6a918e90.62f374cd.18666e.d1ad@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a918e90.62f374cd.18666e.d1ad@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED3241FE1C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 06/16] fchroot03: test fchroot()
 permission checks
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > Verify that with a regular directory fd the kernel first checks the
> > > execute permission on the directory and then CAP_SYS_CHROOT: an
> > > unprivileged process with an accessible directory fails with EPERM and
> > > a process without execute permission fails with EACCES.
> > 
> > Here as well, the order of the checks is subject to change.
> 
> sorry I don't get the review, can you please explain where is the
> issue? it's a description problem only?
> 
> same for the other reviews

The problem here is that the order in which kernel checks for
CAP_SYS_ROOT or invalid fchroot() flags is not defined. It checks for
CAP_SYS_ROOT last now, but that is not something we can take for
granted.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
