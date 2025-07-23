Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4085FC83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753274650; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Z1z2MzipeQdLpV8VMS/TnotEXB/g6/a+LYCusJkhDfc=;
 b=aQ5yf687eAee4PLKZQlZ15kaAdlkMOaDbuHPk4XRqJEZWJW6LoBr0daTt6UNzZJy+ALuf
 mrNAk+zIGsL34OXZVVq4ixMV7P10NpFaUmNkfsQuKwIyal+o8At7XpGWef0FOo1/S7/CTAV
 wWJmYtyIWWWJtIR7hGuwgB2LIpPZtGg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEA503CCD5D
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:44:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 889B83CAF64
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:43:49 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DEEB81400217
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:43:47 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3987042f8f.0
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753274627; x=1753879427; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A1EacV+nSar2YoVwg8+/FNyqRLVBD2ByKE4k0ZHyd3I=;
 b=COo+173Oe1zuA5QEC0MPdxF2Ld6ZC1We2MXM3PqMB9Bi5KBC0Aott6tTQUgJ/52XvU
 gTW1ydLn8n2AgYttNJen1G9CSoElpRGmmEixtCwTs8yThpzf8X/KbC2e7dKvd2V1IFgg
 s2SSEz+w4Hk8SroNJ9xU9Z3tlNBhFB9rCvO5TvggSGOKlM7At/XDmS5TBOAEKvCcyXWU
 2b/h/8UH3nRf9+CNgkj8jVjd/5smtFOCNmPUMsqGpDzXCxin8bvioXlxVGDCey9wMeh9
 /9Jz5UzKAKR4U8rSK5g46o8YNM4n1MjYj2wYq6IeAifP6d7VAGvG3La7L/fP7NRqwfcf
 hF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753274627; x=1753879427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1EacV+nSar2YoVwg8+/FNyqRLVBD2ByKE4k0ZHyd3I=;
 b=jDxTb0mPcK3SeX5fqJbunzRW0XXpcX/3A590a9Mkiy84fBn4931NLyQI2BwhdnSJ62
 h4z86Yt/scMXiELbxx79ewZPoTF1+999xVvqlohJEWMPaxTlUzXMez54d0ODu6ISj10H
 7v70ynH+WPqzSdCfGhOB/h49ga271J63Xb2JWyv8jqCrOBY5ysfr/I3P9rtqqlCVAu4r
 4L18cB7Fk4PJ0TvLig5ybc/2ja+SWIFn+UVZ0RQvDcQKJhAEt3zD5gu9kFsYYsel0VJS
 rLJOGsdE3+O6YC9ffRY36cYXcy3IrJzDzpU+7SskmHZbRmLzQgF0cNuNc4ZeQXbf/gEw
 KyhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtl5QAGcqDtyMt4E0mN1DMhGEJbFtrNb+xeOz2aj/JWDz3Hw7MrUcrWoDL99Qf2O4Oy2I=@lists.linux.it
X-Gm-Message-State: AOJu0YzVyHfxDQLHGJCIZEPKV1zR0gIKp0r9lcMq4zWuaQVFHm2mic44
 w1Fqgc1rq2Za8yx0rSsD/FDjBEQux5NUj3KBIPUbyBCTWI1GZWyQ/ECi7jJbS5rlgCw=
