Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE247C7EE24
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 10:58:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6E3E3CDC7E
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 12:58:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CBD03CBDD2
 for <ltp@lists.linux.it>; Thu, 18 May 2023 12:57:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 77316600C7F
 for <ltp@lists.linux.it>; Thu, 18 May 2023 12:57:50 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D15781F8C2;
 Thu, 18 May 2023 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684407469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npvTmE2OmwRqfzxv8sveq+URoku+P3k1aYKsl6ms1WA=;
 b=yQd5Noqn3uPE/1q/zU95Y+i/GZGhVQKn8Rx1S5WF5HlIIey9E5TN10WR2XDSMF204yIuX6
 fYMhNZ+Kr9Ypu0IJkSlH/c1FHFCsUOxjEYKZMT5yl3GgxOpR9Fj6zVjxyleVDzs6tWYH+S
 P+AVDObajdQdNg74Bai8krFp9zgBHSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684407469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=npvTmE2OmwRqfzxv8sveq+URoku+P3k1aYKsl6ms1WA=;
 b=tSVE4GvRrHFIOMC3IN3RRG4Gc1fLXgW8soYQBctJlVEVPcrmeegqi4cUUz0GBItz4LjBEL
 0Yl3GVOFqTJVu6BQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 529782C141;
 Thu, 18 May 2023 10:57:49 +0000 (UTC)
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230516120823.GB7742@pevik>
User-agent: mu4e 1.10.3; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 May 2023 11:56:29 +0100
Organization: Linux Private Site
In-reply-to: <20230516120823.GB7742@pevik>
Message-ID: <87zg61sy8j.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add goals of patch review and tips
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

Petr Vorel <pvorel@suse.cz> writes:

> Hi all,
>
> I'd like to get this effort to be merged.
> Here are suggestions what to fix (typos) / improve:
>
> https://lore.kernel.org/ltp/ZBsxUp08kTPeF27T@yuki/
> https://lore.kernel.org/ltp/87sfe52cms.fsf@suse.de/
>
> Richie, could you please post v2?

I see there is some further discussion, next week perhaps.

>
> Thanks!
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
