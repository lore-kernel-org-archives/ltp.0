Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF80DC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 14:48:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C64603E8
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 14:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D2C64603E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bell-sw.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 040383C89C6
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 16:48:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7860A3C2A74
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 16:48:43 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A66E11A00701
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 16:48:42 +0200 (CEST)
Received: by mail-lf1-x133.google.com with SMTP id bq5so29389912lfb.9
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mXgQXwv4NvQHphxgeMU2N142mFPl8ZK2ROmQ8NMqOlE=;
 b=Usn78hiQvZws5V8M9a3n/fNxZgb2zySLN7Y/4nPq1VVoudoBBFyLGXQhwWpEKDIahW
 wtKN1heNSXmRS1oguFhf3imOIo8kUWqQOVkJZXE0ynHbGVhjChaLmgw9bYy1fsXH55/6
 bOZ4MKINt98lRto/SrrF00dSCnpR9FeQcdRxsUJ7cB69tGI9P7HHPD8AYrkJNdfjag0i
 +E81wfORXDgQiZST/Bkwqo0dzo0Ik4r1XlDdj4KTd50ASWwysqGfRPgwPkXvd2xqshWh
 LIk19gc/91zlabitQKjRRxlNnNT0fud+2rpC9WhCEecGQjadnRTmAu/XQAgox5us630U
 ABBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mXgQXwv4NvQHphxgeMU2N142mFPl8ZK2ROmQ8NMqOlE=;
 b=xhVrE+QhsYJPwhE6JDfI9Vs29KK+1NhhT6XwElCemTng0CE+/M+mQomV/5F0b/Mryg
 nMJZthJ+OISo4Y2Hv7+whIbzmFviIa+kLtBLYlfbl7rKiC/Im1ZLhvnwqjgwvvCy7upU
 oaWb8QdajvNjg1iIlU6C4pi5e7Y0Un1VFW3ZsNiZkwMVpAjjRMC38KBoFM8zkeOyrirO
 hPy7OveqJFwl9Un8Z2hq2ny3+17BwVsAUAmCc5pETyK5xnF9DmT9y2Un0S0Y/CNU1LTX
 rf1u8+G1shnhZLw9BlQqWQCPi3em++Mk+yK4wDE7AkcCxcP0i3ns6LpSnicpe7QRBYYL
 X2Qw==
X-Gm-Message-State: AOAM531b9H5yOUp+MlIGS3ZIduqaDIgCQDvyFn3Atkwh6aadJg8qK4ie
 ceKXOl0gF9PiapYm7JLi3kyeSijGN2e5
X-Google-Smtp-Source: ABdhPJy0yfrOLKx0FjIOXPKyzIoQXUMbngyDNPOBj1pLTMbpQA5YR0kQBrNttoXixjIMFhjDJ+L63g==
X-Received: by 2002:ac2:5559:: with SMTP id l25mr12817007lfk.579.1631630921852; 
 Tue, 14 Sep 2021 07:48:41 -0700 (PDT)
Received: from [192.168.1.52] ([95.161.221.177])
 by smtp.gmail.com with ESMTPSA id d7sm867413lfn.27.2021.09.14.07.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 07:48:41 -0700 (PDT)
To: Petr Vorel <pvorel@suse.cz>, Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20210914122425.85129-1-naresh.kamboju@linaro.org>
 <YUCah4R0SBDKZvPQ@pevik>
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <e1873210-6d75-703d-f468-c4b826e20d54@bell-sw.com>
Date: Tue, 14 Sep 2021 17:48:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUCah4R0SBDKZvPQ@pevik>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] runtest/smoketest: Remove intermittent failed
 test case route4-change-dst
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
Message-ID: <20210914144841.yDPusbYCQCEdGYM6FnX5O46P1KeeNU2N181aeK7Nn14@z>

On 14.09.2021 15:50, Petr Vorel wrote:
>> The test case route4-change-dst fails intermittently creating
>> the problem for smoketest results verdict. route4-change-dst
>> is a stress test should not be a part of smoketest. because of
>> these issues removing route4-change-dst from the smoketest.
> 
>> Suggested-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
>> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> Did 75184c30a ("lib/tst_net.sh: disable ipv6_dad work on test interfaces")
> fixed your problem? I'd actually like to route4-change-dst in smoketest to
> have it as a detection DAD issue is working.

75184c30a is fixing ipv6. From the log, it seems the error happens
in ping, when it once again tried to bind to 10.0.0.2 as a source
address (with -I option)...

> 
> Kind regards,
> Petr
> 
>> ---
>>  runtest/smoketest | 1 -
>>  1 file changed, 1 deletion(-)
> 
>> diff --git a/runtest/smoketest b/runtest/smoketest
>> index 7f395936e..dd689bd6f 100644
>> --- a/runtest/smoketest
>> +++ b/runtest/smoketest
>> @@ -12,5 +12,4 @@ stat04 symlink01 -T stat04
>>  utime01A symlink01 -T utime01
>>  rename01A symlink01 -T rename01
>>  splice02 splice02 -s 20
>> -route4-change-dst route-change-dst.sh
>>  shell_test01 echo "SUCCESS" | shell_pipe01.sh
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
