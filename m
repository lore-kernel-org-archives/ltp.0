Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0FAC433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 09:43:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEB483C8CD7
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 10:43:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4003C06B2
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:42:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 321FC1A01145
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:42:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E77D1FD49;
 Mon, 22 Nov 2021 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637574174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTeKdJayrGGXipjNcj/9dBCgy2s4WH9eRcdou0Y3OdQ=;
 b=ngZgmDv43zUf5ZKQwJFsssZQzoA/z0XB8lQoZzyP55N0J6wmRp/+xvbpbkuSh4a75tQVx3
 N5PYW6CygGPwgeX1ZhoR5hzN3RPbSy3+ygvto7qtuX206+SQGnewE2PPyeF98hyYPHhZLF
 Az2h0WUd9kkZcVIgUF7dCyEk2L6p+kE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637574174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTeKdJayrGGXipjNcj/9dBCgy2s4WH9eRcdou0Y3OdQ=;
 b=ZxrI31VOs13jyHWyZXATDhzLWhjw1HkFxsBx0OvlS9TaZUpNOrHQrKbnHvGKtG4cGttmLC
 G/M6o2vTA0591oBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6856D13C23;
 Mon, 22 Nov 2021 09:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2molGB5mm2G7XAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 22 Nov 2021 09:42:54 +0000
Date: Mon, 22 Nov 2021 10:43:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YZtmX7MzLCJIwEMV@yuki>
References: <20211119074602.857595-1-lkml@jv-coder.de>
 <20211119074602.857595-6-lkml@jv-coder.de> <YZfBcfs8VZApzMU9@yuki>
 <5979aa76-ca07-2bf2-58cc-33bafe4a280b@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5979aa76-ca07-2bf2-58cc-33bafe4a280b@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/12] posix/conformance/interfaces: Fix all
 unused variable warnings
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Looking at the test the whole loop here is pointless, can we remove it
> > completely?
> I thought the same, but I have never used aio, so I have no clue, if 
> there are any side effects.

As far as I can tell there is none. I guess that the original test
author was simply clueless, we used to have much more code that didn't
made any sense ten years ago and you can still occasionally find some...

> So I went for a minimal?? change approach.

Let's go for that for now then. It would be nice to fix it properly
later on.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
