Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A94DC83F22
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752746342; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=sjIEXI0dvcW2HtYzo/KVnQiWxNo3hXUpsDWSmiYSUXs=;
 b=UtLLrqrpVW03jzhqA9nvvFPMGI7oHjX1DVc1vjaBpEeuvNDWP5yBdSsPKl0Mkbny9nPBV
 XHxfkSQMQ2r9SDP6dXjpCtArmTgvltHiPdRLRVFfNxMtjs3Q6fEVuH4p3Tw8QIfc/GjDleO
 gkxlc4Jcz6HYD7+YrYukhOquhpw+HtA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F3543CC19A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 11:59:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 821193CA650
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:58:39 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B68B31A00CD1
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:58:38 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so620164f8f.2
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752746318; x=1753351118; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=aAy7ZssIFES3X1AtpvmP+zB2iq9GP5l/7fZ4oWPfClwoxIWeFLLhMe+z6KFQwxOVAV
 us/BeRydMWftqeqHeJ0Ry1MIthhRJ+F60YuOmtI78iZU9KeiJ7l6pHd6ZfUr6YBK7bzm
 TGwW/5S5lvWGF/sEnpineA+MxIp1pkOZff02/SlUK1Mnb9w+feG1r9KY8hIZziETrgVv
 ROkryJUAFnBH6peleW3DR6TDsSlBnAwOzTnDU9sBKYsrX/w8hRyJuH7x8RGPcjKXw1A8
 tTFLzcL7G0jzwb/bi6vXOuDBh3oFgdy4ovDtmsixPOBhGzTrp6DJTPQulzN9zqxKmXc0
 vmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752746318; x=1753351118;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrSCBiBykZNwtydAFW50gq0hQyW80s3+ZIrteAUj/Xo=;
 b=d+M7MOiLGIEfYUwK1GtAEG2XrNFpj5CGql7qWOKVbxZeGPhJvoE+EgkyNv3rJVJsHP
 /ZtFwnmKcynpyVJRi7a+Fc8YUQS/1ZSmagYJZ1RfOyIQrBlftnMjfq4LxTRbtnaZTbOB
 ZB1rNoJnxEt+IXp3h7oq5sKkDu2PMDiSheEuMzPvpdKrb15enMM1CJfcNmVKulWvUZMG
 rH0wCq6rVYRM2yMzb9XiLQZdAH4vFTi2ysmWjMheCxP0LzG78/gBvgGi47NxzbYfZCSJ
 UFJ6Wmw2uEPswGeQssa0PBXGKbh/SfKUjiZU1ajatGK/otZIC3swZHtggEjvz4DA0Y5k
 /nLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWecfA1hpRw5ctGSRRiIvGXFMBwxt82X3aRWS4LMe1gPcimY1zWv3kulbf4ReuO73NWOmU=@lists.linux.it
X-Gm-Message-State: AOJu0YxAh1wHTBtm0uw76m+Q44Ca1bcXie5lDsuCMFeTxy7FTksqRXZX
 11f2zVkisrJR9yq40Kc8a19JrW0X1uHD4UF5ydePx5Ai6Il8oV1UZCd/jeNvnap7scA=
X-Gm-Gg: ASbGncsyuCxw14VBnLA7FDHYaBLn0Pl0QIkAz/aJA0cSD3jLRq8kkiH7PV43N67uQ5P
 TFZckrZJhu52bMaWaq/uPHHPURoH74AtsSIyE+EcOLwTepmY8Lkigf5iTLiKm6sDBIEeFPPfBse
 VCYK3Mz/irSn8amfuMnAEqqF1F4VVEuo4CCzLD0bkyupwEnNrZKubyQ8yTMUtihV8553Qpp2ILj
 2uA3QUvoShG6+6Stn1YiisBRFXjixm8CoASwBtUmiqdglceYlNHdUpe252oTuicvUULGopEfoYl
 mq6+9rfWXV9EtagPtmm2dXfB/w3WjJJrwfE3xeISzAF3eHQaMmuFaekkcMpEpyHdALR1PhQBdBS
 enlMGUFj0O+kaR7zCNL2XrxtHx+IL6n28
X-Google-Smtp-Source: AGHT+IG8OVE3o11iYLbKmpYqmoFEmq+ZWl5WRAEy8oU89QRzWZdec+6e9Wikx0PKk9d4uP2D2O8uEQ==
X-Received: by 2002:a05:6000:4b12:b0:3a5:2e59:833a with SMTP id
 ffacd0b85a97d-3b60e4c9a75mr5386013f8f.1.1752746317768; 
 Thu, 17 Jul 2025 02:58:37 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4ca28sm16210816b3a.134.2025.07.17.02.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 02:58:37 -0700 (PDT)
Message-ID: <523b016b-9239-452f-830b-770aca9ee8bf@suse.com>
Date: Thu, 17 Jul 2025 11:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250702-conversions-lchown-v1-0-ac7adb3af51d@suse.com>
 <20250702-conversions-lchown-v1-1-ac7adb3af51d@suse.com>
Content-Language: en-US
In-Reply-To: <20250702-conversions-lchown-v1-1-ac7adb3af51d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] lib: Add SAFE_LCHOWN
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
