Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFE0ECE582
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725958633; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=G6KNbv3GvdiyN/ohJSEgZJv9BQ8TVSWbH7U3opRAFac=;
 b=JI9wVSln2RST0PYUqci5NLMjz5i1IiBJIKPSopfLtr6k9hmleAZqBCmYpmo3p99AqBese
 C6c4+mUZDm3Z/WjV6NjIYSukjGlYp4DyPCXOMJhbUJ+TMtdthV7N7A0DOsAurKH6aFJmP0R
 j9DUpl1ByOYOtjm9wTThLxNb9z8mvUk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96C3D3C1ABA
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 10:57:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA43C3C19E4
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:56:53 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A5F3A1002881
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 10:56:52 +0200 (CEST)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d13b83511so400379566b.2
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 01:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725958612; x=1726563412; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XoYIMCy/onYUXpyQsfOK73E+8pAc16MVgbElRdUpBjQ=;
 b=O6LXSVOYdgd2gb8wqD+iKntPf3sDMi1qxYnAKn4MoUNJBOL3SAgPGSazqH2zQeEplh
 s6BYUu2BtEFinbgrjGrTO630xrWJA2MWlYProVZ5WzrCUEggkRq7wNzk3CjiDwTs04is
 l58/iTixKA475iTHwJNgSygPY3I1e67qORGhLIK9slIgavFEb/q/undKLzTEXJvfX9pi
 Z4h6TowCx6zHCee7y+9GA9KHZ66epo/g+L9p59l9nbZXO+FTj40/WlVOi1luLQvYLz7y
 T0vrQzGF4IoG6MVygOxWSGCjDROsaL5o961Dq0ORRK4C9S7VgRF951LytpQ56AfPZ53m
 HZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725958612; x=1726563412;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XoYIMCy/onYUXpyQsfOK73E+8pAc16MVgbElRdUpBjQ=;
 b=X8+/l0/7LAPPr6HSLZ7nJ8p1Pec65E9RnT65naDe6/s1hTeZzQeVGgN2UhhaTrz7qw
 TuXMVje7Dm3A1oZBHtXQCoP4na18Ou3hOjNiA5bZCYGr0++KT8mkzuuAa0mFXGGwS3KF
 D3iY6ZUfk9ACC4UO/9JrYKz8cVxXBH8PEyOquImlcJhlqUoDHCKSxpMb5wGeReaSgWxK
 1CrEWArOsfbaDJkvkOJbo4U41fXuZwcD9/IfbiYJtPaFpn0D4fYXVR9OjQG4sZqrEuan
 QGm2UWMiKPf/jb5TOES2th+3vjh/oQANjHFKe0IHo66OMFRNgJX5Xd2nBXc6LwWupKzD
 3RYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpGcKDGNAXnX6x5nTMCVSu1eF03k+KduKmMplS86fvM9ZwAu3wcKsvVDdkrlzqhfFj4Nc=@lists.linux.it
X-Gm-Message-State: AOJu0YwaEGh1uaE0DFYO6uCqiyenUlimkr5oUk9DCn5urDb+rJd3PVVH
 GbPeHvgELdQ2u8Yng54+XwDmrd9GXXngNW0X7PJKsbETQ1hKYKZiQ2sHdNrfZx4=
X-Google-Smtp-Source: AGHT+IEFBolqxaUGXMqdvHp3QMhvOFc/b4E1Wn445U6tPUYwl/8aZar88aAtGVV73PwuH26GxMQD7w==
X-Received: by 2002:a17:907:86aa:b0:a8d:6648:813f with SMTP id
 a640c23a62f3a-a8ffaaacec1mr5384466b.3.1725958611364; 
 Tue, 10 Sep 2024 01:56:51 -0700 (PDT)
Received: from [172.20.10.3] ([37.162.238.237])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d259267a6sm457476266b.51.2024.09.10.01.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 01:56:51 -0700 (PDT)
Message-ID: <af9fa249-34ae-4cad-b99c-14f97203be42@suse.com>
Date: Tue, 10 Sep 2024 10:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240909-regen_shutup_lsp-v1-1-d65ad07b822f@suse.com>
 <Zt8C3wF_zgpBtrxC@yuki.lan> <126dde73-c309-4fa2-80dd-d3ae4373a23d@suse.com>
 <ZuAGHuH9araamSrF@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuAGHuH9araamSrF@yuki.lan>
Subject: Re: [LTP] [PATCH] Remove cleanup.c inclusion from syscalls
 generation
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

Ok, thanks. v2 sent.

Andrea

On 9/10/24 10:41, Cyril Hrubis wrote:
> Hi!
>>> Can we remove the cleanup.c as well? It does not seem to be used
>>> anywhere after this change.
>> Do we want to touch old library? I actually don't mind since we are
>> going to remove everything there anyway, one day.
> I would remove any parts that are not used anymore. That way it's more
> clear how much old API mess we have to clean up.
>
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/lapi/syscalls/regen.sh b/include/lapi/syscalls/regen.sh
>>>> index 97027e2f3..0dd3269bb 100755
>>>> --- a/include/lapi/syscalls/regen.sh
>>>> +++ b/include/lapi/syscalls/regen.sh
>>>> @@ -33,7 +33,6 @@ cat << EOF > "${output_pid}"
>>>>    #include <errno.h>
>>>>    #include <sys/syscall.h>
>>>>    #include <asm/unistd.h>
>>>> -#include "cleanup.c"
>>>>    
>>>>    #ifdef TST_TEST_H__
>>>>    #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
>>>> @@ -41,8 +40,11 @@ cat << EOF > "${output_pid}"
>>>>    		"syscall(%d) " SNR " not supported on your arch", NR); \\
>>>>    })
>>>>    #else
>>>> +static void dummy_cleanup(void) __attribute__ ((unused));
>>> I do not think that we need this part, the function is always used
>>> because it's passed to the tst_brkm().
>> I actually had some warnings and that is needed unfortunately.
> Hmm, that is strange, the function is passed to the tst_brkm(). Maybe
> the compiler is smart enough to figure out that it's not used when the
> header is included and the tst_syscall() is not used.
>
> The standard way how to define functions in header is 'static inline' so
> maybe drop this line and add inline to the function definition instead?
>
>>>> +static void dummy_cleanup(void) {}
>>>> +
>>>>    #define TST_SYSCALL_BRK__(NR, SNR) ({ \\
>>>> -	tst_brkm(TCONF, CLEANUP, \\
>>>> +	tst_brkm(TCONF, dummy_cleanup, \\
>>>>    		"syscall(%d) " SNR " not supported on your arch", NR); \\
>>>>    })
>>>>    #endif
>>>>
>>>> ---
>>>> base-commit: d3f1f93eda69905932bde4f66b44d72f9211909a
>>>> change-id: 20240909-regen_shutup_lsp-a35606a887b6
>>>>
>>>> Best regards,
>>>> -- 
>>>> Andrea Cervesato <andrea.cervesato@suse.com>
>>>>
>>>>
>>>> -- 
>>>> Mailing list info: https://lists.linux.it/listinfo/ltp
>> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
