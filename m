Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF99C5B543
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748607075; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=FHYYawc2StYYjHUCER+Jxa2Hq2SZCXxJGqlpPUrJDac=;
 b=BPZcYeEBLcR5xy7Q3POHUBHcPswniJBR/KFQ/1+0c191vqDu1xxjctgwpbX5V1ctct567
 suRU+CQxXGM7ksiQDWV2JuT3w+iTe5hLVl/EiBozwwxgLzSkXnbKjJBR07EnWhQJW8un2vY
 7K4CVakosuGLmXAIV3n4jx0SSqSwrvE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E2833C927C
	for <ltp@archiver.kernel.org>; Fri, 30 May 2025 14:11:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B958F3C6520
 for <ltp@lists.linux.it>; Fri, 30 May 2025 14:10:53 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0D13420004D
 for <ltp@lists.linux.it>; Fri, 30 May 2025 14:10:53 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442ea341570so13550195e9.1
 for <ltp@lists.linux.it>; Fri, 30 May 2025 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748607052; x=1749211852; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cUqDxatKYIcC+OcWK/lp4JoMMUMhaW6ZGsdP+QFostg=;
 b=F8H49+YYcFV++h4uOXpwGWtUaaaev7NR0IYYc6cWsQO8EflObYDGZy41G+ihcL9PoC
 74LdqZlIiH2syVKhj0lMQVbJKCgnFkBrUlAA+G4yBG4Kbl2OakYOfAhPMZbJCpAoqrqo
 /LZvOxtkAISryTZpVxT5ZUTaPAE1JcsnqO2Gqa22h2Y0vbg4qTm3VQV7eciSh8SavLDj
 tANIofF+o2g6bS//MeHucWskZAvO6IW5+akr8wd1ddSlUzKnppWHiq3uD/pRsOnuEPCq
 H0JfO17IT6kIoMhanMByoIFYLzIBRZbQBNNrJc0W6+XcH+dHW3JfMjjQA+8Rs5N7oXdl
 XV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748607052; x=1749211852;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cUqDxatKYIcC+OcWK/lp4JoMMUMhaW6ZGsdP+QFostg=;
 b=oCOg+gP6KOZHyT7LMy17Ki1Vx3w/lfafy/gtVSP9rx9qEtpIeIPSLD1ldJ5IrK1pq5
 0Xp7ciZ6FU6pa/txBm1lbeMRwog9VxtEoB/mDNiz+1cWZZ9QDSgAJaNc/PNaq5W2gr+g
 IMFlex4qlpJafEuC24WVkmtF/di8DlOMWI1DLNINkLjn8mEHx1W9gm9MKGOozUCRUO1x
 co1cpv/dsNhtdjQwf1lgO4eoq1QA7JuxMWsZNdVyvFJ4PUfywZ0clJIviRdiXhO6Ye67
 su9q3orMfvWGUhHqDXfoL69vQcxZVGcfdOfI10mqHKeD02dmCcNDBBiSwLk168COFFrb
 2JXw==
X-Gm-Message-State: AOJu0Yw27ITw3MOV39R8dFa37gIbw0nAXjkge8ZuRAWw991kxfMSspoY
 tKipgdyrOcJG5xuWkj3RsZ+gVICE2UolzT9p3G8b5aSZl55f0dyoD9BJG9SexDw0Tak=
X-Gm-Gg: ASbGncv2Hnat1A3zVXo8H2m7H7m98PZhh4j6LQJubrDQAU13I9o22cL6rD/HbrazqzW
 LJ86TJ+hHJK1cdd1k8QaZelNXJuvFFwRYYGMZFxwbmylRgTTKr8c91A1tgrnJ39GvMYsia8p7/q
 a5LhEzP8f9x5lG8NuvYFjYNYB+t4y1ODB0uAC/RWhSyM8WJjDl/PwOequMYNXenc+ioHEsm0Bb1
 fG1sqSGL6XuJw3Lj0WC6GNriLH7VE1FBMaTOrPCtY+LqPwk3FMGQSQ0AEnhBcHgcTkz/8gFrYZ3
 z8MUDamb4GaeydmQ3rVXByqMra17jUKU8vYbzY7K2ZLvGz1RAUCQx+syCA8NCrdiIvtutkEeY/G
 szRDar+X4MVsyZgf/8wkmAfoqWsKL/tF+XqfWzdeEfemEUBoDjTihyxyFPFdThTRqlNOMeuLWRh
 i4XIOqmEz69ypNeA==
X-Google-Smtp-Source: AGHT+IE4GbiwdgQaWyzmPMdb8IFhZGYANpLg5gNlMhS5PU0Ot4y4pTl9yABtH6uzrAfWeLWpeT/fhw==
X-Received: by 2002:a05:600c:3147:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-450d87a084dmr19576165e9.0.1748607052405; 
 Fri, 30 May 2025 05:10:52 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000e9asm16312855e9.21.2025.05.30.05.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 05:10:52 -0700 (PDT)
Message-ID: <42cacf3d-148a-46f9-9044-3c573779a8b9@suse.com>
Date: Fri, 30 May 2025 14:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250530-fix_irqbalance-v1-1-6509384f52db@suse.com>
 <aDmWlN_BJxhQsUJS@yuki.lan>
Content-Language: en-US
In-Reply-To: <aDmWlN_BJxhQsUJS@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] irq: informative TINFO for irqbalance01 result
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

On 5/30/25 13:29, Cyril Hrubis wrote:
> This looks like an abuse of the tst_res() interface. I would have kept
> the TFAIL message as it was and added the hints with tst_printf(), which
> is used in the test to print debug information anyways.

The debug information is useful, but the error message is really vague, 
even if correct.
The meaning of the patch is to add information so the user knows what's 
going on, even if he/she doesn't know the test really well.

We have some hints for CVE as well, where we print an informative 
message where to find the kernel patch etc.
Maybe we can just print verbose explanation with TINFO in case of TFAIL 
and to keep "IRQs assignments have changed N times" message in case of 
TPASS.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
