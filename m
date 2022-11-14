Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6F9C433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 14:17:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07E133CD257
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 15:17:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C8EA3CD20D
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 15:17:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 34E29600689
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 15:17:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F6A120057;
 Mon, 14 Nov 2022 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668435437;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7uLxhdAQ2sYFm0Vz9X4Qi2VRyesyiHA+iT+Pz4jldo=;
 b=M3qg8JpocY9XOM7amn2ObXIiUGYQFvCDpMq1R832DAcGWviekSAlr4uAy7w6NxjpxU1LCQ
 hron+c0QcP9wRpLoIHLPOsPqt8gQJeHlnMSJt04KlUuY/ZsKHq1QfFNke6/OozQItVC4Kh
 DLRUrSjOqUwNOg0uzm2lhhufD+lAiGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668435437;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7uLxhdAQ2sYFm0Vz9X4Qi2VRyesyiHA+iT+Pz4jldo=;
 b=UsUr7sBmyLSF99LDg7MxxzvgFreI39zTSF96yG5Gzqq5Pokz8ApZyDpkdK2Rn2xOMHTybS
 7zIsgXwC4rHlctCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29F4713A92;
 Mon, 14 Nov 2022 14:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +Lh1CO1NcmP2ZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 14 Nov 2022 14:17:17 +0000
Date: Mon, 14 Nov 2022 15:17:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y3JN6wLNezRUodYD@pevik>
References: <20221027215808.4126148-1-edliaw@google.com>
 <20221027215808.4126148-2-edliaw@google.com>
 <8735atww9l.fsf@suse.de> <87y1slvgkm.fsf@suse.de>
 <Y25+IZDZ9/rvSH+E@pevik> <Y3IdXcWbV/svAUWl@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3IdXcWbV/svAUWl@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/1] mmapstress01: refactor to tst_test
 framework
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> Hi!
> > @Metan: I wonder if this can be fixed in docparser.

> For the time being I would rather keep the structures inline in the
> tst_test.
Good to know.

> Fixing this in the dumb parser would be doable, but quite an effort. We
> would have to start tracking global variables the same way we track
> macros.

> > @Richie: If not, it would be nice to have check for it (I'll add issue with
> > "check" label).

> And rewrite to any other system would be even bigger effort. Sounds like
> a hackweek project if anyone is interested.

Understand if nobody (even Richie) wants to put any effort into automatic check.
I certainly don't. I'll send a patch where I document the need to put inline in
the tst_test (sending patch mainly due my bad English).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
