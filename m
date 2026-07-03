Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1385CC43458
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 10:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783075489; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=n314vnyHN3CsKvBQ9PS+8v4mgc3lu3ef/RNFiQy8MBk=;
 b=SOKqxjiwt6Mr1ck38toVNEWOsRRXnH21gnVStLXV5ND/CDmqo7oZGClSjfP8BYSsyHzgP
 8uUbBdFZkepttmC7Rr5Rj1K3MRFhbCWqDX8Oq9CLZamc0LgELEMcTEy5jtHgssWQQJmBhAF
 O1ySzqdGTfLjU/URBm9aBy1RzHUvKzs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A6023E9441
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 12:44:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8435D3C5F08
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 12:44:27 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 044972003B4
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 12:44:26 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-493c00f74baso2578875e9.0
 for <ltp@lists.linux.it>; Fri, 03 Jul 2026 03:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783075466; x=1783680266; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/iBNvNWAS6c1jWqLXeGnEEyLPGRnCmab56CR8HkarU=;
 b=PEip9FAzqhWgj4Clv7loif6vMWonUzTlaXyCkeUjo7qQErwD+XM6MxJM9tsUaUkwoo
 W0Lb5EjlJExoVQCObUywR55LuO41rz22FhPEMm6xDNXrOTtv6v344ApdrJOm9PgXVjOC
 vTtdoF1NWGNu2tXfsa3x4UbNnnJ8m/bbnwD7YgKI/N+yPVOQv/xeLxK/bXSJDNDTDEJ/
 911njh1i/wM9ZKSlreRVrNKdW/jtWBU5JF36QnvOstvzuyQ89LvFBylWf1bV+bJMoQ2I
 JBOdjwYU2dgo5qSWItpWd4G4Ji//Yp1RD86zjONzcGhSq40I2UAv1fwISgVEKzRVBbWM
 /R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075466; x=1783680266;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/iBNvNWAS6c1jWqLXeGnEEyLPGRnCmab56CR8HkarU=;
 b=JE2byGNAquJQI1tAaCytfJeWP4H2Z7MHF9lWwMLkCX9jrGcKO+WKjy8XPNEa7FHyrQ
 0vPkTwyzwm5pjfQHxClUEf+3R369JyrS4pCyPtZt2GtvVSHIpEVP2OuPcI0GBCT9+luJ
 6VKr3pcmJzBEpBlauEYjNViIY0LfDZejaE8Nux2DPPB+pv4HOt/FzMC6e1GACVb6sjFO
 F0OuebfcGLSUy/FVPHK4IKicbRppIYQghO/+ZBBeaPqqlLsN2s9O7jJ9zsJsdOsJ/N1F
 FqmTcqNDUcOfslqTWge9vqs3G/cJF8aHKO2UpGJNmiDYbhEGqqy/WW4+w2qBhnRcPOfD
 S/2g==
X-Gm-Message-State: AOJu0Yx3MBosy3lbdNPfpX3NwIamZ3rAqbJ7T4DnGbib4yM3ukKBw5ns
 Qu1KLHSeaQx8P6I+Rhy+C2Bh6WSQeVvaTOJfDDPaPEdcVii41W+kFJHIAtyYAjNcjbKELyxDqh2
 pBhqKHto=
X-Gm-Gg: AfdE7clAFOZUQuGERFOF1jKLtD7EP5vp5/nVFuaT7lpp8SLN7Rp3dsQExy7YG/Edrzv
 5vjXfcJzFa8NlLBnUR32aqCPBRVDy97Q5hvuwZRM/Np0eFzRKP15vzSx30PxpJ3a54qmYmz51Tq
 93h5q6FUEiurkfRLARosZkStc+jOVLaPeygMdhMwgNoaqNq6JW/8k9sxdQGnEMABUKDQ/6MX5p6
 Vb1R44X30jPh81LHf9XhGhcLFjs7woP2qurJ/cXvTArk2UmqSYFHOaStzzrMQI49CQj7/HrP+qa
 IlzHwfFnKNltrangEMJh/bYPdsQmMYAQpJpg7JpMSe8iBciB+GLpNrG1qnDaIfZYj3jQn/jOw0W
 ftScxw1Ag8VnnGd/AUHtrkjGRcKLQgSZMJS0ElpHwRB7ZYeorMhM1bf9e7V8ItHUbcz3j4iAxkE
 SrqDK/nm+n+kzfouugPGC+S9qVGAGjIf39mzyTUjm0
X-Received: by 2002:a05:600d:6450:10b0:493:bdf1:fcde with SMTP id
 5b1f17b1804b1-493c2b7c8bcmr116665415e9.19.1783075466168; 
 Fri, 03 Jul 2026 03:44:26 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bf7efsm124366485e9.14.2026.07.03.03.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 03:44:25 -0700 (PDT)
Message-ID: <846df469-f23e-41d2-a8d7-dbd1d0c63b6d@suse.com>
Date: Fri, 3 Jul 2026 12:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>
References: <20260701080324.19270-1-wegao@suse.com>
 <20260703015745.20728-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20260703015745.20728-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statx/statx04: Skip vfat and exfat filesystems
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

Hi,


On 7/3/26 3:57 AM, Wei Gao via ltp wrote:
> On newer kernels (v7.1-rc1+), vfat and exfat implement fileattr_get to
> support reporting casefolding. This causes the FS_IOC_GETFLAGS ioctl to
> return success, whereas on older kernels it returned ENOTTY.
> 
> Since FS_IOC_GETFLAGS succeeds, statx04 assumes standard writable inode
> attributes (append, immutable, nodump) are supported on these
> filesystems. However, they are not, causing the statx() attribute check
> to fail with TFAIL.
> 
> Fix this by checking if the filesystem type is vfat or exfat and skipping
> the test with TCONF.
> 
> This addresses the failures introduced by the following upstream Linux
> kernel commits:
> - 27e0b573dd4a ("exfat: Implement fileattr_get for case sensitivity")
> - c92db2ca72fe ("fat: Implement fileattr_get for case sensitivity")
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   testcases/kernel/syscalls/statx/statx04.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> index af30a200e..b2a2ac9cc 100644
> --- a/testcases/kernel/syscalls/statx/statx04.c
> +++ b/testcases/kernel/syscalls/statx/statx04.c
> @@ -91,6 +91,15 @@ static void setup(void)
>   	if (TST_RET)
>   		tst_brk(TBROK | TTERRNO, "Unexpected ioctl() error");
>   
> +	/*
> +	 * On newer kernels (v7.1-rc1+), vfat and exfat implement fileattr_get
> +	 * to support reporting casefolding, which causes FS_IOC_GETFLAGS to
> +	 * return success. However, they do not support standard writable inode
> +	 * attributes (append, immutable, nodump). Skip them.
> +	 */
> +	if (!strcmp(tst_device->fs_type, "vfat") || !strcmp(tst_device->fs_type, "exfat"))
> +		tst_brk(TCONF, "vfat and exfat do not support standard attributes");
> +
If we are skipping irrespective of kernel version, why not use 
'.skip_filesystems', that also avoids formatting and mounting.
We can also add these two kernel commits in the test documentation and 
maybe also in '.tags'.

>   	for (i = 0, expected_mask = 0; i < ARRAY_SIZE(attr_list); i++)
>   		expected_mask |= attr_list[i].attr;
>   

Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
