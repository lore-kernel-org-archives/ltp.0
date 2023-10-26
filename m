Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ABDC25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 09:57:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3593B3CCB40
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:57:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B93B23CCAE3
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:57:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2C2D96008B1
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:57:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC4601FE17;
 Thu, 26 Oct 2023 09:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698314246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nUimRqPnwbsb8+KmKyaPnA+W2cGxAdlFnzyi7z7+NE=;
 b=3SVRU2WltXU3svauTaoSvRKIv21Bbbfe+I+Rg/Fe/rQSGYENlJSHiOA009E3SNaE1gywWX
 07xDjCJaQ+tnKWNSJ4xzAXwJXUM+Wrkg/mkfIUMX0cJxoNtop8v7FgUMadkdVY1w2PiVpd
 H2Cm1QeVlDHsQHSqAu3UQMWjygcIpi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698314246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nUimRqPnwbsb8+KmKyaPnA+W2cGxAdlFnzyi7z7+NE=;
 b=DR1XXcoNhah2yaJ/oWnYopNW6pKywUmHqPf5KPSPjRYXLfawaDX6OLUhOMFAE26moHH0G/
 Iwd5B/owKvKVynDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FAD51358F;
 Thu, 26 Oct 2023 09:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kXXzHwY4OmUUQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 09:57:26 +0000
Date: Thu, 26 Oct 2023 11:57:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231026095724.GA585957@pevik>
References: <20231005134504.3828-1-mkittler@suse.de> <ZSe6MNMQ6L5yJdV4@yuki>
 <13368109.uLZWGnKmhe@linux-9lzf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <13368109.uLZWGnKmhe@linux-9lzf>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix memcontrol tests under Tumbleweed
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

Hi Marius, Cyril,

> Am Donnerstag, 12. Oktober 2023, 11:19:44 CEST schrieb Cyril Hrubis:

> > Shouldn't we just remove all of dev_min_size records?

> > We already have DEV_SIZE_MB set to 300 in lib/tst_device.c so with no
> > limits we will use the default 300Mb.

> I thought so, too. However, when running this particular test without this 
> minimum specified explicitly, it runs into the following error:

> ```
> tst_test.c:1650: TINFO: === Testing on tmpfs ===
> tst_test.c:1105: TINFO: Skipping mkfs for TMPFS filesystem
> tst_test.c:1086: TINFO: Limiting tmpfs size to 32MB
> tst_test.c:1119: TINFO: Mounting ltp-tmpfs to /tmp/LTP_memkrqX1e/mntdir 
> fstyp=tmpfs flags=0
> memcontrol02.c:93: TPASS: Expect: (current=0) == 0
> memcontrol02.c:99: TINFO: Added proc to memcg: memory.current=262144
> memcontrol02.c:46: TPASS: Expect: (memory.current=52690944) >= (size=52428800)
> memcontrol02.c:51: TPASS: Expect: (memory.stat.anon=52449280) > 0
> memcontrol02.c:52: TPASS: Expect: (size=52428800) ~= 
> (memory.stat.anon=52449280)
> memcontrol02.c:54: TPASS: Expect: (memory.current=52690944) ~= 
> (memory.stat.anon=52449280)
> memcontrol02.c:93: TPASS: Expect: (current=0) == 0
> memcontrol02.c:99: TINFO: Added proc to memcg: memory.current=262144
> memcontrol02.c:69: TINFO: Created temp file: memory.current=262144
> memcontrol_common.h:34: TBROK: write(9,0x7ffda0f93710,8192) failed: ENOSPC (28)
> ```

> Judging by the 3rd TINFO message the size for tmpfs filesystems is 
> intentionally limited to 32MB which presumably also makes generally sense. 
> However, here we *really* need more space. This is most likely also the reason 
> why this test had `.dev_min_size = 256,` before in the first place. The other 
> tests don't need it, though (and I guess the `.dev_min_size = 256,` had just 
> been copied over from the first test).

+1. Although it's unlikely we would really implement smaller loop device on
demand (nobody was really interested and 300 MB for a rootfs is not that much
nowadays), IMHO it's better to keep the real size request in case we really
implement it one day.

BTW more than 300 MB in the error message is 301 MB or more, right? I'm for 300
MB if it works (I suppose you have checked it), but XFS developers are wrong :).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for handling this long standing issue (it looks like nobody runs
controllers on mainline :(.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