X-Gm-Gg: ASbGncvPRj5VoH/Rjmp0TYLFpvTTE5NwGIesrJP1z2wdlsKruYW38k90YhLgT6qbwvc
 iV58k/MTSDFUq1Nht6pUyRQNHBuC8JoYlbAR0gg0PTI4nvfFXuwYlS+01MHy5gVvYoHDCp0qwUC
 StwDW0DB0KfmncQkdUoxt+WCc+/g7AhdEuWvcW+Hf97Z1MkktJAU3w6aPtfSXNcz891bFXZ9m4h
 iyHq/0EuTh/oj/YOgSXz6FqzkXtm+6W0cBlOG/O1Yhm76b0BgXc1b6kgX0hMv4e90wlHjrfDyRN
 rn3RSBHm3odYVDEH1yLphzpOaYZvYrbRiXmnqzs89hviAqX3CZSgIkVWjEm+Zo7iHZINbrrwmVf
 EewEyIos5Fb8J0QRPN+7u2GynerUwVFqMTC7M0RUBU21QdJIW5FGJ1SKhTCYyv4LEPv6NJ+UXZr
 3SvHQdSB9vlZUIDsmarf0wXtttAEpDrxhDi6E2f/yF5hxCMZDZO8LouRxI315AeQ==
X-Google-Smtp-Source: AGHT+IE4N1HNnlGKo+mZZy+hq9Ti9/FbtfR6qOuYx9s6rvjbKSiDNr2UwIE+z1zByJsHm/SqtO7kYg==
X-Received: by 2002:a05:6000:1447:b0:3b5:e6bf:5d5f with SMTP id
 ffacd0b85a97d-3b768eeafcbmr2383935f8f.23.1753274627172; 
 Wed, 23 Jul 2025 05:43:47 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6b4af3sm95598575ad.85.2025.07.23.05.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 05:43:46 -0700 (PDT)
Message-ID: <3a8c2634-09d2-4d29-951a-4e5c5b1adef1@suse.com>
Date: Wed, 23 Jul 2025 14:43:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
 <20250723124127.GA154226@pevik>
Content-Language: en-US
In-Reply-To: <20250723124127.GA154226@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/23/25 2:41 PM, Petr Vorel wrote:
> Hi all,
>
>> On 7/22/25 2:06 PM, Petr Vorel wrote:
>>> +++ lib/tst_security.c
>>> @@ -107,7 +107,7 @@ int tst_selinux_enabled(void)
>>>    {
>>>    	int res = 0;
>>> -	if (tst_is_mounted(SELINUX_PATH))
>>> +	if (access(SELINUX_STATUS_PATH, F_OK) == 0)
>>>    		res = 1;
>>>    	tst_res(TINFO, "SELinux enabled: %s", res ? "yes" : "no");
>> This is more or less what I was doing at the beginning, but Cyril suggested
>> this approach which is more similar to libselinux. Please, check v3.
> Sure :). FYI I did check v3 before replying to v4 (I always try to get to the
> context looking into older versions, I also noted v3 in one of my replies :)).
>
> And yes, I think you were right, that's why I raised my concern again.
>
> But ok, to quote it here Cyril's reply in v3:
> https://lore.kernel.org/ltp/aG5v6enhdqFGgiBj@yuki.lan/
>
> 	> +	if (access(SELINUX_PATH, F_OK) == 0 && !tst_dir_is_empty(SELINUX_PATH, 0))
> 	> +		res = 1;
>
> 	Maybe we we can do tst_is_mounted(SELINUX_PATH) here instead. At least
> 	that seems to be what is_selinux_enabled() seems to be doing.
> ---
>
> Enabled SELinux means both /sys/fs/selinux/enforce and mounted /sys/fs/selinux/.
> I even checked to boot kernel with SELinux compiled in but disabled in the
> command line via 'security=selinux selinux=0 enforcing=0' and the result is
> expected: no /sys/fs/selinux directory.
>
> Both ways of checking are OK, just "access(SELINUX_STATUS_PATH, F_OK) == 0" is
> the quickest way (given test requires just SELinux enabled, not enforcing mode).
>
> This can be changed before merge. Or, feel free to keep the original version as
> it also works.
>
> Kind regards,
> Petr
>
>> - Andrea

Ok thanks, I was also thinking that maybe we can verify if certain LSMs 
are enabled via /sys/kernel/security/lsm . At the moment we only check 
for selinux, but eventually we can also verify if apparmor is enabled by 
looking at the list in that file. WDYT?

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
