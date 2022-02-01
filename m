Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACADC433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 15:39:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 105EC3C97EE
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 16:39:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED3433C8E25
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 16:39:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A484100095C
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 16:39:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B1D81F37E;
 Tue,  1 Feb 2022 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643729973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdhSEkx/cJCrPq9Opdv9FPioywL3T4YhSf33+rsD030=;
 b=eheCpjl39f4Kt7rSYK7Iq9FHj+P0gQ/J0CiqLV3vGpgryAhJ85TiOsroItBhjGQngqrVCn
 kic/auumE7YCK8nnHi81S2OgZhYj4Xcp4/inZO4zzdbVaK5extJu82oTXGF6uJdRhVxgtn
 CNBJH2b8DwdLt480321RD9K2TQ1rxQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643729973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdhSEkx/cJCrPq9Opdv9FPioywL3T4YhSf33+rsD030=;
 b=SYZRpltA2sFVWFAcrnl1Hn79Q/HbMMAaoxP4rRdhUGWcjnffnwY3/dkYh0t7orrRFkWGO/
 aR4td646QXpxQPAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E519A13B53;
 Tue,  1 Feb 2022 15:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qAqTNjRU+WGmNwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Feb 2022 15:39:32 +0000
Date: Tue, 1 Feb 2022 16:41:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YflUp+c8DQb3Qgu4@yuki>
References: <20220119091311.22150-1-andrea.cervesato@suse.de>
 <20220119091311.22150-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220119091311.22150-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Update lapi/futex.h fallback
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
> +struct futex_test_variants futex_variants[] = {
> +#if (__NR_futex != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX, .desc = "syscall with old kernel spec" },
> +#endif
> +
> +#if (__NR_futex_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{ .fntype = FUTEX_FN_FUTEX64, .desc = "syscall time64 with kernel spec" },
> +#endif
> +};

I guess that there should be a followup patch that makse use of this in
all the futex tests, right?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
