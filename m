Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23F8CD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 08:44:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F7053E54F1
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 10:44:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77F403E2773
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 10:44:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A9F781A002DB
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 10:44:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2095A6A932;
 Thu,  4 Jun 2026 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780562643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qigw9E7Sh9foT8gd48kRloiWXfvkxi1pHGgpl/cKoMY=;
 b=zTwLNkRc102MvdvSimMU3gHqTltGQfoBhqM8O5FJ54yFPdHdV6TuVOJ+RoAyqvtb6JEa+j
 21mrKMrlmsBni5QhAobkamW4Pa2T2ioeL2gbPmpJWNM6Lpzhg6SX/r0OjXSU1zkdcWQPs5
 pzDHBXFTHoKrNoeDodHOa2yhRv7BqpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780562643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qigw9E7Sh9foT8gd48kRloiWXfvkxi1pHGgpl/cKoMY=;
 b=We64VyQZELt98xY7YlNE0WGid+Ma433BxwLA6k6oOPqjZo+FYZrtH1Mw8vizKPRZrn7gg6
 YHVBCgDXNo23WNAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780562643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qigw9E7Sh9foT8gd48kRloiWXfvkxi1pHGgpl/cKoMY=;
 b=zTwLNkRc102MvdvSimMU3gHqTltGQfoBhqM8O5FJ54yFPdHdV6TuVOJ+RoAyqvtb6JEa+j
 21mrKMrlmsBni5QhAobkamW4Pa2T2ioeL2gbPmpJWNM6Lpzhg6SX/r0OjXSU1zkdcWQPs5
 pzDHBXFTHoKrNoeDodHOa2yhRv7BqpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780562643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qigw9E7Sh9foT8gd48kRloiWXfvkxi1pHGgpl/cKoMY=;
 b=We64VyQZELt98xY7YlNE0WGid+Ma433BxwLA6k6oOPqjZo+FYZrtH1Mw8vizKPRZrn7gg6
 YHVBCgDXNo23WNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 061CE779A8;
 Thu,  4 Jun 2026 08:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yC9yO9I6IWoSHQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Jun 2026 08:44:02 +0000
Date: Thu, 4 Jun 2026 10:43:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: panzhe <panzhe@kylinos.cn>
Message-ID: <aiE6x3L3trEaeQKk@yuki.lan>
References: <--compose>
 <20260604072637.147497-1-panzhe@kylinos.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260604072637.147497-1-panzhe@kylinos.cn>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] gethostname02: Accept EOVERFLOW on alpha
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
> The ENAMETOOLONG note in man describes the mainstream glibc implementation based on uname(2), but alpha has its own arch-specific implementation calling raw gethostname syscall and returning EOVERFLOW.
> Alpha glibc source:
> https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/alpha/gethostname.c.html

This really looks like a inconsistency in glibc. I suggest to ask a
question if this should be fixed in glibc on libc-alpha mailing list
first. Please CC ltp mailing list when you ask this question.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
