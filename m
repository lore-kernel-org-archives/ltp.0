Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451E1ECAAA3
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 06:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D8243CA4AC
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 08:27:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD3D03CA3C0
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 08:27:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36AA910007C1
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 08:27:26 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 799351F930
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 06:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661495246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzSKzm6zU8C93iG2SI/cGz4CH1n4Lm8AzE6iW5k7DNs=;
 b=ZiiEphTRfb5HXuB8r9Vln3fa3OCm5YPxuedO3LFaot0kuiK6ubDU9MRhQLggQqaR07OJ1q
 5VcOK8Tc6lth0gExme2+0PH75cWFSkBM8YRBNOohj2gP0SK6wWRpPQI4OtSwaxr2Mamxdc
 7d177SiOinKEA4v4iaqgICN069aFVuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661495246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzSKzm6zU8C93iG2SI/cGz4CH1n4Lm8AzE6iW5k7DNs=;
 b=Wy9LHV41MjoAx0Car5hF4Ep/CuMOemVZlL2I+Ifv4n5p3D89bFy7nNgazUBBEDOUO+B9+4
 +6MmSic7MGlPQyCA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 488152C141;
 Fri, 26 Aug 2022 06:27:26 +0000 (UTC)
References: <20220825135528.19653-1-akumar@suse.de>
 <20220825135528.19653-2-akumar@suse.de> <87sflk1dn1.fsf@suse.de>
 <2649941.mvXUDI8C0e@localhost>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Fri, 26 Aug 2022 07:27:04 +0100
In-reply-to: <2649941.mvXUDI8C0e@localhost>
Message-ID: <87fshj1pv6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] inotify_init1_02.c: Convert to new LTP API
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

Avinesh Kumar <akumar@suse.de> writes:

> Hi Richie,
>
> On Thursday, August 25, 2022 10:06:29 PM IST Richard Palethorpe wrote:
>> Hello,
>> 
>> > -}
>> > +static struct tst_test test = {
>> > +	.test_all = run,
>> > +	.needs_tmpdir = 1
>> 
>> Both conversions look perfect, but do we need a temp dir? It doesn't
>> look like the tests use the file system.
> Yes, my bad. No need of temp dir.
> Should I send updated patch or will you update before merging?

OK, I'll update before merging, thanks.

>> 
>> 
>
> Thanks,
> Avinesh


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
