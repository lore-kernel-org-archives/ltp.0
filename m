Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A23C36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744376834; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=5EW3115mm+FrAJuDNO/CNyRO8xwQTEaPObYOamb6KO8=;
 b=mSeGKmRIErDhyS9GcBRSMx2eMkING5TvwYhxXEEQ2PEc+T5epcrxKaO3LxyiRDJjQJwwo
 NgEUwmiTrIej7BEc3KScLB5lb+qXVa21uDxee6JIEU578uVVT27YGcSv0MMFLO95b6Roj4O
 Xm6iQ6B00ikQMf/XW2qF2IKzwvJqE4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D55E73CB585
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 15:07:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC3DE3CAE86
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:06:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 272C4200BD1
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 15:06:53 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so14487575e9.1
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744376812; x=1744981612; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6mLyy2uCo5HVr3BdAREuLCv9qB17LHhcmeTdYaoHisc=;
 b=ZKsAtLOxR7FvlI9m3RyXUNINbruh5fGPLC5vF00i4s9HSRlN3kGcRpy4SXMOC08DAU
 FzSl4a4p7oDWyqScBeFwW9jm3U7etAS7krpDdI7z3pb+AwEMHmvr0lrzJSnncD8UDVRu
 BMl9pAnBkILQFxBv9l/godlYe9xPJFvvoecKdJa9pPeM+FEwwuvoDaZFaQuV36CbldcG
 OfyeBpd2OaswmUDGbWyogpAfAa8F0bvqetEmX2q4YlqNXYqMsY2A6yRHjFRuha37vcqc
 VILjW1WiNdTABL2YMYcJhCl9aup6FQ4gaH6/74+dkUehexPp0+Y9QMg0bCOC3HNcevss
 sY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744376812; x=1744981612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mLyy2uCo5HVr3BdAREuLCv9qB17LHhcmeTdYaoHisc=;
 b=lTodXu8du2vwghqNe952rD0y5Cq0mohOmErWIsV+tqafZCMj3I8IsdFuPTqx21B4qX
 FLEqWq14cwS/oT0QOVrDWwE3U1a6/MIqVJijsF8RRxlAr8WeEUIvphpQgSZpD/0AnMmI
 9X2/feICRtyDuHNG6INfyKJDai6ZGsZIlvkX5AS/tDTFZ8QMB9P1bQlenCucCsv+mMi8
 fruOcbEG6F7nkMSzBOKIhciv5wZ7zeoGXtns3exPEbbq7rrvOxfpRBIbLm/SiGnx4RzS
 DEXmFkLVHae57iTPFtbLAh4KroES5VJQqyNNiDiyNBu+tpKLdAFwkOktdElNA1JJy2/X
 02lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXctPYKV5PiBVwFrpylPnUfB4C6xDc+QYv68hwrJRtQaQTJn4W912aMV2ih4JmQG6Fxf9Y=@lists.linux.it
X-Gm-Message-State: AOJu0YwgSqrj0z8pOxTSgYsRw8e8TrzWlBfzpBlG282EEm2Uptr+/pT/
 cxCwqTHUqSrdPT1p+Nx/4xTC39KP4KQKpbVI5U+FWdyF4ZCHivV4xgPW+zhe+1o=
X-Gm-Gg: ASbGncsNpG8cDvA51Ln1VCOec5KXATbD201Y7dWyPXFZISec7KCTA9cJwvfiJts0Ghp
 +tcIIr6AIy80WvQynGflHy4iDBDuS7nCEx/XZLV/dihzRv5NHz6tT7+iM4cgWx4WCz198uqAXwY
 Qoxi+LQ9qvi4UUef2zlex4em/rBmQiqdemPsq/sBB/tUP/XbPv83PTMRXIGuwC0YRW/JB+R/O3y
 EL2k9FkCYH2KR0vXPTwpt8YCgvExE3lvn8XYx35mu+xNuxeb/XKJptsmZUjo9MEVb3M3bHOF95F
 3R48pi+6XJ1rJH0HVvVJHd9ZSPOa39LXSmEW0F/zx783IDbhIPJM0ivvkt0pJbLGMozVz2BT13J
 kpxtB7mXJr6TkFhMjVL12Lcd/mF7BUqtxkXNacxje7IbOx8cY3Mt7/G7Th5khr3ZCvFNTD5bEHm
 om6fQ=
X-Google-Smtp-Source: AGHT+IH9J2KVF9HXUSiLysOXR72xOABS3EIwMAVTDEMKfFSH2CWcMY5ddHj/a0YkM+pEw1yMSQxeVQ==
X-Received: by 2002:a05:600c:8489:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-43f3a9a70c4mr20446005e9.23.1744376810982; 
 Fri, 11 Apr 2025 06:06:50 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecac8sm86927935e9.4.2025.04.11.06.06.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:06:50 -0700 (PDT)
Message-ID: <8eb9a793-39bc-4afa-a0f2-242d80641b77@suse.com>
Date: Fri, 11 Apr 2025 15:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
 <20250411120714.GA319294@pevik> <Z_kGsUpRRGBwhEI0@yuki.lan>
 <20250411125911.GA327516@pevik>
Content-Language: en-US
In-Reply-To: <20250411125911.GA327516@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 0/4] Support for Patchwork CI
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


On 4/11/25 14:59, Petr Vorel wrote:
>> Hi!
>>> Andrea did a great effort. Unfortunately we deal with problem probably caused by
>>> our mailing list because 3rd commit "ci: add ci-patchwork-trigger workflow" did
>>> not arrive to mailing list.
>>> I suppose the branch is visible on Andrea's fork:
>>> https://github.com/acerv/ltp/tree/refs/heads/b4/patchwork_ci
>>> Mail is not in "ending moderator requests" on https://lists.linux.it/,
>>> I guess we need to contact ML administrators, I'll do it and Cc you.
>> Wait a bit I'm helping Andrea to debug his email setup.
> I'm sorry, I was too quick to send the question.
>
> Kind regards,
> Petr
I tried everything, even changing email client for git send-email and to 
generate separate patches without b4. Same issues.
I can receive and send the patches directly via --cc or --to , but ML 
keeps failing to track 3/4 patch.

I hope we will find a solution.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
