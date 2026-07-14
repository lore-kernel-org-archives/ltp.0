Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF23C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784027314; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WmJQxx5J+he0AIKC4XxY7a1a4UjQnknceuTpGnuBpqM=;
 b=Zo2pt+hjsfeUXdeLY5Byw8DX9hWY+fttEX4/JsxWNF9Vyw3QZcCjV7l4IiNFDX7i8hrZu
 KoxSJdDUMnssRtCaxh22r9Yz0Wt1D2dylCoNoEDxj0NYIqi2nH4C04OD9vQujuN28Nn+oG6
 CZ9//c80QV/fmulcJUyqRKfTCX7Ij/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B99E3E574B
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 13:08:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E329F3E262B
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 13:08:13 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 63905600834
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 13:08:13 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so6008415e9.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 04:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784027293; x=1784632093; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RtV8U7lh+NgygpGXSCttBpTkluATyxLQFMInZqvJLn0=;
 b=ZeMK9yKLkHa6RUOr4b159Swp59IMzpkuDTjtSt7nWZNvhv2v4OLq+8c3WQjiDzP7O2
 wuxuqWH0EzGqkLBhUWyiyLVj2agzUfFbeFSFMJchOhBAsj4BU7MOuIS69aCWYPVFTq3x
 dl8d1xM4zn56VFpJXyjlPaFuePGRQRDE6haYQtmP7RT6/C7yRC+q7bTrZv0E4flh4ibN
 aFLaa6fkLZ8kAOwiX8y5Nglw7h5lJyiBZDvSmsFmTPd5pH2sY2bLIKTMyRgRFD3f83zE
 mBgxSkk9b4RwfBHUaid3HtGHwfPZS26ZpBOimSRka44PxaDYVDMmtM2w7Nc3UQrwEHrA
 beOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784027293; x=1784632093;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RtV8U7lh+NgygpGXSCttBpTkluATyxLQFMInZqvJLn0=;
 b=dij+9JKOlv+xOMpKfM9VMHVOFFgWz7ZQjs3/fVXjn86wkfDsJWllGCUBqg9b9QU7aO
 /B1PYwTLm6IHeOxMLsm3w1dvyFINoNNYdZcCQOoF1AyuTJMh7KwJvSc6jJv5n3oGv8wR
 MTMb0WMCq9Aptzko9pOAn8ibP5NkhN9bqghUuHSgk4c+98mzXZEeSmYL3DKH5ftgO0xy
 p77ygIIizp7TCio6DA7Dob91HR9tQ+feb7tO0HBKQIrSC+/0yhcQ7J5xc/OwehzGk+ah
 i6iw8zUbcy4wsuc6JEJeUKnTH4FzoIj0VFDprlZvcLHFqayXYZxce1g3/14kP3vhdT9X
 NerQ==
X-Gm-Message-State: AOJu0Yy7AF8YgJ5Ik76x0ejcqlRmV3h6hAWQgeQUNG7i7yRxrIWVC2AV
 NarFuZoYXkyd8wQehE5i870YyLZX8yO9CWXU4/UBzklCNRbTdBu3fsV7MEvIEpItSvSb6A2Eku6
 lu+N0nCH8Lg==
X-Gm-Gg: AfdE7cm1XapwZp/mLd4jJTmPI9xGC2kFpZ1XOUPTA0jQ0Swqxc3AXMZZh36IQ9uclUd
 dqJUvmuXXidRBb7YqRnRKBhVT6XxDzf8sY/H5+1p9zdAxwg7sH72HnTYMSKHd1DjexFCQzgV+MN
 wRPonEsJM1AIyAhT7JDjOLZYPyS+H0juuEHksyZBM+/TNkbB98+CYZr6itUwPs1rmpTsoJZFMzO
 eQ9MlPYuu+U1ixj1Dmj8bhVHVyhMYx6JRg3JIHgDJ3RpPIiTyh6t/YSe9W8rMl3KYiXBN9R0hOl
 hQb7RhJvk1p7hpEaUK6vj6/v4yMsf6sUKCPHu3Y/EQGT0ilEx32921qhXe2vxmCCWO2pE05/WYw
 R9bJi815oWann7j1G5Cp87FdR3/Pd21YsSU9TBL5vI36H19VZ7uZ4+KaDRGYUvICXysOj4vMbIO
 oaRMwTeIohDG9qL7yILq7r88NAI/9p1jbFcICe
X-Received: by 2002:a05:600c:6387:b0:492:7142:f46e with SMTP id
 5b1f17b1804b1-493f87d8583mr144609965e9.2.1784027292635; 
 Tue, 14 Jul 2026 04:08:12 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm385403905e9.2.2026.07.14.04.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 04:08:12 -0700 (PDT)
Message-ID: <6a56189c.d419c4af.35af2f.7b5a@mx.google.com>
To: "Gang Yan" <gang.yan@linux.dev>
In-Reply-To: <20260714101454.8784-3-gang.yan@linux.dev>
Date: Tue, 14 Jul 2026 11:08:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] generate_syscall.sh: add a helper named
 tst_syscall_base
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
Cc: Gang Yan <yangang@kylinos.cn>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Gang,

> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch adds a helper named tst_syscall_base, it can check the
> syscall on older distros without tst_brk.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  include/lapi/syscalls/generate_syscalls.sh | 27 +++++++++++++---------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
> index 19f280dfb..95c2c9aeb 100755
> --- a/include/lapi/syscalls/generate_syscalls.sh
> +++ b/include/lapi/syscalls/generate_syscalls.sh
> @@ -49,18 +49,23 @@ tst_brkm(TCONF, dummy_cleanup, \
>  })
>  #endif
>  
> +#define tst_syscall_base(NR, ...) ({ \
> +    intptr_t tst_ret; \
> +    if (NR == __LTP__NR_INVALID_SYSCALL) { \
> +        errno = ENOSYS; \
> +        tst_ret = -1; \
> +    } else { \
> +        tst_ret = syscall(NR, ##__VA_ARGS__); \
> +    } \
> +    tst_ret; \
> +})

Do we really need this? If we don't define memfd_secret, we really want
to get a TCONF. And the function is used in a weird way.

If you need to add the support for memfd_secret, please just update the
syscalls files via:

./include/lapi/syscalls/generate_arch.sh <path to linux sources>

We don't update .in files manually since it's error prone.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
