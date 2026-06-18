Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1802DCD98F8
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:43:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E4F03E5887
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 15:43:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 751043C741F
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 15:43:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1D81600954
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 15:43:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DF8E6BDFA;
 Thu, 18 Jun 2026 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781790194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YaTJoc/bQByp9H9PcRTPJbWJvxLO8ACZ0DrgiX9kGI=;
 b=HhvG7v+5tA4bKOd/Q9vU1yKlTMKvk/9VuFhHNJ3Nu5HbM/AyENr1gazaPxxGncTgtF5X87
 B4GeBeeP3HWss6xjDfk+Ft0VfmjHJV9+QiiZtzWJ9fVj365WCTn8qeguRuJlou4ZwW1Js6
 xjSvhL7c69XyEQT6sscidK1Egjotxfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781790194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YaTJoc/bQByp9H9PcRTPJbWJvxLO8ACZ0DrgiX9kGI=;
 b=4ZMOc+dvv4C9/rwlLeZpvxJCrNQUsBqNzMQtsVSnv0IwJtekSity3jx3pjVQKm0VQmj4wE
 funQhnATUBYuMUDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781790194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YaTJoc/bQByp9H9PcRTPJbWJvxLO8ACZ0DrgiX9kGI=;
 b=HhvG7v+5tA4bKOd/Q9vU1yKlTMKvk/9VuFhHNJ3Nu5HbM/AyENr1gazaPxxGncTgtF5X87
 B4GeBeeP3HWss6xjDfk+Ft0VfmjHJV9+QiiZtzWJ9fVj365WCTn8qeguRuJlou4ZwW1Js6
 xjSvhL7c69XyEQT6sscidK1Egjotxfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781790194;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7YaTJoc/bQByp9H9PcRTPJbWJvxLO8ACZ0DrgiX9kGI=;
 b=4ZMOc+dvv4C9/rwlLeZpvxJCrNQUsBqNzMQtsVSnv0IwJtekSity3jx3pjVQKm0VQmj4wE
 funQhnATUBYuMUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0851C779A8;
 Thu, 18 Jun 2026 13:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dfEPAfL1M2pQbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 18 Jun 2026 13:43:14 +0000
Date: Thu, 18 Jun 2026 15:43:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajP187rd7nSV-Krv@yuki.lan>
References: <ajKzKA_ROAlfBDys@rei.lan>
 <6a33f151.34ecd23a.148835.82ec@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a33f151.34ecd23a.148835.82ec@mx.google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] metadata: add tests grouping support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I was thinking that having `@group foo` is cleaner. When we start to have
> multiple groups it can be really to handle multiple groups: for instance,
> we might end up having one line over 80 chars in the description.
> 
> @groups foo1 bar1 foo2 bar2 foo3 bar3 ..
> 
> Instead, we might have
> 
> @group foo1
> @group bar1
> @group foo2
> @group bar2
> @group foo3
> @group bar3
> 
> These strings are short, but if we have long names it can be weird
> to read having all of them on a single line.

I wasn't saying that we should support only one @groups command, rather
than that we would do:


@groups foo1 foo2 foo3
@groups bar1 bar2 bar3

That would allow us to write reasonably short lines and limit the number
of lines to a reasonable number as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
