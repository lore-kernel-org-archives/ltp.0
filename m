Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CC4C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 13:18:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D13443CAD0F
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 14:18:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCECF3CAC3E
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 14:18:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2103D1A008A3
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 14:18:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6C5D221B23
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667308720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSGpUoDszFNHtP/hGKoe6J45y4AOpG/1bweoVt1K21w=;
 b=pJ5WqytwqI9wPwCemM0LuUg89E3zYLQbepdBE2WvkBb2bG0wLfDcjWIQLCeFCZpl2N/Ods
 z3Vd66q6bxweLWKP3lm974s7T3Ut89ruMH0rCcbb8XK6YS7+rxr0kYYp8RoJ+Xc3zJXBKi
 gBwipsFYfI6Ymd6VbcexbkwVbguuH58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667308720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSGpUoDszFNHtP/hGKoe6J45y4AOpG/1bweoVt1K21w=;
 b=1XKUzDtk6BhHl1d2oq7lAKMmj2Ql0jY2i4WIeFEkF1LzyQ7hMG2YlbElpLHJkcvMSDRMl4
 zfLy52F8vhQuXQDg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0AE782C141;
 Tue,  1 Nov 2022 13:18:39 +0000 (UTC)
References: <20221006102900.3246-1-pvorel@suse.cz>
 <4450243.LvFx2qVVIh@localhost> <Y0CWAi0BnDXaN3ZS@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 01 Nov 2022 13:17:55 +0000
Organization: Linux Private Site
In-reply-to: <Y0CWAi0BnDXaN3ZS@pevik>
Message-ID: <87iljy95jl.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Improve .skip_filesystems documentation
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

>> > +NOTE: ext2, ext3 or ext4 in '.skip_filesystems' on tests which does *not* use
>> > +      '.all_filesystems' needs to be defined as 'ext2/ext3/ext4'. The reason
>> > +      is that is hard to detect used filesystem due overlapping the functionality.
>> nit:
>> s/that is/that it is
>> s/due/due to

Whith that change

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> Thanks Avinesh!
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
