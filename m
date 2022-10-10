Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B983CC433FE
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 15:18:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4637B3CAE87
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 17:18:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237903C071D
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 17:18:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8BAB71A00819
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 17:18:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6BEBB21A77;
 Mon, 10 Oct 2022 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665415114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2v4wmoUw0J+761kpbIuRN7aOldisLawD4a38YH7IWNA=;
 b=A6RJyM7lcwQp+pmeHRx0RyN1P2Uh0bcIeEB6b5qLHtoGDuf2g/Dp+DAwHl6vdCLrIEMIbu
 etByeaVOUa24tYWPN2fxPeaik0R2axTDjdasLoLTWxhoCxxitQ/nH0EjdDNfv2kKYLXPRZ
 OF1OE4BqSBmsX6/DqM8cBfk9cMd0qqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665415114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2v4wmoUw0J+761kpbIuRN7aOldisLawD4a38YH7IWNA=;
 b=ddjfGbe0JTrEReUSzelXAznK7e0vswU6gl/1hKJ2BRsRguoHjhzp+HOujCTGZbBrAuQRjs
 LQ5t+/B+Gxv10LDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 527AB13ACA;
 Mon, 10 Oct 2022 15:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8uBjE8o3RGOQMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 10 Oct 2022 15:18:34 +0000
Date: Mon, 10 Oct 2022 17:20:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y0Q4NH77RySQFkDA@yuki>
References: <adf3a4e338625d85401a7d5ec94b33f86a277c18.1665385670.git.jstancek@redhat.com>
 <Y0QVyF43F3ngrU3r@pevik>
 <CAASaF6wx-zFhbFG6TQ28hj5g9fwwciJQiZ-TXvPDOkDH-+9+Dg@mail.gmail.com>
 <Y0Qx/dUX3f/TbZ5R@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0Qx/dUX3f/TbZ5R@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ioctl03: add IFF_NO_CARRIER feature flag
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
Cc: ltp@lists.linux.it, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> @Sven it's not a good idea to post to ML without being subscribed,
> please subscribe next time before posting.

I've added him to allowed filter, I do that automatically for all email
addresses that send patches. But that still means that first post to the
ML will be delayed by a day or so until we get to review the queue.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
