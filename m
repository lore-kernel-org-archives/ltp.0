Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E791C0015E
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 15:05:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0D623CF0CF
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 17:05:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E442F3C99BA
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 17:05:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BAE9C1A00924
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 17:05:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E7391F459;
 Tue, 27 Jun 2023 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687878311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWiy0zX8Txg50YMmXQpyW6IUxB+jCUDKAT1jqIyutRY=;
 b=rGTsM5lqJiqpXLXkFCrAEoyUgQmitC+VROz704jeqXmZG+YoCaThmqxt5LyYiatDlEk01o
 PvASFgWfdwJNGdhBYkpLTShOUCAKUqPVok/DVL+9AEGynHCvRATSJnxbss7FWXAP8jJap8
 CkPOOHKDRUBJ6Ryd6HrzNp3/1Gz740c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687878311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWiy0zX8Txg50YMmXQpyW6IUxB+jCUDKAT1jqIyutRY=;
 b=PJKf2CFcSgw4VenZB7VBbGBKjwLYVA778meeTCi9QFsmEkdGC6iKielc+iekGgyRNSS1/x
 +zXDuG4Bzvnzc+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 640B213276;
 Tue, 27 Jun 2023 15:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F5J4Faf6mmSfIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 27 Jun 2023 15:05:11 +0000
Date: Tue, 27 Jun 2023 17:06:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZJr66taHPoyDthnz@yuki>
References: <20230615093933.3185297-1-dylan@andestech.com>
 <CAEemH2e-PPPNHNX6_3Kj86hh3z-5o2i4XxD2GP-+Fh4Pe=B3TA@mail.gmail.com>
 <ZJlZD2fVXaVM3X5i@yuki>
 <CAEemH2d=Mf=WsSXFGwUPeL3dqSOR2kf-eJr+C8HFTMMhAEynKg@mail.gmail.com>
 <20230627135004.GA58180@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627135004.GA58180@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Cc: minachou@andestech.com, tim609@andestech.com, ltp@lists.linux.it,
 x5710999x@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Okay, sounds reasonable. I agree with this.
> 
> BTW I also get ENOMEM on my laptop (currently 1G free space):
> hugeshmctl02.c:119: TBROK: shmget #1: ENOMEM (12)
> 
> Should we handle it somehow?

The line 119 looks suspicions, in latest git the hugeshmctl02.c does not
even have 119 lines.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
