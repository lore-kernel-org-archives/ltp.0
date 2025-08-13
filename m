Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA11CA0EE0
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 19:09:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AD3A3CB96F
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 21:09:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FD573CB7F9
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 17:26:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A80802002D0
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 17:26:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6400021ACD;
 Wed, 13 Aug 2025 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755098786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggKq5RvBFKqS4ENPBnWhYuKx0e/+34rBVaUakqCdZU0=;
 b=G+Q2P8Jr74CEv+Tq3vau8Neu3YNNlGUr3SGDuS/taU6mcn1neJpxexx+0oyEjXqVFa1UDI
 MDQvc+tJs0f3DJefYs+RXmL2NIKEQFI0txRqWcg3UFSXPBPbzVKK2FS6AUP4wfmkYQvQ7a
 mkQWLt0zPPmxvtr02ZcfXyb/IL79NM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755098786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggKq5RvBFKqS4ENPBnWhYuKx0e/+34rBVaUakqCdZU0=;
 b=YPNSbyQVUhwebONRXVP+9itLLBqyC9dVWW0WoZRZIaSW1CJTg9X7WNlVdvoNeyVf1xcHVV
 ZgjJ5BW7VIJUfZDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755098786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggKq5RvBFKqS4ENPBnWhYuKx0e/+34rBVaUakqCdZU0=;
 b=G+Q2P8Jr74CEv+Tq3vau8Neu3YNNlGUr3SGDuS/taU6mcn1neJpxexx+0oyEjXqVFa1UDI
 MDQvc+tJs0f3DJefYs+RXmL2NIKEQFI0txRqWcg3UFSXPBPbzVKK2FS6AUP4wfmkYQvQ7a
 mkQWLt0zPPmxvtr02ZcfXyb/IL79NM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755098786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ggKq5RvBFKqS4ENPBnWhYuKx0e/+34rBVaUakqCdZU0=;
 b=YPNSbyQVUhwebONRXVP+9itLLBqyC9dVWW0WoZRZIaSW1CJTg9X7WNlVdvoNeyVf1xcHVV
 ZgjJ5BW7VIJUfZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2055713479;
 Wed, 13 Aug 2025 15:26:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HNNpBKKunGi0fwAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Wed, 13 Aug 2025 15:26:26 +0000
Date: Wed, 13 Aug 2025 16:26:24 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <24huvlw5wphgka5j6uwrweetmpa2tyi2rnrwp3gqymrpvcx2i6@zmepzxfsiiie>
References: <20250808163457.1685958-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250808163457.1685958-1-florian.schmaus@codasip.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 13 Aug 2025 21:09:06 +0200
Subject: Re: [LTP] [PATCH v2] sigrelse01: Check if signal 34 is available
 for musl compat
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

On Fri, Aug 08, 2025 at 06:34:57PM +0200, Florian Schmaus via ltp wrote:
> Do not select signal 34 when the test is run using musl. Signal 34 is
> used internally by musl as SIGSYNCCALL. Consequently, musl's signal()
> will return with an error status and errno set to EINVAL when trying
> to setup a signal handler for signal 34, causing the sigrelse01 test
> to fail.
> 
> Since musl provides no preprocessor macro, we check for the
> availability of signal 34 by attempting to setup a signal handler. If
> signal() returns SIG_ERR with errno set to EINVAL then we assume the
> signal is unavailable. Knowing signal 34 is available with glibc, we
> perform this check only if __GLIBC__ is not defined.
>

This is wrong, the libc can use whatever (RT) signals it wants, and you're
supposed to check for their availability using SIGRTMIN. This applies for
both musl *and* glibc. The only difference is that glibc only needs 32 and 33,
whereas musl also needs 34 (for now).

So, the correct fix would be to exclude all signals outside of [SIGRTMIN, SIGRTMAX]

-- 
Pedro

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
