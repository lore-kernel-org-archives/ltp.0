Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD69C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 10:09:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 113AE3CAF07
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:09:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BFA23C264A
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:09:35 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.209.81;
 helo=hedgehog.birch.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from hedgehog.birch.relay.mailchannels.net
 (hedgehog.birch.relay.mailchannels.net [23.83.209.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 753022001B1
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 12:09:33 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BF96E445B7;
 Mon,  7 Apr 2025 10:09:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com
 (trex-5.trex.outbound.svc.cluster.local [100.107.20.214])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 6D74D44256;
 Mon,  7 Apr 2025 10:09:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744020571; a=rsa-sha256;
 cv=none;
 b=BTB4a8NBOU6iMJ++fe2rmkmDiJo98rndQI0wFoE5g1W8bDqvJ7APlhSD/1v/0bNuGhZD0y
 Y5k5y6kOw8x7yXpNZvQcbxdhwb0c6B/6JSOsrkpLTA9VdIEjiAnAw6N3TEjkUrV3bfXr5Y
 ZVUjaooUP2EhLWeBhCJp0wwT+5T3XDBcD5Bq5HWG3MPYJFgUgf1lohL8+pqFT7/dcCz7nW
 CiM9rgJuhqaYYqPPjxM0hcMFH2FCK/ygRXnPiWutE92nK1F18KGtZX6Wz0g4Lo2JVX531Y
 wWVLCF1Hn5MZ3dD5ZTMSCQQrhMTx7g5aTTP76iekUY5vKTcuBQF5csR7wyWw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1744020571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=EbjHrUDUTk8dGSfFbPca5yBwOHEkVtcJ5/BOw8X9YDo=;
 b=0irvi9HJF+kdJvgCgdGbedIAYbFmRyCMpWLpLifTlcT/GwmTaWnUlBUDUjIJmuzg53KEuM
 sJUAEXMnM2yS6A3SezA3DK3X0zZF2tRv87gybZYLhIkfp2D7+ag5sXOMq8M3uraJqBxqFr
 eXb28Z+sC59GiUS7dkogym5fdWV8lfyKIWaA44BbzUKyJFwR5W+ShSvWQ70s99CHmINZsY
 k3Pt8KaSEfAVESGwr22bys6/pi2CSwLwVGa1fJC5heYhf+Z+9OuRFPkr2qBJqc1aVT2Qoy
 j7v1fN1+vGgKpehi2aePXs8e1iQoEg3hXQgIP9O/ZvfaoDALtRiq9FJCVcN6Vw==
ARC-Authentication-Results: i=1; rspamd-7dd6dcd7db-p645v;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Cure-Left: 1a5e35ac1de7f381_1744020571668_2303938911
X-MC-Loop-Signature: 1744020571668:966795652
X-MC-Ingress-Time: 1744020571667
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.107.20.214 (trex/7.0.3); Mon, 07 Apr 2025 10:09:31 +0000
Received: from [192.168.0.135] (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4ZWQ166Km7zQr; 
 Mon,  7 Apr 2025 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1744020571;
 bh=EbjHrUDUTk8dGSfFbPca5yBwOHEkVtcJ5/BOw8X9YDo=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=PFcyGk3jBr4ZCstCZg71NDTksQbK5V1RVjqi4pwo/axEsSlTMgo22g41UNEWZTlXw
 2w5HNhNxwnw3dW4bEsNvV7NkbsTFrAqIIrf5bTktemC+AaAxFigv8/YGgkAjhc8qJG
 /tjkHM5Gh0bRVZfuoEjO2xY1qI64oCt7sB/aczWTQ6H6U2bCtHBNqe0AJpv0GL63Lq
 Uhcib0jZFG4AMX6QbRNm2nnu3whAs4enAruQ+WJu1AerCpawhk8kYhjSzJF/OltZae
 oX7zOIrMLEKii8vvhDLaRdxEDqP6mTQFZ/LCXJaAUtgAItftO2wfAF5QvfcmE2/KST
 pp1vVYByDniIw==
Message-ID: <99391a73-00fd-4d70-9429-2a799b5d3d18@gotplt.org>
Date: Mon, 7 Apr 2025 06:09:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250404181406.2385612-1-siddhesh@gotplt.org>
 <20250404181406.2385612-2-siddhesh@gotplt.org>
 <a24e920b-4254-4cae-895d-64fdc0f5452e@suse.cz> <20250407091809.GA74858@pevik>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <20250407091809.GA74858@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] cve-2015-3290: Disable AVX for x86_64
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

On 2025-04-07 05:18, Petr Vorel wrote:
>>> diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
>>> index 01b9b9ccb..d545a7f93 100644
>>> --- a/testcases/cve/Makefile
>>> +++ b/testcases/cve/Makefile
>>> @@ -22,6 +22,12 @@ ifneq (,$(filter $(HOST_CPU),x86 x86_64))
>>>    meltdown: CFLAGS += -msse2
>>>    endif
>>> +# The test needs to clobber %rbp, which requires frame pointer omission.  Also
>>> +# for x86_64, disable AVX since that could sometimes require a stack
>>> +# realignment, which gets in the way of frame pointer omission.
>>>    cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer
>>> +ifneq (,$(filter $(HOST_CPU),x86_64))
> 
>> If you don't want to add the command line option for 32bit x86 builds, then
>> this condition would be cleaner:
>> ifeq ($(HOST_CPU),x86_64)
> 
> +1. IMHO this works as expected. I suppose Siddhesh got inspiration for filter
> due the above meltdown, where it is needed because it compares 2 archs. But
> I will also appreciate an explicit confirmation.

Oops, yes.  I tested both first just like meltdown and then just removed 
x86.  I'll send a v3 in a moment.

Thanks,
Sid

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
