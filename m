Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA514C83F1D
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752566962; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=DnIhjbRy5Vns4lyNhVuS7bZ2FG6SgG9l0MslrgSwWlU=;
 b=Nbb11NJAx9UsXWCJGDu+R4R7M6v1Zm/DsWlRb9f7G4EpfLVYRltE7ri+5kagUzC7zyEqw
 JibXQD2zQHGsVPaOCumcxgJxbAA2gIP204TBmopyAizpJ+5NZS6qnRGzgPhhLr/rdCYodhl
 8HZGdgmPJ22TGp7otAzKn9M7jPfPGkQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32EB83CCAB7
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:09:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7B4B3CC8AA
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:09:00 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4544C200908
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:09:00 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so47392045e9.1
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752566940; x=1753171740; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cdar2TOqSWT9Vjo8xxzpSYo7dYfQVBm6UVvwHPtTRgw=;
 b=TKakzaxERbrTq9ohlYyT+suLwN7IRcLPR7rz9LUUV81sFUr2MQ/ZOmvMJ5M3CSEDE2
 Z3VkpA6QeOslUldijYhBS9SZ7C5HAMUQ/fJtoyfvWgHj6PLp/fsONO/8lGUO7qmiCZCq
 9DIiYWcgUP7st/+ZAMFXG/SN7qI4/tYZFEBcOscn9vIzZth4VB8Z+FN3B8Okl4Nmwz3P
 i6keiEA6wzdUGSS2zqSUtDhpF56g6sI5+W3QRkblpk3oQ46KdkQbWqw7HLiciOABNuoz
 PfZjzbgXZFqPxvD/jp8UuSSTA2IPMU3bLTnB50hnHeia//4CYKxmA6X6qcDyiN1gGMw0
 WNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752566940; x=1753171740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cdar2TOqSWT9Vjo8xxzpSYo7dYfQVBm6UVvwHPtTRgw=;
 b=Y06JBFzmDji+2/BtZqCFxVfb9qsieG1DZ30mj9HQr1bDyyQ2na0k3GidfpfyNBTAyl
 +0mS/qa3gqGKK0tFJFhlW93Rh/i70yIUz8ibAUGPLPLTelHlMmkgj51h93NJepGsR+pi
 XAOMc/zMsIny6FAOzplLpWjmRR1ef+g88ZyhTVT579GP/hd3IPt0OtWPR2OOitYD4yvE
 64qYRynOZoYTnJqtfyjEmbQFQTrpKZQBLIc5Z25QroAvxH9O7mp0EpbwSeqD7YmGEnSU
 8X9op6701iBZWjJVxWoEonKiApf5ijhwmpeGDyRMXNRNdIDn6db38C2nZBWgvgbm/RlG
 Ce4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBKpJn6rmbxzdaPlYHbhtiiQqW1lIsPv3JfbU+gOUzFdWiECHEwN+ha0nziK7yVrsh8eA=@lists.linux.it
X-Gm-Message-State: AOJu0YxUSMEO1W/bMi0Z7bcoNtEdO9Zqy5Ited/8qI2nHdtnR4XLEk+/
 ACTuXkLDTsc4TRyEQhtI6avq0ccSGH60V8zFabWMtKzi/pNBB0RP6L9uPS40tkpBp75hc7C+FDH
 UfZBTKfA=
X-Gm-Gg: ASbGnctNRYDAZPiN0HMzEERHH0bOLT3/qPrvs7qbKpuADZ1JxPbnY1LfzU47hO2Wphb
 1L0Iz9HCUy4k5qHqPQn5FsXOWzd8HJlxQrtzoLEb2gsA22RkhQmtC18gv5otN370IHhryOAJmy1
 B3CzVLT+q3/7stsGmW9stOmQPFe2JA4JC2zjAi7M0CeW+M6N74FHhK3hqmfKFq0gkFwLMp7uGqQ
 Tdz+Q52YIvdU/Hefd0ZpYlp9i3Gk9uPYORRaXmrFqiVKNJh8JVoCKWtxbHiNc0Ch/eu6G7cqkr+
 DIi/BP0luUb/9tB1g0Pd1L2Sk8+Dpkftl/EnHo9gaKxIcsBQyp3XnaRRTrSjofbZdrqGHF6otRW
 zXzrDV31zZuvWaVCWg75tmV+FmqomLFJFi3iLdh4lNUdGlkxZbnk7YBhq7K/Q6XLAlsfaULOszk
 MM0/LpYWB1uI35CRnZmbmkkQ6CPJPpGQQYpb/MZC7fAuEmxaADzGoUwp2ZeX0H8Q==
X-Google-Smtp-Source: AGHT+IEK6l5NaK/Qhp6L1FbKnPqluW1R2H8VQIerIMyZUZ7VMabD/TMBFdy1zQe7/X6wY2riySYvjw==
X-Received: by 2002:a05:600c:81c5:b0:456:cdf:1ecd with SMTP id
 5b1f17b1804b1-4560cdf221fmr90477655e9.31.1752566939593; 
 Tue, 15 Jul 2025 01:08:59 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50ded8csm191740675e9.20.2025.07.15.01.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:08:59 -0700 (PDT)
Message-ID: <e84ee8be-f168-4519-b606-9ca42134e8fa@suse.com>
Date: Tue, 15 Jul 2025 10:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lufei <lufei@uniontech.com>, ltp@lists.linux.it
References: <20250711072406.41444-1-lufei@uniontech.com>
 <20250715073622.60572-1-lufei@uniontech.com>
Content-Language: en-US
In-Reply-To: <20250715073622.60572-1-lufei@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add unshare(CLONE_NEWPID) test
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

Merged! Thanks

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
