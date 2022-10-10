Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9CEC433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 10:40:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D24C3CAE69
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 12:40:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 189733C28F3
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:40:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 43D5D1A006BC
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 12:40:41 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8B5761F8AC
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665398441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kh2tEPbcmj7TSoeG/LBtPNVAUbAH6idvzpN2/T1glIw=;
 b=UxvJILHJGXlnDwb424AorScuHBuS7JRIvAlRKo6/qgdGTYN8fGWABg774NR/oHjPonPgpV
 /2k5u81/K3admb1Ks7fLXZ5jRpqHsAFWkKiSqxx0h/zszwDSlJFLErKt+2C13vLSMrp8zc
 HbbMf71vwrwJJYsxeeO7DnapCRS/znE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665398441;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kh2tEPbcmj7TSoeG/LBtPNVAUbAH6idvzpN2/T1glIw=;
 b=wIXdwFtNuvGlN5hzldC3HnroVpO+UMVfzr3iAZHsvYH/FRB3zdIW0uYS0/8VvZuwbv3ICD
 BxkkCKWh2Y93xYBQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 20E212C141;
 Mon, 10 Oct 2022 10:40:41 +0000 (UTC)
References: <20220406110837.14773-1-mdoucha@suse.cz> <Yma8g4NUSRAIvMAW@yuki>
 <c7b54e0f-641d-9188-fd29-4b1b35bf27a7@suse.cz>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 10 Oct 2022 11:29:17 +0100
In-reply-to: <c7b54e0f-641d-9188-fd29-4b1b35bf27a7@suse.cz>
Message-ID: <87r0zg9d23.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: Check for leftover partition info in
 loopdev ioctl tests
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

> On 25. 04. 22 17:21, Cyril Hrubis wrote:
>> Hi!
>>> Due to a kernel bug, successful ioctl09 and ioctl_loop01 test runs
>>> sometimes leave behind stale partition info on the loop device they used,
>>> which then causes mkfs.vfat to fail in later tests. Check that partition
>>> info was properly removed in cleanup.
>>>
>>> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
>>> ---
>>>
>>> This does not fix the mkfs.vfat failures but it makes the true cause visible.
>>> We could add a workaround for the mkfs.vfat failures by simply initializing
>>> the loop device with the LO_FLAGS_PARTSCAN flag by default, or at least when
>>> stale partition info is found by tst_find_free_loopdev().
>> 
>> I guess that it would be cleaner to put the stale partition info
>> detection into the loop library. We can print a warning there and then
>> do the workaround.
>
> The workaround needs to be added into tst_attach_device(). It doesn't
> make sense to add it to test cleanup, in part because
> tst_detach_device() can and occasionally does fail on timeout.
>
> On the other hand, we need a cleanup check in ioctl tests which create
> partitions on loop devices, otherwise they'll leave garbage behind silently.
>
>> Also do we want to add a regression test for the stale partition info?
>> Should be easy enough. Or at least add the hash of the kernel commit
>> that fixed it to the ioctl tests?
>
> I haven't investigated deep enough to find out how to reliably trigger
> the bug or which patch fixed it (if any). Regression test would be nice
> but it's not a trivial task at the moment.

I'm trying to cleanup patchwork and I'm not sure what the resolution to
this was?

If this has not been resolved elsewhere and nobody wants to work on this
further then I would be in favor of merging the patch. The information
is then available for others to investigate.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
