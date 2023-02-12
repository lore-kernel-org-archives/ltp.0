Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10D7C05027
	for <ltp@archiver.kernel.org>; Sun, 12 Feb 2023 21:35:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D45473CBFE2
	for <ltp@archiver.kernel.org>; Sun, 12 Feb 2023 22:35:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCB263C1047
 for <ltp@lists.linux.it>; Sun, 12 Feb 2023 22:34:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F5591400451
 for <ltp@lists.linux.it>; Sun, 12 Feb 2023 22:34:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADBB43EB57;
 Sun, 12 Feb 2023 21:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676237686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H4YALlwDEkqarzghTXs3LvXMMiZAKRZfylmUUnC+o4k=;
 b=ftTa18/qsvOs+UUDr8K7rWSNIaq6gDPzwt4ynYHkvjNCq4ZSrXDoqTsSU08+0zUw2CetlJ
 ZMnC+6sEWnbwNej26CGl7Zouz49HYBjwdXaYdph3KUWxvKZrO5R9hZZXqmJIHzZUoSXN0K
 hhYKk3k/WlUUVObAslF5CwoboP+qa2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676237686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H4YALlwDEkqarzghTXs3LvXMMiZAKRZfylmUUnC+o4k=;
 b=ht4/CateXAUMeB6LC7ugQjHBNVEPfwbhycLgMPzp7hb5oxQUurtObixrDTu2q+FY6+IrLF
 jRF1TLA0YepiTxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E890138E3;
 Sun, 12 Feb 2023 21:34:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fmJwGHZb6WPyRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 12 Feb 2023 21:34:46 +0000
Date: Sun, 12 Feb 2023 22:34:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y+lbdJfWRVW7rPNw@pevik>
References: <20230125222703.19943-2-pvorel@suse.cz>
 <20230210223342.240969-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230210223342.240969-1-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugepage15: Resolve compile time warning
 generating with -O0
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

Hi Tarun,

> Instead of turning off the optimizaton with -O0 to resolve unwanted
> behaviour of clang with goto statements, this will make use of clang
> pragma to turn off the optimization for just clang compiler. This way,
> gcc won't throw unwanted warning on turning off optimization:
> "warning: _FORTIFY_SOURCE requires compiling with optimization (-O)".

Thanks!

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

> Also, removed redundant header-includes.
BTW this does not apply because there was change which is not in your fork:

1106777cd ("hugemmap15: Use TST_TEST_TCONF() for unsupported archs")

No need to repost, but please always rebase to current master before posting

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
