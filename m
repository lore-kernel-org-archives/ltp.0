Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D22C8303C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 07:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751872639; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=uTfXBOV0kU98LedbHTFu6yz44DIUTLcTY2JSZqfh45A=;
 b=bl2VOrBY/E17ijW9REOgrX1jlvIu9JSumDw7I2lusMv1kn3gMi++Unwu6s9gJDX+VkLSO
 mSHrtVsHDQQShpwWf65qQppyC+ctDvRj7olE+L9vKOgHKIMobmm/9Qt4m2AnCs0aq22brqe
 2qJQ334gfjDgd/OUKO4nIiz72F6wlIU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 468453C6AF9
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 09:17:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03C9F3C0F3E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 09:16:56 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 452BD2003BD
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 09:16:56 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae0de0c03e9so466484666b.2
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 00:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751872616; x=1752477416; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=SYiiBZv0ptr5sHBuh6Xs9ULKXcxtjvhyGD3ZVP6U3DfXsswZ5s2Obi35SiL1vSR6rJ
 gfXUhLmqzGQDc7dCfnocf8sJ6+lwo+Mppt4zqzdS8IgQFoqpE2dR1vdTVmeF0OFTehqZ
 JUHNXOKVIeFlGWw/Sdgmfb5eeWkJbk4tX1g5FMNYODWn3t2MBz4ZpUjoBdiZ6XIHBBxC
 Pev/ljXXaFoRQGswfvQqN/UOYGhRQzqtvDKiBroROeRXA/lsl/NgUY/aVt9uJoGB6UTI
 6a+C1lE+wqtfrUovK9LkgiKc6GrKZicFW6U7SfpeWRwCoN4k14UWsK76iWpuYpARrpR/
 nj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751872616; x=1752477416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=vkciqkxGGpv/6tRV0jxmpVI4LsKELojUONs2znFUWYoK2Nyu9cZL15iGHzvWVAxFzk
 kaAm0vZAn1bvV/MURwFLZ6F/es7ByowLAPqiCCz9SK+rs6+SYQC5ZSenQRY8+Es7sNHP
 L9fwafCgYhk9uQn7TsD2t3haso5aVkmeVUfIBuiPaAsDVCf4fb8pyIT/tDNmhrkdGN/f
 GvJmKg3UbyCeFmiQbTbTckJxuzMUgQouDqKeX+Rh6G1vx8Ipom+6zJd5hU/MIe7WCOqB
 FQZ+rluT00aEE5OtTaLy+47/bq+sJnlAAwXLpFys0cpw1HFeKWWRTtNafSAH/IDL6p49
 yGbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvdtaWFarqvyzLxmEwSyx28uUrstpXUfzY/4xTPvL1fdvMBjBcC0lMWdK33+cB5IGq/Qc=@lists.linux.it
X-Gm-Message-State: AOJu0Yydt8IIc9fWSeV5WXSj8Vu7HPQr2q6d+C0s+eRE+w78C5Hxs+MV
 YzhQLQcZGHo0NwPNDFLYCwPvoUjWAyRf/dqHN0ZwMhgZ9csRCl8QPpHCjwd+UIBx6/W5M69gm9Y
 6VEsX+FqWhA==
X-Gm-Gg: ASbGncthCsouBSplAS9T8wTEpttbuJSViCMb9/DeZmv+fuwvjSgJu9v02dQPU7lc67F
 /3GmBJC+V55qsIlohar1EEM7L5nY7mhCUaqruC6Thaf4RJE0/nJ1DvZIT9CphSmgxijK93rw+ko
 CGAhvF3pr/RoaRiByhqf/bXV3D6HzA+DTKU2a5TQ9RC9byD3VcpCf938oM0ZldwjpyrYM2M25cR
 XiJdjk9MJNY0OX9uYGqpXdC4KNpiE2+FtZNng8uKJqeFGZpOk96r8URUw03bQRdcFetoX8uS7VA
 9JIWimPV8lR+MzhTm9mjI8eBoYRDI/4ROV+3G09l/aHwqntfWGDv8J8Ovb79Hhpp4FdSxyLJ
X-Google-Smtp-Source: AGHT+IGcDbyHi2GUSvX/4IlLmxcm66kgHGzaa0IsgsJVpRPivIdA5JaeOtbBRZslSHGvfZ19gheLww==
X-Received: by 2002:a17:906:f1c6:b0:ae3:6cc8:e41f with SMTP id
 a640c23a62f3a-ae41088d76fmr512435566b.30.1751872615580; 
 Mon, 07 Jul 2025 00:16:55 -0700 (PDT)
Received: from [192.168.0.108] ([83.1.218.186])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d93afsm648814666b.6.2025.07.07.00.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 00:16:55 -0700 (PDT)
Message-ID: <78e7480e-088a-4aed-8351-478cc4712723@suse.com>
Date: Mon, 7 Jul 2025 09:16:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250703180201.3384905-1-wegao@suse.com>
 <20250707141219.4161701-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250707141219.4161701-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] du01.sh: Read the actual filesystem blocksize
 instead of pagesize
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

Merged, thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
