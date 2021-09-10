Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14478C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 08:35:53 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2463961186
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 08:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2463961186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A3D83C8CCE
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 10:35:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCC253C20F4
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 10:35:40 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D91761001442
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 10:35:39 +0200 (CEST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E964F3F07E
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1631262933;
 bh=6pMBmBTaXkxyABYtIsuCy7OiVqB57CfZQGGeZXTarGY=;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
 In-Reply-To:Content-Type;
 b=DJnDghnqJLluRbJ/uoCFINo3Blsco4IntgeN3egqJ5qufJivrkpE5SgPFKQxN1QIR
 cny5cqi0z7E9BGKIDgbYEQzyRaMxB4yB6nlhRlsOSt4JjjBCRu1KRp6IHx8gmJZk8+
 oX1/JKpGKH+fb67sRFaJksVeLYcjlKN81X3zdzrpEHS2BuPCP6MutOVCsSjo7XfOBo
 spHoxbdIMFGXTx2kTw8wylVwrTzDOHNcP8hYd5rrrHHEyXiNphCtuIHRzyAL4STl1C
 Mz44Y7Oa9sZ/sM5ouYbOzBs4DwAqsgP9rxGte5buVxzm7dV0Pi+5oCe5fXLKC3XhYE
 hFwMeUJN6Tlag==
Received: by mail-wm1-f70.google.com with SMTP id
 c2-20020a7bc8420000b0290238db573ab7so627792wml.5
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 01:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6pMBmBTaXkxyABYtIsuCy7OiVqB57CfZQGGeZXTarGY=;
 b=3PaDz26OHfWJih1gf3MvL8VcplrCkwOg/NFSXox/lETLLY9O1bK1UnAn0oS4cZfDZ7
 7XXHlR08nqgsYmxWoeIMSfsstA0ILKlXuN+iWKHqbI+uCmyWfG506P8zbO0XNExkwoBb
 SuYkeHYUwpV7wZ9DfYDn2yfMNfh2NDSIYDldz/ncpw9P04VHWbqwCwOvVxY9wQpcqBHD
 /2pr3zjH4Y3KhgY7oTsdtxR4MUGRXZ2Aibk/WKZqHQPXwgt3AIxH2gvh0yecDob2y2kV
 uL5lwl+8w0YVFBxLEym/knMMLY60JvfejVY0Gs1FnMbVkRQnghOveveCDCWrxct0bZaN
 GYEg==
X-Gm-Message-State: AOAM53139D5TxguFYQuIWU7h3T/BdTC5iJw3qHJKHGhNHQ9/J+qPXGX3
 0STma7wMiwk7BPm5+otb+sJS58kzw6LwSPGl4e8M1vFa1K6wNKC8+euYZMz5r0EiZmL4xbHSjXQ
 icCs9EtuqFHIKHWjdaMl/YAltUYR5
X-Received: by 2002:a1c:1cc:: with SMTP id 195mr7220967wmb.188.1631262933328; 
 Fri, 10 Sep 2021 01:35:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEp2LwV8ONkxBQ6qACZG0bwDZ9ezybRhImxLtSbV6JKzwMF0SM6hfyfcfx/jvcaLVh753PRg==
X-Received: by 2002:a1c:1cc:: with SMTP id 195mr7220955wmb.188.1631262933163; 
 Fri, 10 Sep 2021 01:35:33 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.74])
 by smtp.gmail.com with ESMTPSA id m18sm1353945wrn.85.2021.09.10.01.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Sep 2021 01:35:32 -0700 (PDT)
To: Cyril Hrubis <chrubis@suse.cz>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
 <20210909163326.42598-2-krzysztof.kozlowski@canonical.com>
 <YTsYqBJP8oWiuEGQ@yuki>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d50543f0-6e41-8911-e24b-ba0ae61185fa@canonical.com>
Date: Fri, 10 Sep 2021 10:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTsYqBJP8oWiuEGQ@yuki>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] rtc01: add workaround for broken CMOS RTC on
 Microsoft Hyper-V cloud
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210910083532.h8bwdegMTBCTSolwrhqaaGVwh7KC9zSFaQ3jX86dDtk@z>

On 10/09/2021 10:34, Cyril Hrubis wrote:
> Hi!
>> rtc01 fails on missed alarm on multiple different Azure instances if the
>> alarm is set for the next minute:
>>
>>   rtc01 0 TINFO : RTC READ TEST:
>>   rtc01 1 TPASS : RTC READ TEST Passed
>>   rtc01 0 TINFO : Current RTC date/time is 11-6-2021, 09:00:58.
>>   rtc01 0 TINFO : RTC ALARM TEST :
>>   rtc01 0 TINFO : Alarm time set to 09:01:03.
>>   rtc01 0 TINFO : Waiting 5 seconds for the alarm...
>>   rtc01 2 TFAIL : rtc01.c:151: Timed out waiting for the alarm
>>
>> Reproduced easily with rtcwake:
>>
>>   $ rtcwake -d rtc0 -m on -s 50 -v
>>
>> If alarm is set for now+60 seconds, it works fine.  Clearly Microsoft
>> Hyper-V cloud instances have a broken CMOS RTC which unfortunately
>> cannot be easily fixed.  Adding simple workaround to extend the time to
>> 60 seconds allows to avoid false positives in expense of longer testing
>> time.
> 
> I do not think that adding workarounds for a broken platforms into
> testcases is a right thing to do.

I am actually also not sure, but the broken platform is one of three
main cloud providers. :)


Best regards,
Krzysztof

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
