Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE7AC433FE
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 10:08:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F18D3CD244
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 11:08:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0BE33C2306
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:08:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 98D5920075C
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 11:08:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EC4C52296B;
 Mon, 14 Nov 2022 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668420524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uOKq5UT/Xq/9fSbre99l6zWZBmVTKHikSu6bnes8t2o=;
 b=bVT/oLGARzKDZFeirb5U9c9OCs/LIHmibiVeZSKgInvthq/ciN1t3BelBuEvAEeCxR9eUT
 xa/BjR5iPRds+BK1ZYnPbx2AJy1fzYUczHU1lEtOwhY6jK6JcFvAdRE21wjWvJ9LCtCdH8
 oCMKy62/9HGI2UGnIkuqgC3td9XNaDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668420524;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uOKq5UT/Xq/9fSbre99l6zWZBmVTKHikSu6bnes8t2o=;
 b=CyjHs+R7djw+VbxtJsMrbeCT4U5ft2ev+ZKxouUgtY563YFDd+bce/UeMW0CYyEblQnfUU
 tmuq4g5dbN7vwQBA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id BB1CC2C14B;
 Mon, 14 Nov 2022 10:08:44 +0000 (UTC)
References: <20221027215808.4126148-1-edliaw@google.com>
 <20221027215808.4126148-2-edliaw@google.com> <8735atww9l.fsf@suse.de>
 <87y1slvgkm.fsf@suse.de> <Y25+IZDZ9/rvSH+E@pevik> <Y26BWsQM33+85Po2@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Nov 2022 10:00:35 +0000
Organization: Linux Private Site
In-reply-to: <Y26BWsQM33+85Po2@pevik>
Message-ID: <871qq5voer.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/1] mmapstress01: refactor to tst_test
 framework
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi all,
>
>> Thanks for your work! FYI 2 tiny problems sneaked in, see below.
>
>> runtest/mm contained -t 0.20 option, which caused failure. Fixed in:
>> https://github.com/linux-test-project/ltp/commit/36321277a294c0467219f650fd76aa1a8d310c1d
>
> @Richie This would be even more important to check automatically. If you're able
> to in sparse list test parameters and whether they expect value or are standalone,
> adding process to grep in runtest files should not be hard. WDYT?

Again this is producing meta data with Sparse. I guess it would also be
AST level (i.e. not linearized IR byte code) which Sparse is not that
great at.

Probably this would not be hard to do with a reasonable SA framework.

It is a good idea though, I'm just grumpy about the implementation.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
