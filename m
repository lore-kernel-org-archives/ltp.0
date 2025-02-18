Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A45EC021AD
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739885396; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=yQ/9E3xlJAdb4aN31LZawCSlaqkr4QHNKJSivu5i5mw=;
 b=gFVoS47gUT6nX7vYlJIOfsH+BmnvbPBiqbXGb/2j4V315Wb9vlYfynrIYivDy6MeVstdT
 e1Ym5qXKiiGF5OIepAmWJCvEzF78JZSylm1tDWn5JdVhRx3vGUzICFgRMMVp6r9kOGkOyrT
 MF5atyQ1TVnQi+ejSFk0Fi/kpdcCN/0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11BF03C9CC1
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 14:29:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49F113C9C41
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:29:34 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8B23611180
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 14:29:33 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so37725485e9.0
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 05:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739885373; x=1740490173; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yOLm1a5wZ8dwNWo+LoGomisNYgAkSNL/BVOsRqqMPx0=;
 b=gdvLqmoKhQUreW1l/ETqR3GfwwC4qVlNKn2+Twv8AvbNxTC3cKNEuRPgls+KdpZ46t
 RoEgb3Y5xM4D0zDQhG8j3fh7EhYwsBxzGAmoQvoBtYOIMkH6G78r+ChGB+cHlK6b8Cxd
 b0U4yzn2QNadSu/W1JDmN7BN+rbdivLNiltCpbcQxWVUM9Ovv8VJA7rn8c9ols2J8Vwo
 nhgwPe5ygwZ4imkzQ1I2Uh3dz+UNmvG+CWe+MZ9XV91Cv56r49bQQbODLD5It510+qBJ
 4/4R49tepaEqco7Pkjv2yvs75LuqdA7KD45ZgzbYMH0N9ADz2lW72vRM4m2D4uyLombI
 609A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739885373; x=1740490173;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yOLm1a5wZ8dwNWo+LoGomisNYgAkSNL/BVOsRqqMPx0=;
 b=u4XItpP0A9r4nNy+N8T/ukcXMech1oquKf1GQCP6dUA4N6F4IEdIFViwagonZqyz51
 tgV+2asOL3UbafTfvrNQD2h8LMrHEnGQn8tSRGDb3ECjtWAKEAbJx9RMmGsIM3KaCZZH
 PrOUucbZLlnyLtiG/PhpXBHX0wBJW7hAZLSduWk6MArHZbpf7/5rtS+K8Sor2RM54D88
 kv883WkR7Zti+O9j4UKFq9DZZav137hvvI2W524QkPJAZjVnd6bjAyV5f6hOCm872xq6
 g2BrqN3an9fc0C317BTJ+Mcr/UF0cJWa9XbtrJ1Z+zdauJBRbCG1cxH9nEbkogm4xovH
 SAuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZvnB17TY0i6gdUD6aGU0uTngPzwQSgB8iYiKWoIzgH5USZvM1NDDcdfc9Qgsz7M4nhZw=@lists.linux.it
X-Gm-Message-State: AOJu0Yz77+aJmhAGrEWbLdEkkDDNYJJu6lxQwv3H4VdZ6M3jWi8vqKt3
 +Q5LKBw12reo6jdKfHq3pYPIw9+DkghuxGez1xqMKQejo+/7YUjPzc4CYgRralEbuLBALg9KJIR
 Q
X-Gm-Gg: ASbGncsJ3q/HTm705TKXLk4eo3uGdrbq54665sYBzUgEal68pICxXOVTsNtf1p5J1+5
 0NKKcoyFEFVBe6ykwFBecHHZRBE1TyntmYL/GMrQ/mxtg7vS88y63dL6ZlU8uUA1gCNdznXFOWh
 x8hxgpdqBGKAiBAUotzTm1JmlZXGrdnKO9ARmjIgOIXLh2I0D0yjzrMvKfBywrzqgNCoUkDPjJO
 cBeT1i1oIoPODzHG178+FnaKGUhD+KoViR5qOlEmTZYLuw0cgghWm8qXsJ37LvwH9uMFm2grhs8
 lomUh4/MFRNimlbP7x0MIHwVwg==
X-Google-Smtp-Source: AGHT+IHdf3Y2fjmeHAhsGrX6TMu9CZeoeuTGFL6flga7fXb/fqDqKc6TmTjHjDbH7HqIlWyTRdJSCg==
X-Received: by 2002:a05:600c:4f47:b0:439:9377:fa22 with SMTP id
 5b1f17b1804b1-4399377fc5bmr24485745e9.18.1739885373010; 
 Tue, 18 Feb 2025 05:29:33 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399558f8d1sm15291835e9.19.2025.02.18.05.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 05:29:32 -0800 (PST)
Message-ID: <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
Date: Tue, 18 Feb 2025 14:29:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <ricardo@marliere.net>,
 chunfuwen <chwen@redhat.com>, ltp@lists.linux.it
References: <20250218023107.1208990-1-chwen@redhat.com>
 <D7VJNTFZM1Z5.1WXQYU2HD3T0P@marliere.net>
Content-Language: en-US
In-Reply-To: <D7VJNTFZM1Z5.1WXQYU2HD3T0P@marliere.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test case to cover the setting resource
 limit64 for process
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
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

The whole test is a duplication of the setrlimit06, so it's better to 
work on that one and to introduce the 64bits support using 64bit test 
variant.

A couple of comments about the implementation:

- we are already defining the "struct rlimit64" inside getrlimit03, so 
we need to create a new file lapi/resource.h where we move that struct, 
checking if HAVE_STRUCT_RLIMIT64 is not defined. I guess the same should 
be done for getrlimit_u64()/setrlimit_u64() syscalls definitions. Better 
to move them in there in case we will need it in the future . We can 
skip SAFE_* variants at the moment, since we are not using them around 
LTP test for now.

- in both setrlimit06 and setrlimit07 we should probably use tst_buffers 
for safety reasons when passing the pointer to the rlimit/rlimit64 
struct we are gonna use

- it's worth to check if the other tests might introduce the same 64bit 
variants

FYI i noticed that setrlimit06 description can't be fetched in the 
metadata because it's not initialized with /*\ . It also needs to be 
changed into the RST format instead of asciidoc.

King regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
