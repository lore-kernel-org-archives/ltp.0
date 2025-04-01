Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C164C36014
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743497562; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=P7z4K2hYohr3TuKf/cvXi6qtOSd3O5VJiHpVzvKktoM=;
 b=ez9gLgWPyTrdU9i3P2loGtJAAWN6a/rf/CIWVkLLKhYGdxDuZEUICJF0zd6V82rBRsTaC
 W/qW5IfnLjVooSWV6+G8AGHPbTETbksJDP41rUAwECHd69FKo/7mqKIeNZ6Kb2nb0d28SOc
 u2sDkxZbsyFolFvmrbpCbpXuO7c1tBs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2A673CAFCE
	for <ltp@archiver.kernel.org>; Tue,  1 Apr 2025 10:52:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D3273CAEDE
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 10:52:21 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BEAF21000952
 for <ltp@lists.linux.it>; Tue,  1 Apr 2025 10:52:19 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so47875315e9.0
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743497539; x=1744102339; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFOv+lQiGrEww5gGEC+0b/IsVB3+IcCOANeSqRV1pfk=;
 b=Ug5/mejQ3jBOlgAsgGbpLNssglSj+9II4fPHDMFkA2KKF7oDToGEj08HAfmMGw2MSf
 YSG2sA/TZbCQWf04x/q79EEze/R1ozYtYNibd4kRPSSc67KKpljdZz6fvoi5vk9MichT
 IxFg1n3S28IzoOL8pXlAXEXH76+Z30KGKxSyPuTN5IvaQi4vA6XpIdutQx4trwDq+aSY
 6+9pQx3fmbNYD/dwtU7Dncv4j5MGim74bez+tGMIvtI8IonE2M12TDh7pnEk6udxUoVj
 lTbYITD2NthT2pMJT9kRdtSUljKCk/9YP5zYbQ1cclAfZ4ttrrq6I8hO6Z4/VdkojIEq
 r2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743497539; x=1744102339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFOv+lQiGrEww5gGEC+0b/IsVB3+IcCOANeSqRV1pfk=;
 b=dOfVKptNB3+8u+AyP5ZWufMadHtYFlfQGOWIBWtEREMpm13FjHGCTkr7IXYH4jFFvw
 QcQS95QajThL+yYCw1P8XeLNgQPu2q9PUvyyUJLO8p3cM9+kz+/VVGB76StAVZDNKsUG
 gkIsfWMhaKrYhJksUON/KgLt8AltujYoxPkTdwpoWKrLgBkMAl22F1YC06ondo9s7oNL
 QQzUHBZhMW8sid3A7xbHZVDpDjvC2/+ybOFNE16GJDLiHBCDDZTdYCONhP+YIb5x3dAW
 1ILlkreNce/8yPWn2ndrrYmAKf7ypvbeG4fsQ7N9H4ZL4emYQLaoHHo+yJaIfQG7Yohj
 237g==
X-Gm-Message-State: AOJu0Yzj9WVcNJgVBh1gA1gBnXxrZSVf1NHcBdOyc0St1gsoajn/+0/u
 eEtQ3xM00BucA3+BCpg2BLZv5rRC5283wB8CmgNsCqznT2LlkEuzb4zqDOt8iaoeUHAveATMx0Z
 Aozg=
X-Gm-Gg: ASbGncv2xIXfPhXDR+LWB7cwx62Wdr10brCtYMhL9d4vNK85O9qUIIVIcsx87+/DE5O
 TNcbLDRnos08g3pUO0jFy5WmVop5m633n6VSrGlkdi6xFs4gQqW+JT+LnZ+JOErNilWtNzOlXxq
 BMRq0sl6Dz2o560gBfyhzSvthgaZom7cOG8iPz2G2ODOsjn83u9yTtl9o7uzyX72ybRAnHaDOgQ
 ShWriZghglwTMH5BeyF6Odvh4UIMVOMw52ToQ4Ktg/AyDqMArJimFfiaLukIMXS96CkoKPSiEe0
 9rBuR/FvDY4VH9MPRybKaWG884/jn37iJRWKKNqMde97D7c14loKUbO344lqO9xTIqRzeh88twy
 rkndgW6Wtcujce+o8ZqhYMjcNUs8=
X-Google-Smtp-Source: AGHT+IGYw6J7DjLJJE8xvSm+cgRBGIO25vzofWAIhyE8Kj6QdB0Dq0KZoyaUX0NEkkrzW9ahVGRpUw==
X-Received: by 2002:a5d:47ca:0:b0:391:158f:3d59 with SMTP id
 ffacd0b85a97d-39c120de81dmr7557944f8f.15.1743497539012; 
 Tue, 01 Apr 2025 01:52:19 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4351sm13751301f8f.98.2025.04.01.01.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:52:18 -0700 (PDT)
Message-ID: <edd62e1f-689e-4157-8666-4d97e277e73a@suse.com>
Date: Tue, 1 Apr 2025 10:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <f1833ac3-5c28-4a19-945c-2112dbd898eb@suse.com>
 <Z-rAFF9yX3de8CZw@yuki.lan>
Content-Language: en-US
In-Reply-To: <Z-rAFF9yX3de8CZw@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [kirk] Remove support for external testing suite
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Thanks for your reply. I sent a pull request to fix this:

https://github.com/linux-test-project/kirk/pull/44

Andrea

On 3/31/25 18:17, Cyril Hrubis wrote:
> Hi!
>> As you may know, Kirk supports the execution of certain kselftests and
>> liburing testing suites. It was initially created as an experiment.
>>
>> We have made attempts to implement these features, but it seems we have
>> not succeeded. They appear to be largely unused by most users and are
>> creating a bottleneck for new Kirk implementations, such as the
>> automatic installation of LTP inside the SUT. This feature would be
>> particularly beneficial for QEMU vanilla images. We had it in the past
>> already and probably it's time to get this feature back. And we should
>> probably implement it for other testing suites due to the current API:
>> something that we really don't want to do (see eBPF kselftests compile
>> madness).
>>
>> Another concern is the maintainability of supporting for additional
>> testing suites. While they are interesting, the implementation is
>> somewhat flawed. Each testing suite has its own
>> input/output/configuration/compilation methods, leading to confusion and
>> over-engineered solutions. While we understand that no solution is
>> perfect, it seems we have reached a point where Kirk = LTP. Therefore,
>> we should reconsider maintaining features that require updates due to
>> changes in external testing suites.
>>
>> For these reasons, I propose that we remove support for the additional
>> testing suites and focus exclusively on LTP for Kirk maintenance.
>>
>> What do you think?
> Sounds reasonable to me. There is quite a bit of work to be done in
> order to implement all the advanced features in kirk and it does not
> help if we get distracted by side quests.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
