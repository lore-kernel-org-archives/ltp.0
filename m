Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF8EB64D9
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 18:26:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80C953CD80D
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 20:26:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CA143C99AD
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 20:26:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B16856000FB
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 20:26:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 754E51F8BE;
 Tue, 27 Jun 2023 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687890397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Tr1Z9brkcRIgMH8fVvuwPZICQhHEKpcjevS0/dFO24=;
 b=P0I10vqO9XNhlZ9xvuh2EGmRvMwtD5NzP+j/FWuL86JWaBOjI9gbKpblkJSUKUSmZFfWkG
 5hTHW75PFH6FvtDlYUBUWTDDlYHK9Wb0oevHTBpNXwRx0xoae7cWXYbPOmyiQUFTr2ojYW
 GsuGZuKK+i91UkKkgviTlCihRJPG62w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687890397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Tr1Z9brkcRIgMH8fVvuwPZICQhHEKpcjevS0/dFO24=;
 b=I+EMbGCDDOV8GmuFzVlKTnajgLwUS9sfu0jX4p5VsSS0+uUz+uxtBuHqTJW9c6GVJA6cg3
 ybwoeG2BonC5+nAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D1DF13276;
 Tue, 27 Jun 2023 18:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bBl1Dd0pm2SSAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 18:26:37 +0000
Date: Tue, 27 Jun 2023 20:26:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230627182635.GA85230@pevik>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
 <ZJlZD2fVXaVM3X5i@yuki>
 <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
 <20230627135004.GA58180@pevik> <ZJr66taHPoyDthnz@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZJr66taHPoyDthnz@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugeshmctl02: Skipped EFAULT tests for libc
 variant
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
Cc: minachou@andestech.com, tim609@andestech.com, ltp@lists.linux.it,
 x5710999x@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.

> Hi!
> > > Okay, sounds reasonable. I agree with this.

> > BTW I also get ENOMEM on my laptop (currently 1G free space):
> > hugeshmctl02.c:119: TBROK: shmget #1: ENOMEM (12)

> > Should we handle it somehow?

> The line 119 looks suspicions, in latest git the hugeshmctl02.c does not
> even have 119 lines.
Well, it occurred with this patch (file has with it 147 lines). Previously the
version from master worked, but now it also reports ENOMEM even on master:
hugeshmctl02.c:87: TBROK: shmget #1: ENOMEM (12)
(therefore not this patch specific). Should we use .min_mem_avail? (not sure
which value).

nit: The patch subject is "hugeshmctl02: Skipped EFAULT tests for libc variant".
"Skipped" => "Skip" (we use imperative mood).
IMHO more important is the fact, that test variant was added, that's what I'd
mention in the subject. Of course, I'd keep in the commit message body that
libc variant was skipped.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
