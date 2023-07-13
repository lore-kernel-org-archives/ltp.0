Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E2CEB64DD
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 08:57:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C45A3CB6C3
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 10:57:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0B4F3C99ED
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 10:57:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2D08E1000342
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 10:57:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09C932218C;
 Thu, 13 Jul 2023 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689238645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvSAQ58I3KT3sQiQXVtAQuYZj0ABNTsia8XhazUFEKA=;
 b=iwifAzjNeIXCCdMXBT1yK4SFh48dMIO3CqfG0njbZFo/JEL7NUY9946rvugMNeiC5MRNI4
 2rPtY8vYeFQ9lzAanegeejSr11WuYTDCnC9h6wnrdM82DGlVBBRbhqx//1I0O6+a0ksFa5
 SbFP6HjdBownx47DjzT8MYEvi20Rs5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689238645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvSAQ58I3KT3sQiQXVtAQuYZj0ABNTsia8XhazUFEKA=;
 b=RJi2Omczzl2NFSi3/brOZSPyvornjdPbPjbjwlp3P+PpMus1GEm//y7sVwLqAfvZb1O9sZ
 42C9QGyEDi+NMNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E04BA13489;
 Thu, 13 Jul 2023 08:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ROqTNXS8r2SHPQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jul 2023 08:57:24 +0000
Date: Thu, 13 Jul 2023 10:58:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZK-8tcKOTsRHexe8@yuki>
References: <20230321110337.22970-1-wegao@suse.com>
 <20230507142209.17815-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230507142209.17815-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] starvation.c: New case for sched starvation
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
> +static long loop = 10000000;

I've reduced the default number of loops to 2000000 since the test
runtime on small ARM board was quite close to the timeout. Given that
when the scheduller was broken the original reproducer haven't finished
after running for 40 times longer than on working kernel, 2000000 should
be enough to trip the timeout even on fairly fast machine.

Also added note to the test description that the test is expected to
timeout when scheduller is broken.

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
