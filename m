Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F15C54E67
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 11:29:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF1F53C1C06
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 12:29:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E4E53C02EB
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 12:29:20 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9263E1B61076
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 12:29:19 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9AED207F7;
 Thu, 28 Mar 2024 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711625356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MEduXgBkuim0nqnrPlSHqZvlWMiEKecZqoVzi0igbzo=;
 b=nR4JOKWOipVIxpTw0w64LJg/UVC0ioQonIrZWbkZ7bJwmjR3pM2DC5IQ1pSgmtSjRIrKSX
 AijU03OqKP2c2Dis7cfWjFpNyTR83kiqz/+bV76XTuyUSSs43f2QjnW10t3f72sFmeKQnT
 2pqyjVxOTJfKsIBOZ/O1LQBUWyTyDpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711625356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MEduXgBkuim0nqnrPlSHqZvlWMiEKecZqoVzi0igbzo=;
 b=wZnHTMHmidwzGLnuxSxFHcdPpi+xqdjV6EUOFssTQ5QWOoYTnks2zDDMir2KQC48+Ht15g
 ZvEwuof49I6LUlCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711625355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MEduXgBkuim0nqnrPlSHqZvlWMiEKecZqoVzi0igbzo=;
 b=VPoJxdkegEsrHpPi/rJxYDOyRje3JFysYU5aWwwXCrggUtNM+sPNuyONMGXxqpcK6P7v+B
 hJgeHm0j/VkASp/R6YPn7KmeJtm57+YCfSq/s6SK5t1bQ3yIf5oLS1gGnW6YsIikjlDCst
 f0Gx+rZPyV7T2ocsGD+gwIWCjR4F384=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711625355;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MEduXgBkuim0nqnrPlSHqZvlWMiEKecZqoVzi0igbzo=;
 b=bSm0Oy7uKEPhP+rdUIFtw/8xTME09Xqsf4fG//Zu5RWF1qNgg6vZ2EWakujhVeKK28dzAC
 0d9eeWKJACvq0ICQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B523313AF7;
 Thu, 28 Mar 2024 11:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id su2DKotUBWbqGAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 11:29:15 +0000
Date: Thu, 28 Mar 2024 12:29:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240328112913.GB51940@pevik>
References: <20240208013224.859-1-wegao@suse.com>
 <20240327034923.30987-1-wegao@suse.com>
 <20240327034923.30987-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240327034923.30987-2-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VPoJxdke;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bSm0Oy7u
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.68 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.97)[86.84%]
X-Rspamd-Queue-Id: E9AED207F7
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> --- /dev/null
> +++ b/lib/newlib_tests/test_macros07.c
nit: Instead of creating a new test I would add it to existing test_macros02.c
(it would reduce some duplicity).

Also having exp_errs_pass[] and exp_errs_fail[] static and put testing all 4
macros into it's own functions, I'll send a suggestion shortly.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
