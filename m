Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D39C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 07:02:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABCD13CA0DE
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 08:02:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AD633C9F0B
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 08:02:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4478E20120C
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 08:02:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E119219A2;
 Fri, 18 Feb 2022 07:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645167764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mdgnk2NgN6AIdnB+2ICN/uuVm6ZN/GkZY4uNEUQeKz0=;
 b=1fB+5qFHX39rDZ81SlxQRKzKnjVjCBpf+aGeNvqEEJG0ZrcFImR2Bg9GXLruyw1IBammS3
 dCypFZ7x7hkt4CVtYQbmwkYWQMwJp32ILThMyDc5zmCPc/tHs+yO7M+wV53C52WcrvXQ8C
 zB+5Hz3dxH9XHAYwPKbEyJO7iZ2oo00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645167764;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mdgnk2NgN6AIdnB+2ICN/uuVm6ZN/GkZY4uNEUQeKz0=;
 b=HjO8iolYqBH1hUUoj0zpYXsG2cINNLx5aQw2Do3zP/yRRecwsVfaOneOT+LCoAU60KUBRc
 4JHvVmc4PrSoZACQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DAA013A15;
 Fri, 18 Feb 2022 07:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xzbzBpRED2ISLAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 07:02:44 +0000
Date: Fri, 18 Feb 2022 08:02:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg9EkoeDiRQhekhX@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6f6p/rdFTfzkoR@pevik> <620F118E.3070306@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <620F118E.3070306@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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

Hi Richie, Xu,

> Hi Petr
> > Hi Xu,

> > ...
> >> +++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
> > ...
> >> +	remotefd = TST_RET;
> >> +	flag = fcntl(remotefd, F_GETFD);
> >> +	if (flag == -1)
> >> +		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFD) failed");
> > Just:
> > flag = SAFE_FCNTL(remotefd, F_GETFD);
> Yes, I almost forgot we have this macro.
@Richie: It'd be useful if sparse checks would suggest to use SAFE_*()
functions, but not sure if easily detectable. Something like setup() and
cleanup() function and syscall followed by if (foo == -1) followed by tst_brk().

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
