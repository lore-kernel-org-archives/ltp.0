Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162FAC54E60
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 10:35:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92C733CE6A4
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 11:35:16 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BC9E3CB5E1
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 11:35:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4D0B605630
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 11:34:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 27A115D4C5;
 Tue, 19 Mar 2024 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710844498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+jJHS5za5o4KPVtUSvufScW+swwmWudmMZwCF37//Y=;
 b=ZhzPVktZfmMFjYGUwu+xGVK6ZrEoC8akeGKUFPBLWuiRy1Vbirh57VrvOmnDw03aHOfXgi
 FlPBrTGTk9viUNLwEtQ2u4LQbD9+NZJvgC73VgFPnbVarOnSgHSeDKtdX39/f9PZvzH99C
 FaKW7ZJC3anYyljT5fHNMu0kDyZItWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710844498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+jJHS5za5o4KPVtUSvufScW+swwmWudmMZwCF37//Y=;
 b=YW7ttxQ3CLEGkR3jfHEcG3pN+trRmFbQId/EI+yuYr+s+CFmIvrLwlmwE3qOV3Y50bcstB
 CdOSA50/zD85eoAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710844498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+jJHS5za5o4KPVtUSvufScW+swwmWudmMZwCF37//Y=;
 b=ZhzPVktZfmMFjYGUwu+xGVK6ZrEoC8akeGKUFPBLWuiRy1Vbirh57VrvOmnDw03aHOfXgi
 FlPBrTGTk9viUNLwEtQ2u4LQbD9+NZJvgC73VgFPnbVarOnSgHSeDKtdX39/f9PZvzH99C
 FaKW7ZJC3anYyljT5fHNMu0kDyZItWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710844498;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+jJHS5za5o4KPVtUSvufScW+swwmWudmMZwCF37//Y=;
 b=YW7ttxQ3CLEGkR3jfHEcG3pN+trRmFbQId/EI+yuYr+s+CFmIvrLwlmwE3qOV3Y50bcstB
 CdOSA50/zD85eoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10031136D6;
 Tue, 19 Mar 2024 10:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hjz5AlJq+WUfKwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 19 Mar 2024 10:34:58 +0000
Date: Tue, 19 Mar 2024 11:33:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZflqF-zH-e77vePV@yuki>
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZhzPVktZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YW7ttxQ3
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.97 / 50.00]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BAYES_HAM(-0.16)[69.51%]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; SUBJECT_ENDS_EXCLAIM(0.20)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 27A115D4C5
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] New LTP documentation!
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
> I started to work on documentation refactoring, re-organizing the 
> overall structure. The first prototype can be found here:
> 
> https://ltp-acerv.readthedocs.io/en/latest/index.html

Thanks for doing this! This looks way better than the current wiki we
have.

I'm also looking forward to the API documentation parsed from the
library headers.

A few minor comments:

"Install and run" -> "Installation and test execution"

"Patch reviewing" -> "Patch review"

"Debugging with gdb and strace" -> Just change that to "Debugging"

And we should mention the newly introduced -D test parameter in that
section as well.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
