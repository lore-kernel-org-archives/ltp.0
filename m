Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A93E77197
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736249613; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=bq7g0E1L/z5hV+0PkabpMIlTVSg+2h5qGxqkWFkRZ7w=;
 b=bp4ZzCVIVnlPeV4Bxqv7QN09sFB1oSoh86nV17KmOdv2Ubaw0ZqzcLNXLpR/A4kSMO+aS
 qQyr4+XU8EeAQzKwJ3rOufpjVDYylmLA4osXMinBajpH+yqobyeVu4ykKKJ7931rNJfpAQa
 sbuNgtPDPoQTOPkzUuysSwB/dlcOHWQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55EDD3C075C
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 12:33:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB46B3C0309
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 12:33:12 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 337B01400422
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 12:33:12 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso102691135e9.1
 for <ltp@lists.linux.it>; Tue, 07 Jan 2025 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736249591; x=1736854391; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5huum8aXInNs5kxYrIHSfr10hi4Un6FvSf+dexQO30=;
 b=L/mNftarbaQpnBvPnQHkK4ALtMsPQCfResvhMyFwYpOgTuuA4JLe50lFZBywqhrOP4
 QwJbyGdW4GNuoE7D2A8aOvIf/2Fn2XEiTanjASVZUlc2KwsCGw5MxIlX0ZVVNE0WquOK
 Uc3pmXbau0JPi/lLAfRwFFepYmN2RzjbIzdq4PpJxutyqxvCyR2+7FsIFSrAMwDt4hiu
 UGjjlfJDxugth2ALjvd83o/vuRhRU2WChG8GKX69CUavY+WJTmLi3lqTFlHw7GDSDnPH
 Pw0OyT3bFslWJPxfqRY+Wuvpn9z6aKr5tdZA8l9P3Nia3jyIisrsUxdgcmy+WONiWsuw
 FUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736249591; x=1736854391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5huum8aXInNs5kxYrIHSfr10hi4Un6FvSf+dexQO30=;
 b=Rp2XzGsqsQIJNy1hA8Au+bUl4d/dxnHR2y1qkXC/NPsiFZyb5J5pSsIOUn5VOs13WT
 d8krco3JVJMXjgxGlqBOcHFbxuPPGMaQhMACTEgjUHykAUKUgLweY14TRXhtj+TRl/st
 Op2DYygz9GXJ/Gmk/ZgYYa0TNULOMKLFHkR/i2sottzEyYvGRpejY0sNmzbIJTqgHxG0
 CzXAqw5SsSDuCogOI92s6tJa49fFn7yJmqqfm/bzUQMyw7O96RRX4dG8j9X5EtYckmN+
 pqo27kSRPRwLMEh2mp5zUXMLqxuut4kIbGvkMlXEVyN3z1AHkRDf2sibmVHGn/q/3exy
 U6UA==
X-Gm-Message-State: AOJu0YzxeYM7N6TH56+7Jv6uY/44tJt5oba12AtkbUdliATsFneAr2rI
 orDt4EAGocH/7biH+UDR19pR+0gyH20QG3mIimjibNRd+X7x7ZncqiwQicj0Cjg=
X-Gm-Gg: ASbGncuKiuKTJbQmE4ZcyhCgjbcNwFLepCDsXk38pusi8U3V3ssvZWoe/gblIeo6Q/R
 OuG1bBeWYzZ2z//0E7mxslBVPYgfaU/xQD4+7MByhpiALRQgnKRAeub9Ew3Y9xcJlj5bB9mJMzU
 HSZies7SYidau4fQgCyX++H1OkOLcFIhDaI3e3SzRFNJyrfRigncqEzgVFNU7oiC1sqoM1WLLEr
 /NOYEnrnX9PTPya9ecg1JdDzoLMQbwQBcwC950EH3I9aJGgbnh9vnL8skIpKKcwHI0jXbOjcGM+
 1t1GLjOrKttxt32jWJhEpv3ryxiVJa+m52j45DSgZuuNbS5IJDByvwCrXTDDd1kqbViPjsrh+PE
 Xhf7izmJRUQ3EoJilZSU=
X-Google-Smtp-Source: AGHT+IEQuVkq4Ov8Fsvpkxqwm/04sdIm4epNAyBpMJ4gA8361bEGT8zmPAE8UPk8Am6lRaMZy4sC1Q==
X-Received: by 2002:a5d:648b:0:b0:385:e17a:ce6f with SMTP id
 ffacd0b85a97d-38a221fb704mr49085613f8f.24.1736249591557; 
 Tue, 07 Jan 2025 03:33:11 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6dd3sm50198482f8f.96.2025.01.07.03.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:33:11 -0800 (PST)
Message-ID: <dae38571-9437-4b57-9da3-d9cab19f8665@suse.com>
Date: Tue, 7 Jan 2025 12:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20250106140402.52196-1-pvorel@suse.cz>
 <119d081a-f1cc-400f-a278-27e6e33495ac@suse.com>
 <20250106141635.GA323533@pevik> <Z30FOs2ckQTxEYLl@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z30FOs2ckQTxEYLl@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] runtest/ltp-aiodio.part4: Remove duplicate
 entries
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

Hi Cyril,

On 1/7/25 11:43, Cyril Hrubis wrote:
> Hi!
>> @Cyril? If relevant maybe we should just document it. Does it apply to all
>> duplicates? I wonder if it makes sense to run whole runset for 45 min when we
>> are testing something mainline does not care about it's performance.
> Well the ltp-aiodio.part4 is a stress test that iterates between
> different I/O stress tests. Stress tests by definition must run for some
> time to be useful, the question is for how long these should be run and
> for that there is no clear answer I'm afraid.
>
> The dirty and dio_sparse are interleaved because dirty tries to fill in
> the page cache with dirty pages before each dio_sparse iteration. The
> dio_sparse then creates a sparse file and checks that we correctly read
> zeroes all the time while other processes write zeroes to the sparse
> file. It may make sense to merge the dirty.c into the dio_sparse.c so
> that it's executed at the start of the test and then possibly eliminate
> one block of the dio_sparse tests.
>
> We may as well get rid of the multiple lines in the runtest file by
> passing -i option since these tests were converted into the new test
> library. But over all I wouldn't vote for reducing the runtime for these
> tests as drastically as you proposed.
>
I agree with everything. The usage of runtest file for something 
strictly related to ltp-aiodio.part4 doesn't sound right.
We need to get rid of "dirty" binary and include it inside the test.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
