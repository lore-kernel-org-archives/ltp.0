Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37C5CA0EDF
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755004242; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=lvrFfWKiCTo3sEx/yrYD3FC/bn09DYdNNJtZupSwHbg=;
 b=h5pgUOBnTtP/Xv3J9pD0zyMgvXdw0ckVa3Pl8XFJCgFNoEJ48fWcb73dgOQDmlrBM2dK0
 Yd8jeLfLYu1PMbgPO4sl8ABDGzTX3UKkoVL0S3d605BPqtKHgSf/rEzjnYiBERvBfWf2w+B
 Fcl9MWwKRBTj6n41Z1VXAe0WmWojhNc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 210943CB4F7
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 15:10:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3013C0485
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 15:10:21 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65883200972
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 15:10:20 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7920354f9so4466014f8f.2
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755004220; x=1755609020; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=USVX8iVoXVYYnGtP1MW4j3+kPvhbsbCj9dVz3B80bBs=;
 b=PYT335+oSSlE9eAn19BENM82CDNqdq5DC5VYAaaRX+nwWHvVh9nGGwCs+flYd+uToY
 OXDPiZbvqxGevOW9dGE8LO3ZZfJCYPDMl8nAfkSD3Se4I8yMuKRUZIjleTo9VcyEfRBe
 UM5n3BL90IzOMycVaR5XSCArqf3fdv/39sKCUjm4G+fyJ0/nY+DNP+HzWMwfZzF0kEHM
 GgE44G9juXj5siR09GgGEZqiIZwGR2zgXklHuLJNvysGphqyAUnrfksH5yJnUyGJV7VE
 dih2Dz/J8knQKTQLFEeMCTgl6m7/8loJO2BrpExSmwO/I21rb6gvKbxt3jwPphqCz/Pz
 VIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755004220; x=1755609020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=USVX8iVoXVYYnGtP1MW4j3+kPvhbsbCj9dVz3B80bBs=;
 b=iuOfUX191/HcdQ06feifzR/2lGlUiFVC2fj4itzoxuay3jliqJZPl7+q5X+EPc/CQW
 QrYPMtcVEPG2Kg6lOuMwE1vC/Cp9yG+gkA7JNBpwch+xKQL2YpO5OW2pohfo8RsmLNLf
 avEn6xI0zCSbToF6NYyZEZpB0tlQrAR5Pb3Jt8Bel8bpGucp84tT1R65mYdWh9HbF8tk
 Nsz7SkDUI8ldFHF4FQkyFRpjZV6aKig/1yMU0offiTaL4BZrCAKuq2wxycx8FOFIfkbK
 uG4P3t+N3RfbFKVwZYbgzXV+SQX5IiHZVRi2rGsBop8oLcWYQOa+OBtAuWgJQKnYYQGW
 +OoQ==
X-Gm-Message-State: AOJu0YyG5sasJIxP9bNTu0XBmFUBAUpR9oyXm9lPowmE1FfM63Awc7ry
 j1rMaNkfovf1c2/L/KZj1NU6YsXD/y6CiMwBEg8X2t1azVhmbCvp3zCFSV4GNh3D+j4=
X-Gm-Gg: ASbGnctCqjo6AQ/Pa4R2aTWY1x20+ypaT36REtDd6mFoi891W0mun2J/ZwWxxy8Xcp7
 X3OQvHdvJXFxGy75Mmic/4vEr52C0g/xap/NsF2h5CUwcWiMQf0uDr6n7Gt+c66fxK+XXfLl97N
 q5m/QqHyg6c3KcQsfGMinLyJuewgcseHawEshaR8vwmNyMT2NmDfxexBEJr/8BlJmwj6+srDwNw
 gIjaBLD3gHbo/Ye/8EnKrK+OA+Vs+enTJuCxzkXPeJ4agi6SMov4vL0GD6KYyuVxEX1bV0+se/e
 0P4iq9iNcQ0YBZ64kmQ5WHqOdD+2uPlEVng6f5IMPqo9k4IseuVvaodr8eqDcMmObuDOm36chYM
 +Dkbr1AiXPEwiSCXs/YJobCgSLA6dIBAksg==
X-Google-Smtp-Source: AGHT+IHVfbhX8e7wJL0XeWjZgNAipcMMUGbhtRsYuMlVVYLl4/JpbJyeDy4Aa3QKPBPIJ0N1lHjNog==
X-Received: by 2002:a05:6000:1aca:b0:3b8:f358:28b0 with SMTP id
 ffacd0b85a97d-3b910fdef46mr2896738f8f.25.1755004219605; 
 Tue, 12 Aug 2025 06:10:19 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e075805csm356755865e9.4.2025.08.12.06.10.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 06:10:19 -0700 (PDT)
Message-ID: <1dd5eda5-3b87-4af0-8615-24e300e97c0d@suse.com>
Date: Tue, 12 Aug 2025 15:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250812-cve_2025_38236-v3-1-48ce90adc216@suse.com>
 <aJs37JoQOUdMnhxP@yuki.lan>
Content-Language: en-US
In-Reply-To: <aJs37JoQOUdMnhxP@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cve: add CVE-2025-38236 test
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


On 8/12/25 2:47 PM, Cyril Hrubis wrote:
> Hi!
>> ---
>>   runtest/cve                    |   1 +
> Usually syscall related CVEs are added to syscalls runtest as well. This
> is something for the "let's generate runtest files" discussion though.
>
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Merged thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
