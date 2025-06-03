Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86859C5AE59
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748948913; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=7rbL97p8rjKWF5UdEio519e2ce4I4W7DEiHNZzfaFG8=;
 b=mFdTolwWiRQC22vhRaiHKtHz1QHiJuCDCT2s+pnUbwJOWv4hah7QemWz9MVypLaTKHu12
 +zNVtxCRgdAICUBKSpwMmRfj0MckXiAFpxzBgz88NBnCOyIFzFx+UUkpCHp3g1JfLLWgBqf
 3rcQ36z5PBWQIRzp4/Q/uYa8ZlRGhso=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A1A93C9FC4
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 13:08:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D5413C76BB
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 13:08:12 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6273A600C97
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 13:08:11 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so33567715e9.1
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1748948891; x=1749553691; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+qj36nqBixWDx04ZhmR7C4IhjhjZ2ul2yJGWG1XMV+8=;
 b=SwpaQOVJ9nLUnk2IwZKmcP7eW/PjfRHU/MxJGcQnBdrHDwmJbJlRFKhoK+ta6GDVJd
 mrcJ75wDtogGUsg1zmNsgDUTvN1aMHiZkn5jqOsQ+yDu5QzeLUwdiYrZtemhyfzgkSsl
 rQwEk9F7WqIb+qJky4QdwbHT8CktWzEuFvciX8I02dFwGchA3y1Voju/YdYC8S7XMXV5
 n8YcvSTU3rSqQ2fK97ElTJFzd9JpX7EA23TsA6ziICBgchKPcYj6PwArnhOHiGdNSxO4
 HOvBDpuuyUeIG3Jh+BShkokyYAtsFFehhtwa5Va2EUcuOYoRmq35Xtwr5OXbXjbAyj1e
 5uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948891; x=1749553691;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+qj36nqBixWDx04ZhmR7C4IhjhjZ2ul2yJGWG1XMV+8=;
 b=kWAaujZ9JNWUZxIEIfNq2Iu4IXbcfd5Vxw7dx1/0JLDzkNXVdq/x9DMkCTsdBq8NUK
 HRqoiChrOqO7H4Vdbb/Bbu17nxB9Qg6wVbHao3s+6CNP7oTM1cvQo7A+TGw39dMOTd7w
 QSONwBM1ggaEF4k68qKXmngWgEGWj7PakVGMqEwjt5BEwVjq9d3B7kQeqPUpBax+EZ9J
 Qhzxd6LtljlbAAff9Y2YQ/Fl+YzBlYLFDPWVAInldaJb+mRuKBODbt0576JBg7CR3PaY
 Xa9FlG7/SQJUb7wIafJvkrjv4Kq6MytEFfmTQ3lyXUHs5IeRxnQGyNcB4YvDqt2xFai8
 VzJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2HieQD0CuiEOUD0oSb7Ze1iL6WCMLAOqC33lJdZZBg1NexVQ1F+djIhDprW9GeqJIYd0=@lists.linux.it
X-Gm-Message-State: AOJu0Yx5sITF6F9fVhJ48pKXpgrrpkxhwo5TLqyISCebiucLYrqxHrHW
 3p4cFd+J4IEBCIM7uVxtJdPs5oyAi4rpsfq2S/rLEWxwOZzJ7v6nBrp8TsC8fGlNM6KmTcJ+dv7
 3JWGQ
X-Gm-Gg: ASbGncv2tx14y/nUogIaPT4F3wcWP1JvE0o/R2jlU7wUBZz2yjoJsHarG1S5cqmFAZL
 lrzvH2Dg1vF7YsVjK6/Jfx2zNAcFv0iE6nHt8UOq+62pIDkDHuVdSpychVs55pT5n1TqpaFF2Yo
 GrOQT9QcSIScoSw5ouSlBJoBH8Auzp6x4OvoLEd6W9afwoMnwLKkR77OEDuEqYw1RdENiR5jgD1
 ediLLb/JxeVrOAftdGXPidl+IT1jn40J2vj3rZEeo+hMWIcLxvQvBMow4qeEweX5QsVKWCbEzuH
 EpMn2UgHC/PIFVzPB4JpWev96EdhIZ75otLwGHHlE5NgbJB+BbeWKOE4jPPHbg==
X-Google-Smtp-Source: AGHT+IE1Y9J0A1ZgYcYAFKY/bt9fNEg+Palw+GHeDJGLQSzO2M/RcRV+Uij0rf7lIG7iWdl+tnl+KQ==
X-Received: by 2002:a05:600c:1c96:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-450d64d63d1mr162039565e9.9.1748948890637; 
 Tue, 03 Jun 2025 04:08:10 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000f3esm159960455e9.23.2025.06.03.04.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:08:10 -0700 (PDT)
Message-ID: <0cbb1058-a832-4ce3-9c52-5e0db68f9082@suse.com>
Date: Tue, 3 Jun 2025 13:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
 <20250425-conversions-mknod-v4-1-222e0d2e7ef1@suse.com>
Content-Language: en-US
In-Reply-To: <20250425-conversions-mknod-v4-1-222e0d2e7ef1@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/8] syscalls/mknod01: Fix checkpatch.pl
 warnings
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

Hi!

>   	TST_EXP_PASS(mknod(PATH, tcases[i], dev),
> -				"mknod(PATH, %o, %ld)",
> -				tcases[i], dev);
> +		     "mknod(PATH, %o, %" PRIuMAX ")",

%lu is enough. Otherwise, LGTM.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
