Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75C1C433EF
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 06:33:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A0633CA06C
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 08:33:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B39E3C87EF
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:33:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE6BA10007EF
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:33:08 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2BEDB22430;
 Tue,  5 Jul 2022 06:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657002788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsvygjw8CwwRZoKcupE/JmxaSvQH1ycH+JBcqRSc6bg=;
 b=ev7Xqy11z12t/IspUazS8MC3JgclY3HANu+hnEqRNDK0+XIX00EaW1jeNjcmhIpH/V3jTv
 pGCXBQz+gQwo1WZCBT8XabJpdrg7Dv0hVxUc1fwkJTeuvj9rfw+Q4tGFTKybOzKV7GsvJJ
 Z6EHgkMqHEcZKvNPgNKRTYkYs9b2eBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657002788;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsvygjw8CwwRZoKcupE/JmxaSvQH1ycH+JBcqRSc6bg=;
 b=aGGRIT2y4FcIMb1YVHHeSMyY23K8tOvmtzP0oDfM41cof7FGd3hvqSrU2mBWuxnKduljzN
 Fdh0eEtdXX5LlvAA==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DB4C42C141;
 Tue,  5 Jul 2022 06:33:07 +0000 (UTC)
References: <20220627125321.1560677-1-lkml@jv-coder.de>
 <20220627125321.1560677-3-lkml@jv-coder.de> <87czekrseu.fsf@suse.de>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 05 Jul 2022 07:28:44 +0100
In-reply-to: <87czekrseu.fsf@suse.de>
Message-ID: <874jzwrrvg.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello Joerg,
>
> Joerg Vehlow <lkml@jv-coder.de> writes:
>
>> From: Joerg Vehlow <joerg.vehlow@aox.de>
>>
>> This allows installation of the tests to a different directory
>> than directly under $prefix.
>>
>> Before the layout was:
>> $prefix/bin/{run-*,t0,run-tests.h,Makefile}
>> $prefix/conformance
>> $prefix/functional
>> $prefix/stress
>>
>> with prefix being /opt/openposix_testsuite on linux and
>> /usr/local/openposix_testsuite on other systems
>> OR the value of the env-var $prefix.
>>
>> With this change, the prefix defaults to /opt/openposix_testsuite
>> and can be changed the usual way using configure (./configure ---prefix=foo)
>> Additionally the path of the tests below $prefix can be changed, using
>> configure --with-open-posix-testdir=<foo>. This allows clean installation as
>> part of ltp:
>>
>> $prefix/bin/{run-all-posix-option-group-tests.sh,run-posix-option-group-test.sh}
>> $prefix/$testdir/bin/{run-tests.sh,t0}
>> $prefix/$testdir/conformance
>> $prefix/$testdir/functional
>> $prefix/$testdir/stress

Sorry I don't see the need for this. I can't find the RFC where you may
have explained it, however it should be written here anyway I think.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
