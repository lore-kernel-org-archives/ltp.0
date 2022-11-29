Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D8CC4321E
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 11:47:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 566613CC5DA
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 12:46:59 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 665E33C0162
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:46:50 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 7C9F5200923
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 12:46:49 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A8BBD6E;
 Tue, 29 Nov 2022 03:46:54 -0800 (PST)
Received: from [10.1.30.171] (e129169.cambridge.arm.com [10.1.30.171])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BE063F73D;
 Tue, 29 Nov 2022 03:46:46 -0800 (PST)
Message-ID: <ab38f01b-0290-0cbf-ae7d-beab064a89cb@arm.com>
Date: Tue, 29 Nov 2022 11:46:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Richard Palethorpe <rpalethorpe@suse.de>
References: <20221123144746.590890-1-tudor.cretu@arm.com>
 <Y4XmlHZyi2DG9DRT@pevik> <Y4Xnt+OsEt94aZRr@pevik> <87mt8at3md.fsf@suse.de>
 <87iliyt2x7.fsf@suse.de> <Y4Xt5vXi3c0tdRkK@pevik>
From: Tudor Cretu <tudor.cretu@arm.com>
In-Reply-To: <Y4Xt5vXi3c0tdRkK@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 29-11-2022 11:32, Petr Vorel wrote:
>> Hello,
> 
>> This looks pretty trivial to fix actually. We shouldn't pass NULL as
>> mode. If it works I'll add the fix and push.
> Yes, it fixes it, good point. I was also surprised by NULL.

Many thanks, both! I'll remove the NULL and re-post a v2 if that's alright.

Kind regards,
Tudor

> 
> to whole patchset:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
