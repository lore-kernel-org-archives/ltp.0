Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45F7C83F17
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 06:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753685450; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=mxsIqSY3Z/Qe2F6DbeAPxkfEom/M0/jeNttURDHGGy0=;
 b=AoZAqIe6cqEWDmP4LrEhTr6vpdzv+iz3P2b30QweMJuYP+WZuCOw+7t1I6p9cFA4MW1Dv
 THrOd1b8iRHRx/O9gAj/rXGlrutbSr7WJ90xKNGzsCY8bdAp2kBHXFxWYzuBwNIkvfA/IVh
 tgi6w8Chy17LDZisIz0DdAlwSx5QZU8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A0683C75F5
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 08:50:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4330D3C088D
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 08:50:28 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F054600984
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 08:50:27 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso3728925f8f.1
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 23:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753685427; x=1754290227; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XPpjKasv8vSyJtEJuzv7AEZeSdSIHEKxkR3GqvzlLsI=;
 b=PjwlUj5Npanr75KoNhftG8nOZ3RpyYKDxNuzYZTex07Pz2SFQqtaUQB6OYUmhiq19n
 R6ZwyIXH7DLep07hMk8CODn/AmA+jvCForkixY5TAfKzKn0LwRx9liyNYq1SmB3lxnqT
 DG56Rqrg/13/yWhp5tZ0ogP1+aonnbdCBmnGvJn03N8TYDRAk4Bi3adp2arIX8sdJKRb
 7UnwGIFamLyzQuZGQnPDEH9fto5S1orumpO6LcdUEv/d5ZZQihIedNQrK2kDBKhJ3BxR
 RZ0xLphWE1rEIxeJY8eJSrXGzENuwaLB6AlrQ4yumdLpG47mK9Ghrwz033Y0Lk7FSgmM
 0Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753685427; x=1754290227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XPpjKasv8vSyJtEJuzv7AEZeSdSIHEKxkR3GqvzlLsI=;
 b=XsB6xP+A0i8VTK8clhy4VSzsQ+TMRplNg5bPvVRY8/pZNCYjaX1dcEnyjVMRTzhAJ6
 L2GhTEeOC+eUD2Iab0IIdLrs9VPQ04nV8sUmbC9mjZRn8+irITLHJr13CJA6Gyna5KBX
 2h3ip+Fb7aMG6EPoSwcwDn9njoSEMwezWFcyXT2Q7qwTBJrnO4szu7myzIMrGB0MSaKY
 IBEzIYNF3d36BR9IhFSNVGG31nDTl+RWxHZQ9tOGy12OrXN6VoXC2NLytNmQ69r3UXlZ
 YTqt4NspZeIqQVo/yQvsahfihRqhQxJvizAn13r/lCIy6EvGxbOZxxYrvlvlIaJI7yjG
 eoWA==
X-Gm-Message-State: AOJu0YwcNZYEsrtUZOzeC/JX/CZ/uJnzhus7ez48fSoKKx5uoqa6ncjy
 yzBYzw8VnGdm5MzHiMOfdu4FvyXMir6tBK38B7EVflKTjHDX0uvTFaaiiee2aZOTWc8=
X-Gm-Gg: ASbGncsNeyD8BWRX1V+jlHPRqWXyEcRpE3r6kzr2/AeKQKlgsoR+eYL559Gs0CpCQgd
 HR7+GZ/XY/QtjxWBPCWAnoRr7f/yNjSqYzWDlN2o5YzK/Dzc/NylbYco2w87S2qziokkBG3XK7C
 3wjgISnDPCRiJpYMrddXGoaSgASgg+zIZ/tZuZXy7pzDjh1fYuFfqcLu6iyjbNJ7rZ6+KQCQHCj
 kf4Kim0nkQN3xfG3U6bXtEbI3d0xkX4v+yrbdAaGdnGzNooQSE69KwX96yxB1c0vkrGuH9iXRE8
 OZcpkccc77HQLSz0614QoT7TpnLq9qTvdgTTEjqNDdPp+3CgeXvy02yPQV7RyIBOT4fXz0KGtSb
 ZO+MrGHZnSX+pzbO3rbrfHfG9ZeQnC1L82SSFQAD1XTRs
X-Google-Smtp-Source: AGHT+IEHzyhCQi2NA77k75sNHFUlyZv/U68K0x5VnwHghCj4W8VxC5SZlBH6CNxRRDdn9N8oUZpp2g==
X-Received: by 2002:a05:6000:4308:b0:3b7:87be:d9d8 with SMTP id
 ffacd0b85a97d-3b787bedf1emr2827643f8f.43.1753685426613; 
 Sun, 27 Jul 2025 23:50:26 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.193.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2400e97194fsm21261025ad.209.2025.07.27.23.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jul 2025 23:50:26 -0700 (PDT)
Message-ID: <afbc636d-89ea-44ac-aeda-5d85c5e542e5@suse.com>
Date: Mon, 28 Jul 2025 08:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
 <20250617-statmount_mnt_ns_id-v1-1-d8d81637d73e@suse.com>
 <aIOK5Nm_k8uJjOI8@yuki.lan>
Content-Language: en-US
In-Reply-To: <aIOK5Nm_k8uJjOI8@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Update statmount fallback definitions
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

Merged with the addition below.

Thanks!

- Andrea

On 7/25/25 3:47 PM, Cyril Hrubis wrote:
> diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
> index 503346de8..a52bad064 100644
> --- a/testcases/kernel/syscalls/listmount/listmount04.c
> +++ b/testcases/kernel/syscalls/listmount/listmount04.c
> @@ -135,7 +135,7 @@ static struct tst_test test = {
>          .tcnt = ARRAY_SIZE(tcases),
>          .min_kver = "6.8",
>          .bufs = (struct tst_buffers []) {
> -               { &request, .size = sizeof(struct mnt_id_req) },
> +               { &request, .size = MNT_ID_REQ_SIZE_VER0 },
>                  {},
>          },
>   };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
