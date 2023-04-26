Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C6AC7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 12:01:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4003CBF12
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 14:01:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B1D73CBB51
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 14:01:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 22A052009A4
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 14:00:58 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9D3E4B3;
 Wed, 26 Apr 2023 05:01:40 -0700 (PDT)
Received: from [10.1.27.36] (e126380.cambridge.arm.com [10.1.27.36])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674773F5A1;
 Wed, 26 Apr 2023 05:00:56 -0700 (PDT)
Message-ID: <e5ee14bc-9f65-877f-38bc-c49896488eac@arm.com>
Date: Wed, 26 Apr 2023 13:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230420160910.809091-1-teo.coupriediaz@arm.com>
 <ZEkOWeUze71J3x/7@yuki>
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Organization: Arm Ltd.
In-Reply-To: <ZEkOWeUze71J3x/7@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] setpgid: Test EPERM error paths more
 reliably
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

On 26/04/2023 12:43, Cyril Hrubis wrote:
> Hi!
> Both pushed, thanks.
>
Hi Cyril,
Thanks a lot !


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
