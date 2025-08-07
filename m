Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C415C87FCA
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 09:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754558808; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=//IxrybJNf6JP+NV9OWeSTa67cz9QPLUbglJ81lO1CE=;
 b=M5eaKDbtGs1HWi0yZANSdQ0oAzaiRXNyoE55cxt08RNkxtw7bYoI06Yu4dlaz1XbC4rNR
 CFWx+gXeAOO+MPNNk895l1FwpfQOuMR/uV52W+KkzbMxp2t/kDTkypOmPBwdi8Ut9wTvt/n
 c3Uz5Kr0ohpM2ey3eYikBy3nF6UKvGE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA7CF3C9272
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 11:26:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE7ED3C300C
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 11:26:26 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9D3CD1000553
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 11:26:25 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4589b3e3820so8048625e9.3
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754558785; x=1755163585; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7cF7aE2RIMSAYNWg05h9IkCuemgs8ynhz61f6Quv7M=;
 b=VK9dw69+r/SKO+7CGrW6+WQja8ZFxIipP/Pp0FUIrrQOGuGIzzhQCG6CUwYhyl4oWb
 oI9TRLqueV8/SHxtSdZuh8ytQHJy621aolc96ccrQAn1OWaaxmGZnpHnNSMkW+iZ9gbG
 PCueV8R0ODOL2AugKCfqA7PnDZvtpCVhMrN4qOnrAWYm4TaQBDafTeaPTNa1i5lAVXxP
 ESwexFhSluRKfNO/Jh9PZps054bjADTjULLgchI+ZBXWqKV6h9pcVHjPJYU4F4ON7eXx
 X6GLqf/znjg46/bY6Lw4C2Z/jZ34NJLn+ggL3KdaY+Kz5ua5Rqmkktr7t2pDtN9R8ZWB
 +knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754558785; x=1755163585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7cF7aE2RIMSAYNWg05h9IkCuemgs8ynhz61f6Quv7M=;
 b=dAvEYOZaCqqeT0UlIdm66PN89/h0qd/O7pGl806ITbx6jr+vpMVJKTvILTJdN6ipSH
 ngLVaKJuSdewnP0OzjmUwaZ5QSuVBV+V4KejArBv/jWRGY7sKjJdoL9HolFlQXsa14Gt
 9oWXCRyRtfp09qEK/F/+0b1bQMlRerrJqW/f0eGSReilXQLjKnZtpXgIYl3/rKe0wTPy
 w+q7G9weYGLlVl9NgZiEn/qp4WRo9UXguFpUDGK5CL32YpONKWfqL14hN/mlm27dU6Qw
 lIq6zmc39FnHPEc0r2uUkR4/dKf9R4wkcct2xIeBI5BvCWBHSb7m972BqcBttCw3GXyn
 TPaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRQLRa5ZmKMVmx/vq5c3CCciRQE2wUbF+TFE7/Z8tD+TzKFUUeRO5yN+bwovvMOOgggAo=@lists.linux.it
X-Gm-Message-State: AOJu0Yyk2wrqysm/jzRiCXEnQWWSEUysRCsumcGMgkMPnkBuGy69J1bL
 e5NzOHeK09Y7R/SY6IT76q3yxZhd2zkzj9wHPFJNEFVxvecspziSCVB68Mld+KfEXC0=
X-Gm-Gg: ASbGncvjNyhVeMqapcDicrpWoLBECfHLijMt9cEoQMJ+iOi/X/FDlLJHBn/mflChLnC
 m+DUDjghuoaYnDKMTCkVEL3tkubhjetQUVnqu3dYBRtSs3nOU4Lrval33D73HWR1obbcZjOM/aa
 peSxaoLwDg8Mh1l2s5keuxTRvjngdl3+PNlQBearS088NM60/SbgOPHxT3uoO9A1OhWFUvjAO3q
 zbAze9zrhHSylhpo91oMY8Hn7De2Ohemc0E9F1rOc5CXPX5VVLmCaB8hhuaa3xbd3XuZzECY5Oq
 Lyjd0BL3N4Wdktb+6ECAoyhejpJubNYa5No6rb65i+XZ5sYsNyu3KrNpJ54t3exK0MnZcgSqXno
 q9q1bSFM2wy2m1lxb2KS3tntcmuanxIbvpwR/CqlxMB/N
X-Google-Smtp-Source: AGHT+IGATCzmiE7/vckzbj8nkXkNrhuJN1KmaNfKPh6hk7LR/qdCZcCS+upQJdUZ7yTNUkY3tlnwmw==
X-Received: by 2002:a05:600c:1e89:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-459e7079457mr49145345e9.6.1754558784851; 
 Thu, 07 Aug 2025 02:26:24 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459ee17535bsm32026175e9.16.2025.08.07.02.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 02:26:24 -0700 (PDT)
Message-ID: <9dd8c328-0a5a-4b7f-8ebc-27fa7aa88575@suse.com>
Date: Thu, 7 Aug 2025 11:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
Content-Language: en-US
In-Reply-To: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/7] file_setattr/file_getattr testing suite
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

Merged, thanks for the review.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
