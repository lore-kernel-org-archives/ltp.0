Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BECCC54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748882187; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=CmHlkNQqj3s2takFL0255x24cOcei0LrKG4fvUWWwBI=;
 b=QkJ6BbgsQJymV+1p/Q7wmTazdvhbDE/2pj85cv1PRxrsxTkIgNkB/3CgB27DiL7fwoAhd
 Nl9H19uw5YidZjjTCyDTBhJPWYNjYnbNWc6Y3vbJwH+DGOMLoCU2yfpsOUreUzaNbWpBWXJ
 Ogv2b/N/Fxp4P/O9zJy+G9UtLV48i6M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 014F23C9D96
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:36:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AFE13C9904
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:36:04 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A2C61100094E
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:36:03 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450d37d4699so21219615e9.0
 for <ltp@lists.linux.it>; Mon, 02 Jun 2025 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748882163; x=1749486963; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/sswzCOGmYzHjfhh9iPPxNUTzBWJI+U8Xg4HMmpv6U=;
 b=VN5eseaNeBzoeTAG6GouhOD0PExsZuucB9/rJ2WyPvWcSewIHHpAJltXllpgX7Bdrq
 dYxfcbdxXVqLBPEAk0cIeuHEzcIQWdQ0lbg610ubU1oaVSjuziskLhTlyzFx1IrrAcIj
 ftV2eHM6Fgh8F4PihvmCglk9omp7XPANYPJWTI+PNHDAJPLzt8GjCaFK8AFVF8T1J7hL
 VDg+81nC8a7AHChSLlfUawUVVMrlxwY9YXxIGhef+abIWkZV5YXe9fezX1+xSGjDp56E
 736I5msOYyeH/go4vMbqMJ0LzM8vJsXBiWghLcvAEcBCC3JwXcYzqi6mtn7YHs+9F1r2
 HpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748882163; x=1749486963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/sswzCOGmYzHjfhh9iPPxNUTzBWJI+U8Xg4HMmpv6U=;
 b=u6bLDGYnRFMAQuDahVDJG5FBt5IU8YP9iczwsdyibXm5ZrKPmt90yVCA/8o459kFA0
 7Pv5sh5jnM3+lDK5G75ZHOOGySXu2Q+PqWpE0qgaCa++nxth1iUGvJl3dW6Fv3SD8RPp
 vVn/ROoASOaSVaOIu/gkTFtJ1btG2n/+8pT8ntGZzVzXYIuhTiwtfgvnAwJyeVkq1+FN
 KdHbh35cs577C064u4viU7uR3mokFV3tfOdDRdwFtYBQ6Zfg2f2pZKjqMEYHYKcylYVU
 4ul3ASdUdWLl0GZ9Xe4WfTGjAn+NjMIyieEE1kfK0Jt5z58B0la34aqgu+LZo7NMQS/g
 mINQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVquTNLaWg8G8OJh43k7gJW3F8JypRZ0WBPzMod3qaNHKLjbb77MYphSQLRNcyWO5Au9Ww=@lists.linux.it
X-Gm-Message-State: AOJu0YxwrcZ5y5vUGglL8IbB++hZ1gsfI0sVldAup/aDlWvzlpFIehYl
 nhm0soAdCtEdKyskYlfOHzKVniZHQqT9Ee0WR662yjzLIAHStaF4En3+biVUCD3Cnns=
X-Gm-Gg: ASbGncvbBX771fuBYZ27EdfPDMB/xjjyYsxOsmekAiI+8NtMJFKuxDTCBnnPgpqO2iL
 VGhEmxwRWMyrXTS3FPHj0j4jgrF9NmGaxb9AsjMLBp2f9upouvNMpo8Y8gAVOA+R6caxL5bkYjh
 2ZvtBXLqw100LGdId0KKWBnKCUFXQxvpPCM1+GovvOGjn6DxDzK6TcpR+8VDOQgainLcxhZ0ql4
 9HxmlZFIVpV3IIGGkgueNDIEHE479uBHvAD3lWZpA+Dp5xlKnnrotHOiYOHym1QJbAt04WV1Hyf
 wimmXwQItIx191HdWJ+Iyc5AtY1iejvGGDh3U0J5dNVTVjggUA3gM2WdupWFOk1+JKpiAtGtCsT
 IN3h6MIauSryOw9tkxe/fPhIA26JRa/a8bDtmdhr4SZfSuoZjodsQPTQ/C2SKSYW4Z/raNGa27d
 f4wSzz2sP8qYJc3g==
X-Google-Smtp-Source: AGHT+IEQ2EFUS5BfQMoKzTHVlkcy0QTHDWHkG/UgtJOJIaa7Z8ilEArO2bGjTFfCyTvUvlvTCc1MqA==
X-Received: by 2002:a05:6000:25c4:b0:3a3:67bb:8f3f with SMTP id
 ffacd0b85a97d-3a4f7a7d0c4mr12026216f8f.53.1748882162902; 
 Mon, 02 Jun 2025 09:36:02 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf93a1sm72708725ad.205.2025.06.02.09.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 09:36:02 -0700 (PDT)
Message-ID: <501ca64d-10d5-46b5-967b-e76a201cb171@suse.com>
Date: Mon, 2 Jun 2025 18:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
 <20250429-lsm-v4-4-602b7097e722@suse.com> <aD2dDODCBai0Ee-s@yuki.lan>
 <79b6bf40-b4d5-4998-af0d-4f0ba3c6fd9f@suse.com> <aD23bPyqhaAAkPXH@yuki.lan>
Content-Language: en-US
In-Reply-To: <aD23bPyqhaAAkPXH@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/7] Add lsm_get_self_attr03 test
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


On 6/2/25 16:38, Cyril Hrubis wrote:
> Hi!
>>> 				next_ctx(next)
>>>
>>> Otherwise we will fail the check below.
>> Right.
> Feel free to add my Reviewed-by: with that fixed.
Ok
>
>>>> +	for (uint32_t i = 1; i < count; i++) {
>>>> +		TST_EXP_EXPR(strcmp(attr, (char *)next->ctx) != 0,
>>>> +			"Attribute and next LSM context must be different");
>>>> +
>>>> +		next = next_ctx(next);
>>>> +	}
>>> Have you actually tried this on a machine with more than one LSM active?
>> Fixed, also I think I we to check if "/sys/kernel/security/lsm" exists.
>> I guess it doesn't exist if no LSM are present.
> We do call verify_supported_attr_current(); in the setup, that should be
> enough. What I was asking for was if you ever tested this code on a
> mach9ine where the count > 1 so that the loop actually triggered.
>
I modify verify_supported_attr_current() in order to check if 
/sys/kernel/security/lsm exists.
And yes, I tested the code on a VM with 7 LSM(s).

Gonna send the next patch and then merge.

Thanks,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
