Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527F7CCFA18
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 12:52:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F8A93CF693
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 13:52:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14A7D3CF64E
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 13:51:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8E3E1000972
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 13:51:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8630421A9C;
 Tue, 11 Nov 2025 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762865510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqvVLJhxBBIu4GGeaNVXGHcGWsKrbKNr30cRpEPaHdA=;
 b=pXWGFf2UiJpJT5qyWWmiBEN/3n35wYS7F8Vj+aq48vVtTP9u+echXXAWE+CB1zlH3fMZFm
 8zkPBiZxYi8nIoONF64TGXZ+Z6TCiUfmQUNQvvzTMOiM1bXsBz6pkqKB4lYGaYjY5XKS7O
 KWRfmI53HdaZggqGWHHINTIdA8huAG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762865510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqvVLJhxBBIu4GGeaNVXGHcGWsKrbKNr30cRpEPaHdA=;
 b=X6uRCXdSUVaNDTsmyrJKF3mMIF4TalJazOj7gc2K2N2uP7ajzhUN+QfiOT02gBwlmpbfKf
 MwvOzNwcwDEzG5BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762865510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqvVLJhxBBIu4GGeaNVXGHcGWsKrbKNr30cRpEPaHdA=;
 b=pXWGFf2UiJpJT5qyWWmiBEN/3n35wYS7F8Vj+aq48vVtTP9u+echXXAWE+CB1zlH3fMZFm
 8zkPBiZxYi8nIoONF64TGXZ+Z6TCiUfmQUNQvvzTMOiM1bXsBz6pkqKB4lYGaYjY5XKS7O
 KWRfmI53HdaZggqGWHHINTIdA8huAG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762865510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqvVLJhxBBIu4GGeaNVXGHcGWsKrbKNr30cRpEPaHdA=;
 b=X6uRCXdSUVaNDTsmyrJKF3mMIF4TalJazOj7gc2K2N2uP7ajzhUN+QfiOT02gBwlmpbfKf
 MwvOzNwcwDEzG5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75B4E14977;
 Tue, 11 Nov 2025 12:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RtxcGmYxE2n7PAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 11 Nov 2025 12:51:50 +0000
Date: Tue, 11 Nov 2025 13:52:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRMxkqqQzgu40uqo@yuki.lan>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251106163500.1063704-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] swapon03: Don't create swap file twice
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
> MAKE_SMALL_SWAPFILE(TEST_FILE) call is not needed, because the file is
> created by is_swap_supported(TEST_FILE) call.

I find it a bit ugly to depend on a leftover from is_swap_supported() to
create the final swapfile. Maybe it would be cleaner to pass a path to
an already created swapfile to the is_swap_supported() function instead
so that the tests would create the file explicitly.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
