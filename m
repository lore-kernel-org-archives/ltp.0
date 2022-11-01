Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E336CC4332F
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 14:32:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88D0C3CAD1E
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 15:32:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 736073CAC3F
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 15:31:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A61501A0079B
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 15:31:48 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 769E21F88E;
 Tue,  1 Nov 2022 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667313108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYGe5mxtGYQcn4cAi8cVlJrdQtYB3oeEsx0qtw0fsv8=;
 b=BQ7l5F3wtOvFj1v4VNoVNlrHW3wLObiT2QG6zwXDA5sNiEjLNkObpeRaaviYBeOl4POZHJ
 r8pY8pSCCXa5x4fiGAOc9Iu7KMpB9/FybBUg/VIKOwU/d9Quvl37rWfSPvBWho4uZFfHsP
 A6YskrLjojD9TvYAiQSsgM1EEmrEiNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667313108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYGe5mxtGYQcn4cAi8cVlJrdQtYB3oeEsx0qtw0fsv8=;
 b=5KYMU7pd7y2Q7U+LEcALYkorg8ihZMEhg2W/WVQNKAiz5ux4wS7ju4fN2wfkGXBAqZS/1H
 IelkHZdZcoBnHoDg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 087E62C141;
 Tue,  1 Nov 2022 14:31:47 +0000 (UTC)
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-2-mdoucha@suse.cz>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 01 Nov 2022 14:29:49 +0000
Organization: Linux Private Site
In-reply-to: <20221020130843.15147-2-mdoucha@suse.cz>
Message-ID: <87edum925p.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] fanotify14: Print human-readable test case
 flags
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

Martin Doucha <mdoucha@suse.cz> writes:

> It's hard to tell which test case is failing from the current fanotify14
> output. Print test case flags to make failure analysis easier.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

I'd be happy to merge this part of the patch-set at least.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
