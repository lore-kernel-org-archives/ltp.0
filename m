Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94720C54FD2
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785401940; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=u6//skJXiU1svZXfxr+CC4IKAgxOuLrqQSwD4YagM8Y=;
 b=Ev7e3hcmFdF8MPDghuKd/4eDqDumCU1WOXmWOfD8bQdEy6FBfXJTlVM/aPph9IxSYood1
 mja5X9xaIkfEqUTzYaRQsPEg9/qd3AIjvTV1rfnLxzTmhbteC3IE+YFMEBjTafG+MSOPGlQ
 iqmMXSxDXDvkYPX4W7VVKatXVV9W7Oo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C80A33E7229
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 10:59:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D33053E49EA
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:58:37 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AEC9C20034B
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 10:58:36 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so1148473f8f.3
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 01:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785401916; x=1786006716; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZUV9fMKdwqiY8dGaOp1ysyYECB1uVWG6tXVNUyNpJI0=;
 b=RH++5oK1owBReOnfNonX8NiwqffrMvtvewDXcdOmQ/IwJHzZIstxODfUY5ezWcRHNj
 DOduCrAV9pDVvnUc/+Ow2g3MQeXocfkoESryCydDeBsCDTY16TslrS0zjWIUPvZrmM6z
 e1ItdDsayhUZSpCx1k56XU/r9sjO/kAmVwGPj+p2nTpFcXCjl+de4V5uga/fMYpTUXMP
 ACw6FNIMGrWudP9UjCr8kinfj7XdrMkTESD5/1/Ej/rR3nkPfKkY+opOYunL1L+khPzw
 quKVvXVqf8ZPP68BRCYN7J/g/PqVPC7yTFl6TLUHAxUuxw9kypXza4RX4NYottm96a/H
 9zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785401916; x=1786006716;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZUV9fMKdwqiY8dGaOp1ysyYECB1uVWG6tXVNUyNpJI0=;
 b=nylrw0L8W5vj/T9YRFX/NMMGY97Ym750g08J5TZyAV4rz1sCfnzpsrcsAa6M1jtQpO
 pMsAanln9Vp5ICmqqvTvPK+i0t80/cYIj01ibzq1nPt441PI8+Mb+Y1K+XrSmZ+xYdFI
 gK8JhdIsB0z+gNsU4T8hqCDI64RdHFv0z7yPV9Ii+wGNLZhlRoCTW4Q1Nm6BPJJzX21M
 GfqjTfvivLgSMsLrjHesxYIUyi7rI4WGy5cyWrTcvJxdR03mRikK/wq44hCZmYPtNDQW
 HhO2fA05vHW5n+LYK7Frt0H9VBxTKZiaIyeklNs4iqvH5uo2GX9AG7SUefibdMLLk3gf
 g7tQ==
X-Gm-Message-State: AOJu0Yz9UXa978jLTUjFmcrilm/mHItJUairmw7p7XjsXKqMY+L4/0gJ
 Q8dn7cm8fiZGJK1iDmPxp+oCTzm6Lix/CvjliEyATEydMvodbdX8BeVBhZ2ZOLm+yJU=
X-Gm-Gg: AR+sD133/KcPmIrN6HvRKTMVmLsUMgld39CqkQ2DLH6NYisxoNPmEH5AsvwUXL14bDr
 ERiuT/DNub/H6BGCCSEiVoTERZsXb4I6WIloU+a9LNya+b2YzHZVzj2y/lXK74SqKU0g9DqmqKi
 WxML1PoynuxW9oMaeSDyBb9oELp2GlclyhNm6/o/sR5n7UVUFjghpkO2w9KldL+GflZ52wCKf6e
 UIYflNy/aL3J6YP8l0Z1JiNbpS6Kp1Zeo0RnZvQ88IW1Lx3eb/mGe7y07Z2odXLxvL4WR/5Wej+
 hTxGPiWOlrD8dpYowv8CTg73YUDzUiJbVKuv2ecGAzFjpXgIlKqL33IcgIMXBfB1Ue9FLj7a9UE
 2sPeClFoO3E3richtHrROsLsthz+XpJ3ffUc5uFV5NTnjDxow1OmOttTE9oDK92uEYkdrYxlrEr
 eHNh1Xiz1m4y9WsfPOr/aaGYCGn498GDdPgtxwhfkaLiqBZafIz7Jm4tAywHq38vXKwIf1bvwxJ
 T9Ltg==
X-Received: by 2002:a05:6000:1acc:b0:47f:45d1:7b74 with SMTP id
 ffacd0b85a97d-47fc8213878mr2286930f8f.58.1785401916016; 
 Thu, 30 Jul 2026 01:58:36 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc8934ba3sm3952883f8f.27.2026.07.30.01.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 01:58:35 -0700 (PDT)
Message-ID: <6cf41d41-1541-4ae6-84d0-ad6ec94cd041@suse.com>
Date: Thu, 30 Jul 2026 10:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260729095730.29185-1-pvorel@suse.cz>
 <20260729095730.29185-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20260729095730.29185-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] lib: Rename function check_kver() =>
 check_min_kver()
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Thanks,
Avinesh

On 7/29/26 11:57 AM, Petr Vorel wrote:
> Preparation for a next commit.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> The same as v1.
> 
>   lib/tst_test.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 5c3607016e..778a1fed40 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1058,11 +1058,11 @@ static void do_exit(int ret)
>   }
>   
>   /*
> - * Check for the required kernel version.
> + * Check for the minimal required kernel version.
>    *
>    * return: true if the kernel version is high enough, false otherwise.
>    */
> -static bool check_kver(const char *min_kver, const int brk_nosupp)
> +static bool check_min_kver(const char *min_kver, const int brk_nosupp)
>   {
>   	char *msg;
>   	int v1, v2, v3;
> @@ -1461,7 +1461,7 @@ static void do_setup(int argc, char *argv[])
>   		tst_brk(TCONF, "Test needs to be run as root");
>   
>   	if (tst_test->min_kver)
> -		check_kver(tst_test->min_kver, 1);
> +		check_min_kver(tst_test->min_kver, 1);
>   
>   	if (tst_test->skip_in_lockdown && tst_lockdown_enabled() > 0)
>   		tst_brk(TCONF, "Kernel is locked down, skipping test");
> @@ -1584,7 +1584,7 @@ static void do_setup(int argc, char *argv[])
>   				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
>   
>   			if (tst_test->filesystems && tst_test->filesystems->min_kver)
> -				check_kver(tst_test->filesystems->min_kver, 1);
> +				check_min_kver(tst_test->filesystems->min_kver, 1);
>   
>   			prepare_device(tst_test->filesystems);
>   		}
> @@ -1988,7 +1988,7 @@ static void run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
>   	if (fs->mkfs_ver && !tst_check_cmd(fs->mkfs_ver, 0))
>   		return;
>   
> -	if (fs->min_kver && !check_kver(fs->min_kver, 0))
> +	if (fs->min_kver && !check_min_kver(fs->min_kver, 0))
>   		return;
>   
>   	prepare_device(fs);


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
