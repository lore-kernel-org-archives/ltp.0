Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26268C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 09:03:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04BAF3C07B5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 10:03:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FEAB3C07B5
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 10:03:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF52A201019
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 10:03:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D94B2110A;
 Fri, 10 Dec 2021 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639127021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PiZCYzCBCn7b1Oa3o/iqSQPCEnWYalE5xafKGUTPtWA=;
 b=mYBk9p/U+vW1lJRLKxkYOeWxnjZ0Dn8ogmYWI/O7iLV9JwhKrBczAt6B6r/HPmXpcflFVz
 FF2m4+y8nuHvUToQwKccQC29bFx1lVMA1hMdXTGa/YfueQtzO+2P2qYFS0hoSyG/s0O5Pa
 MFMWk+zjgxKWdPxINK+0ZpBN1Mitcdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639127021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PiZCYzCBCn7b1Oa3o/iqSQPCEnWYalE5xafKGUTPtWA=;
 b=Mr6H7FDKmdBnUUPTUBQC0FYRaBEkgr6gg0f1KoLLNJilOYcjTru6TZ4hXyD6lnPP15B6IE
 5eJE49oxEQCJ8eBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3103013E15;
 Fri, 10 Dec 2021 09:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fdZUCu0Xs2EBJwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Dec 2021 09:03:41 +0000
Date: Fri, 10 Dec 2021 10:03:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YbMX66Oeu1byuMiR@pevik>
References: <1639035823-5786-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639035823-5786-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YbIeFLfVb36DaVq8@yuki> <YbJw6IfUFhVDgQLS@pevik>
 <61B31657.9020008@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B31657.9020008@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] zram/zram_lib.sh: Skip test if zram module
 can not be removed
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

Hi Xu,

> Hi Petr
> > Hi Xu, Cyril,

> >> Hi!
> >>>   	tst_set_timeout $((dev_num*450))

> >>> +	rmmod zram>  /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
> > This is wrong:

> > $ lsmod | grep zram
> > # rmmod zram; echo $?
> > rmmod: ERROR: Module zram is not currently loaded
> > 1

> > Why not detect with lsmod? i.e.:

> > 	if lsmod | grep zram; then
> > 		rmmod zram>  /dev/null 2>&1 || tst_brk TCONF "zram module is being used"
> > 	fi

> Yes
> > Although I'm not sure if we should attempt to rmmod, maybe quit when lsmod
> > detects zram would be better.
> If zram module was loaded but not used, then we can rmmod and do 
> modprobe(case needs a clean zram envrionment). IMO, it doesn't affect 
> any things.
> If zram module was loaded but used, then rmmod failed and case skips.
OK, it's safe, ack.

> ps: zram01 need to rmmod and modprobe zram. So if kernel built with 
> CONFIG_ZRAM=y, we also need to TCONF. But it is another story.
+1

Kind regards,
Petr

> > Also it wouldn't harm to add at least rmmod into TST_NEEDS_CMDS (in the
> > zram_lib.sh + take into account TST_NEEDS_CMDS from tests), but that's another
> > story.
> Agree.

> Best Regards
> Yang Xu

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
