Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5CC433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:19:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 140123CAEE1
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 11:19:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 987FC3CAECA
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:19:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2474110002B2
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:19:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 120271F385;
 Thu, 13 Oct 2022 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665652749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6y5QnAl4wFV6P0nUqpDZbYsFwD6KpP0PptRD2+S6sk=;
 b=E9XrhDoudUi9We2V8Ldl6RTFKk16g40Bvl2N5DhS3QXUxQZbUXKQfE/QBsdZrbPqdWuHWe
 FfFKNdjOne0xIlMbr9vKpx4WUmnxB0LraS0tah5lX4UJRo2+oILTpcAQxZCAGIxaNrL96i
 wm+r3bSPs9F/HDP10RAWl/FyP97KmoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665652749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D6y5QnAl4wFV6P0nUqpDZbYsFwD6KpP0PptRD2+S6sk=;
 b=Ma+VjLtiF2+qw87DpxGTLTldyyTTWZBQ+xOAUIHlyRa3PLeJtIvr2sb4PFKNlY8TF6rtPI
 EH8/U+IqhmoXApAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1A6E13AAA;
 Thu, 13 Oct 2022 09:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KH09LQzYR2OcCgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 09:19:08 +0000
Date: Thu, 13 Oct 2022 11:19:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y0fYCp2PdJ14/JYk@pevik>
References: <04dbdaf51ae940289775353f0535c4a4@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04dbdaf51ae940289775353f0535c4a4@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
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

> Hi Petr,

> It is failed on my system:

> sh-4.4$ ./msgget03
> tst_test.c:1535: TINFO: Timeout per run is 0h 00m 30s
> msgget03.c:42: TINFO: Current environment 0 message queues are already in use
> msgget03.c:45: TBROK: Failed to open FILE '/proc/sys/kernel/msgmni' for writing: EACCES (13)

Ah, b740bfac5 ("msgget03: Set custom queue limit")
causes the need for root. IMHO this one is valid.

I'd suggest to remove needs_root for needs_device and mount_device now
(i.e. send v2).

nit: FYI most of the people use bottom posting on mailing lists, you use top
posting. Combine both makes it hard to follow.

https://en.wikipedia.org/wiki/Posting_style

Kind regards,
Petr


> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> tst_sys_conf.c:118: TWARN: Failed to open FILE '/proc/sys/kernel/msgmni'

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
