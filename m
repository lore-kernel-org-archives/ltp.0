Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5A5C6FD19
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 08:54:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBA123CAE63
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 09:54:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A5A93C1047
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 09:53:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5AD866000F0
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 09:53:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE1A71FE07;
 Mon, 13 Mar 2023 08:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678697632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PL7/S9fZZSEs2eAfAlZvwrXtz6LHjXlEmQyvJda62EQ=;
 b=LQnULXcAdBzpnHepci+2ZQg7aDmpdTYTiwCGnr2/qFdiiE2Gk2c4LAaXWxM/70A4zug3v6
 ofZx9dK9hbfGmbJeLmLAY2QtMV1RawN+X/28ag+5hdUGtj3LPg/McdyeZjZIjw6O7WgMpi
 t7h76h/OGSfvu84dag5XVZsVauyMzxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678697632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PL7/S9fZZSEs2eAfAlZvwrXtz6LHjXlEmQyvJda62EQ=;
 b=AU6N0WsAFpKrkUKLEid7vMjKlDh8vbjXdD/yhPel9rFy5K9tnpm2ps77748A0RLt5N6V7K
 fwRffTinGQimhaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5A3613517;
 Mon, 13 Mar 2023 08:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hRoOL6DkDmTECgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Mar 2023 08:53:52 +0000
Date: Mon, 13 Mar 2023 09:55:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZA7k8HLZpY+3Evx7@yuki>
References: <20230310140407.20137-1-wegao@suse.com> <ZAtEIClci4QximeK@yuki>
 <20230311022309.GA12553@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230311022309.GA12553@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] madvise11.c:Check loadable module before rmmod
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
> > The code already has if (!find_in_file("/proc/modules", HW_MODULE)), you
> > are reinventing the wheel.
> There is an issue happen during our test, the fail happen with following failed msg.
> rmmod: ERROR: Module hwpoison_inject is builtin.
> madvise11.c:356: TWARN: rmmod failed (1)
> 
> So i think before rmmod we should check this module can be rmmod or not.
> And every modules which can show in lsmod output, it means the module can be unload.
> I am not sure the output of /proc/modules contain ONLY loadable module, it maybe
> also can contain the buildin module so this function created.

The lsmod command reads the /proc/modules, that's where it gets the list
of loaded modules.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
