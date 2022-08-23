Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84350C32774
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 09:42:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10F2C3CA38C
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 11:42:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E93AE3C8854
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:41:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2F2A41A006AF
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 11:41:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70FF220FF7;
 Tue, 23 Aug 2022 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661247710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjCJADV3WuKTr217QBnhuRoC4TUyXM75MI2fXeAgzmg=;
 b=P0taf5dMskqu44WdwqPbx78SYKjqvSI2eohyZR7Ptrzf2nWAUdUZXoY2AIVJTViijcEXru
 RW/fz6UpqsoK9OLUPbG8ryqm5NecgbYgPE71CmrZr+4r6S4CUgEjU4Bhst0WDLGjFgLhmy
 E2JxZYbl3q+3xwYUxcjTBAXX3RItam4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661247710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjCJADV3WuKTr217QBnhuRoC4TUyXM75MI2fXeAgzmg=;
 b=7i0RkKBO0klzz8MhF8YvdpYSlEnqI6EXtuoHqP/xA47R3JWX2PNv/f8n7rHvNq/ckjhOEL
 1wbGse6JWJUzHjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1101D13AB7;
 Tue, 23 Aug 2022 09:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ryH1Ad6gBGOieQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Aug 2022 09:41:50 +0000
Date: Tue, 23 Aug 2022 11:41:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <YwSg3BbsVwGcjlsx@pevik>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
 <20220822113919.196953-4-tudor.cretu@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220822113919.196953-4-tudor.cretu@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] syscalls/prctl04: Allow rt_sigprocmask in
 the syscall filter
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
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tudor,

> Some libcs (e.g. Musl) call rt_sigprocmask as part of their fork
> implementation. To successfully call fork, rt_sigprocmask must be allowed
> as well in the filter.

When tested on lastest update Alpine with 1.2.3 it in both cases fails:

prctl04.c:205: TPASS: SECCOMP_MODE_FILTER doesn't permit exit()
prctl04.c:207: TFAIL: SECCOMP_MODE_FILTER doesn't permit exit()

What can be wrong?

@Yang Xu: Also this test (written in new API) should use tst_reinit()
https://lore.kernel.org/ltp/70476626-2c7a-fcd6-4cf4-de7cbd572f99@fujitsu.com/T/#mb3e34713dd15f2050ec2dc01615fefb7ee66c880

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
