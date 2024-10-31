Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7DDD7495C
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730381889; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=nAjAGbW57csstG8zIvjVjsY3HJGHxL4cHPN1jGMh7A0=;
 b=nx6dIK8IQpz/0IOLhPNeXEdYMTwmoxWItyrJyHJq8x5ZYUtJgFDvbIGnaZdLXDt73Xz6V
 MsaUZaxb26V7hDmi3G4oN5caA+s0gHyVHJAzMK9vTDJgDu1W4Lumpy3aZyo/rpvOYwIB+Fg
 fqAvP9rIHB5EBad2lgqp4KSgJDdx3TI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56AAE3CC092
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 14:38:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49B7A3CBF24
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 14:37:47 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A4D363CB10
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 14:37:47 +0100 (CET)
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-37d4d1b48f3so630919f8f.1
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730381866; x=1730986666; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yytrw4+u5NvrCRdJRy0ikMt8spQGCNCW9n3Z1z5qPYI=;
 b=S1StctHYp09et1djD1Kz5AqkLRqGx4E6MhxBwnth+HqLodwV5bIhvWGAedO+4Jayie
 XLnzX2uq4xWFRQYhdSt54otcL2No2ict//kdL5wwKF8KsXJ5Dppa+Kfc7LUfZcStE4Y0
 m+dEdQDLNnTeuUKJ4gg1M/kN33S/1F7aQSLY1GweU1I1+Ie5Ar5hwSZtkkeaPTV6gRy+
 ZYVrU0DdKCjUZSiAlchb/pOxi3GyxCwTngenfROCjI1P8SGnTw42AgiIeM+Q4x7fU3y3
 b+M8wTaJ38kLjHZkxVQUISpGkRoCDGdlqjA0lz1p9+O4lIyh6d/aEW10y7gw83nhMgsl
 Of3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730381866; x=1730986666;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yytrw4+u5NvrCRdJRy0ikMt8spQGCNCW9n3Z1z5qPYI=;
 b=XPVE5rMUMvn7Ugg660GhkO5GaNAQ5tS639fMYILy9mBtUGJ6/LhFRAJzmvmqY0QBJX
 dv2jTQKAlpAEe6d+37gKETCTM5dYRssJX+dpS8pgl0iuK73zBgfDMTW0mYU6apH0JDq6
 mUU4TF0bnaF138fYN8bSQMP/FEX4O8X+z8MrCfFhWNOb9jGJ0t0lGu5Oh2tqF+ha+Amw
 GZPajxNMY6ut3UXrPmD8qxN/pLwmLyM/Mx6yAvbVaKlKFTwRxqyHuyOF3CUDUtDG47HG
 7vJmv0VdTsAWbdwNN2bXIiTTJaQWNog7HRaPFsvLkNpW/JmM/HbT+uht416wTg7Plzac
 pJ0A==
X-Gm-Message-State: AOJu0YzKN6eWoaCJGJaU71QlpIJ1VLCOYzLXnt2X9I+7ChfuB4KAvN69
 TxxlaHEBC8+d9hRI51wH8hdQdA9TZtM+tpzSbLwo+U9HrSElMqOUGFyWOf0Wslo=
X-Google-Smtp-Source: AGHT+IGm/CKW+3c5iaGJvlz/BI1wqrbFLgaR3qEhD9JPdibXdhasBTgPtHRWu0ffgRNW0JHSs5QXrQ==
X-Received: by 2002:a5d:5482:0:b0:37c:d179:2f73 with SMTP id
 ffacd0b85a97d-381b70750d9mr4881616f8f.13.1730381866363; 
 Thu, 31 Oct 2024 06:37:46 -0700 (PDT)
Received: from ?IPV6:2a00:20:6047:3333:1b05:5290:eb22:1d88?
 ([2a00:20:6047:3333:1b05:5290:eb22:1d88])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116a7a6sm2112320f8f.92.2024.10.31.06.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 06:37:46 -0700 (PDT)
Message-ID: <b507e053-8404-4b46-bba7-ce5e86383a97@suse.com>
Date: Thu, 31 Oct 2024 14:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241031-generate_syscalls-v7-0-f3e26c06814e@suse.com>
 <20241031-generate_syscalls-v7-1-f3e26c06814e@suse.com>
 <20241031130117.GA1017691@pevik>
Content-Language: en-US
In-Reply-To: <20241031130117.GA1017691@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] Refactor regen.sh script to generate
 syscalls
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 10/31/24 14:01, Petr Vorel wrote:
> Hi Andrea,
>
>> --- /dev/null
>> +++ b/include/lapi/syscalls/generate_syscalls.sh
>> @@ -0,0 +1,109 @@
>> +#!/bin/sh -eux
> I'm very sorry, I asked for "#!/bin/sh -eux", but better would be without "x".
> "x" prints output of the commands which is too verbose on generate_syscalls.sh.
> Could you please, when you merge, change it to "#!/bin/sh -eu"?
No problem, I will do it before merge.
> I'm not sure if it should stay in the other script.
> This is on dash, but I suppose this can be reproducible on bash as well.
>
> $ ./configure
> ...
> + syscall_nr=__NR_writev
> + echo # ifndef __NR_writev
> + echo #  define __NR_writev __LTP__NR_INVALID_SYSCALL
> + echo # endif
> + echo #endif
>
> $ ./configure > /tmp/out 2> /tmp/err; wc -l /tmp/out /tmp/err

Did you check the CI result I mentioned in the cover letter?

Andrea

>
> on master:
>    290 /tmp/out
>      3 /tmp/err
>    293 total
>
> on v7 (at least what I apply from https://patchwork.ozlabs.org/series/430633/mbox/):
>      289 /tmp/out
>    48706 /tmp/err
>    48995 total
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
