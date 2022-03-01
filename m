Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA06C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 10:18:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019593CA2EE
	for <ltp@archiver.kernel.org>; Tue,  1 Mar 2022 11:18:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3849A3CA29B
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 11:17:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6ADE51401244
 for <ltp@lists.linux.it>; Tue,  1 Mar 2022 11:17:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8182E212FE;
 Tue,  1 Mar 2022 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646129875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=au3l4GVlqAwn4jwNZloZBu/2ukHRIR40KItzybFtx+E=;
 b=bI+2WivLbHjUCn5mceTxuV1o7weE7m6gt6Y/UNUIb/0ebjhYGQwUrTg7u1OkWoTbfj58KR
 XoKRq86bzuAjirFZitCHreRaV52Ob9yJMrgVR35tkpkWv7H2Ryjn+31GIXGJspbkwsmWJs
 mPRQqzPYavp6Hq/a4NTAYEbmqJ+SuQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646129875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=au3l4GVlqAwn4jwNZloZBu/2ukHRIR40KItzybFtx+E=;
 b=1VMC1rQbww3nmpGegN9rofMVog8pBBB2FbBpTN7UDTWniTbr6nL6I3ISqCBYNmWrq2PQ2c
 gXF0lyHvjlyvO9BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D958139F9;
 Tue,  1 Mar 2022 10:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mkfKDNPyHWKIdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Mar 2022 10:17:55 +0000
Date: Tue, 1 Mar 2022 11:17:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yh3y0b7WRfYfBWHF@pevik>
References: <20220223153243.317-1-pvorel@suse.cz>
 <20220223153243.317-3-pvorel@suse.cz>
 <6216E3ED.1050700@fujitsu.com> <Yhz1+H3SAlwPaO8H@pevik>
 <621D72EF.50500@fujitsu.com> <Yh3SOwogWwWQdZ4O@pevik>
 <621DD533.50509@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <621DD533.50509@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] quotactl08: Use do_mount()
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> >>>>> to change
> >>>>> quotactl08.c:160: TBROK: mount(/dev/loop0, mntpoint, ext4, 0, (nil)) failed: ESRCH (3)
> >>>> I doubt why fs quota is not supported on this case since we have check
> >>>> kernel config?

> >>> There is probably bug on the SUT, thus it might be correct it fails.

> >>> But how about martin's fix 4aab31e4c7 ("syscalls/quotactl: Skip tests if FS
> >>> quota is not supported") - quotactl04.c also checks for CONFIG_QFMT_V2 and uses
> >>> do_mount(). I'll check whether it was another bug on the system.
> >> Maybe we miss check the following kernel config?
> > In my case it's probably a problem with mkfs.
> Another possible way about loop driver. So do you use default loop image 
> to create ext4 filesystem or export LTP_DEV?
FYI: in our case it was JeOS broken due missing quota_v2 kernel driver
(JeOS tries to be minimal, so it's always a fiddling between space and
functionality). I'm still not sure if we want to add check for .needs_drivers
quota_v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
