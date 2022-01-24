Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C90C433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:10:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B073C8CE0
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 16:10:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02EDD3C21D9
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:09:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4226B1400059
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:09:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61EA71F38B;
 Mon, 24 Jan 2022 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643036993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eI8JoLOVXa/ICcNu4cgFs5C1gtoD+mSQ+uNNstDfVmE=;
 b=T7vzpbl/W5BuW1TR5iWMeGjEXIDaTdxxkP26LeFGXg39S7pMOEO2oyveQ4tk6YTR9Lngbh
 TSCnQgoQY4dnYjKbR/G1Fs9M216HhlfkOmGkcTsm9yCvVKM3Lt9OhLt59pyzNzuouUbBxz
 uuLZlqRBqAu/CudreYxGrTDlei01fQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643036993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eI8JoLOVXa/ICcNu4cgFs5C1gtoD+mSQ+uNNstDfVmE=;
 b=DloECeAwWcQTHkpcHNNfN1bW5HhwuFyxWg+LL0OCmxXscmclV716kkQBuSOgjQ9JMYBQO4
 jLUQOutDMaEEY6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43BB213C1B;
 Mon, 24 Jan 2022 15:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WkRgD0HB7mHpEQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jan 2022 15:09:53 +0000
Date: Mon, 24 Jan 2022 16:11:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Ye7BrHTbkLRtVwhF@yuki>
References: <20211208082625.26324-1-pvorel@suse.cz>
 <61B1CFC8.6060305@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B1CFC8.6060305@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Fix warnings
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > * s/AC_PROG_LEX/AC_PROG_LEX(yywrap)
> > yywrap argument introduced in 46f384f8 ("Revert to 2.69-compatible
> > behavior in AC_PROG_LEX (#110346)") from 2.70, but using is is
> > compatible on older releases (tested on 2.63).

Just looked at what the lex is needed for and it's ltp-scanner.c in pan/
and the ltp-scanner does not seem to be used in any of the scripts we
have, so maybe we can just remove it.


Or is there anyone out there who needs ltp-scanner binary?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
