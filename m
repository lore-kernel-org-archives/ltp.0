Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2202810A62DA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:17:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2AB23CC313
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:17:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4AD13C572F
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:17:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 006371000A62
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:17:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 577BC4D2B5;
 Thu, 26 Mar 2026 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774534649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWj20J4BVZhCCAVyDPTLtKcDv/MjsuR6OK1nSBZ1MVw=;
 b=TJ6xAhRTVgPSOxNp/C8DazC5p6bei05l1uWlqTJWF1YoVoYiH+aXlTKpi8gKIWa58+yZXA
 5WSSOoP889yk5Z7bpKWXkK+i4piPultHhL1Dh+pYNHuUoxW2BokT5ohsuuPbwc7+D2ehwf
 N399A3bOqMiOi5NDDBXCV33lQ9KSR74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774534649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWj20J4BVZhCCAVyDPTLtKcDv/MjsuR6OK1nSBZ1MVw=;
 b=f7BmwyLUdOiPdPu70sxGb9QoLjidCvJeqfXcZwTsklnihNU2lYXqxQqpk3pq0D0h+4wCwn
 vNL2KXkhfUpZN3CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TJ6xAhRT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f7BmwyLU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774534649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWj20J4BVZhCCAVyDPTLtKcDv/MjsuR6OK1nSBZ1MVw=;
 b=TJ6xAhRTVgPSOxNp/C8DazC5p6bei05l1uWlqTJWF1YoVoYiH+aXlTKpi8gKIWa58+yZXA
 5WSSOoP889yk5Z7bpKWXkK+i4piPultHhL1Dh+pYNHuUoxW2BokT5ohsuuPbwc7+D2ehwf
 N399A3bOqMiOi5NDDBXCV33lQ9KSR74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774534649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IWj20J4BVZhCCAVyDPTLtKcDv/MjsuR6OK1nSBZ1MVw=;
 b=f7BmwyLUdOiPdPu70sxGb9QoLjidCvJeqfXcZwTsklnihNU2lYXqxQqpk3pq0D0h+4wCwn
 vNL2KXkhfUpZN3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CEDE4A0A3;
 Thu, 26 Mar 2026 14:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tReyDfk/xWkSGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Mar 2026 14:17:29 +0000
Date: Thu, 26 Mar 2026 15:17:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <acU_-ypHdCrUdEVC@yuki.lan>
References: <20260205135724.23772-1-chrubis@suse.cz>
 <69c24c53.050a0220.eec9a.6546@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c24c53.050a0220.eec9a.6546@mx.google.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 577BC4D2B5
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
> I know header is used only once in the code, but we are missing header
> guards in this file anyway. Otherwise there's a risk to break LTP compiling
> if imported twice in the future.

Sure will add. And also rename the header to tst_kconfig_checks.h since
Peter complained that we may want to add other types of checks that are
not namespace related there eventually.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
