Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F4ECEBF8C
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727429239; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=BGKnCb39urMemRdD10uMEpoOKImfiNTFz3qWs9k/puU=;
 b=Hsd4x5iy/rmNslDl2KzojD8Ym4CtFvhvNlVTsYjrxiHI7JI5NFM934RES8Wi73U8vyCj9
 8+Dn/Q6BLW9hGbA1ymXvWkvA79w5zuZa+JArM2OBSTMGj33jWgraS/wzsRuwjZ1dm2sKOOq
 DEQLqdZ9W3qrHkeMCU2FXhC6JKci3gk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16FF43C4F98
	for <ltp@archiver.kernel.org>; Fri, 27 Sep 2024 11:27:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EB343C2D8F
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:26:57 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3E0B91000997
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 11:26:56 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so2335885a12.0
 for <ltp@lists.linux.it>; Fri, 27 Sep 2024 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727429215; x=1728034015; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LhEw7KcuzrM4T7WE5gg/vFryPLJpIziSd9dB7p4Cy4U=;
 b=gaiuKZBDjX7MoELx/V1u63b5/YkRlwxHueH9d0jXMropymcfK3bGCGCvJtPgAw6LZJ
 5EZR1FuO7gj0sriC+ht5xwpqPlhwvD1CTY8ulUhZPi7aNuVWWCh6HJaKx0z8djyXfV5L
 Y462A/5XErzxE/8f4cWpHHuJchlARRuUkSwG9pqMqHbVIEy7xYIDDY9UeOoKwlyU2k9o
 KTOzN5c/nFLNOAVplsoZbNoqoMm+5VhZXwjvOku/qYQENigPycRhiDqFuXcKgrGqVQ+G
 erQ9LOrRRwAVMbmFlbfkn+lk/bFRshPRLtJ79K8kR+T6J3nteQjosmqe+AFPtKcH4cX8
 DHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727429215; x=1728034015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LhEw7KcuzrM4T7WE5gg/vFryPLJpIziSd9dB7p4Cy4U=;
 b=FYltsFhmyASJl7ZWTNBY1az3zU01IVSdLyBtavG80BHSMHOlG9fLKhmW7fBG81JfSW
 nrUu+ZLhp6Xj9ae0mO2A4k+rUNy/u0l75Hoxov9Vlq41F9f4yAxzV8is9rLievnlC5SO
 RT0k9zhnSrUKwlMNMbLWoNM2EGSuF+qsrYpLHwyVg/5fQ/GqLt6IQD4yHLoocFy9YSE8
 q3ahXZKeZq6QX7HV+kBxYjSOFpuU6xCtZ1u4j3sKLZ8QPhrNv4lJwe2PQHPixcelHchZ
 fTFtey2baopYhaxjv5oK7C4WNUmshhTPCg0PFO3Sa8Hb6YxlYVfH/xJlek+7GEg75TPH
 cY0g==
X-Gm-Message-State: AOJu0YwdAxQeC+yIdUCflFpXdn/fQjo4ivHR4BdUeX8vDk4swbUXnxPj
 2F9lMXCIndRoIfyKG18H2kPu9ZeoDDf+D3q72S7BIOScge+VzWNfwP2M4Ib18jZuYmsm/1jtrcM
 OBkE=
X-Google-Smtp-Source: AGHT+IF2MmD9CbpGCpaPhFRA6Gau7GffVO3AmyPX/IQ88Tw+aNeLeh1bBe87URWI+mrVSJ+7zUUCjg==
X-Received: by 2002:a05:6402:3494:b0:5c7:2209:e937 with SMTP id
 4fb4d7f45d1cf-5c8824e51f3mr1860795a12.12.1727429215132; 
 Fri, 27 Sep 2024 02:26:55 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.47])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c88245e737sm918956a12.56.2024.09.27.02.26.54
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 02:26:54 -0700 (PDT)
Message-ID: <70567f32-0e4e-489d-8904-a5ff094b3ab9@suse.com>
Date: Fri, 27 Sep 2024 11:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <ZtWLSQSSqmh0tn13@yuki.lan> <ZvZu7HoQf5IR1r4K@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZvZu7HoQf5IR1r4K@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

this can be added to the release without impacts. It's actually a devs thing

https://patchwork.ozlabs.org/project/ltp/patch/20240919121909.15025-1-andrea.cervesato@suse.de/

Andrea

On 9/27/24 10:38, Cyril Hrubis wrote:
> Hi!
> I will tag the git, prepare the tarballs etc. on Monday 30. September.
>
> If you have any last minute fixes they must go in TODAY!
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
