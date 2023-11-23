Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023B6C624B4
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 15:05:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 584FA3D0182
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 16:05:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 184043CFE15
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:05:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DACF71A0BC5F
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 16:05:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 45AA81FDAE;
 Thu, 23 Nov 2023 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700751906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLZvFQwf86jiOOk2l8e7dGkpnYRn+5gohb99Krf4sNw=;
 b=HFwyAEgAiMRTAbNehuAlSe5mR1BZiwgalaFG4y0naeYYlQBTFetbaIbxa7oe2ltGRmth32
 vS8zyZDWGUvf3axZnEmSJqxpct6Lecvv6Us54nhquGcov/lcj7cbdJzEdbOjE0bMmPhdx3
 M50Ohf0SPDriYEnhEAi3he6i0OwWNxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700751906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLZvFQwf86jiOOk2l8e7dGkpnYRn+5gohb99Krf4sNw=;
 b=libH6xmqcvVaLSnQtExIJGv8C0PmDzBNfsp00EuTxGh5RxWX2IGSEG4yi6XOMtmzK9dOds
 s3IxpBdZvCVTt+Aw==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1849F2C5EE;
 Thu, 23 Nov 2023 09:30:08 +0000 (UTC)
References: <20231122144944.23993-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 23 Nov 2023 09:30:01 +0000
Organization: Linux Private Site
In-reply-to: <20231122144944.23993-1-andrea.cervesato@suse.de>
Message-ID: <87pm0095r4.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [16.89 / 50.00];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 HAS_ORG_HEADER(0.00)[]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+];
 FORGED_RECIPIENTS(2.00)[m:andrea.cervesato@suse.de,s:andrea.cervesato@suse.com];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-2.40)[97.22%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 NEURAL_SPAM_SHORT(3.00)[1.000]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(1.20)[suse.de]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Queue-Id: 45AA81FDAE
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/2] Rewrite exit_group01 test
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, thanks!

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> exit_group01 test has been completely rewritten and tst_gettid() has been added
> to support missing gettid() syscall from GLIBC
>
> Andrea Cervesato (2):
>   Add tst_gettid wrapper around gettid syscall
>   Refactor exit_group01 using new API
>
>  include/tst_pid.h                             |   8 +
>  lib/tst_pid.c                                 |   5 +
>  testcases/kernel/syscalls/exit_group/Makefile |   2 +
>  .../kernel/syscalls/exit_group/exit_group01.c | 161 ++++++++++++------
>  4 files changed, 125 insertions(+), 51 deletions(-)
>
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
