Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09E0C5AD49
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748882909; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=OleeKubqiHON9j95k40Gs1k5ptaA34y1hSyLIjdomUg=;
 b=lACkr5Y//u0iCNlnjbPT8ua2PazMgzi8wpmpPuyfKJ/V4dLE9Xf9YxiVcT+quYHJfVTqv
 /ueS3n/n18DisdJ5r5hQyBGe0YNXGi3G7Q36js98gXvYn5lQcQp8iZ2FSJveirXFPq5PGAE
 Py2sFmU+LNvErAqQY30DUOPe7xiQUR8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D3F53C9E77
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:48:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A559E3C987F
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:48:07 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D9642200754
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:48:06 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so12061125e9.2
 for <ltp@lists.linux.it>; Mon, 02 Jun 2025 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748882886; x=1749487686; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RyWH5kZ/hqM43TkekH9VfrC6hAHjIItg77H5Nj0TbJ4=;
 b=W/uGk8Own8oPl4YJaZooMlNgeM4RFUyon4wpXXjLvtHuVRc5RPLu/Ft99vNlxuuT5R
 NsUhO9uMDrLhZ2gHaqWaYPEdgU8pDnP9lpCMS5eSL+hYKSKLi5EWAcqDvrTY+U90Pqv7
 Py9B95F4D5luSBFEpQjt0YK1wewN3gZbXjYV4hN8q0FyIcA+hMUmSm6gSqXAU0oQYPXu
 aOOK07wxIpza9DuTE/MG11nCBoKgyzXBYhboyEVmFlc7ovdIfA9Zs5Mhvf7JRPwcp1LG
 iYt/d3sH8BH4HS6h9hoOfQRqAyfPXaBxRQi6/lrWQPT/SZm2OWseRFUu2C0dguV9VKWi
 Kyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748882886; x=1749487686;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RyWH5kZ/hqM43TkekH9VfrC6hAHjIItg77H5Nj0TbJ4=;
 b=daDBt5fmnvQBZVX08XT+m4zXyTtG3GRRj2kGG9vxCRuTTYX4nXTPI3z7HAu+nsM/4a
 yJZm2l80W99SgoTg5DCCzPdL5q2TkMp9or0cXg9NgI70PxsTUiiWY2k6+F+MH7l8BLr/
 xvpgPfvvshNHlD5LzcPO+nRbpbIwJt59ZeaUV2uonH3xTNEteBKd+ChaSDhULDLmJaQd
 fBltuBw9hlZflYanR8faF912ytfi0EeSuqjL6Nb+NqkiJ4qKKhuWGVV3hwQZIWHuDgxS
 PBZPuadG3A+cfQymqfHSaSW42ZgDAlyPtTwmrJRaD1ipQWMtesHCUv65xy5ISpHEJft0
 miVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5tUEoy3nbE5d+aabY0JSstoduQFaybWgGKyJytNzSh3EVHDUvQY1R8axCYxLhiB62ADk=@lists.linux.it
X-Gm-Message-State: AOJu0YwWEagsnXVEgC9vQwrXORWCKJyN880p2XogoPtEOQABfsvCQqwt
 NhIJoOpxEZjRxN4IM/4oQjeK8/4NzHPnOA4aY8vrZ4Sl1oNt3nF6IVFvTvl8r5O4YKB7peu/aNk
 mpNSx
X-Gm-Gg: ASbGncviNvHxnxMdQu5I6XUSPZv1P4UBvER1sEoMF7SOyFyjAtPT63tBC6smUau15ER
 6mQ3iu9YKXrDGO2HBewP+UQvDxYt1mS+//de0UrDsEdFFH2982+5i5bM7ITIu+ylbAIkKSgblpQ
 5SUvQVMvxmwNe8v5bSuApl/SQGu6u0y52iYpVN/MHr5REXdMv3+IQUpkteExEjruLv/OlAK9E9Y
 lOVskfmdWBXnGzGVwjkCDcEfJ8m82jxO67J+9ibLP97nhG1DdXhFpbjo0BB86fNWavEmvt6ANBK
 RLqhUESBeqOKEjgHSGsArXafn26TwHrpO0TOiNhH/I3TGUfE2psWBUX8rmQUt6K5tkFzWNqfxLF
 unPgGcm6OCJfWEml21CNQ/gEcHql86rwdkMM2vFZxEBOAWf0sPynD8ePWw4nNP8tU4KohhFGNt1
 r2TzOXnGrccTAjHw==
X-Google-Smtp-Source: AGHT+IHB42iIFudth9IeZidxE/r6Mkz7/FjI9NFxFUjtXIUklQpbWHdvXrzvj/zSuwrTsAgQBXryoQ==
X-Received: by 2002:a05:600c:3e83:b0:43d:7588:667b with SMTP id
 5b1f17b1804b1-450d8846c1dmr149639185e9.10.1748882886286; 
 Mon, 02 Jun 2025 09:48:06 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb8745sm127248205e9.31.2025.06.02.09.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 09:48:05 -0700 (PDT)
Message-ID: <8e8cf4b9-38df-4ab0-b82f-8333b71f7e9f@suse.com>
Date: Mon, 2 Jun 2025 18:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
 <20250602-lsm-v5-2-5c0dd01df3c4@suse.com>
Content-Language: en-US
In-Reply-To: <20250602-lsm-v5-2-5c0dd01df3c4@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/7] Add lsm_get_self_attr01 test
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


On 6/2/25 18:41, Andrea Cervesato wrote:
> +
> +static inline int verify_enabled_lsm(const char *name)
> +{
> +	int fd;
> +	char *ptr;
> +	char data[BUFSIZ];
> +
> +	if (access(LSM_SYS_FILE, F_OK))
> +		tst_brk(TCONF, "%s file is not present", LSM_SYS_FILE);

@Cyril can you please double check that it's ok? There's the same check 
in lsm_list_modules02 now, because this function is not needed there.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
