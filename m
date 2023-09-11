Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA7AEE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 09:11:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B64CC3CE84C
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 11:10:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E0403CB379
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 11:10:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D6788140111D
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 11:10:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA30D21850;
 Mon, 11 Sep 2023 09:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694423445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T6eTQPwu5EVfTNpCRvMwLrNIf4bbAv5r4K1P8gChzRU=;
 b=w08G21eJhxX03JMoXAjArc2V0eEH1xaHw99PFjXQztKh6pbdTt7ijZ177Zin4Lw4FYPy76
 GdkfKmScHIN5LbamY++4ttsxqjX7WNSXryUkq9qjdt9uajaWJRaagEJGRzydJdVuY4lkHy
 MxgwjcggT7vMbrkj+t6NzAGO/4KALTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694423445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T6eTQPwu5EVfTNpCRvMwLrNIf4bbAv5r4K1P8gChzRU=;
 b=s72RyxwnhBTtQzlwsG8X/xOd8O1nhbGS8FxjcJ1GHPbeSAG+2de0JRD/q7ze+2hrTK4+k6
 Y491DfoWaH50/cCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C59DE13780;
 Mon, 11 Sep 2023 09:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pxkkL5XZ/mQTHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 11 Sep 2023 09:10:45 +0000
Date: Mon, 11 Sep 2023 11:11:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZP7ZwvOIA-aUxeJp@yuki>
References: <20230907142141.15388-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230907142141.15388-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Use correct ioctl request for termios
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
Applied, thanks.

>  static char *device;
> @@ -62,9 +65,6 @@ static void verify_ioctl(unsigned int i)
>  {
>  	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
>  		     tcases[i].error);

It would be nice to also print a nice description here instead of the
parameteres. The third parameter to the macro is a printf-like format
string. What we usually do in these tests is to put short description of
the testcase to the tcase structrure and print it here with
TST_EXP_FAIL(... "%s", tcases[i].desc);


And another improvement would be to create a tty with openpty() and use
the fd from these for the test instead of messing up with the system
ttys. I suppose that we could drop the needs_root flag in that case as
well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
