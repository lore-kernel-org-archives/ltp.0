Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9E6C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 15:07:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58DD43CA3D4
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 17:07:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5833C91A6
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 17:06:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6B3276008AA
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 17:06:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B752B224F7;
 Tue, 23 Aug 2022 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661267208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSN0rn48amZyaXWG14BU53eI8qeMq7nyXt3z16jlQbc=;
 b=TQGbqNeFNNXOjVZUOr57RB2kqSko0TIQwsMLFTYH5QnfgW4pQAWhGC6eSoIoYkJTyC70+3
 0vtdcOsrbaW9uYmgHK1o+wXLHwoePTCKc8FJcUORfXiAM0gzfoLXPGQGvM44VruzxbsLLW
 RllFODJ7mRg0N/SMY90w47JLrDeYKkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661267208;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lSN0rn48amZyaXWG14BU53eI8qeMq7nyXt3z16jlQbc=;
 b=iboDTzVPIDccwFPoGdnfthTlirRnxy/JTH5Woe94GGDBPQ/8iRbPobsI4IM+Q3MUzd3OY5
 6yiPXzhQIIfpeVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6254913A89;
 Tue, 23 Aug 2022 15:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V5FyFgjtBGPrEwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 23 Aug 2022 15:06:48 +0000
Date: Tue, 23 Aug 2022 17:06:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Tudor Cretu <tudor.cretu@arm.com>
Message-ID: <YwTtBqH+ys4qBPkW@pevik>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
 <20220822113919.196953-4-tudor.cretu@arm.com>
 <YwSg3BbsVwGcjlsx@pevik>
 <ac9beefc-f2a9-1333-aba2-54a11d2f0689@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac9beefc-f2a9-1333-aba2-54a11d2f0689@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

Hi Tudor, all,

> Hi Petr,

> On 23-08-2022 10:41, Petr Vorel wrote:
> > Hi Tudor,

> > > Some libcs (e.g. Musl) call rt_sigprocmask as part of their fork
> > > implementation. To successfully call fork, rt_sigprocmask must be allowed
> > > as well in the filter.

> > When tested on lastest update Alpine with 1.2.3 it in both cases fails:

> > prctl04.c:205: TPASS: SECCOMP_MODE_FILTER doesn't permit exit()
> > prctl04.c:207: TFAIL: SECCOMP_MODE_FILTER doesn't permit exit()

> Sorry, I am not sure I understand. Which are the both cases in which the
> test fails? I am also using Musl 1.2.3 and the test passes for me on
> BusyBox (both x86_64 and AArch64). I don't have an Alpine environment,
> and I am having issues with docker and seccomp, so I am not able to test
> on Alpine yet.

I'm sorry I wasn't clear: on Alpine distro (which uses musl libc) it fails
without this patch *and* with it (i.e. patch does not fixes it).
But as you report that it fixes it on musl 1.2.3, I guess it's some Alpine
specific bug, I merged it.

Thanks!

Kind regards,
Petr

> Kind regards,
> Tudor

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
