Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D0DC36010
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 18:28:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CDA83CB065
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 20:28:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE803CAFF1
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 20:27:52 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=jacob.martin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13EF8600963
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 20:27:50 +0200 (CEST)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B81E63F59C
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743532069;
 bh=pGnnvoGOpPxkU777gYZPbxKC9IgkxAndxA450df/AeQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=qCrk8E8ccbcb1kONdqjAwdWC9UFmsE8sPQ6HeNVZopEXYYHB7qWoCdMld7agp0Rzp
 675Sl7ZGzzDEESCkc1lG6fdJqGBa1r2Iex+VXcQLpI4yUj+tgtSTZy4RsP50qujYMZ
 GC51eokcylvXCXZSUmNw824n0lXyffQ6U8w2keJW2bibWbo60/JXnCbAHwJLPhtV/n
 c1T7yWgxeWkpcVKOZh7HVHQOmplSQcuscxB6zHW8+xGalZKMNmEdAm19IQXvVaLHoe
 OhN06vkuS0r7kk49o+bnJwsJntdjiVgYUVGzcCre1PPnaOG8W1wnz7nRPwj2/KAqjd
 ng4M6d5P94GXA==
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-72b846873b2so5191033a34.2
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 11:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743532068; x=1744136868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pGnnvoGOpPxkU777gYZPbxKC9IgkxAndxA450df/AeQ=;
 b=cXIxY/B59ui0dNWHReaNmVUlpcWqoNiBENqXKy1tU46ITAZpU/3yYyv4Oso38UV97p
 2qghp7BWTR9iVBXKK9cPlJ8cxtfgU+cbtFS2n1N6LPkFHUQSL1ghNrtAEJQuFh3Jqwql
 IoZrmMM69zHkm8XPbLeEXmwMM/GkhAtykxfLCTS1uYTYB29tQo8yn+FA/rYex02olECd
 sVsEl4dsZkwEoLbupFbuAabUwcnQmix9Mhh3bBeNgS6m6o37Uj8DPszJfva9aeqfGhbF
 s/sHb6v79ZSg+lABUpYHFaaFV3+D8VM5huLHzbQMINn0ry88Te7bvMFJLViUt3QkgJAh
 u/Fw==
X-Gm-Message-State: AOJu0YyBMReZ/txT4dP+pWykqekiIuX15y1d6Lp7GycHVC/ZkSayvLRA
 KEStyh/hKwNwh1iDP7qAmFGtdgtQKFqpTmVVqB0KGFKJ8SoOLIZseAdYhl0F7O652449u5I5YUq
 XaUQ6z/ZRiLr40+RdPDmR0kR2JgxRlMW1lhh9n/3pjHWHfN32DCyWA5pZD4ywsObQ
X-Gm-Gg: ASbGncul4IPmDwthaZHs0Ftm00NbUIJOavDgVDXzDP1qPJASSmRfs/AGz/JfwoRPLqV
 4kSB6/3AaHV7LTEUkkUpgwXVpCLaRrJV8CmvNm8QxffoYM+rTAnLzBh6SXw6VRQvIDgxd/LZQ7r
 jIUEu2ujHXgvvCp3lgk4bsoXG32IjaOUvfqLMaUcKRJZ4wFbHHD2SDgZwnLens4HXp4ESSKJmRE
 nDy9fWVjzgtsb7Au3t4VgEO+rLxzwFQJq74O1rw3SPrd4nX14NkW2lLv8k8jgLcqfWs2WrEjHuj
 IKY+o+oPJpv+H1M1JV28HIAkmNj9XqOt2SLK3aghgkausCYunD9X69AUDItEi9CBcSkOJQ==
X-Received: by 2002:a05:6830:6088:b0:72a:1a9f:7dc7 with SMTP id
 46e09a7af769-72dae5b485amr2600907a34.7.1743532068644; 
 Tue, 01 Apr 2025 11:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ew0OPhdlqOrgYKKWnHxvs0xVFuvRfeJuFMwNHpr4Tz4H+AUtX1vXJqV1M58FEX+9PrQhsQ==
X-Received: by 2002:a05:6830:6088:b0:72a:1a9f:7dc7 with SMTP id
 46e09a7af769-72dae5b485amr2600888a34.7.1743532068225; 
 Tue, 01 Apr 2025 11:27:48 -0700 (PDT)
Received: from ?IPV6:2601:441:8201:e8ff:3a9f:51d:3eeb:7009?
 ([2601:441:8201:e8ff:3a9f:51d:3eeb:7009])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-602844e6574sm1919096eaf.2.2025.04.01.11.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 11:27:47 -0700 (PDT)
Message-ID: <9bcb3681-4a12-4b12-a341-664aa52b4314@canonical.com>
Date: Tue, 1 Apr 2025 13:27:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20250307225804.380166-1-jacob.martin@canonical.com>
 <Z9lTTX4BrkpFhmQV@yuki.lan> <20250401072006.GB299271@pevik>
Content-Language: en-US
From: Jacob Martin <jacob.martin@canonical.com>
In-Reply-To: <20250401072006.GB299271@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_memory_testset.sh: Give SIGUSR1 handler
 time to run before changing target mapping node in tests 12 and 13
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

On 4/1/25 2:20 AM, Petr Vorel wrote:
> Hi all,
> 
>> Hi!
>>> Fixes: 70259d6e7
>>> Signed-off-by: Jacob Martin <jacob.martin@canonical.com>
>>> ---
>>>   .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh          | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
>>> diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
>>> index c1e7cea8f..04d7cc877 100755
>>> --- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
>>> +++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
>>> @@ -383,7 +383,7 @@ talk2memory_test_for_case_12_13()
>>>   	sleep 1
>>>   	echo $1 > "$2/tasks"
>>>   	/bin/kill -s SIGUSR1 $1
>>> -
>>> +	sleep 1
> 
>> This is just another workaround that does not fix the real issue and
>> that is that the C child does not communicate properly with the shell
>> code. The best solution here would be to rewrite these tests into C.
>> There is not that much work the shell does and we would avoid parsing
>> files written by the C helper in the shell as well.
> 
> @Jacob FYI how looks the patchset which rewrites test6 to C:
> https://patchwork.ozlabs.org/project/ltp/list/?series=450626&state=*
> 
> Feel free to pick another test.
> 
> Kind regards,
> Petr

Thank you both for the feedback and info here. I'll work on converting 
cpuset_memory tests formerly 12 and 13 (now 11 and 12) to C.

Thanks,
Jacob

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
