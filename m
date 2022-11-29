Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D64FC46467
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 740C63CC5F6
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 13:02:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 130293C85AE
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 13:02:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B73FE60012A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 13:02:17 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id BCA4721B7A;
 Tue, 29 Nov 2022 12:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669723336;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=juSseI67vGCLDyGAyPSNWsH2R9lZp42DIeelVT7TgFc=;
 b=S1aFU+zZoj05L/LGXG0NS2vfsB2jP41z65B0bJRDoTrhSRYeanSBcdl4Sorqp8RV1TTaIe
 I+Nwqjp9iuvVNG3tFgm05g+B46m9T0jG8gjDBYrOhs38qS81p3BcOkqLMrrM1ggJDbkolT
 jPw/Qhe+GDCYnVwmCUFU4Hp5Wk5x7vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669723336;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=juSseI67vGCLDyGAyPSNWsH2R9lZp42DIeelVT7TgFc=;
 b=zCCxO5K2FGKAowJvW94KQNIEeS+0hIVeNWjt9XMIrMNa8kLM3saHzxKpHnU3MjEz/vvSOW
 Ne3pM0fr0l7lRlCw==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6DF4D2C141;
 Tue, 29 Nov 2022 12:02:16 +0000 (UTC)
References: <20221123144746.590890-1-tudor.cretu@arm.com>
 <Y4XmlHZyi2DG9DRT@pevik> <Y4Xnt+OsEt94aZRr@pevik> <87mt8at3md.fsf@suse.de>
 <87iliyt2x7.fsf@suse.de> <Y4Xt5vXi3c0tdRkK@pevik>
 <ab38f01b-0290-0cbf-ae7d-beab064a89cb@arm.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tudor Cretu <tudor.cretu@arm.com>
Date: Tue, 29 Nov 2022 12:01:49 +0000
Organization: Linux Private Site
In-reply-to: <ab38f01b-0290-0cbf-ae7d-beab064a89cb@arm.com>
Message-ID: <87edtmt1dm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] safe_macros: Fix undefined behaviour in
 vararg handling
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

Tudor Cretu <tudor.cretu@arm.com> writes:

> On 29-11-2022 11:32, Petr Vorel wrote:
>>> Hello,
>> 
>>> This looks pretty trivial to fix actually. We shouldn't pass NULL as
>>> mode. If it works I'll add the fix and push.
>> Yes, it fixes it, good point. I was also surprised by NULL.
>
> Many thanks, both! I'll remove the NULL and re-post a v2 if that's
> alright.

OK, please do.

>
> Kind regards,
> Tudor
>
>> to whole patchset:
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Kind regards,
>> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
