Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A44C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 08:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35FC73C9353
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 09:16:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6D9C3C9315
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:15:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 557271A0025A
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 09:15:53 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 70833210FE
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1641802552;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L43JGKJUwYoyKoPtMR9qvqEx60KoSgcQ9pmf2+gqtA8=;
 b=tuIH0r4N8hCY3GxBH5CpXNXtIakb2wklfT4qX8xfs48QjZHIgImlTXpZKiIiXSvzrjiJN4
 5K3XBuS5nfiPzYtwaycB/ayUsiO/WsB8516lXWbCVcGXF2bXyjNGkf98ETVUQkqi4va4PH
 TmZRJxCKwJkkYGS9YZUNE6Ed85u02EA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1641802552;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L43JGKJUwYoyKoPtMR9qvqEx60KoSgcQ9pmf2+gqtA8=;
 b=I5IpqjUfqJXta0ep9cIcWUCVRpTITUspld+C0GGkVje3g58E879DH5o7SDIVXqccTbn0yv
 ExV55TJEKFwkx2CQ==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3E560A3B88;
 Mon, 10 Jan 2022 08:15:52 +0000 (UTC)
References: <20211220180748.36A90A3B8E@relay2.suse.de>
 <20211221113042.21357-1-rpalethorpe@suse.com> <YdW/0BUm+vBY3PHy@yuki>
 <YdXAhgvstNcDz7WY@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 10 Jan 2022 08:09:27 +0000
In-reply-to: <YdXAhgvstNcDz7WY@yuki>
Message-ID: <87ilus0zwo.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] API: Allow testing of kernel features in
 development
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
>> I would be even tempted to add this to the default syscalls runtest file
>> but render the test resultless, e.g. replace the tst_res() and tst_brk()
>> handlers in tst_res.c so that it will print only INFO messages.
>
> And that would also allow us to have env variable switch that would
> enable all tests for unrelased features, something as
> LTP_ENABLE_UNRELASED or so. Also with that we can really just TCONF if
> that variable is not set which would be much simpler.

I worry this will cause extra work for people reviewing
TCONFs. Obviously the meta-data can be used to avoid any issues. However
few people have integrated that into their tooling and workflow yet.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
