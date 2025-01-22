Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0180FC02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737542623; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7eUH1lJQxFlWgihpgKaf2Wew6c/dKDLpIq+zyTZKs/c=;
 b=mbFW2EVwymoRizDRSNuw6G/i3eERJiNkt8S3ONwr2oTqohvxN5DG6vhre8n89J31aC7sw
 CLpCnD54Rp4Jb72Z30hfzk3sfkVkn3Q/YbR2ZDHrdjfXWiainfrVSJDpnAp82rJGlXLeMir
 rAazMBR/0MyfSiYlmIbIbrPYVFCD1sg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 329463C2F40
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 11:43:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F8BF3C2CF7
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 11:43:19 +0100 (CET)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 427466111AB
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 11:43:19 +0100 (CET)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28a4fccso10471273a12.2
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 02:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737542598; x=1738147398;
 h=in-reply-to:references:to:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LLDC66mncnGKiUwawAaan2BSaEhv2bPYOaL5s+xd1z4=;
 b=cGgoxiyQq/ujxVRviX2ZhlRjO/PplkkdAHUcJpMg/3Q3ynvPF5ULROcODHpG31a7tk
 PotaBTFc4oG0WYatDYmLDzPk9T4fadOD9mV3B6qCimI9yAtNMKzk2iNhINQuULRxv/cW
 D8QWYrcCz14+xw3tPBGrps51+JaEJtP/eanoyF73Zandymu83MKwOpQ5D3Ydt3WgJEtM
 lchuu0rXzGXWE8Xor+ekkEyetMn97mnWFMfXK3o1T2jCUdZ8jQ5uW7j1Y4qdJ05gYWsD
 ya9IFkohBhTQgyu6IyKba4bZWK7ZAyiy9d0Jkw18EirjbFb7LYMv2mjtOaoYMoDpiuFS
 X0kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwFTO/4ZcGE+isIKN0+VqlUqbEnYBcdFZ0wng2SIzk3WtkXt2mLLuXYYl91nCxmyFNDAk=@lists.linux.it
X-Gm-Message-State: AOJu0Yy4xnfIAjCeuLMWFPhDHvV+4gZMXN8ofPh0CxCaagTYYhTXi5My
 iu5eff4mNMStmG1tq3H3bh5l6xDcBHC/kaVr3ruWNR0I8nWaARgU4AXIBpMH8eo=
X-Gm-Gg: ASbGncswqptG/1dLG9QyzD2oZCmqtXcjQCpYLmeVEDvnyY6BWoRdls0jw+EJr4rg3me
 SvLjWAHPWpWpHDiHJbDkH9M+jgxl74GD2qADQStHZmsYRRmsnwh8M3UtMnbzKLnlWR3GFZ44+Cq
 Xb5Db22JtpSYCLrwY1UJjDuTTpk+S15zYvsKAY2xuza4zlqcXb3GFa/8ebVrzjKaKYpiS3wnpQj
 nj4sXE836lSAcjbwgX1JD9vQt1RDeyG57kB+1xoCPkvcBZk3RiuXH8eO68=
X-Google-Smtp-Source: AGHT+IFoWS/rny1lFjr39NfiNyQisw5q3ybz+UdJ5CfKoQbGfprCNJ0xlgiPnr/bJEf9FjXvtQD/Yw==
X-Received: by 2002:a17:907:7da5:b0:ab2:fefe:7156 with SMTP id
 a640c23a62f3a-ab38b3af754mr2158549066b.43.1737542598521; 
 Wed, 22 Jan 2025 02:43:18 -0800 (PST)
Received: from localhost ([179.228.213.254]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7e6a6359bsm1259208a91.10.2025.01.22.02.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 02:43:18 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 22 Jan 2025 07:43:14 -0300
Message-Id: <D78JG0F2FTVF.247MMHZD8G4GH@suse.com>
To: "Sven Schnelle" <svens@linux.ibm.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.19.0
References: <20250122100915.3126008-1-svens@linux.ibm.com>
In-Reply-To: <20250122100915.3126008-1-svens@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap01: initialize buffer in check_file()
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
Cc: ltp <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Jan 22, 2025 at 7:09 AM -03, Sven Schnelle wrote:
> mmap01 reported random test failures. Turns out the
> the temporary buffer in check_file() isn't initialized.
> The SAFE_READ reads less then sizeof(buf) bytes so the
> rest stays initialized and might contain bytes check_file()
> is looking for.
>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Reviewed-by: Ricardo B. Marliere <rbm@suse.com>

> ---
>  testcases/kernel/syscalls/mmap/mmap01.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
> index c93c37ceda52..ff09bc635c74 100644
> --- a/testcases/kernel/syscalls/mmap/mmap01.c
> +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> @@ -36,6 +36,7 @@ static void check_file(void)
>  	int i, fildes, buf_len = sizeof(STRING) + 3;
>  	char buf[buf_len];
>  
> +	memset(buf, 0, sizeof(buf));
>  	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
>  	SAFE_READ(0, fildes, buf, sizeof(buf));
>  


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
