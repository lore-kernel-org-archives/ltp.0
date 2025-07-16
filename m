Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F196EC83F1B
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 06:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752648841; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TwoGUv3VMT0vaQlgzG1vT6++kgu4jU2FNar61oyl1RM=;
 b=KPHeTVqTfaLPtaMMUtvTqdTRb4ZV1lD/RkxXtNlr3P11dHamV7gU8dfF1Jqn25TeMuFfS
 xMKktDrQKQitZi89uXEIPGBn5FH2IGXMKXyqkyKefCAqwMZrPJB5bkyvT5jt9j2Cz7dc/6/
 2XclPIY4NzmMmp1XGJBnC+nWNKVNkN4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3B6E3CBCE1
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 08:54:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296613C9B01
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:53:38 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A3341A00438
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 08:53:38 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2923094f8f.0
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752648818; x=1753253618; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WrgKvqvjQ/E2/rI4CIe+pC6csSSk6ZJls8DxS+Xekrc=;
 b=b10jTqDyIdVuAYqLSuhfCtITVcx3EKxPNhYHAY1GK6pjLg4hiS+zD3j9ma5wo6etDG
 YNLbYaxdTknpkCIkNgjnNtzpf0N1Rnn6PUWMsTpD5Mo5Csgn33dhmFEwvIlSbmG0uBms
 peZ+Kl1lpfzX7amc/a+iz9BLozOomj4TSzG4vs/+He3M9B1+fz2ESRWu0EqZjMv0jcxg
 L+CIYEoyrlqLlqNJFhNWFHgpJ3StiVnlYdPR8/x+SwKBWBzrYHq4dgwujBaWVb76j3wG
 TUBYoWPHbt3xbMQWAqx2V2GSVaolZCX2mpMqlhwUKUZQMaLUKaPs7fH4tR2+EL0FmEW+
 6yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752648818; x=1753253618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrgKvqvjQ/E2/rI4CIe+pC6csSSk6ZJls8DxS+Xekrc=;
 b=axjb1DM2Niwz+6LGBlWAvJWuYooCJOjcMvP8djRZpDQqmHVJLO7/yUOYlm/KuNu3we
 RPlA0gHw8Wbgq07Q+jMVnfnpxpwBA1YAZH3a7K9RS0WcWKYWfzpBMZQRvichn7JNEtl8
 9j1SfKdevZEZR2hgh5lc/DO9vDqiuIs4sTwnxT/ZbCwN1/ocnAVnMGYkeNqYNVOsB8bS
 FmSaqdRtaFCbANUbkD7IUviW+Zcr5c1VT9Xrems+MRrbHAg9blIWUiEL6e9XN9XNuJ8s
 DJ6wfojrCpOfvAC7mn25Uh4Io5J1/kRV2iBdkjoeXhyNyc2DdnJsLh62Box/NNKHrTzA
 8T7w==
X-Gm-Message-State: AOJu0Yz04aZvdamZWPrbuWCju41GFSAqqgH9T+vDoUXhuNalxc60edEI
 naTnHBU2ngMkMrpE0B2DNPkXDR60LOYQMzjYbSJiDxsweiVfIg0NSEknvukYNtPLsQ==
X-Gm-Gg: ASbGnctRYHt268wTalTEQ06MgIQPYKbFSZCvz/ZuASYdZ2DB7DvjuTkypZ2xC+lbcTz
 dAPGLe3CpWY3TQ2boGBwqba8Ja8sXiaHDDDPZodkvdAkCGQ3liX/+52N/ji9gVwm7B/OBhYv/DM
 EoUpWSQTvN5u+5mJwEK/tWJBMzw95YFguSPG4ti+8XetqBaMtG9Nvf49Qn7LlHhmvVhIWPvpKRv
 aLhhQI+3BMEo1cmE/dRHJin1CNMiPLR99lk7aXly/z7N8sCZR3j2zdcRyeZzGdatc4etSdd2joo
 TNx35sEd92h/z/1aBNTCJOvr8ucKTRx03/uBVBe3aVwpU6mJRQhw+KBqHrXnqUn9VGhYoxcqLsw
 TnBCBlzxRlit3Oilv1NUNQg==
X-Google-Smtp-Source: AGHT+IHmWD+FUoiZE3M0/rI4JH2TdnbwoobnLV9UtZH48GGQwYjCDssuCwj6lTfIAiodJtbgckmmTw==
X-Received: by 2002:a5d:64a8:0:b0:3a4:eef5:dece with SMTP id
 ffacd0b85a97d-3b60dd7b098mr1164007f8f.35.1752648817636; 
 Tue, 15 Jul 2025 23:53:37 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f1b540sm13123428b3a.74.2025.07.15.23.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 23:53:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 14:52:53 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aHf1BWUqSOEYIe5D@MiWiFi-CR6608-srv>
References: <20250630125509.22775-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250630125509.22775-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statmount{04,05}: Enable on FUSE
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 30, 2025 at 02:55:09PM +0200, Cyril Hrubis wrote:
> These tests works fine for me fine on NTFS mounted via FUSE on 6.14
I guess we need remove second "fine" ?
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/statmount/statmount04.c | 4 ----
>  testcases/kernel/syscalls/statmount/statmount05.c | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statmount/statmount04.c b/testcases/kernel/syscalls/statmount/statmount04.c
> index 7fd4fe8c5..332f6dd4d 100644
> --- a/testcases/kernel/syscalls/statmount/statmount04.c
> +++ b/testcases/kernel/syscalls/statmount/statmount04.c
> @@ -92,10 +92,6 @@ static struct tst_test test = {
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
>  	.all_filesystems = 1,
> -	.skip_filesystems = (const char *const []) {
> -		"fuse",
> -		NULL
> -	},
>  	.bufs = (struct tst_buffers []) {
>  		{&st_mount, .size = sizeof(struct statmount)},
>  		{}
> diff --git a/testcases/kernel/syscalls/statmount/statmount05.c b/testcases/kernel/syscalls/statmount/statmount05.c
> index a517f8212..56a2cb328 100644
> --- a/testcases/kernel/syscalls/statmount/statmount05.c
> +++ b/testcases/kernel/syscalls/statmount/statmount05.c
> @@ -110,10 +110,6 @@ static struct tst_test test = {
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
>  	.all_filesystems = 1,
> -	.skip_filesystems = (const char *const []) {
> -		"fuse",
> -		NULL
> -	},
>  	.bufs = (struct tst_buffers []) {
>  		{&st_mount, .size = SM_SIZE},
>  		{}
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
