Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA60DC54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 06:21:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2BD3E4B95
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 08:21:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45E343E254E
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 08:21:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0E7A10007F7
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 08:21:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 735F27DDD1;
 Fri, 31 Jul 2026 06:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785478870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eq4wI0/rtix1cS+HgY/Nf8uR0dXjdsI8JyKkZRx1xU=;
 b=UiObj6InxKVfN/v5B72QI1Au16f+SeVtMdndV1MsFsNvR/cLTBAAH7iJcfeq/kIEkxxyWv
 OENf+RjTupbZ0+1ZJj7sNaQ0rq1zQXkX7ZismrxkCEldpp2++D1tCBZHfFkOqoJwNtvgRr
 1ZizbDaRbe9Hjpg3O0WAsZgxNfafhx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785478870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eq4wI0/rtix1cS+HgY/Nf8uR0dXjdsI8JyKkZRx1xU=;
 b=5vHRx3JMX9E+ZcRWE5Z6zguVWN46F1Z2vYOZCGuf2M1175sn0YOTwm3Y53Rd98Q6LT6csA
 YmY26bm5xVZlbbDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785478870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eq4wI0/rtix1cS+HgY/Nf8uR0dXjdsI8JyKkZRx1xU=;
 b=UiObj6InxKVfN/v5B72QI1Au16f+SeVtMdndV1MsFsNvR/cLTBAAH7iJcfeq/kIEkxxyWv
 OENf+RjTupbZ0+1ZJj7sNaQ0rq1zQXkX7ZismrxkCEldpp2++D1tCBZHfFkOqoJwNtvgRr
 1ZizbDaRbe9Hjpg3O0WAsZgxNfafhx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785478870;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eq4wI0/rtix1cS+HgY/Nf8uR0dXjdsI8JyKkZRx1xU=;
 b=5vHRx3JMX9E+ZcRWE5Z6zguVWN46F1Z2vYOZCGuf2M1175sn0YOTwm3Y53Rd98Q6LT6csA
 YmY26bm5xVZlbbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C45C779B0;
 Fri, 31 Jul 2026 06:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UCxIC9U+bGrZHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 06:21:09 +0000
Date: Fri, 31 Jul 2026 08:21:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260731062102.GC129332@pevik>
References: <amsi77l_1J8Bdbfz@linux.dev>
 <6a6b2f45.d1054386.1d5b49.88c6@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a6b2f45.d1054386.1d5b49.88c6@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mailmap: enable liwang@hygon.cn address
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
Cc: ltp@lists.linux.it, Li Wang <liwang@hygon.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, all,

> That sounds fantastic! Thanks for continuing LTP maintenance.
> It's really appreciate :-)

That's a great news, Li. Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
