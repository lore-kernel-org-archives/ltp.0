Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AAAC3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 07:23:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 478353D1A34
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 09:23:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A86583CD924
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 09:23:33 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1B4141A05C98
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 09:23:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71FB121A52;
 Fri, 26 Jul 2024 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721978610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
 b=PxcwDMYe3RU0a8jn2W1UIib9BsHAWcA17jFIQ++vTH8e8vjqxCmlqs97LhoDlUXIBjtiMR
 n1D1xLVtnOBWwePS5UyhMGQVbFfeEP6HR+M3cdNoMBFNW69a1rEr8gNjmO2O3DvN0jUKwc
 H/8SxTBr8txMbfRjucQAkF/fXIzZDYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721978610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
 b=qmRl5LTYWwEkdANyQD3RVkLqpEv1UQaSBCxFcG8LLmLMzuqGKGzZvgf4E+Mav/Ev6CA7oQ
 CuJVxUy43aF9pJDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721978610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
 b=PxcwDMYe3RU0a8jn2W1UIib9BsHAWcA17jFIQ++vTH8e8vjqxCmlqs97LhoDlUXIBjtiMR
 n1D1xLVtnOBWwePS5UyhMGQVbFfeEP6HR+M3cdNoMBFNW69a1rEr8gNjmO2O3DvN0jUKwc
 H/8SxTBr8txMbfRjucQAkF/fXIzZDYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721978610;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlZ5XTu7aKQY5eOub/IIfBi0FvPWjetDemmGi8yJwUU=;
 b=qmRl5LTYWwEkdANyQD3RVkLqpEv1UQaSBCxFcG8LLmLMzuqGKGzZvgf4E+Mav/Ev6CA7oQ
 CuJVxUy43aF9pJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1893E13AF7;
 Fri, 26 Jul 2024 07:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e04gBPJOo2Z5HwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 07:23:30 +0000
Date: Fri, 26 Jul 2024 09:23:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linux-kernel@vger.kernel.org
Message-ID: <20240726072327.GA1021851@pevik>
References: <20240726072009.1021599-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240726072009.1021599-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,fujitsu.com,suse.de,lists.linux.it,linux-foundation.org,gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] MAINTAINERS: Update LTP members and web
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
Cc: ltp@lists.linux.it, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> LTP project uses now readthedocs.org instance instead of GitHub wiki.

> LTP maintainers are listed in alphabetical order.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

Please, whoever merges this, please keep as SOB only my SUSE address.
I'm sorry for the noise.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
