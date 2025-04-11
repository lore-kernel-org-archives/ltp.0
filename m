Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D89AC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 12:10:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECB393CB26A
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 14:10:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 576853CA5F3
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 14:09:57 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5411D600BCD
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 14:09:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59B851F453;
 Fri, 11 Apr 2025 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744373396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HIm0B8a1F0M4AwC940vqfnmIiklxOc/zADj3qHYN2I=;
 b=DtcbPXnYeCgVG1EAM+O28seVQYKKggtKW7Q2W6K1oUnTK9s7I3uE4ZWfm3dMxHDK5g5elV
 bZpVtDU8a5CyGKykxSKj8kgwXCFyL87DDsVcXqNWl+yGY/p203qGaIhx4cByMXLEtKtWuL
 zDrdYCmX8W3+/xlzxTRTdDUvz8zKkm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744373396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HIm0B8a1F0M4AwC940vqfnmIiklxOc/zADj3qHYN2I=;
 b=xn0jUcZFdbc3k+Ebeg0gxJbNfrDLhztzPE9zDV1jFK5oeNPDpKeu3DAsVbWh5SlNL6KN7F
 55ci5ZHu6X2xkyBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744373396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HIm0B8a1F0M4AwC940vqfnmIiklxOc/zADj3qHYN2I=;
 b=DtcbPXnYeCgVG1EAM+O28seVQYKKggtKW7Q2W6K1oUnTK9s7I3uE4ZWfm3dMxHDK5g5elV
 bZpVtDU8a5CyGKykxSKj8kgwXCFyL87DDsVcXqNWl+yGY/p203qGaIhx4cByMXLEtKtWuL
 zDrdYCmX8W3+/xlzxTRTdDUvz8zKkm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744373396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HIm0B8a1F0M4AwC940vqfnmIiklxOc/zADj3qHYN2I=;
 b=xn0jUcZFdbc3k+Ebeg0gxJbNfrDLhztzPE9zDV1jFK5oeNPDpKeu3DAsVbWh5SlNL6KN7F
 55ci5ZHu6X2xkyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D0FE136A4;
 Fri, 11 Apr 2025 12:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +mq9DZQG+WfQXQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Apr 2025 12:09:56 +0000
Date: Fri, 11 Apr 2025 14:10:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z_kGsUpRRGBwhEI0@yuki.lan>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
 <20250411120714.GA319294@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250411120714.GA319294@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/4] Support for Patchwork CI
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
> Andrea did a great effort. Unfortunately we deal with problem probably caused by
> our mailing list because 3rd commit "ci: add ci-patchwork-trigger workflow" did
> not arrive to mailing list.
> 
> I suppose the branch is visible on Andrea's fork:
> 
> https://github.com/acerv/ltp/tree/refs/heads/b4/patchwork_ci
> 
> Mail is not in "ending moderator requests" on https://lists.linux.it/,
> I guess we need to contact ML administrators, I'll do it and Cc you.

Wait a bit I'm helping Andrea to debug his email setup.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
