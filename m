Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E00C433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 14:27:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6E6D3C9601
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:27:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CD1C3C03AE
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:27:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AA7F0600C74
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 15:27:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6336D21135
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 14:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643120397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3hDsfCuY/IOMEdAABfSRLskN+oYiLGPkW98h+fpSaI=;
 b=QMzt0t4GZDZ98cyCG74Ev9Nz1zmkAuzP3+waLszrfnygVAvFBzQ75VM1LEBbkxUrZYzwZ4
 m+yxGY/k/y4crBkovjlhrIX1LnTGHiix6TFIdWg2J6KHFsiV9xC1iB4gDP0j2rd+ybptLt
 nDW00k+loTj4mEgxzkXDzdGoruZExGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643120397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3hDsfCuY/IOMEdAABfSRLskN+oYiLGPkW98h+fpSaI=;
 b=e6GFLb2DwpgrSsnlgrPjxOllritWF8ICpxHHSY2naSPMK6rv7ZHI2YwXGagazEa0Z+4BZd
 9O2oRf40K4b/76Bw==
Received: from g78 (unknown [10.163.24.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3372FA3BA0;
 Tue, 25 Jan 2022 14:19:57 +0000 (UTC)
References: <20220124173651.652-1-rpalethorpe@suse.com>
 <20220124173651.652-2-rpalethorpe@suse.com> <Ye/kxq1oXnj5z1hd@yuki>
 <Ye/k9bYtALTieq7B@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Jan 2022 14:19:31 +0000
In-reply-to: <Ye/k9bYtALTieq7B@yuki>
Message-ID: <87k0enyk1k.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] memcontrol02: Fix anon memory comparison
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
>> > All memory is being compared with the size malloc'ed instead of just
>> > anon.
>> > 
>> > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> > ---
>> >  testcases/kernel/controllers/memcg/memcontrol02.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/testcases/kernel/controllers/memcg/memcontrol02.c b/testcases/kernel/controllers/memcg/memcontrol02.c
>> > index 411f5aea6..0d144cf2d 100644
>> > --- a/testcases/kernel/controllers/memcg/memcontrol02.c
>> > +++ b/testcases/kernel/controllers/memcg/memcontrol02.c
>> > @@ -68,7 +68,7 @@ static void alloc_anon_50M_check(void)
>> >  
>> >  	TST_EXP_EXPR(anon > 0, "(memory.stat.anon=%zd) > 0", anon);
>> >  	TST_EXP_EXPR(values_close(size, current, 3),
>> > -		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, current);
>> > +		     "(size=%zd) ~= (memory.stat.anon=%zd)", size, anon);
>> 
>> I do not get this, we compare size and current and then print anon?
>> 
>> Should we just change the memory.stat.annon to memory.current instead?
>
> Or did you forget to change the current in the values_close() to annon
> as well?

Yeah, sorry!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
