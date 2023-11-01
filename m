Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C16C4167D
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 09:45:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 402C83CE9F2
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 10:45:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68D8A3CC8E9
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 10:45:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9AD1260064F
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 10:45:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BCE7D1F74A;
 Wed,  1 Nov 2023 09:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698831924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MI+nv4DExXCCjRLEb76+OJ3z1dtWUguDX4o5UHnZUAE=;
 b=XqUpjdSkg36hR7l2NxJSNVWx/7yYtY8NZBcplacA4wq8FSenVZSV8RQkHgwKFUSN7Aa0rK
 Cfr3kNwkOIJZPoMYMRIxqAS08J0y/hyxKRp1UNCRT2gX43eEoMnV1rw72TcDk6H8RnmjbG
 +sYP5eCUbUXzNL525kK7mCbdTiVSR4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698831924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MI+nv4DExXCCjRLEb76+OJ3z1dtWUguDX4o5UHnZUAE=;
 b=vy3aCmNGO6NwFuUBarTLhk30Cin91XtAtwOfIZCR3ObXpyl3tGhzevhM6KPMy9mAmUoM7J
 A7KdNdHsxu8UmiCQ==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0BB2F2C841;
 Wed,  1 Nov 2023 09:45:24 +0000 (UTC)
References: <875y33vsks.fsf@suse.de> <87lebpu02a.fsf@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: rpalethorpe@suse.de
Date: Wed, 01 Nov 2023 09:33:03 +0000
Organization: Linux Private Site
In-reply-to: <87lebpu02a.fsf@suse.de>
Message-ID: <87msvxst71.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 1st of November 09:00 UTC
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Thanks to everyone who attended the meeting. Some outcomes:

1. There were audio and connection issues with Jitsi, we should try
   something else next time

2. We'll make best efforts to chase reviewers for their tags, but we
   don't have a better solution for tracking contributions to review.

3. I'll be more aggressive in adding changes requested. Most of the
   responsibility is with contributors to remember to resubmit their own
   patches.

4. Petr vorel will move patchwork instances. We accept there will be
   issues caused by the changeover.

5. 30 minutes is good meeting time (IMO 15-30 minutes is fine)

6. We shall write down an agenda next time

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> After reviewing the responses to the RFC I have come up with the
> following meeting details.
>
> Time and date: First Wednesday each month at 09:00 UTC.
> Platform: https://meet.jit.si/linux-test-project
>
> The first meeting will be on the 1st of November at 09:00 UTC.
>
> I haven't tried to address the lack of chat brought up by Li. I suggest
> trying Jitsi and if there are issues then we go from there.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
