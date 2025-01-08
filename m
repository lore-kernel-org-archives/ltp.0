Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000C7E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:35:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79BDB3C1C0C
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 14:35:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF4F3C02C4
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:35:32 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E483B200741
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 14:35:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BD4A21101;
 Wed,  8 Jan 2025 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736343330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bjSO3NDaLfK8de0nRbrzaFwoEiJFLQQm2OPPxOgkTsA=;
 b=Q1NI1r6ChgIv32Z+grdMP0X7cFVaVod+O/QeH1XazxiX7rvn1bf0xqwgarG2NDENlYuW51
 HFEQT9KGkdKzGsRTZuK+8IPvz40JaRxlnM+AdSGQDznJB3r5T7VShYX1wHu4eZTIZHEeK0
 ysbEZNSok47jEVY2NfpMNJ65B7+rvmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736343330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bjSO3NDaLfK8de0nRbrzaFwoEiJFLQQm2OPPxOgkTsA=;
 b=KoDjL/Xd/MpUWobYUE5YQxzn0FMOBPc0+0ABKSIZFPmq1V/FRoMMTETDD6Ih8CdRUh+W2J
 xYnQQjEtmDuf6kDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736343330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bjSO3NDaLfK8de0nRbrzaFwoEiJFLQQm2OPPxOgkTsA=;
 b=Q1NI1r6ChgIv32Z+grdMP0X7cFVaVod+O/QeH1XazxiX7rvn1bf0xqwgarG2NDENlYuW51
 HFEQT9KGkdKzGsRTZuK+8IPvz40JaRxlnM+AdSGQDznJB3r5T7VShYX1wHu4eZTIZHEeK0
 ysbEZNSok47jEVY2NfpMNJ65B7+rvmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736343330;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bjSO3NDaLfK8de0nRbrzaFwoEiJFLQQm2OPPxOgkTsA=;
 b=KoDjL/Xd/MpUWobYUE5YQxzn0FMOBPc0+0ABKSIZFPmq1V/FRoMMTETDD6Ih8CdRUh+W2J
 xYnQQjEtmDuf6kDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AF8B137DA;
 Wed,  8 Jan 2025 13:35:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L4YWByJ/fmdvOAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jan 2025 13:35:30 +0000
Date: Wed, 8 Jan 2025 14:35:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z35_EDf-np4R0AeT@yuki.lan>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-3-e293a8d99cf6@suse.com> <Z352WrLF5bP-DgA2@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z352WrLF5bP-DgA2@rei>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/7] Add lsm_get_self_attr02 test
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
> > +static void setup(void)
> > +{
> > +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> > +
> > +	if (verify_enabled_lsm("selinux"))
> > +		lsm_count++;
> > +
> > +	if (verify_enabled_lsm("apparmor"))
> > +		lsm_count++;
> > +
> > +	if (verify_enabled_lsm("smack"))
> > +		lsm_count++;
> 
> Shouldn't we just look at the /sys/kernel/security/lsm file and if it
> exists and it's not empty there is a lsm on the system and the syscall
> will not fail in that case?

And looking into the documentation these attributes are currently
supported only by these three lsms. So this is correct, however the
pattern is repeated in other tests, so maybe put it into a inline
function into a common header?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
