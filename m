Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62C2EB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 13:01:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D514D3CE0FF
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 15:01:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55F3A3CAD3F
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 15:01:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B75D810009EF
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 15:01:13 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E639061226;
 Tue, 20 Jun 2023 13:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE734C433C0;
 Tue, 20 Jun 2023 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687266071;
 bh=7KEcImdWQsV5ftAoeEXEPIyOcOuuJplZYjr2jYmpvwA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vL4T3CqZHFmb2kLXjbv7AlQFgsrskXjTYqOsJq1Gu/v6Q0zZpnbB342FgWwT6LW8F
 6yl9+FLrdKJOWE+ldhKHlaNM19bUWsdnfsy9ilAvNMkGPPxi57JVugqO4Uj92ob4Hq
 aGP91x/3Heuo6G1zeSogBdbCn672srBZX5wImMgDWzuocrQSTp4/ea81mMpChp2yry
 65YeROeGDd7FVIbCYU2JxMDpGzVlXIyD11GsV06J7sTPrnwgzaa7aNpNdCvGn+rCO0
 46DXiYRJeN4rwsXCnaWZ1M25UB6nLpYEjl0u4CIY0Kx2vn8m7Kqkvv4KHhrFUtawWG
 WW7EBICm/3xcw==
Message-ID: <0bd3afa7-5e03-b168-75c3-98ba94580b2c@kernel.org>
Date: Tue, 20 Jun 2023 22:01:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20230608005315.3703446-1-dlemoal@kernel.org>
 <20230608005315.3703446-2-dlemoal@kernel.org> <20230620101429.GC275381@pevik>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230620101429.GC275381@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] ioprio: use ioprio.h kernel header if it
 exists
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 6/20/23 19:14, Petr Vorel wrote:
> Hi Damien,
> 
> thanks for this effort!
> 
>> For the ioprio system call test cases, avoid blindly defining the
>> IOPRIO_XXX macro internally and instead use the kernel user API header
>> file if it exists. Given that the definitions in this header file have
>> changed over time, make sure to test for the existence of the macro
>> IOPRIO_PRIO_LEVEL macro and define it if it does not exist. Similarly,
>> use IOPRIO_NR_LEVELS to define IOPRIO_PRIO_NUM if that macro exists.
> 
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If I'm correct, the only change in v2 is added Linus Walleij's RBT.
> nit: it'd be better if he sent it himself.

Yes, that was the only difference + I sent that v2 after subscribing to the ltp
list as I did get the notice about my messages being held up when I sent V1.

Thanks !

-- 
Damien Le Moal
Western Digital Research


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
