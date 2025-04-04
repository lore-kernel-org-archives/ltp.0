Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763D1C36010
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 14:24:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04E223CB2F4
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 16:24:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF63B3C60C9
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 16:23:54 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.218.252;
 helo=rusty.tulip.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from rusty.tulip.relay.mailchannels.net
 (rusty.tulip.relay.mailchannels.net [23.83.218.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E2C6A200AE3
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 16:23:51 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 185282C3220;
 Fri,  4 Apr 2025 14:23:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com
 (trex-7.trex.outbound.svc.cluster.local [100.102.82.177])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 50BE62C2FDE;
 Fri,  4 Apr 2025 14:23:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743776629; a=rsa-sha256;
 cv=none;
 b=EvGsPWAoOX83NVSfCW9Kc+GouS2ahD8kOt54caAzAtbnc+T6RFmHmzKg2oTqo1nAu9hvMm
 wQoUSj2MsjXkXwukmzeSUVOs9NAY2EPhaCH8XuLtLS/bFVEeMUQ369rzSZJeGocElz/rwR
 iD55Bv5uWCDDx0OCbcDnXGyxmn+qC4+w1avvhegfH+qXYpgVxTKBIMaTOyHyK/Mkui9Ab4
 me7m83oJ0lcitL+5jMDozDTLGpdWIa8XAY2Anu7uJepkk8rql1SE5+prRUE5oeaXBKgPAM
 a3FQN0NpNcSr/VcsmN5B+9v5k4+TzLzJB2geNQcYduFt0w+yoBmLjcbXYEAl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1743776629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=rPRSqS+UFCgWf61QmL5DpCKwcshV8HWI8bh4RQv3asY=;
 b=f7izasNqKTAamxJtjufFR6k4hYrzOhvegw5HxsvtXzxy4naiR4Q7RXZZ8NAbKPuZ/fitV1
 8zOKxCKIvZEeahpmzrEcYpWKhQMMKqE1P1ztK4wC7AtR4vl5TNB3dRuIBSoCemWtsnfBcG
 AhyprNlu2u6g6e6DATnUtcMI4r9uypd7VLRWmm0r4mhKLUx8167q9KZAeF9NVqVMyysFrd
 JmsbT710xB3TVc4UzhLGe+rJDQ1lpUKe4pO3knLDRuV0JwiVnUtMrQumMQS6lMf76DCOjp
 hwjz3M/EneLY8w76SUItA5X9CJilhcfGH2AxQX8UpOtWKBKZiVyEZApSLzmUKg==
ARC-Authentication-Results: i=1; rspamd-7dd6dcd7db-wgmqm;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Army: 60cc1601599fa175_1743776629739_620575191
X-MC-Loop-Signature: 1743776629739:3149086710
X-MC-Ingress-Time: 1743776629738
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.102.82.177 (trex/7.0.3); Fri, 04 Apr 2025 14:23:49 +0000
Received: from [192.168.0.135] (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4ZTgnw5XCnz6h; 
 Fri,  4 Apr 2025 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1743776629;
 bh=rPRSqS+UFCgWf61QmL5DpCKwcshV8HWI8bh4RQv3asY=;
 h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
 b=sJ8y+cUI3ZtMZ6XiKAGEVioz5QOepthkpKjKn6nAbwKcW37TCNjZbcyPZ6h6gGsnz
 aEz1Ju5/81sNTBjUTMlML8FZHJA2Aq64eRhvDlRHpQdwqZE9e3ieJBEUaXTUKE6Caj
 7yoSz91/9MDnZzejSukQwRmIMnzBY7vlmaco3aIHn7XXMZtcbf9so2Nc6T6czN4Et9
 HFL0IZdM/KxBn0H3ryDJxdtNVVwzGJ5WLPUl08lHJ7ujGNmc5QlUutcYGSxLyXi7ZN
 yMgoLkjb2yy21J+pIHgSZAqk3F//pMVvqHrypCoucW2BA5WIAyBQ2u1SuKLQjpx5i8
 Yt3AJ1rzRW1tA==
Message-ID: <fda55d8f-703f-497e-a414-5974452c7094@gotplt.org>
Date: Fri, 4 Apr 2025 10:23:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <bf93add4-f125-480a-8f13-3f5c9660703d@suse.cz>
 <20250404140028.GA533593@pevik>
 <16c8a205-9d54-4493-8afb-eeca2d1e9c9d@suse.cz>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <16c8a205-9d54-4493-8afb-eeca2d1e9c9d@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2015-3290: Bump up stack boundary requirement
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

On 2025-04-04 10:20, Martin Doucha wrote:
> On 04. 04. 25 16:00, Petr Vorel wrote:
>> Hi Siddhesh, Martin,
>>
>> Siddhesh, I was not aware -mpreferred-stack-boundary is not supported 
>> on all archs:
>> powerpc64le-linux-gnu-gcc: error: unrecognized command-line option '- 
>> mpreferred-stack-boundary=5'

Sorry, I overlooked the arch check, I'll fix that.

>> But it's even not supported on clang:
>> clang: error: unknown argument: '-mpreferred-stack-boundary=5'
>>
>> You need to use -mstack-alignment.
> 
> It might be better to use -mno-avx then and wrap the CFLAGS setting in 
> the same condition as the meltdown test right above it.
> 
> ifneq (,$(filter $(HOST_CPU),x86 x86_64))
> ...
> endif
> 
> I've tested -mno-avx as well so if it fixes the clobber problem I could 
> not reproduce, you can submit patch v2 with my review tag.

Yes, I was just about to ask if -mno-avx would be acceptable :)

I'll send a v2, thanks!

Sid

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
