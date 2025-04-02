Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BFC28B20
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 06:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743574441; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=1jgr66nQ+pskxwKBDtoBhocRcQ9ygLAaoCnAkCGCLjc=;
 b=Tgm5Y8fid4UJi/aJnEmxowSftzDwsI3Eqt7mS2vYPTRhUmyyNO2EJAaGCONY33zgM3Bp0
 2UvAGfJZ+AQyN2czhDNgmMLCWChcvmdCFPK6eeAP7GZ/xEHc73ZIbpaZa1YRiP0zP3yN5gE
 cxzwGjiX3BD+eBYcTiF+9Z7425eWULk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 527DC3CB0AA
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 08:14:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56E7A3CAE10
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 08:13:39 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 965CD600A09
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 08:13:38 +0200 (CEST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e66407963fso12015127a12.2
 for <ltp@lists.linux.it>; Tue, 01 Apr 2025 23:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743574418; x=1744179218; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qb/INOR8TEGPE6WsfI8e4AqA17UK3+xpILD5SY4ZQ1Y=;
 b=I/Hrm2SmjiyFCejpwfeYi7jGSqPPeO14v9cOcVZjSRGhDxb/Enz0PMfu13uwEJv5eb
 lU2NYF8yvr8Mh7cjlUl70O266aFuQ/5r7EtiRTSJ9UWuSi2F4xOQfDuWQKUAkEMYqZjP
 rYEAtOG1VNhBgaslnEnWsFlrI8HldJBzHv511peGAuED4kZsOoUNVB0TQX1CTk+Lr+aZ
 69YHQhm2z1/MBTH4BqcmkNXUkYNnpmUS2zOYKGXMyVUEz0fTi6e6lzINePWfBESRPunp
 k062eEaZteoS5Z8jYB8Ee5NwNmrVjlnUAEDInYs95ROk9ivhnZWd3WHbfqcwKq8QfdZY
 2XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743574418; x=1744179218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qb/INOR8TEGPE6WsfI8e4AqA17UK3+xpILD5SY4ZQ1Y=;
 b=hP0jUmTbsHizy+Y+yjzT61IBT8AaZKfMkWjLYVvtuCuLwbOg93LfP+O2a142v8RIFT
 78c71PmE6I8r6ROWTJPaWr342AsazwuPlXfgAmZr6jWK5tE95lLOHnD8Ziu22AgBqKbo
 EDcIb4qcquq5cqdMWX7mlE6poWRDqL9vYIEkkR9Mrz6447oH4Bmsb9S4mI+gm6DrsOh0
 b5z/MoQH0VUngS/X6EG790Cqn5FSLhClmrGVZpihLSw7pvyFbXBildOZSPs8Wxp9q8WF
 zpGZKo8jYj3+YIvPvUCEaVQgjxKUQ8nbAGJerT+KENlpZKmUPb2ybe3kdBDbmkO920w2
 hAKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTFQVAcAOzgxxsuTKZ52pV9Z1WF4iPBYeet7SIrc4/3XcJo8Nfhc+RYhiCG5DJG5+Tqy4=@lists.linux.it
X-Gm-Message-State: AOJu0Yz19FJER2Efs0PtzzX81x7tW4QWcHeyifnfx20+x/0irUhAWpkh
 Hu9XrR9pz+EVEyHBMirooB55Ce03A/2JTO56IFPbivaNjbTxOaEt0PbbRwCzRwByM51KxcuUwcf
 qhrg=
X-Gm-Gg: ASbGnctzqErzfm6B0qSSdT8Vc0FrtIMktQmAblqCEplFyMZY2R6LrWDAjgPokK9vuxJ
 igN9Qi+p0YUlTW5viokllZTi6byDFoK5b1M1iECqUtoy1ELdUH5x9H3v6M0H7y8UKmf63iHYRew
 iRm2XZEJKetiL5NS9XebH5eJ1wA2y28wuS+lCJj8Bkz81ImanpZxBhXRxC6mSWABG+EZzXpoXQR
 bpMstHFcQFtq4x+fKgxAajPSI9k2a7CGK6ynLWt+iEfdQewXw5VUNNCOuW9qim5xw5Km0x4X0GF
 6u/zU1cS8vgKR8X2OIyrHVTsADZ87Zz3+5Xyhiphi+0MUCNvFmOa7KUbSTK6sMVQHOHgJpajPCr
 Q7TcOo2jTDdKHPE/gH5ZHnZlsVWs=
X-Google-Smtp-Source: AGHT+IE+LgU8Piqmz9h+TMB30diI5z3xrbMskS80C4jQCHvx8BbByyieEXaITLEWbs/aqS3UbcwSdA==
X-Received: by 2002:a05:6402:34d4:b0:5e6:1352:c53d with SMTP id
 4fb4d7f45d1cf-5edfdd15461mr16366772a12.28.1743574417714; 
 Tue, 01 Apr 2025 23:13:37 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc16d3634sm7983561a12.19.2025.04.01.23.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 23:13:37 -0700 (PDT)
Message-ID: <14712086-654e-4567-873d-f9bdf7f43c54@suse.com>
Date: Wed, 2 Apr 2025 08:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <20250401092913.135745-1-maxj.fnst@fujitsu.com>
 <54c380d2-7221-4302-8fa1-ba280610cc4e@suse.com>
 <TY3PR01MB1207138B56801633191996B04E8AF2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <TY3PR01MB1207138B56801633191996B04E8AF2@TY3PR01MB12071.jpnprd01.prod.outlook.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] move_pages04: Fix the doc to fit RST format
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

Hi Ma,

On 4/2/25 04:35, Xinjian Ma (Fujitsu) wrote:
> Thanks for the review. IMO, It might be better to keep these two lines. This way, users can more intuitively match the kernel commits with the description.
>
> Best regards
> Ma

Sure. There's also an ongoing idea to integrate the commit comment in 
the table by fetching it automatically from the official kernel 
repository. I will implement that soon.

I will merge this patch as it is, thanks!

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
