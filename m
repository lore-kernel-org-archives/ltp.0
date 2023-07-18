Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC93EB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 10:02:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 597353CDD6E
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 12:02:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F1023C98FB
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 12:02:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 06E581400967
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 12:02:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5ABD521980;
 Tue, 18 Jul 2023 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689674527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0ywIlxKmAuxSGUY6WyqCMbfkwE99zVtDgLe4ij98Tg=;
 b=A7so3LC5zFOkJ/NeHX8uYz29VoTx0ybhfon5O0IvlwZ7lzUb1jln7m2RvZw7pV/dkAdc4z
 41bbRYu7cNGEY4sNTYS98OjyOL7ITAI2bdKHfjtjGLqirTuBQN5dRCKP3BrqU5GIE1g2I4
 nl3+r7zSgPlLi+4u3p3VAL+HpXJwFL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689674527;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0ywIlxKmAuxSGUY6WyqCMbfkwE99zVtDgLe4ij98Tg=;
 b=1nl4Jl0hLxZZiYoXjzwjTenpVXxp8GuWhFqBkN0RxmB232FAAVxO7FRSoakr7kGiEtxpOQ
 0q1iGhw4MKRNZNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 188D3134B0;
 Tue, 18 Jul 2023 10:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o09ZAx9jtmSUdQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jul 2023 10:02:07 +0000
Date: Tue, 18 Jul 2023 12:02:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20230718100205.GA1153123@pevik>
References: <1688637954-17765-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230710134604.GA645484@pevik>
 <934a1afb-c157-326f-21f1-776563373f13@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <934a1afb-c157-326f-21f1-776563373f13@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/geteuid01: Convert into new api
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

> > Hi Xu,

> >> + * Copyright (c) Linux Test Project, 2003-2023
> >> + * AUTHOR: William Roske, Dave Fenne
> > Very very nit: s/AUTHOR/Author/

> > Also, in the subject in both commits: s/api/API/

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Thanks for your review.

> I merged this patch set and modified getuid01 to origin gpl-2.0-only.

> But  It seems all of uid/gid case miss to use COMPAT_TST_16_H:= 1 in 
> Makefile except syscalls/setuid.

> I search the history, it seems related to  a bugfix[1] when 
> touch/modify/create fiel in syscall/utils.

> [1]https://github.com/linux-test-project/ltp/commit/631d16671d876524588320ee71fd23fe22750307

Good point. I send a patch which switches the logic (old tests have variable):

https://patchwork.ozlabs.org/project/ltp/patch/20230718100050.1162482-1-pvorel@suse.cz/

Kind regards,
Petr

> Best Regards
> Yang Xu

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
