Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27211E7717F
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734051714; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0KzyyYBzPhpf8/0/Cb+w0XsJHv+R/f03lnEov9odEGA=;
 b=rzklO+nm4/P9Zs8gJwj2iKTvNm2GJPFlIw+s4QHv5SqiIpvD/DKOHnI/JaK++X8qHzqsy
 GbftuJfneEuc2FniMR3KZ/8wM53ipWdmjOdY/VDoMxn20cByQANjwDknd53pr31PI8sdH6o
 dVE9yXiipShTqUiTNw8Bz3Er4xWIDGI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5CFF3EB183
	for <ltp@archiver.kernel.org>; Fri, 13 Dec 2024 02:01:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51E393DD988
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 02:01:34 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82EB71423DE9
 for <ltp@lists.linux.it>; Fri, 13 Dec 2024 02:01:33 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso1146416f8f.1
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 17:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734051693; x=1734656493; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sxru5D0wa8N4CYWwbvjGfADrD1BXCDUTVt8rdTMZyJM=;
 b=fbq2ZgqXlWf3yFPnrDopA0Volo+X50SRL35QWHGu3SLfNET+mNfqEd0CjH4FXxm8lO
 4M7FE+cYsoYORK7eqBgJd+LNz+Fcpja8lnzXOg+feNbAxBtfr7NjtqBk7TQTJqtNyr+r
 5I7k23eRnNp8LQw+AXD5a2TUwnlBXOBI+4H6iWLU+37LhbJ1eZVO4ZZJeE4lu0uW6jCe
 QzFM3S/MguVpw+Kp92MPhHoSTBwtLRCc2SOYPr+frH0mHZCriZDg152ihjYhl3fvduQK
 bu2F1nJs/JtqFJCgw3vCLSNYwXTtmuAA7Vd6CO33K+msOhVBMtBFaICgsyJVewjmzMtg
 7aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734051693; x=1734656493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sxru5D0wa8N4CYWwbvjGfADrD1BXCDUTVt8rdTMZyJM=;
 b=pwgxdRPkW5/REDwo/V1jF7tKX9xDPCCKewOQ1YUeDdUCk98eyyPUNX4zbb+GheQBbU
 5Q30vpZo6s5ZeLqW6W6WTZs6aE4g2zG7e7v4+nWtGDX0vz/Tmbq/j+DGAY8HjtuxzU1L
 yDUuRiydsPHI1c+okVurVg9UsBcUKYbjqtsvFw94R93rTwAHRpaT5exDKpunrFpqdR8q
 3UMTq+4Lilh8YvcjCxm6JF9jBBgeWO00krwPT64igcTBHU7M40Y1/YbhFWX5nfmCxqZj
 dPUka15aW55tROCn0bGOjWBsAUX0sRUWyTxCXeg2xxV9ctLGTMklXV/ZfrVYW/QynvLa
 oaXg==
X-Gm-Message-State: AOJu0YwBmUHpuB7mFjwp4PiYtBeja2dx0kmna7QBCS0/TSh52wC5rK7u
 DOLoiOlURl2zXE4euk+pNTQ51+0dNlHDqD+MhUhO8zr23put9UV5CpnfLbMGpGZ98Zq+ln8Arxl
 Y
X-Gm-Gg: ASbGncu3pLe8c9e5AxFeffyaudTyB6e4eqzEhQTASGYGJela01BVlS0Go4utv6IfL1n
 LH7Wvbh34AJA1ai+Zn3YAGrl19H/oCVo0/aKfuO1YmjHJrwx+slcEwoSTOO007M8Nl0Ki6+qA+u
 aXAK4c81gYvOoLX1DtSKDx/WGtuPLYx+9JSiW88Intq6Nmyuz5lMe9UgmBTV8Cr1vBMJuU1C6vO
 uvFfHk13Qcq9fTzSsoQ7m6qbP1S45iyeXhC5iLNGmr15w==
X-Google-Smtp-Source: AGHT+IHNPXlxqs8T+Tx4YnbOWFWisYvT77uOXoi6pUEcum7wEgb8LmyBiiIlsaXTeg279v2oRuzF5A==
X-Received: by 2002:a5d:6c65:0:b0:385:eb7c:5d0f with SMTP id
 ffacd0b85a97d-38880ae15a2mr369139f8f.26.1734051692614; 
 Thu, 12 Dec 2024 17:01:32 -0800 (PST)
Received: from localhost ([152.250.153.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d91a01sm1970838a91.8.2024.12.12.17.01.31
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 17:01:32 -0800 (PST)
Date: Thu, 12 Dec 2024 22:01:29 -0300
To: ltp@lists.linux.it
Message-ID: <z3rvuk73qw5xtlern2ckqetshe6frlw6kn5g4py7dsnijsyujp@xjdztvpb5jfo>
References: <20241212-convert_mmap01-v5-1-258d9d78bb83@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241212-convert_mmap01-v5-1-258d9d78bb83@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] mmap01: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 12 Dec 24 21:54, Ricardo B. Marliere via ltp wrote:
> +static void setup(void)
> +{
> +	set_file();

Actually, please disregard v5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
