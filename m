Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48051C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748338102; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=s5UNebgrSxic7rBTCGSwMiYLArrtdsHY/h3QPGDauQ4=;
 b=JyJJh9c7gFaP4sAmmpQ0G93+WOFZ77aQIK4a+8eYHsiEQLzJ23/00v5en6Q8GUXkZHn7K
 rhs6QPGPWtRdtzuMVfPoQBrh8H/4+nViuWTh547ioS7zY2GxWEdVacn7LenppyT/C/GM+oV
 XupEP6YYxt9QE+cGdOUA+tl+WU7AHSs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A331B3C5788
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:28:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D446D3C2C13
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:28:00 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BCBE81400323
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:27:59 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4c6c0a9c7so2134538f8f.3
 for <ltp@lists.linux.it>; Tue, 27 May 2025 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748338079; x=1748942879; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gvuYBpe0SmkAn3J1lSohgTiau1w65/n9a6QpK+J56AE=;
 b=L+GmDMFR/OEGLvHRFi5yfqwf92XhsSuvZbpZ2pMNNKoadXPon6b/lWC9snqEPdT/Hh
 8dIIGQBrnhQ21doEvPPvaKTD2rhV8/0YbqIBXqkny+GseEQNGiLTD9IXDPXUzULYQQO8
 35XGoIkT5pmkFSHu9EfZjHl22djsHLTYoQbIOvrlByngkYUmMgwAV87TYdE5Yjqe7O0Y
 uLfiFUI1wn62/hJ/AMpAgN84QY9OSKAeD89DT5TqnSIjXCM0BwOGxSlp9eo8ZderoVjn
 4tP5JWr+FKropT+xunmaLRUtB30Imt8vHeNM1ded8H0XI0bmFteNQpdSQWqplZTWZalG
 8j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748338079; x=1748942879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gvuYBpe0SmkAn3J1lSohgTiau1w65/n9a6QpK+J56AE=;
 b=eqR2LMv4nvHHGVKhoDehSOWIz0I/fREMENc/SCtYEuUKnNepRvm2qUP3k1f1FO3iRh
 DLC4aDf9NJBZC3F9o7OUWRNp3bBW0xl06uFTfiW0M3rZNuLjwlXNDQ0qxGu6JfN9jfmk
 K5+DqdUMPo5LpkiirsNt/BbxX8b+kwnBWfL50nozL7RgbxEY8dSaNxQWBxF3d+3cq9OK
 3Ea6RXIOYpxPUqmeEza/rRKH/FRZeW+ew2qmGujqhRNAoIfNSraFcekzU1C/8nfhVl6t
 2lTlJntqU1Wk6LebxFHlrGeBQm7nWJ0kSEvP/PucArruxiRq6tS99iX0CfhfA6xZQa2B
 ViDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Mqb90Evk78Y5U9WnpNwH8fzRsrTmEI/22wGVLeI3QBC64OrZ3JgUOxVmSrkbBtAExS4=@lists.linux.it
X-Gm-Message-State: AOJu0Yw4NXwmx2ocfWVD9/zY5C2rZ1oVP59MQD6TfkvMB3VjClu8FcHn
 6YQj2x4ym49E+kwpdJTSVytr87fcwSKLRYOMcMi5dWIc+IzAeknvlErZ01NgYauhCFs=
X-Gm-Gg: ASbGnctKQxfRk9+GkeIPxNnmq9fINfubeFnzTymA4IV05/nctVXCC/nrOaydXYTcsk2
 oUxiLqeV/Gux+2uUBBCMirQIV4O7dMxMI/2hNoSbHXDJaTy6gBzNVEcRGXXYwQp1hheCJH4ePBW
 heqKZf5CnoOi1BBV1uMwDZTqtyhWSprp/z3k2ENW1X99QxSXELS+p4ssYrwV0FrqIw+6/my0k3/
 9pYlmJEFoiYXG+ybEUflvl0JoICrcRrL3m2Y+BPFhkFwG7quAEyCewcb3sMrmdv61B1N8Q1zLc+
 LECZileWrOdqLOgxr3gJh0fBkuQk/mQqGiuH/XIsKqE53WexKDoZP2xeRIDXATmVkoiZd0avkyJ
 AI47EgYedUqqSxoyEh0Uydx2oYUYvj6MVbJi8/nieEkgc6LP2WyvTzc6QGAAwDMPCG7xsVfCsNz
 +QlNxvc58gsRq7fw==
X-Google-Smtp-Source: AGHT+IFjJwxLbFk8L/my8BNvi1AJ5oNGtqHgWULaYhEOGbSIWebW5OOj7koxsRYAQZRR+mk4yFjCLg==
X-Received: by 2002:a5d:64c5:0:b0:391:3aaf:1d5f with SMTP id
 ffacd0b85a97d-3a4cb4c6b6amr11834482f8f.52.1748338079129; 
 Tue, 27 May 2025 02:27:59 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23411fbfdb2sm56880265ad.235.2025.05.27.02.27.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 02:27:58 -0700 (PDT)
Message-ID: <bd003583-648c-4793-866f-01b07e46b85d@suse.com>
Date: Tue, 27 May 2025 11:27:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <aBSURzY2zu2HGI2x@yuki.lan>
Content-Language: en-US
In-Reply-To: <aBSURzY2zu2HGI2x@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
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

Hi!

kirk will need to be updated as well to v2.1:

https://github.com/linux-test-project/kirk/releases/tag/v2.1

- Andrea

On 5/2/25 11:45, Cyril Hrubis wrote:
> Hi!
> As usuall we are going to produce a release at the end of the May, let's
> start with pointing out patches that should be reviewed before we freeze
> the git. If there is anything I should have a look on please let me
> know.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
