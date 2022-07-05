Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA05C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 06:43:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C9863CA08B
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 08:43:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D2FF3C649E
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:43:28 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC0FE1400B7C
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:43:27 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 0F6ED9FE98;
 Tue,  5 Jul 2022 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1657003406; bh=6krwBjwsj0zUqIS8eMcU1wjDfgq+UsxsA+YDIG+s5VA=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=tfE7qP7+00iW54XQ0oi9T5+KpttoBdKi4Ljb8oEDwGIys8AptxMmxJTOPhRzXvPa0
 SASr1qk3seKS91S70IQXXecLFQ841fO1lhx1z1zYWlJhhgDPtqnsNiEIGYl2wr9nOM
 r1Kb01ngGWtjpYqnUuBsc77F/BRLti77wLmiKrjI=
Message-ID: <ff33060e-07d1-a552-caa2-dda8188f2131@jv-coder.de>
Date: Tue, 5 Jul 2022 08:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220627125321.1560677-1-lkml@jv-coder.de>
 <20220627125321.1560677-3-lkml@jv-coder.de> <87czekrseu.fsf@suse.de>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <87czekrseu.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] openposix: Setup autoconf and fix
 installation layout
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Am 7/5/2022 um 7:57 AM schrieb Richard Palethorpe:
> Hello Joerg,
> 
> Joerg Vehlow <lkml@jv-coder.de> writes:
>> +AC_PROG_CC_C99
> 
> This causes a deprecation warning for me

I think autoconf developers messed up here. They obsoleted the macro in
2.70 and told users to replace it with just AC_PROG_CC, which defaults
to C11, but also excepts C89. It is not possible (without adding more
code), to verify if the required C version is available. What is even
worse, that autoconf does not fallback to a version, where this was
still not obsolete, even if an older autoconf version is defined in
AC_PREREQ.
Nevertheless, I guess in case of C99, we can just switch to AC_PROG_CC,
because every compiler should support C99 nowadays. I just wanted to be
explicit, because C99 us currenty selected in the CFLAGS file, that I
dropped.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
