Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0634C54E67
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 14:48:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5FC83D16F4
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 15:48:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46B5B3D0A01
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 15:47:53 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23FEF1400250
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 15:47:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBC891FB6B;
 Fri, 15 Mar 2024 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710514072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oELOxEZQpEhQgObH9fGoS3meswHVIdriQ2+lUWDfXyA=;
 b=WvSU5rl/FU3wa7Ne1cBQdAlo3VATwlNa0FgkltUHub6JzZpfC2H9bvFyvdldTCkIQyRQg3
 ySI4imrzJSB1/k4ndYD26WNWdh8Xouo5Fj1WJLUvranFqkiCCE2tsN36oRCwkc9ba3hAyu
 dpykc3/vBW5C2GUbftBaSuj1JQonP10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710514072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oELOxEZQpEhQgObH9fGoS3meswHVIdriQ2+lUWDfXyA=;
 b=H6QY3fVE5VYJth5STJy1xb9Yxggdss7pf6xOiE2opewAoFz+LE5nhpQERhztxjJEYQ4vne
 240i1Zuel5pLtUDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710514071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oELOxEZQpEhQgObH9fGoS3meswHVIdriQ2+lUWDfXyA=;
 b=Sm1CQnKUr8BJK846w/+F/DVNNY+IuboTmJUkzTmfBAodnBKtWMtGYEKkaDvCJIwXhh1wOu
 LAec7DI1ZB4g2aK+N4T1XppJu/aK/Z8+Vb3J1ZtYFNe1/+RL4pMBv5YT9yPLnTfZrVEpHN
 uM3GZQoz9inUmrc+cJbHPbAz+esjO3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710514071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oELOxEZQpEhQgObH9fGoS3meswHVIdriQ2+lUWDfXyA=;
 b=iE7BeQ1oBXONxgWJ5NCPowjiGRuwcRk2fCLq3C4y0Co/HrmK+CGb2BcuYGIRyskOCb34qK
 Z1fphSksavIh/1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBF5513931;
 Fri, 15 Mar 2024 14:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xa2YM5df9GWtRQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 15 Mar 2024 14:47:51 +0000
Date: Fri, 15 Mar 2024 15:46:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "K N, Santhosh" <Santhosh.KN@amd.com>
Message-ID: <ZfRfX30dN6wszeme@yuki>
References: <BL1PR12MB599467E27B4B32A86788E6D1E2282@BL1PR12MB5994.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR12MB599467E27B4B32A86788E6D1E2282@BL1PR12MB5994.namprd12.prod.outlook.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,opensuse.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[22.10%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Sm1CQnKU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iE7BeQ1o
X-Rspamd-Queue-Id: EBC891FB6B
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Regarding LTP Version 20230929
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I am using the latest LTP version 20230929, may I know how much time
> it will take to complete the full test to get the results.

That really depends on several factors, e.g. the machine you run the
tests on (I/O speed, CPU speed, RAM size), however generally running all
tests should be in the range of a few hours.

Also it's not a good ideal to run all the test in a single session,
there is too much of them to be executed in a single run.

Usuall these tests are executed in a subsets and the machine under test
is rebooted between the executions. It also may sense to run some tests
with a different settings/options such as 32bit test binaries on a 64bit
kernel to test the kernel compat layer. Or rerun some tests on a kernel
with debuging options enabled (KASAN, UBSAN, KMEMLEAK, etc).

You can see how we run LTP tests in SUSE in OpenQA[1]:

https://openqa.opensuse.org/tests/overview?distri=opensuse&version=Tumbleweed&build=20240314&groupid=32

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
