Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA5BC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:37:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 787F03C9DA5
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:37:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E7393C07C1
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:36:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8870E1400BD1
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:36:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 35C491F390;
 Mon,  7 Jul 2025 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751902610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6K5KwZiPHoHZTj6bixIAXRyYq+f+6AJDT0yw2XiO40=;
 b=Imuul7GP6fKeuzUiBDH/7/6UpDf4IRQfluAkW/FkZW8FDEm+SNWeA1vQbVSfrJcmawWz0a
 tIH5wCeiUxZFfuriGwYDIcFHu1sTEetQzizvEPoRYxcuF9O0IR1q3g9+hJQGA6zZ8sOb/+
 DEOMvccXJ0OLoiCeIB4MS0PFJ/frnDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751902610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6K5KwZiPHoHZTj6bixIAXRyYq+f+6AJDT0yw2XiO40=;
 b=bxJe1fyYLA/eZwqv8LW/EhNQyWrxzVhS27GiTdJdhl0bN6atlHRAbpCZ6WNkiGtufpN/T4
 zbevupfxgpbQuxDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751902610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6K5KwZiPHoHZTj6bixIAXRyYq+f+6AJDT0yw2XiO40=;
 b=Imuul7GP6fKeuzUiBDH/7/6UpDf4IRQfluAkW/FkZW8FDEm+SNWeA1vQbVSfrJcmawWz0a
 tIH5wCeiUxZFfuriGwYDIcFHu1sTEetQzizvEPoRYxcuF9O0IR1q3g9+hJQGA6zZ8sOb/+
 DEOMvccXJ0OLoiCeIB4MS0PFJ/frnDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751902610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C6K5KwZiPHoHZTj6bixIAXRyYq+f+6AJDT0yw2XiO40=;
 b=bxJe1fyYLA/eZwqv8LW/EhNQyWrxzVhS27GiTdJdhl0bN6atlHRAbpCZ6WNkiGtufpN/T4
 zbevupfxgpbQuxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16FC313A5E;
 Mon,  7 Jul 2025 15:36:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 16VABJLpa2g2RgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Jul 2025 15:36:50 +0000
Date: Mon, 7 Jul 2025 17:37:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aGvptwZtV26Dj7e_@yuki.lan>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
 <aGu-qne-SMpTCEy4@yuki.lan>
 <7080e0b9-2d4a-41b4-8566-c7afcc694bfe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7080e0b9-2d4a-41b4-8566-c7afcc694bfe@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Add ioctl_pidfd02 test
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
> > Looking at the kernel code it looks that if the PIDFD_INFO_EXIT is not
> > supported we will get ESRCH in the second case. So I suppose that better
> > fix would be to allow ESRCH in the second case if kernel is older than
> > 6.15 instead of skipping the whole test.
> 
> Maybe it makes more sense to check PIDFD_INFO_EXIT is available via 
> configure.ac and eventually check for this support in the setup(). So we 
> avoid weird runtime checks. WDYT?

And if you think about checking PIDFD_INFO_EXIT in the test setup() that
may be doable. But there is no need for configure checks in that case,
we just use PIDFD_INFO_EXIT fallback definition from the lapi headers.

I suppose adding a check for support that would be called if kernel
version is older than 6.15 would work as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
