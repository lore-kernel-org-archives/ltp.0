Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D13C433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 08:12:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1806B3C8DD1
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 09:12:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D65A3C093B
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 09:12:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0918F1A01229
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 09:12:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DACDD1FD33;
 Tue, 23 Nov 2021 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637655134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sqobA9AveqOJ6cP6dycnOtPhYXbNf6MzTJrJfDzIS1Q=;
 b=GCloePr5SeZvJYBuZhaHYeyiqu/+zYxNIde7Qz5Uo5kM9x9Ihk2Ftem5rSB1pgfghjKOLO
 M5qeL6xt7Y44sWqZyS4IAkNTCEFC96rOlvlH7Y/L1oj2y91JILsb90ygjXN1vE00ZydJrX
 vpEuvzAkzsFBPAlH4fDNtTjHkouxJ38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637655134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sqobA9AveqOJ6cP6dycnOtPhYXbNf6MzTJrJfDzIS1Q=;
 b=KY8EPgsf4+rEB7Ne7M4GCxsbUyw0lSLrZl48YF47I8j3tYIViNQXblo1QmP4iJ2MWmUcdA
 4DVYN+kP7gLLKbCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA5A813D2B;
 Tue, 23 Nov 2021 08:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zV/fJ16inGEIcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Nov 2021 08:12:14 +0000
Date: Tue, 23 Nov 2021 09:12:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <YZyiXbx5QOymJSsE@pevik>
References: <e58da01199ac4995805b2053f5e44a56@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e58da01199ac4995805b2053f5e44a56@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/fanotify07: Add stop_children() to
 cleanup()
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
Cc: Matthew Bobrowski <repnop@google.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi,

> I have test the patch through setting "ulimit -n 20" and while true;do ./fanotify07 &;echo "";done 

> Or just add a tst_brk as follow:

>         /*
>          * Create and destroy another instance. This may hang if
>          * unanswered fanotify events block notification subsystem.
>          */
>         newfd = setup_instance();

>         SAFE_CLOSE(newfd);

> 		/* inject */
> 		tst_brk(TBROK, "exit abnormally");

>         tst_res(TPASS, "second instance destroyed successfully");

OK, thanks for testing! (suppose you've done this for v3).
I'm going to merge it today.

> For email CC, I have CC to you and Amir yesterday, please check.
You send extra mail on older version with info that you posted new version.
More effective is to use --cc parameter on git format-patch or git send-email in
new version (fewer mails + people don't have to search for particular email in
LTP mailing list mailbox).

Also, FYI we have archive on lore: https://lore.kernel.org/ltp/
(patchwork sometimes some mails).

Kind regards,
Petr

> Thanks very much!

> Gongyi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
