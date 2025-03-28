Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED93C36011
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743171836; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=2n7nkCTnqxGQmd1ZUJupMuAXxmXNqiuKXfako/TP7YU=;
 b=Qlq/ba0vHI4fFxsWovOOK1TXfp3IlJFpJGsbUPlq5+fZ5QHn9dLVlCH3z2lIlu65nseUS
 K2Y5qJZr2bCRWMRKZwXtzn9enjye3M1aey6nsqqVNewNAnOi14YLzlx1sm5tne5B3KLxtHp
 OWbtp/Oazeo0A0Fw6iwuEM0qtWj8PiM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C17253CA4C2
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 15:23:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 433C43CA3C2
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 15:23:34 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 11B6B1000415
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 15:23:34 +0100 (CET)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1277644f8f.3
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743171813; x=1743776613; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/YVbk+FAHctUFTkB0Tbe9+fTyTz3+mvl+rPXDEf1uU=;
 b=VuX/B50wv6FhdR6rQi1PpLwFRqnfjS2InNnXLiH39/ofmSyL4r9hTbqpM9QhljXZEp
 CfqJTiUSC5OFn4cu3q3vAY/gdr5N1ydZs+l/dCUUO+jkuuEviyBOQNVQusRQ7/i5810w
 eK1R+GO3vqdrXykaBoDNLZTiBP9StQ3q+h/O2bIBssqpLx79FcNFLuEuuouRcm+Uzjd0
 n7UWmcfNh6dLpkN9OzkerJfKL5KQqt/C5Tnuvusr8WIgK6O+2kk8xfY36a0cRXDm0uey
 +M5R0DZjOyRxPFluCZiyWES3TP+lbLbArfyNX+75BwYSO76whTx7QT6irFFwLRLqUr8V
 nn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743171813; x=1743776613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/YVbk+FAHctUFTkB0Tbe9+fTyTz3+mvl+rPXDEf1uU=;
 b=S5Vao+VA6QRJHgTBtlk/6PpoesZtHebnEDZea8WivQqCANoccUVsG/XaL3eks8I5TS
 0CM7rompALEEh6PrIcd8pUy2uGHd2NGVIOOIOwJiClWZMfBjNrvNNC0P6avg1+5p1s/T
 L9QVT3h3S3O8OZipkPLh+xnqmcnkLPFVfMRlZgGY5YJYGMdnoZJzMssZIRZAHj9VeA7A
 T7e98DBWghE3OeNZ99mam+JKaMQSnWMfx6Jxpgo/TcPOUGZ0w1QBDPmmcFNE5UsdtnKU
 ZJfqrGOIWZk0EeVsACQNZORdBhn3TsbKaf4bbGFBKYumqAKhaaCUmyKqir7bqOxeQWnK
 SKlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc/LXuVUbEkbzJjgY9avOpeQ624AawMVRb+8coOR2sR80CijOnuQotv/8U790auIHS8FM=@lists.linux.it
X-Gm-Message-State: AOJu0Yy2YLtyanEAl+cxv7/5lj8RdwA5C0lNXcA8R+FTXD13IZ7tdWUB
 4BZnfjK7N1tZ64cfHkIodotqLCC9ssyc0wjOEIS+wzGgKwcMfkLMUUw+5CVMT/yS8+QqbAG8DOP
 0mksV6tZx
X-Gm-Gg: ASbGncs4+eB980t/GHMPlcwn78N6F8BDyn3WRw8Jwog3VX06YfmYDK/mPV8m4kCibD0
 LrniPGt/DIHcwK4LFEaLeZMZDvC7gKopp3B4C9yq/L86pFkGNfRTJ8Kb4HgOlGAfEQCye26UNRy
 oKmch+cmMeY2sJ1t4Met6zdh9k+vFJ+jN+3VVF0DH5UsBFlGYogPUTfCcdML5qdkrajWC2GC3Xt
 Mp47CP7exMi4Mo3FE74xajyEuFR3dy2/aRyzcPmOuJfbrtZRI65LbMhJtpqaAxI4CakQC4jgAjl
 ptNxJpFlzftc0Q/5hAii0X6sYdd7+Sp7qNrR3zIdBuzHfPxnEcULzT8t+O1wQmCrhQsgHZ4U7PT
 HMqtzgt8T9WURJP50u6qn9N96TVp8PJbtvTMSvRk9C3btNvdAvn8/Jd1JirsY1ABEEuknxhdR6q
 K8YbHM/0A=
X-Google-Smtp-Source: AGHT+IHKkga1scWvmw4ZemOif1mZkrLSWuBJ3vnh4njdFdPs3Uu3cTHUUXOzGMLYYyzqOJJLQvFkSg==
X-Received: by 2002:a05:6000:1a8f:b0:391:2db0:2961 with SMTP id
 ffacd0b85a97d-39ad177062amr8856133f8f.38.1743171813310; 
 Fri, 28 Mar 2025 07:23:33 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eec9628194sm11742106d6.7.2025.03.28.07.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 07:23:32 -0700 (PDT)
Message-ID: <487079c9-317f-4c44-a303-cfb6beae124d@suse.com>
Date: Fri, 28 Mar 2025 15:23:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250328-landlock_unix_socket-v2-0-dd3072962c42@suse.com>
Content-Language: en-US
In-Reply-To: <20250328-landlock_unix_socket-v2-0-dd3072962c42@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] Landlock tests for ABI v6
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

Hi,

there's a building error. I'm fixing it and then I will send v3. sorry 
for the noise

Andrea Cervesato

On 3/28/25 09:36, Andrea Cervesato wrote:
> Landlock released a new feature for IPC scoping in the new ABI.
> This includes the following new rules which will be tested in
> this patch-set:
>
> - LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
> - LANDLOCK_SCOPE_SIGNAL
>
> https://docs.kernel.org/userspace-api/landlock.html#ipc-scoping
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v2:
> - add landlock09 and landlock10 to runtest file
> - DOMAIN_LENGTH -> DOMAIN_CNT
> - Link to v1: https://lore.kernel.org/r/20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com
>
> ---
> Andrea Cervesato (4):
>        Add landlock ABI v6 fallback
>        landlock02: support landlock ABI v6
>        landlock: add landlock09 test
>        landlock: add landlock10 test
>
>   include/lapi/landlock.h                            |  23 +++-
>   runtest/syscalls                                   |   2 +
>   testcases/kernel/syscalls/landlock/.gitignore      |   2 +
>   testcases/kernel/syscalls/landlock/landlock02.c    |  12 +-
>   testcases/kernel/syscalls/landlock/landlock09.c    | 132 +++++++++++++++++++++
>   testcases/kernel/syscalls/landlock/landlock10.c    | 110 +++++++++++++++++
>   .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
>   7 files changed, 283 insertions(+), 9 deletions(-)
> ---
> base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
> change-id: 20250325-landlock_unix_socket-592bb00535be
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
