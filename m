Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B59C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788421148; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nK+5gXUmQKvs220TCPjTmye0qG4awY8QYrzlM3Msel4=;
 b=iTZWrE/R7T1v+xsSEEhPusaPbu4WzOKtEh50iPSWNzyQrxCD0fZCMLnsMtbDvBTFAVTcU
 a+6we0OvYPyQUWP/K1LnIlkXBjM0QhF0v8yy1Aw6kJFsEscpnSDxOseAEVaSF93n+spTO8o
 V3BzEUVOVzpyb1FJk52zsOw4ZgpjP6k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E58963E97C1
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:39:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA4713E93A2
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:38:47 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8984D2009FA
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:38:47 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-482e257a23aso1408855f8f.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788421127; x=1789025927; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mZwdEPD97iGbgPCNwBxVnHbAtfDuX8OvhSImVaYg93I=;
 b=CoLVuUsNqVqP4Xxb8dXcdmQjzcrhGiDSUVbCvcFom8OuOlKerRI8SKZK1XI3HSgwQP
 HcLqcRGjWjgP2PS+hNDuXjAaMFlVuB7+ssrqVnZ/ticm2iPXJ5crytI0nBPTFiEMbW7H
 QngbhoTR7/P8ZEfFq9vk3AJUcp8nhG4ghH4Bh4RubCEq9iWKe5ZpRuTKD9xPLS5y7QJX
 KkASywR6Y3PUq4PNPpygXyerRzKsZDYWCk8AK1kQ9W9Or1U/iAX7yrztpUIwiQaXfHRa
 D0Z+KCzbGapwgLOBm2UKxisWdwih1+LmBeWgw4JAg0otqEAq3YaVcWur4e27ufaX6PW6
 D10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788421127; x=1789025927;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mZwdEPD97iGbgPCNwBxVnHbAtfDuX8OvhSImVaYg93I=;
 b=MW+Wyyme4Js2pxnWH1Dg8To8DDz+z8KDl+xM38NYmlIpee78nXtYeKslcIwLygdH2m
 zMEie38kN9LWS2sV90sOPmyuFK2lFHvi4sGVoqin+dl8Y4EopV0VC90SN6LPMAqA7Q3l
 VrN2jXbPIMwh1GKOLLiZl1vP20gdwR8HynLUnQWbpn/rd+w26JwMS4yeViow9E1S5m+G
 b9l4PWlvKpw5vhvL5otk3K19qu1PIwdxKwZMP0FVnAS31wmmVmi+9/PmM9n7qqCJkoUS
 7gmd7KK9fBS8lnWP9CGajCj2YYEc/P+QXgqVNk2JXuPDvz+ZSZtjOn2xj12qZOhMIo83
 yvjQ==
X-Gm-Message-State: AFuF++kNnIW/Rl0/wHZzUQeDsndcOfeVeyG5XON/kIO++njWDQ3xMp1Z
 hgJ77hn6VaMaFXHbgO6vM9KZiq6WYGAzautxLpTZvdaUOPcCkd+xgkVkKLmRorVyK/o=
X-Gm-Gg: AYBFou0VMfu60K8QATXwy05aJRurWPOkQxD49L+m/Ihuht88TKH3FL4+xndnD3o3MZL
 ocWIH8lXrYcvT7KCgDBimzgu7+jh2hhAoGzNDJSXJdsxfW1d9m/JiBq+wFSk9BCHiUrQTq1n7RO
 gliJcMq1lJKh3aZH2XsvLQ1AEmEaVAh8mxAmixd0OEAolin+iKnRJE959pJLuh1r0UYScZQNUnn
 oNl++Q6ALzeZ0kKR52uBIoxiorHEsDzm0LYSHeLks90UQIXriunBBG1qYgTnERwFbqkLRSuDwIb
 Mx15oNfjkmGSXTRVD4JzhV+D5YXBTlfIBcIXy2vkXLevqLpbn5V9Fg5LOUQzpuZmsHaZVW6UTDd
 YEkVGzMseK5iekzBnj8Dx8iuaQ7EBBwgAl045Y1wUM6yjBDGvxSi/dAJNi6BiUdRW9pkM98OKYc
 za6E+ruMWOGqZcz0nUbKYIaUhdU4Wf1C3xZZTigyNgIO3hU+i2Goej93Ir/6+fdqrXWyO02aDVe
 8NhHZ0nWRnO
X-Received: by 2002:a05:6000:2610:b0:484:3311:4bfd with SMTP id
 ffacd0b85a97d-484914be599mr19948187f8f.26.1788421126779; 
 Thu, 03 Sep 2026 00:38:46 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eeae34sm12666529f8f.32.2026.09.03.00.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:38:46 -0700 (PDT)
Message-ID: <6a992406.c70771d4.a9d0c.493d@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260903-cve-ghostlock-v6-1-a3272bb81e4d@suse.com>
Date: Thu, 03 Sep 2026 07:38:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] lapi/sched: add SAFE_SCHED_SETATTR()
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> -static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
> +static inline int sched_setattr(pid_t pid, struct sched_attr *attr,
>                                  unsigned int flags)
>  {
>  	return syscall(__NR_sched_setattr, pid, attr, flags);
> @@ -169,4 +169,33 @@ static inline int getcpu(unsigned *cpu, unsigned *node)
>  # define CLONE_INTO_CGROUP 0x200000000ULL
>  #endif
>  
> +static inline int safe_sched_setattr(const char *file, const int lineno,
> +				     pid_t pid, struct sched_attr *attr,
> +				     unsigned int flags)
> +{
> +	int ret;
> +
> +	ret = sched_setattr(pid, attr, flags);
> +
> +	if (ret == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"sched_setattr(%i) failed", pid);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * SAFE_SCHED_SETATTR() - Safe wrapper for sched_setattr().
> + * @pid: Target process or thread ID (0 for caller).
> + * @attr: Pointer to a sched_attr structure.
> + * @flags: Flags modifying the scheduling behavior.
> + *
> + * Calls sched_setattr() and breaks the test with TBROK | TERRNO on failure.
> + *
> + * Return: Zero on success.
> + */
> +#define SAFE_SCHED_SETATTR(pid, attr, flags)\
> +	safe_sched_setattr(__FILE__, __LINE__, (pid), (attr), (flags))
> +
>  #endif /* LAPI_SCHED_H__ */

the header is used by sched_setattr01, so I can't include the SAFE_*
definition in here, which is the right place, since we are trying to
move them into the related headers. It causes a build failure due to
the old vs. new API mix. I will send a new patch-set with the
sched_setattr01 rewrite.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
