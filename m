Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD1C46467
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 15:28:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABB233CC940
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 16:28:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 873233CB568
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 16:28:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85851600763
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 16:28:29 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EDFA667928
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673882908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=44iO3qwUEGZQoFlilFvIaDqwskqrtWLBVgjZbG9tJ0g=;
 b=Jbrai80wHkBQHiwEy6T81XNmLYZIGdtNy1NRuzRBTN05hetOlYQSb6a0Zh6Pj+R0eKXvzW
 r7M/YUkzEhJaH/1PMBW7LGeHlcYTgWt+Wy7CFKBzXrTp5iGI5bZc54pfyGAkW8pZO5L/+x
 CWPHYLuO61msDnnoaD/v5XdywgtEz/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673882908;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=44iO3qwUEGZQoFlilFvIaDqwskqrtWLBVgjZbG9tJ0g=;
 b=q/prDOGMDSqsAyjNe/cWzA7doUvepBvu5yY7p66oY6Tx1Zl1D5tikiZbj9apFl2F1NYCEa
 8npJAM9XZ3aisXAQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C87EF2C19F;
 Mon, 16 Jan 2023 15:28:28 +0000 (UTC)
References: <Y8VRpdW7LUh4uFm9@yuki>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2023 15:23:24 +0000
Organization: Linux Private Site
In-reply-to: <Y8VRpdW7LUh4uFm9@yuki>
Message-ID: <87bkmywlb7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> It's about the time to start preparing for the LTP January release. Well
> we should have started at least a week ago, but my family was sick and
> nobody else seemd to start to work on that...
>
> Anyways let's start with listing patches that should be considered for
> the release, looking at patchwork the queueu is nice and short so I
> suppose there will not be many and that we can start with pre-release
> testing now and do a git freeze at the start of the next week. Does that
> sound reasonable?
>
> Also are there any volunteers for picking up various release tasks?
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz

My fix for fcntl36/34 doesn't seem to fully work for fcntl36 on 32bit
compat. Hopefully I can fix that before next week.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
