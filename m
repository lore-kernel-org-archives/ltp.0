Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417C3C5479D
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 14:07:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAAFE3CB5B0
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 15:07:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CF543CB592
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 15:07:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2E1C320074F
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 15:07:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D4B6A3E962
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673273249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qni+QFc5YwBWVbdCbRB/5++OmuqKAJt4ovgTAdkdkRo=;
 b=TiZf2QZgZILrtN2lUgHL6HRVKcHWCWxxp/pLhVZvkUebMiICzqTPNXvxpmMFJztmZdcywS
 kAg7b9g5/7IfKM5j5YqfCsL7WQpcM4cCqp7DHuAxluxttYtrIWGefB4hVn/0QdTEniLOVb
 s4wyHLQgeppIutESyI2zWWtoUuGkXYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673273249;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qni+QFc5YwBWVbdCbRB/5++OmuqKAJt4ovgTAdkdkRo=;
 b=VXLqK0kbpNmy7rM6uXvVp13bx1lupOLC9QzU7dBHH+0cFsRyTFHoqLORO4YCjMAMzPUoFN
 jQYpuAQzGDEHr3CA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A50E22C141;
 Mon,  9 Jan 2023 14:07:29 +0000 (UTC)
References: <20221227053247.1855-1-akumar@suse.de> <Y7LpFpTgKuPneJfs@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 09 Jan 2023 14:05:07 +0000
Organization: Linux Private Site
In-reply-to: <Y7LpFpTgKuPneJfs@pevik>
Message-ID: <87y1qbiyxt.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setreuid01.c: remove the test
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

> Hi Avinesh,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> Test scenarios in setreuid01.c is covered in setreuid03.c with
>> better approach, hence remove it [1]
>
> Waiting a bit to allow other than me and Richie to see this.

No response, merged!

>
> Kind regards,
> Petr
>
>> [1] https://lore.kernel.org/ltp/Y6Vsgkx%2FVcY%2F78vs@pevik/


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
