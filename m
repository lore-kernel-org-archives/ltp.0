Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCA1C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 07:30:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADE2F3C88C5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 08:30:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDCFB3C2242
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:30:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56E24200990
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 08:30:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6233E1F3B0;
 Mon, 13 Dec 2021 07:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639380605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cpeZQLlHGtFEeBf2YZEuIsFMt2RTmaA8C8GtobDHH+w=;
 b=WYfSHc4vYTXe9XB1T7zJDEe3M0BDptYuxdOc+uwgTeaO0kBRthPOKEIagufsE4pj4X3mEl
 a4dimMcFKtfXLgFMmPmoFzVRO8CIr10Yb332fQbiV7jdTkGbdxM3DCCDIxSUYSSUmczsrS
 oTOC693urQFus8EawEdvPiR8CEjSCL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639380605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cpeZQLlHGtFEeBf2YZEuIsFMt2RTmaA8C8GtobDHH+w=;
 b=NbWTzH6r/Kv/zqvvIDQ9Bu0jMNLSoqMy7XLh1FWqc6B/NPSDTlufXczkMaijX1yHwqy2zu
 y7+a0HrhOpIhejDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 384D113B51;
 Mon, 13 Dec 2021 07:30:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c8eNC332tmE1cQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Dec 2021 07:30:05 +0000
Date: Mon, 13 Dec 2021 08:30:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Ybb2e1QC/HXCsGwV@pevik>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbJ3SKsLu7iNoqZc@pevik> <61B33253.2070105@fujitsu.com>
 <61B334D8.7000200@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B334D8.7000200@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] zram/zram03: Convert into new api
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,
> Hi Petr
> > Hi Petr
> >> Hi Xu,

> >>> Also add removing zram module step in setup, so we can avoid the situation that
> >>> zram module is being used by zram-generator.

> >> ...
> >>> +++ b/testcases/kernel/device-drivers/zram/zram03.c
> >> ...
> >>> +static const char *const cmd_rmmod[] = {"rmmod", "zram", NULL};

> >> Again, here should be lsmod used.
> > I prefer to detect it in /proc/modules.
Generally I'd vote for approaches like this to not depend on anything external
to cover more systems (Cyril suggested in v2 SAFE_FOPEN("/proc/modules") and
loop over the lines and do strstr() for zram.)

> > What do you think about it?
> Since we have require modprobe/rmmod commands, using lsmod is better. I 
> will use lsmod as you suggested.
OK. I was thinking a bit whether using finit_module would help to replace
modprobe and not require rmmod to cover more systems, but it'd be probably
overcomplicated just for very few systems without kmod installed.

(+ We already depend on all but AOSP on /lib/modules/$(uname
-r)/modules.{dep,builtin} for tst_check_driver().)

Thus ack keeping the current approach.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
