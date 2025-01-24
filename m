Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20936C02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 10:45:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A62E3C558C
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 11:45:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A4CF3C5396
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:44:57 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B2F41431272
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 11:44:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A57492115B;
 Fri, 24 Jan 2025 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737715495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEPsf/6JNqrsYtMn0stqANisC/Y3bo47/8iPtndS08=;
 b=ZT5bs7yzNXO+BHLx7WYxeWTx54dutloXxIAfuYWTcwxre6ropIOZ/R3w2n5txfMkIP9951
 HpRsIfkwntBgRRduqH/3HHhZ5nYs1jYTYsXV5OEJc9auVALpHVPy8/2H6VS5FtfLFOsOiu
 sDVoPuvZIwGzXPZr7K3nAcFmDTw6LSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737715495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEPsf/6JNqrsYtMn0stqANisC/Y3bo47/8iPtndS08=;
 b=2i3fzKp3ISc6kjdcn7+LEPwzFsrAHdcfhHRBuxlgsdebLdkPwRzudqXGmQ4SA3dmPuGIF3
 hvgJLLYnpD7/MPDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737715495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEPsf/6JNqrsYtMn0stqANisC/Y3bo47/8iPtndS08=;
 b=ZT5bs7yzNXO+BHLx7WYxeWTx54dutloXxIAfuYWTcwxre6ropIOZ/R3w2n5txfMkIP9951
 HpRsIfkwntBgRRduqH/3HHhZ5nYs1jYTYsXV5OEJc9auVALpHVPy8/2H6VS5FtfLFOsOiu
 sDVoPuvZIwGzXPZr7K3nAcFmDTw6LSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737715495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmEPsf/6JNqrsYtMn0stqANisC/Y3bo47/8iPtndS08=;
 b=2i3fzKp3ISc6kjdcn7+LEPwzFsrAHdcfhHRBuxlgsdebLdkPwRzudqXGmQ4SA3dmPuGIF3
 hvgJLLYnpD7/MPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94927139CB;
 Fri, 24 Jan 2025 10:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iNJEIydvk2fdXwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 24 Jan 2025 10:44:55 +0000
Date: Fri, 24 Jan 2025 11:44:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Z5NvIqrcIWZN5ry3@yuki.lan>
References: <20250124100151.GD159953@pevik>
 <CAOQ4uxgSLN9QgoZOaB4H+80AjgnLEHOQOcH-BpM=yAfQO47MTw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgSLN9QgoZOaB4H+80AjgnLEHOQOcH-BpM=yAfQO47MTw@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-0.999];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_TO(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Split some fanotify tests
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The reason I tend to add test cases is to save code duplication between tests,
> because there is a lot of boilerplate code for event verification, which often
> has bugs and needs fixing in multiple tests.
> There is another solution for code duplication - to write generic fanotify event
> verification helpers.
> 
> It's up to you to decide if there is room for some helpers for fanotify event
> verification or if you want to fork the tests with code duplication.
> WDYT?

Sharing code is almost never a mistake. We usually put static inline
helpers into a common.h header and include that in tests.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
