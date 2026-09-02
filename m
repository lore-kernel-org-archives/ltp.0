Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DEEC61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 12:25:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08C6D3C6603
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 14:25:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 801E23C6603
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 14:25:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0E21E14010C4
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 14:25:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 091E31F7D2;
 Wed,  2 Sep 2026 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788351927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=go0iT95F7xAUNF8IE9ydRPtky9XrxvBWvN9o0PUAaNs=;
 b=13kd2T8XoxP3WbBWojER5Klo6gpZncgcxTEctr1ka2WrmTiJaArt8dUcqBUgQ+n27yBX04
 aeknSPQyo0WZzYSnTjH7YET29g4VnU9AjanCeFZrt7FV8gev3q1pmGNjJHJqZl6Yi6nfWT
 PzomPtFe5JY5yWiJSf03kXtIUCRHx4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788351927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=go0iT95F7xAUNF8IE9ydRPtky9XrxvBWvN9o0PUAaNs=;
 b=TK/Zl4wFj1qNSI3b1qvwXFnE2KD8R8FT5jFYZtxV+FUDBhq+3aIqpWDTB4XkTFXVjm+voi
 LlymRFEt2/OEt8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788351923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=go0iT95F7xAUNF8IE9ydRPtky9XrxvBWvN9o0PUAaNs=;
 b=lIMIxnfTiTTEt5w2/C3kJ3tcqfj/e5aQQdAMY342CMaTjRcrmOUa064yS8c/SX/XeW3T5c
 TjEY2Anxz/3LcvTFwKN59NqTssYMPhTdvJStTe5cHssznYhuOYbBjNRO70DWihkfGH05EM
 kFVZai0Kx1ZfreOEYiCUztMS9w70WFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788351923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=go0iT95F7xAUNF8IE9ydRPtky9XrxvBWvN9o0PUAaNs=;
 b=p8WXmSz2rQlX3D2EUC0YHeetoIDRedStjXhVgwteNa+SSJCnVrsX1RbE5IekRkx+xN7sl/
 VqZE7tfX+urVAbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2988136E6;
 Wed,  2 Sep 2026 12:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hMeqJ7IVmGqjFgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 02 Sep 2026 12:25:22 +0000
Date: Wed, 2 Sep 2026 14:25:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nirmoy Das <nirmoyd@nvidia.com>
Message-ID: <apgVur5s_potD6ND@yuki.lan>
References: <20260825152544.1675541-1-nirmoyd@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260825152544.1675541-1-nirmoyd@nvidia.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] getrusage03: account for percpu RSS counter
 batching
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
> getrusage03 allows ru_maxrss to differ from the expected value by a
> fixed 20 MiB. That can be too small on large systems after Linux commit
> f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter").
> 
> The fast RSS read may miss percpu counter batches, and the batch size
> scales with the number of online CPUs. The test child is single threaded,
> but it can migrate while faulting memory, so allow two batches worth of
> slack based on the online CPU count and page size. Keep the existing
> 20 MiB floor for smaller systems.
> 
> This is sent as RFC because it makes the test tolerate Linux's current
> percpu counter batching behavior instead of treating the smaller
> ru_maxrss value as a kernel failure.

Maybe we can pin the whole test to a single CPU instead. Otherwise the
max rss delta can easily get into hundreds of megabytes, which is more
than the test consumes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
