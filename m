Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703C8C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:41:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80E723CAFED
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:41:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE8D73CAD6A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:41:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 70F25600637
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:41:37 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B30D533A5B
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666003296;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a2zJEiteC64aFs2sAMJGIX6Zbs/CH2y9Axei6O6/+fw=;
 b=ldZlOisFZdvSlOil2VVDkGiQMwDgbPZLrSiVyZvtkomKOi5dtgKev0vzRgvK8WTj7VqVCq
 PyzUJ3OOSBxsilVd0DGguZkF/2/f3XpUZV1G8DHxP00i2dp0piHMSNI6udjTCORe0u8YE1
 WcIPqVLf5Mkv4Bt1Mx7w9YBkKnRieGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666003296;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a2zJEiteC64aFs2sAMJGIX6Zbs/CH2y9Axei6O6/+fw=;
 b=laD0Mi2pkpywPYa0WIMxy046vzVrlaaBu/gZXXguyjKKHAhIlTyDHI5HTWMqGHG7ffwkUg
 OBKD39838wR3kdDg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4F1792C141;
 Mon, 17 Oct 2022 10:41:36 +0000 (UTC)
References: <20220906054612.9790-1-pvorel@suse.cz> <YySDWP9I46TDIgEK@yuki>
 <YyTIvPWfkkEoUflB@pevik> <YygfGEU8YRftJ1fj@yuki> <Yyrz7jFTo168rjzl@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Oct 2022 11:41:01 +0100
In-reply-to: <Yyrz7jFTo168rjzl@pevik>
Message-ID: <87lepeohpc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] checkpatch: Ignore warnings irrelevant in
 userspace
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

Hi,

Petr Vorel <pvorel@suse.cz> writes:

>> Hi!
>> > FYI the error is from fanotify.h (kind of lapi file for fanotify:
>> <
>> > #ifndef __kernel_fsid_t
>> > typedef struct {
>> > 	int	val[2];
>> > } lapi_fsid_t;
>> > #define __kernel_fsid_t lapi_fsid_t
>> > #endif /* __kernel_fsid_t */
>
>> > which we added in b8aebc835 ("fanotify: Fix missing __kernel_fsid_t definition")
>> > "Instead of including <asm/posix_types.h> where it's defined we just
>> > define the missing bit." (fix for musl).
>
>> I'm aware of that, and while typedef is mostly wrong there are a few
>> places where it's required.
>
>> > But if you prefer to keep this check, I'm ok to merge it without it.
>
>> > The long term solution could be to add variable to Makefile to pass extra
>> > parameters, e.g.:
>> > check_fanotify.h: CHECKPATCH_IGNORE += NEW_TYPEDEFS
>
>> Case by case decisions like this for typedef sounds better to me.
> +1 (TODO after the release).
> Thanks for your time!

Don't forget this, I'm setting it changes requested in patchwork

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
