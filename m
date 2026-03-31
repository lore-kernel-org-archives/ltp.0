Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29F31061B39
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AA173E4ED7
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:14:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945453E21CF
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:14:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 141806003C1
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:14:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 355D04D202;
 Tue, 31 Mar 2026 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774959258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtgqunutxpPRXtL5hL0Zf2P+9Ds1ud+YgPW3sUZit2I=;
 b=NLZ96cl4J7LZgIbSjz9waDx1/3yCRTfaz3uqcr3rmW5wPaDsyPcbHbq+aF6bZWln5PmUKa
 76frsJ1RrZzBQ2Cij43YL8m3508K99DkXs3Jn9mrq4zgiiLtYY2OwMzSZ88Nw59dhCrGKz
 9BNrBMAyaqjX+dmdH6qj9O3bDSHPMVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774959258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtgqunutxpPRXtL5hL0Zf2P+9Ds1ud+YgPW3sUZit2I=;
 b=/V+ChPx7NCZSqcCX8OdCl8uBDW0OxLj0hBu54UvESgcJpsHJM8cjZKS6NV2H22FNfvPA+b
 dbfK5MO+RVdJBYAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774959258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtgqunutxpPRXtL5hL0Zf2P+9Ds1ud+YgPW3sUZit2I=;
 b=NLZ96cl4J7LZgIbSjz9waDx1/3yCRTfaz3uqcr3rmW5wPaDsyPcbHbq+aF6bZWln5PmUKa
 76frsJ1RrZzBQ2Cij43YL8m3508K99DkXs3Jn9mrq4zgiiLtYY2OwMzSZ88Nw59dhCrGKz
 9BNrBMAyaqjX+dmdH6qj9O3bDSHPMVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774959258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtgqunutxpPRXtL5hL0Zf2P+9Ds1ud+YgPW3sUZit2I=;
 b=/V+ChPx7NCZSqcCX8OdCl8uBDW0OxLj0hBu54UvESgcJpsHJM8cjZKS6NV2H22FNfvPA+b
 dbfK5MO+RVdJBYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F4F04A0A2;
 Tue, 31 Mar 2026 12:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RLBuBpq6y2n2CQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 31 Mar 2026 12:14:18 +0000
Date: Tue, 31 Mar 2026 14:14:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <acu6odZhugXeNM_C@yuki.lan>
References: <20260331-nanosleep_posix_fix-v1-1-7a707f871582@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331-nanosleep_posix_fix-v1-1-7a707f871582@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nanosleep: Use CLOCK_MONOTONIC for elapsed time
 measurement
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
> All nanosleep POSIX conformance tests used CLOCK_REALTIME to measure
> elapsed sleep duration. CLOCK_REALTIME can jump due to NTP corrections,
> VM time sync, or other wall-clock adjustments, causing sporadic test
> failures where measured time far exceeds expected sleep duration.
> 
> Switch to CLOCK_MONOTONIC which is immune to wall-clock changes and is
> the correct clock for measuring elapsed durations.

Unfortunately CLOCK_MONOTONIC is optional in POSIX so we have to check
if it's present at least at compile time with something as:

#if _POSIX_MONOTONIC_CLOCK
# define TEST_CLOCK CLOCK_MONOTONIC
#else
# define TEST_CLOCK CLOCK_REALTIME
#endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
