Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F85D12689
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730805635; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=XzZmlfTNa2spdd5PKj1VXVEPio5mLAs4ZZBA7C8Qt+M=;
 b=MFXgoCND07LRvcKHs1kij+flJ5IvccxZCW2aTX0s0UjtzjEGbGfVa3ghg0DWq4iEpL94e
 BAkClUPFxwQMnWpNVLKsPu4qoQYzXofDB65WaKAlBbM5Ks0sGlcgvx2VmrFp/eqO2+KahWw
 pLLVbprWaPQLcPlamcsqvaQciRzC2pg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F2493D20A5
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 12:20:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15F933D1AD2
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:20:13 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EFD76209E34
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 12:20:11 +0100 (CET)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-539f72c8fc1so5083813e87.1
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 03:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730805611; x=1731410411; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZDt2ni0fKkNmv5Aa6UsbfV3/S/TOMToYs7XV0p6xlpU=;
 b=eKEuqurWcJXNvv8+yReVG7sMvU+YS716LF0yE+S8XP7VfNDjPvEme03g8RMuWrQvGP
 YaNl0qMUH3MDfZZh222YCTD+gHBXYRrOyTqRDG3y/Vhb/x/z2PNAB7opiqFS//owVHaM
 c6B7vHEXr2SlvP4SaQ6TB+Bd61PMp3Yxtr8H9cdemqUTht07dDjE72Coz1QABo0nvceP
 gevt0u05lWnVvk6bwIJp1NqmAc5lJrX9vCJqMh5iPBnesE+/bmXZZ8PGMUUCZLgDvBJ5
 Z7tMbwb6n+V3xm+/5q/xBC7vvsp0r7tr4hJskf+Udzfdl22I9zqikhFZPpk0bVTTIymj
 p0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805611; x=1731410411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDt2ni0fKkNmv5Aa6UsbfV3/S/TOMToYs7XV0p6xlpU=;
 b=r27qM0Uk5p8RSIwNcE9jr6/B+I1sEzGakmprb1uZpNeCGaolS76G86nvNGOiw4g2F3
 aVwiP2cPB1YJ1Kec4e/nCPqH2BqxoulDWBHuCjUqDxxzK5NXPERsti9wxdBM9+dcZKu7
 cToMLzymA9xKoQeiwzdxT3/GS/bw/ENvjpgWuJuYYqwg5XI4l+lQC3Euuyn8DfxZGXpt
 o8y5qMIAf3u6O4Cj0R/tznD99rBzd++gTZ4i2solpbp/akU/ULevzLQ5MGLt/RaClJmj
 E9MhevHB5fJDv+i3ZsJEGjZylh111p4q0c0Ag+NgeCynPAyf6sdx4WqPTIlpGEtBwquE
 qa4A==
X-Gm-Message-State: AOJu0YxlycGeHxrZAEfYdDRykqvYEsLznD2qsgXHa/wa7fNxoxTvEud+
 rlZTP6+wTFiEcZ4fIJ4nDmwP+tbHt00pmZ9TkB+BomORuzvkipuRtV5wlkk8sHyzHdqC6scWUdv
 olAc=
X-Google-Smtp-Source: AGHT+IF6tYeS0zmvujCUnKVvJOjd9Rsg+To5CqhN54hXuRstfE4VPMgIlE4C52ydIT2EYgVPQqIiUw==
X-Received: by 2002:a05:6512:31cc:b0:531:4c6d:b8ef with SMTP id
 2adb3069b0e04-53b7ecd5232mr13460642e87.6.1730805610695; 
 Tue, 05 Nov 2024 03:20:10 -0800 (PST)
Received: from [10.232.133.32] ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5e8562sm185114735e9.23.2024.11.05.03.20.10
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 03:20:10 -0800 (PST)
Message-ID: <279a334b-6ba2-4edd-a0e2-3118401a2178@suse.com>
Date: Tue, 5 Nov 2024 12:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20241105041326.18531-1-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20241105041326.18531-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi: Add new field socket scoping to
 landlock_ruleset_attr
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

Hi Li,

please check my latest landlock network v2 testing suite, because the 
paradigm will change due to incompatibility between ABI v1 and v4 of 
landlock implementation. We need to simplify the way we fallback 
landlock_ruleset_attr.

Andrea

On 11/5/24 05:13, Li Wang wrote:
> Mainline kernel commit 21d52e295 ("landlock: Add abstract UNIX socket scoping")
> introduces a new "scoped" member to the struct landlock_ruleset_attr.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   include/lapi/landlock.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/lapi/landlock.h b/include/lapi/landlock.h
> index 211d171eb..5fb6d3755 100644
> --- a/include/lapi/landlock.h
> +++ b/include/lapi/landlock.h
> @@ -19,6 +19,7 @@ struct landlock_ruleset_attr
>   {
>   	uint64_t handled_access_fs;
>   	uint64_t handled_access_net;
> +	uint64_t scoped;
>   };
>   #endif
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
