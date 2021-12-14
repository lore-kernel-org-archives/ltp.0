Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9F4C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 15:12:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D87523C8C62
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 16:12:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501D73C8A8C
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 16:12:05 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D01591A00245
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 16:12:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECFC81F37C;
 Tue, 14 Dec 2021 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639494723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1EpiJyiUKWpXgs3ShfAQG/b5vhUFPlJNyE1oZ/A9iT4=;
 b=ixxWFCiWKfxm9knHTA3/EzmnXKLbK2CsDq4YPZ05Iax21v1TIhxGRkp2ZGLwoQff4VoBm8
 sv+4TjViCQIeKybnPoA7X1sX/y7qbd22z+bB0Ao66fpcTd4sefcchA5HfQ+Tt2uNXiPQmR
 zXmQNFYk7gc4LvwA3Hzt6Jw7FZ54v8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639494723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1EpiJyiUKWpXgs3ShfAQG/b5vhUFPlJNyE1oZ/A9iT4=;
 b=JdSmz6fVbEC1XaRDz3dr6oxqqcLv99mIO9s7SXECxi3qbnLJoBlEJw9Yylwr0IWXYg709q
 8GdLrxfox+zuFICA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAAD913DF1;
 Tue, 14 Dec 2021 15:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4lnFMEO0uGFaXQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Dec 2021 15:12:03 +0000
Date: Tue, 14 Dec 2021 16:13:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ybi0mHK4s3X7nLlD@yuki>
References: <20211213160437.32353-1-andrea.cervesato@suse.com>
 <YbiyhLnljUy2K7Mv@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbiyhLnljUy2K7Mv@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactoring dio_append.c using LTP API
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
> I wonder what I'm missing:
> ./dio_append
> tst_test.c:1409: TINFO: Timeout per run is 0h 05m 00s
> dio_append.c:69: TINFO: Parent append to file
> common.h:45: TBROK: open(dio_append,16449,0666) failed: EINVAL (22)

That's an O_DIRECT open() EINVAL probably means that O_DIRECT is not
supported. Is your /tmp/ on tmpfs?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
