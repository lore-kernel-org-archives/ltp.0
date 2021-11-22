Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0CDC433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 06:49:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 981A63C8D10
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 07:49:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 932853C8C3B
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 07:48:54 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A4A251A00FBC
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 07:48:53 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 8F5159FB3D;
 Mon, 22 Nov 2021 06:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637563732; bh=O2BopaQsM+6Qmtghw2CX0AFjj1Zpdm38N5kM7HKmeNo=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=rzzLIYEDR2iK0+O0HOIlwQhKIrjzeP5o7dA5/9yxF3jVlP8MDGmELhEniLPZfAXeZ
 mwfQYhuar6h70poEn0m1thsgnwdMUUc3hNRkVAmXNbuweDgx+oFn5yxcqJkwAHKtGS
 XCbfN8QYdBcwt5bAZrzOnTa0VxtL5fdHsFrFiK30=
Message-ID: <cf8798c3-0837-fe66-2c3e-e8f1a0b84d84@jv-coder.de>
Date: Mon, 22 Nov 2021 07:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20211119074602.857595-1-lkml@jv-coder.de>
 <20211119074602.857595-5-lkml@jv-coder.de> <YZe9oyEQH5a58VMr@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <YZe9oyEQH5a58VMr@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/12] posix/conformance/interfaces: Fix
 unsued-variable for testfrmw
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On 11/19/2021 4:07 PM, Cyril Hrubis wrote:
> Hi!
> Applied, thanks.
>
> But still fixing warnings in the testfrmw this way feels like we are
> putting a lipstick on a pig. Large scale cleanup of the code is needed
> and the warnings were really harmless in this case...
Yes as I wrote already, I wanted to start somewhere and the warning 
clutter hid already
some warnings, that indicated real programming errors. So I wanted to 
get rid of them.
Additionally the compiler output is to be inspected, because some test 
are just compile-time tests.

A one-shot cleanup of all tests is also probably not feasible, so 
iterative cleanup with clean warnings
should be easier.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
