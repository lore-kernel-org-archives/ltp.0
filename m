Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C0CC43334
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 06:37:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E400B3CA0E0
	for <ltp@archiver.kernel.org>; Tue,  5 Jul 2022 08:37:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A321A3C87EF
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:37:29 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED91A1000936
 for <ltp@lists.linux.it>; Tue,  5 Jul 2022 08:37:28 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 5070BA3352;
 Tue,  5 Jul 2022 06:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1657003047; bh=hL/HMLS+vzuH7+oNMuCwPXHNxt9jMTFpD8BiYGBIQZE=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=rhAn+akJCZY8Cb65h+1Dqp3SJ2gWaNihkHuUTpHkXxW3a6d2sqI5x3v2TxOIhMNuG
 oIuBc78GkGaU7HrQS5CeR7Dwt5qHkYJbfXameRN8taNIsUfj8FXillMyMNieGbjFgx
 sFZafTs45RrEeYFrwbA6UHrfwlDH18f2qNHmKIbU=
Message-ID: <b33360f5-96ba-f7c3-9e86-f7966c260eb9@jv-coder.de>
Date: Tue, 5 Jul 2022 08:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: rpalethorpe@suse.de
References: <20220627125321.1560677-1-lkml@jv-coder.de>
 <20220627125321.1560677-3-lkml@jv-coder.de> <87czekrseu.fsf@suse.de>
 <874jzwrrvg.fsf@suse.de>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <874jzwrrvg.fsf@suse.de>
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
Cc: ltp@lists.linux.it, Joerg Vehlow <joerg.vehlow@aox.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

Am 7/5/2022 um 8:28 AM schrieb Richard Palethorpe:
> 
> Richard Palethorpe <rpalethorpe@suse.de> writes:
> 
>> Hello Joerg,
>>
>> Joerg Vehlow <lkml@jv-coder.de> writes:
>>
>>> From: Joerg Vehlow <joerg.vehlow@aox.de>
>>>
>>> This allows installation of the tests to a different directory
>>> than directly under $prefix.
>>>
>>> Before the layout was:
>>> $prefix/bin/{run-*,t0,run-tests.h,Makefile}
>>> $prefix/conformance
>>> $prefix/functional
>>> $prefix/stress
>>>
>>> with prefix being /opt/openposix_testsuite on linux and
>>> /usr/local/openposix_testsuite on other systems
>>> OR the value of the env-var $prefix.
>>>
>>> With this change, the prefix defaults to /opt/openposix_testsuite
>>> and can be changed the usual way using configure (./configure ---prefix=foo)
>>> Additionally the path of the tests below $prefix can be changed, using
>>> configure --with-open-posix-testdir=<foo>. This allows clean installation as
>>> part of ltp:
>>>
>>> $prefix/bin/{run-all-posix-option-group-tests.sh,run-posix-option-group-test.sh}
>>> $prefix/$testdir/bin/{run-tests.sh,t0}
>>> $prefix/$testdir/conformance
>>> $prefix/$testdir/functional
>>> $prefix/$testdir/stress
> 
> Sorry I don't see the need for this. I can't find the RFC where you may
> have explained it, however it should be written here anyway I think.

here is the RFC in the mailing list archive:
https://lists.linux.it/pipermail/ltp/2022-June/029188.html

Joerg



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
