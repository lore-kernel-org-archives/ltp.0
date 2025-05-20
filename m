Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A190C3ABDD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747743804; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=KcpNt3aPmmg3TORmLxdQ8voBsDd2io7Op3Vd8+b9h4I=;
 b=p9vg/pdzURIBIsUgZjlodcrKbBth2r4QFXhxMXnkNdB/SaiHZaoHl831Ebm9DctG3wnQL
 9Ls/LfAiWEuZC97RPWnsUIOHAfX4jY9z3eOOmcXdVCGG3JE+G1jUfVJP/DdvlZV7rQ856l2
 syqmsrT8m5OJ/xtzP/Pn30O63KDKnfc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C10A53CC765
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 14:23:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5A8A3CC3E1
 for <ltp@lists.linux.it>; Tue, 20 May 2025 14:23:03 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7759E1A00A2C
 for <ltp@lists.linux.it>; Tue, 20 May 2025 14:23:02 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so1047868f8f.0
 for <ltp@lists.linux.it>; Tue, 20 May 2025 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747743782; x=1748348582; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zzMJjZBbCUg2M3odjzm2MdBdp4i6U5JuRG4rNId5GIo=;
 b=BOdqlB97KDfjFRFjqwLnJrlLtwODDxmrLgfdth6U8VOJuIsjX0xxvtLqFxkiSZOw9v
 gmZtLnaqQy1I6ZP71jBc4y1/7bBKokTXb6hsCn8sLNxKhSdiKXPzjIOntdfo4Bxju0E7
 hOw43qyLJWVaaNwOeXP8eigVs8KKqWQRcWe04F5dOg0Ler6VUj5heEWxZhmpeOnmSxUF
 XkU1qn87+ouDH83I9evj+eNhoD6V4IYxkOIQZPaaargEooP+VrLRSzep/XMl3k2c9Eiv
 yT2cVNm4rjCcIzM5IJdWY6idptu0Z5tTfRBjl/dyM1DyKyvjfE/ZitT8fUYutuDwzPJY
 ef5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747743782; x=1748348582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zzMJjZBbCUg2M3odjzm2MdBdp4i6U5JuRG4rNId5GIo=;
 b=g0pf6mDkJJD+0KQPXxxI71s97ya95poL2+Dbf1/Jfqk9TrTfkKxRr7fLU2GGZGNqL2
 6A/c6BrOOI2W/CPFE6hh+YEH9YcWeNfVWrqkPTaC4Z3YcRw9fSIX4PuBqDdPVQGMsCls
 yuoIQ/MHz/EZIVrGDsUcsSjJE6JR4Z9nDXftZTQFf3VNFbHnXhNxZghgwISbvLKbCy8t
 UYln0deMl5eGbywGiKji9U4MA4EKenxutS2jzjKzgGhTHoHwszDr3bq9+cI7arGcKq5m
 Bn6z8TdaJjamUy+l4i/I3rjGJUYjhiK68z1N19W2yL/EOP7rEf5zUOByY1YzQBBKDfbo
 BWLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoN9IWBXVUsvYio1qFEs+af05ETUj4Zhlc67Ah7Ru8E5piFO7AuqjnpuSY6fZqVqLnRYk=@lists.linux.it
X-Gm-Message-State: AOJu0Yz0hhURdhsQUIFTAK7kykrH3IshEIYxcL34rPN0RfmzDfNKHMaQ
 AKNswAi4pcCfVg70ytaKlF5Yfgg6i0ivakQjX+S/orfR58vUAREghqs6V0bc0Wn+MiQ=
X-Gm-Gg: ASbGncvacPpqkWa3PUSuTl4tx0fmZg6wD4hMB4Lrz0CVKK8PAa3AE06IN4DJYY6JXoF
 A/ICZrQFnDHa49r8Zhr333bM9fJkPja1MyGU7T3iRRAJs2iUOS49LBKiA0oDb6suANhrpCs9Qnh
 /Hnf0cye9r0hzgNJdkEeOce7U3l3IZSpO7UWqzEu3jAG8YjvkDVFhkQT5dOM3rsSW5aPbBYhtEr
 xy+/sK+O6EY+Yv4/Lli2uPY5asWez1LhofqGlJI5UKQ+Gr4Kmcut6539Id92G2frbKZzjHJLb8C
 iHt5bFbOyHoiqsSbomvo/81AJcQTzYMWuqFalfV5DbjKHPhHLD8j0dUlZUvWeA==
X-Google-Smtp-Source: AGHT+IE1vWSH9uGxQQIyv1v6ntIxPnmNVsaJJlM4A92oCc38kVEq7Big3w7kwOkINgR1+vzl5vf63A==
X-Received: by 2002:a05:6000:2012:b0:3a3:5b88:fb2a with SMTP id
 ffacd0b85a97d-3a35c808a9cmr16999352f8f.7.1747743781880; 
 Tue, 20 May 2025 05:23:01 -0700 (PDT)
Received: from [10.232.133.20] ([88.128.90.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca888c5sm16412026f8f.66.2025.05.20.05.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:23:01 -0700 (PDT)
Message-ID: <084e07ac-61d7-435b-a5d5-1512bb57b2e5@suse.com>
Date: Tue, 20 May 2025 14:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <rbm@suse.com>, Linux Test Project <ltp@lists.linux.it>
References: <20250520-fixes-modify_ldt-v3-1-a78c79341d0c@suse.com>
 <13b3679f-ca6f-43ee-a56d-865544c2474b@suse.cz>
Content-Language: en-US
In-Reply-To: <13b3679f-ca6f-43ee-a56d-865544c2474b@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ldt.h: Add workaround for x86_64
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

On 5/20/25 13:34, Martin Doucha wrote:
> Hi,
> safe_modify_ldt() should not allow any errors. Let's merge v2. 

What about the other tests? This check should be applied to them as well 
eventually.

- Andrea



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
