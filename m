Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B62C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 08:28:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1D293C9411
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 10:28:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1F223C2806
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 10:28:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A39C360071E
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 10:28:34 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 042D921EFF;
 Tue, 21 Jun 2022 08:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655800114;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=voMp0GCVU7RAuitF8xyWYbtjRLyUr7scj6dPuShVxd8=;
 b=D7PmQ+jbOeYEdJtdyQsEQHqffg/U4PvkBN8haZRTEtlLxHR1YIY1+s1yPYqeHmHJVOK36R
 BwySdRUguBUnS6MzoCFWBg+CE8fpaRFE4uuZR4V+3qx+OLeqxqS3XEqH64JRawQdr5UZ1w
 o/AYFY/dTznz8zb03NpG0Mvh60XSF7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655800114;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=voMp0GCVU7RAuitF8xyWYbtjRLyUr7scj6dPuShVxd8=;
 b=7PD5Nz16WffhJpXBvOdN5u5OCneC0lEG7JDiZH0qTaoHOW+afrVDcRD1doCtN358fx1Hx5
 3NtYYRzKmTm9YiCg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B44502C141;
 Tue, 21 Jun 2022 08:28:33 +0000 (UTC)
References: <20220621034729.551200-1-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jun 2022 09:27:56 +0100
In-reply-to: <20220621034729.551200-1-liwang@redhat.com>
Message-ID: <875yku5sjy.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] madvise06: shrink to 3 MADV_WILLNEED pages to
 stabilize the test
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
Cc: Paul Bunyan <pbunyan@redhat.com>, Rafael Aquini <aquini@redhat.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Paul Bunyan reports that the madvise06 test fails intermittently with many
> LTS kernels, after checking with mm developer we prefer to think this is
> more like a test issue (but not kernel bug):
>
>    madvise06.c:231: TFAIL: 4 pages were faulted out of 2 max
>
> So this improvement is target to reduce the false positive happens from
> three points:
>
>   1. Adding the while-loop to give more chances for madvise_willneed()
>      reads memory asynchronously
>   2. Raise value of `loop` to let test waiting for more times if swapchache
>      haven't reached the expected
>   3. Shrink to only 3 pages for verifying MADV_WILLNEED that to make the
>      system easily takes effect on it
>
> From Rafael Aquini:
>
>   The problem here is that MADV_WILLNEED is an asynchronous non-blocking
>   hint, which will tell the kernel to start doing read-ahead work for the
>   hinted memory chunk, but will not wait up for the read-ahead to finish.
>   So, it is possible that when the dirty_pages() call start re-dirtying
>   the pages in that target area, is racing against a scheduled swap-in
>   read-ahead that hasn't yet finished. Expecting faulting only 2 pages
>   out of 102400 also seems too strict for a PASS threshold.
>
> Note:
>   As Rafael suggested, another possible approach to tackle this failure
>   is to tally up, and loosen the threshold to more than 2 major faults
>   after a call to madvise() with MADV_WILLNEED.
>   But from my test, seems the faulted-out page shows a significant
>   variance in different platforms, so I didn't take this way.
>
> Btw, this patch get passed on my two easy reproducible systems more than 1000 times
>
> Reported-by: Paul Bunyan <pbunyan@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
