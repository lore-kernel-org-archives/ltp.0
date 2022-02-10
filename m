Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450EDC433EF
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 09:25:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C551A3C9E3E
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 10:25:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 537503C13C0
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 10:25:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEECF200AEA
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 10:25:39 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BF2ED1F382;
 Thu, 10 Feb 2022 09:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644485138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p1sm5okPPE3MFUxuELnAoSw1HQmnwNeCm/7FaJ2hWBw=;
 b=V5rBkU6LvCDajyl8+JIYAnwtq3GykCtAlKUzzpYa0Qb7pBhqK8Nf9MBJa6UxSnTTRRMJQQ
 HbLq57lTtEvGWsYM0B+UXrcE76ME2M4Wi+q5maAj39CPS8Man+UzT/N4p3AdbCNlvNGwuR
 AIx4zPAz1UTy+ru+GEuXsrtcvFIJ6ZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644485138;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p1sm5okPPE3MFUxuELnAoSw1HQmnwNeCm/7FaJ2hWBw=;
 b=plPUNDg9BQH/ZLsAGS0YSalQi/cebk2m2cJN0QmTm/n4n1e8zopfL2Yvc/B37UUDHWur15
 32ByjdKM3DiaNUAA==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8E014A3B81;
 Thu, 10 Feb 2022 09:25:38 +0000 (UTC)
References: <20220208140322.6842-1-rpalethorpe@suse.com>
 <20220208140322.6842-4-rpalethorpe@suse.com>
 <CAEemH2cb65kihwnkMMKSr8FRXJ_SY3jPnSxPPp-Kk_xBrJAeZw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 10 Feb 2022 07:34:25 +0000
In-reply-to: <CAEemH2cb65kihwnkMMKSr8FRXJ_SY3jPnSxPPp-Kk_xBrJAeZw@mail.gmail.com>
Message-ID: <875ypnkr8v.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] memcontrol04: Copy from kselftest
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> This test has a high repetition with memcontrol03, I'm just
> wondering if any possibility to merge together by defining a 
> struct tcase?
>
> static struct tcase {
>        char *ctrl_file;
> } tcases[] = {
>        {"memory.min"},
>        {"memory.low"}
> };

There are a number of places where the logic is different. We would end
up a with a test full of branches. There is some boilerplate which is
the same for now, but that could also diverge between tests.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
