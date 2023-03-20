Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04752C6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 09:34:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 416D93CD354
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 10:34:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D35843C1D84
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 10:34:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68E2B6001E0
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 10:34:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CF7781F45F
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 09:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1679304859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kp0ydPUPK8o58td86UirzHyIKHM4Qx9GQh1dWy5f/k=;
 b=hHv+CQJw3fZC9d8RYF7WWKH9XFPWkApkKzTRGlPdP5Unp4OC//9qPx1fM9avPRrbULLTlh
 e7jGiXRkUAdwqnoyS0lfRSKj3uhGLPXLAQrMTxcKmseHUgOY5x//XtvKxb6U8KoTxhTbjw
 1Ht6TEkLQyhf4V4cJHTadSUwb1lqGiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1679304859;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kp0ydPUPK8o58td86UirzHyIKHM4Qx9GQh1dWy5f/k=;
 b=zkoEw6Dr0NSI5VfJ24WfXIhqzbvCb9PEiUDWNonPGRXEWjkP+9FMYWoH2IglY7d54tsld3
 UKY9NlpjF0ZjfgDg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A4B162C141;
 Mon, 20 Mar 2023 09:34:19 +0000 (UTC)
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik> <20230320080415.GA179863@pevik>
 <20230320082336.GA182681@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Mar 2023 09:25:50 +0000
Organization: Linux Private Site
In-reply-to: <20230320082336.GA182681@pevik>
Message-ID: <871qlj4vhj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
>> + also add Tested: link-to-github-actions-run below --- in patch would help
>> (it's than obvious that maintainer does not have to bother with doing it or
>> not hope that it fails on CentOS 7 old compiler or very new Fedora compiler).
>
>> Maybe also encourage people to create account in the patchwork and maintain
>> status their patches would help (set "Superseded" if they sent new patch version,
>> other statuses like "Accepted" or "Changes requested" are also sometimes
>> forgotten by the maintainer who post comments or merge the patch).
> Example why helping to maintain the patches by submitter would help:
> mknod01: Rewrite the test using new LTP API [1] followed by [v2,1/1] mknod01:
> Rewrite the test using new LTP API [2].
>
> Li reviewed v2, but later Cyril pushed v1 (manually updating patch) without
> update patchwork. (Li review was ignored, I tried to apply v2 to merge it
> because status was not updated.)

Yes, I think patchwork is important.

Probably where we disagree is how agressive to be when removing stuff
from the default view. IMO a shared list can not be allowed to grow; you
can't leave TODO items on there unless they are next on your priority
list.

So I would say remove items (so they don't show up with the default
filter) aggressively and put them on a private list if you intend to do
them ever.

>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/project/ltp/patch/20230222034501.11800-1-akumar@suse.de/
> [2] https://patchwork.ozlabs.org/project/ltp/patch/20230228154203.2783-1-akumar@suse.de/
>
>> Both of these are small helps, but they still help LTP maintainers to have more
>> time for the review or for writing own patches.
>
>> But I can post a follow-up patch with these after your patch is merged if you
>> don't want to formulate them.
>
>> Kind regards,
>> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
