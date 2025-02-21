Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BBEC021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:51:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFEB63C0549
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:51:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1CB53C0430
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:51:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4725A14225BB
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:51:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 596CC21270;
 Fri, 21 Feb 2025 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740135067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hPwHl6OjmO6ofoDZgwV7L57bsqqjvNqCISHf+bUvZg=;
 b=cvb1SEy27BeGNk/viAxNh0jG7ekZYPup+PpU3glFSwH/NVjCVDs5rvpElXd3BAmojtRBPW
 v/Wfg6wvTp45rYPY2RkVV7RYhIsvSm43nXjFwRY7A6+2cPVvo74CvEkbS6UG6DjmvWsriF
 BwLEcoUGDudpTkA2drdVD3Sfcebxx+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740135067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hPwHl6OjmO6ofoDZgwV7L57bsqqjvNqCISHf+bUvZg=;
 b=0Pfps6HTK+O8EFCRn1qBFn5FE/N0c/MomD7tGqyTT5Be6VcH883BF2cHgZeL3WN2hHoA7g
 u4Lgl9zWWOrYfCCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740135067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hPwHl6OjmO6ofoDZgwV7L57bsqqjvNqCISHf+bUvZg=;
 b=cvb1SEy27BeGNk/viAxNh0jG7ekZYPup+PpU3glFSwH/NVjCVDs5rvpElXd3BAmojtRBPW
 v/Wfg6wvTp45rYPY2RkVV7RYhIsvSm43nXjFwRY7A6+2cPVvo74CvEkbS6UG6DjmvWsriF
 BwLEcoUGDudpTkA2drdVD3Sfcebxx+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740135067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hPwHl6OjmO6ofoDZgwV7L57bsqqjvNqCISHf+bUvZg=;
 b=0Pfps6HTK+O8EFCRn1qBFn5FE/N0c/MomD7tGqyTT5Be6VcH883BF2cHgZeL3WN2hHoA7g
 u4Lgl9zWWOrYfCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A0A313806;
 Fri, 21 Feb 2025 10:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CjoJEZtauGc4QQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Feb 2025 10:51:07 +0000
Date: Fri, 21 Feb 2025 11:51:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Z7hapGbedK8Kw_fH@yuki.lan>
References: <B8632D9169E22850+20240902061218.39040-1-zhaoyouzhi@uniontech.com>
 <366aaadf-e189-461c-8249-a9b1d46cff55@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <366aaadf-e189-461c-8249-a9b1d46cff55@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fspick:add coverage for fspick01.c
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
Cc: YouZhi Zhao <zhaoyouzhi@uniontech.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This test is meant to test fspick() syscall, but this patch is actually 
> adding one more check for fsconfig(FSCONFIG_SET_FLAG), which is probably 
> the reason why this should be done inside an another test under fsconfig 
> testing suite. For this reason, the patch will be rejected.

Quite contrary, it checks that the final call to fspick() with
FSCONFIG_CMD_RECONFIGURE does apply the changes to the filesystem.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
