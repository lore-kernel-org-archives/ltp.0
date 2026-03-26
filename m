Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D79109C05D
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 10:34:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6224B3C572F
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:34:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D9683C1014
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:34:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1599B200222
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 11:34:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBDBE5BD0A;
 Thu, 26 Mar 2026 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774521277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Me7pRXIXxRVmp8mzuif1rjeAruSDL6eFRUK/knlY9cg=;
 b=tARHrnn0PneymLTTwbTqTfK3puwLt6sN2/ytkqXfCO2bSC278arLRYQNt6o73i2wCz4Fik
 PA77x8egjdvHSsXgQ7U4F92MJJ3iQuidu6JBiU5VeNhvlfbdsQVBVG1i4QZHxLJI/tQit/
 3Id0/fwOJbYTH6ZheF/iEPRESv7DKyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774521277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Me7pRXIXxRVmp8mzuif1rjeAruSDL6eFRUK/knlY9cg=;
 b=/3QRQwAZV2mjKJhRawow6YLJSatDtr4RwI2/NHiADmW9N5m8rm/T5AUonPF8d1WNdCc0Zs
 dZur0LmVgg6iBoAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774521277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Me7pRXIXxRVmp8mzuif1rjeAruSDL6eFRUK/knlY9cg=;
 b=tARHrnn0PneymLTTwbTqTfK3puwLt6sN2/ytkqXfCO2bSC278arLRYQNt6o73i2wCz4Fik
 PA77x8egjdvHSsXgQ7U4F92MJJ3iQuidu6JBiU5VeNhvlfbdsQVBVG1i4QZHxLJI/tQit/
 3Id0/fwOJbYTH6ZheF/iEPRESv7DKyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774521277;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Me7pRXIXxRVmp8mzuif1rjeAruSDL6eFRUK/knlY9cg=;
 b=/3QRQwAZV2mjKJhRawow6YLJSatDtr4RwI2/NHiADmW9N5m8rm/T5AUonPF8d1WNdCc0Zs
 dZur0LmVgg6iBoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7549D4A0A3;
 Thu, 26 Mar 2026 10:34:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NI22G70LxWlaMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 26 Mar 2026 10:34:37 +0000
Date: Thu, 26 Mar 2026 11:34:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260326103421.GA144321@pevik>
References: <20260323074954.3393-1-gaoxiang@kylinos.cn>
 <69c0fb92.050a0220.1af5ad.144b@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c0fb92.050a0220.1af5ad.144b@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem/tunable:min_free_kbytes: fix disabled
 check_monitor flag
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

Hi,

> Hi!

> This patch is correct. Indeed, `end` is set to 1 only when signal is received,
> otherwise we loop into check_monitor(). Interesting enough we did use this test
> for a while now. The monitor that was checking for possible failures was never
> used.

Good catch, thank you! Patch merged.

> We can add before merge:

> Fixes: f28b29f16ba7
I added 8b7cc630a5 ("mm/tunable: add a new testcase min_free_kbytes")
it was wrong from the start when the test was added in 2012.

> @Li FYI
FYI Li was not Cced, doing it now.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
