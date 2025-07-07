Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166BEC8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:39:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EAEA3C9DA5
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:39:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37EF83C282E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:39:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 732C41A0099D
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:39:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 340491F390;
 Mon,  7 Jul 2025 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751902766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkEOBAd4xRIAKAKuhVkdlvIeb8SRKCBcEjN/wapPzjs=;
 b=NWsdqJayFLfgGY/0jkoctnE/puenfADCMFprdp6pSUrk878U5Ee/qDlPLlB+gOdVKISgBl
 Zam4X5M0KmDpQIgzalsmoeIzJew3kEr5H0ivDgJlcFE0fWHsdvi9Mf1GlUV7EKub1tZ1W/
 QhMUW26F6rgPZd901K9Gv8OURGEoh8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751902766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkEOBAd4xRIAKAKuhVkdlvIeb8SRKCBcEjN/wapPzjs=;
 b=M2HUiHJNTqAES0C2Zs2f6cGdwTjz23a5VQAj7uM9HicKvulkt+Z67h/DQ6ZzdyuT7eYT9D
 4kW+YnwaUZOzivCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751902766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkEOBAd4xRIAKAKuhVkdlvIeb8SRKCBcEjN/wapPzjs=;
 b=NWsdqJayFLfgGY/0jkoctnE/puenfADCMFprdp6pSUrk878U5Ee/qDlPLlB+gOdVKISgBl
 Zam4X5M0KmDpQIgzalsmoeIzJew3kEr5H0ivDgJlcFE0fWHsdvi9Mf1GlUV7EKub1tZ1W/
 QhMUW26F6rgPZd901K9Gv8OURGEoh8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751902766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CkEOBAd4xRIAKAKuhVkdlvIeb8SRKCBcEjN/wapPzjs=;
 b=M2HUiHJNTqAES0C2Zs2f6cGdwTjz23a5VQAj7uM9HicKvulkt+Z67h/DQ6ZzdyuT7eYT9D
 4kW+YnwaUZOzivCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BE5313A5E;
 Mon,  7 Jul 2025 15:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UIrhBS7qa2jsRgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Jul 2025 15:39:26 +0000
Date: Mon, 7 Jul 2025 17:39:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aGvqTxkk5gbsLbW-@yuki.lan>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
 <aGu-qne-SMpTCEy4@yuki.lan>
 <7080e0b9-2d4a-41b4-8566-c7afcc694bfe@suse.com>
 <aGvoSa4aTQsyTB9I@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aGvoSa4aTQsyTB9I@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
> > > Looking at the kernel code it looks that if the PIDFD_INFO_EXIT is not
> > > supported we will get ESRCH in the second case. So I suppose that better
> > > fix would be to allow ESRCH in the second case if kernel is older than
> > > 6.15 instead of skipping the whole test.
> > 
> > Maybe it makes more sense to check PIDFD_INFO_EXIT is available via 
> > configure.ac and eventually check for this support in the setup(). So we 
> > avoid weird runtime checks. WDYT?
> 
> Forget about configure checks, these are useless since the version of
> the kernel never corresponds to the kernel headers installed on the
> system.
> 
> The only way how to do things is to check if something is present at a
> runtime.

To sum it up configure checks should be only used to detect if fallback
definitions should be enabled or not.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
