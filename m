Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1EFEDF14F
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770978350; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RBlsLnqhPFdsw71nZUVzF7thfdAqQOjiw24kP4If0fg=;
 b=lgKLMbMaRVmfxKOFJRQO8e0tW+PH1K2pzk4RXWf5JEzxh5MSyXczWhsnbY0RPkJTBJe2S
 ncijCX2qLPVB9cYYbaxYiEG+YWknScMTYaQdZRrlF+vJeuhSVLZ+sbbWZk7ZmoOD1E2tAcD
 +Dggf/p7PbVKNNHcueAcy09fddFw5ik=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC60C3CF7B6
	for <ltp@archiver.kernel.org>; Fri, 13 Feb 2026 11:25:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72F033CF124
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 11:25:26 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 97E851A00F77
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 11:25:25 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4837584120eso1961895e9.1
 for <ltp@lists.linux.it>; Fri, 13 Feb 2026 02:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770978325; x=1771583125; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDQfHVTRQv4xMMrS4p2AANAIh8A+HqLCnJKkkHWQVC8=;
 b=IREv+Cr0z8yYmJnar2KiwYUiTqSRKHI3uGgRwyDUq8w9/V1DNOPEwopvq/zslrMDGc
 Bj11gDDN0c+GvQha/uxopr84naBE2OXdIn+PRINdraaSwjtqbG4CcfL5oDBzGVscr7ka
 e+x87PxNbREgLy40JuHUKRcM4QDapJMPt/5MtyFCty/MjY0OqXwKO1bwECmEtKrXSIko
 hfaIdwJ/pgSYvlAz5baXG0kR1sdFC6Q6pO2YTpQobsiPrOHLPLjNb13q/Pesuq2ZMsqj
 ldnsYz3LT7CZTBN8TAyQRyv4T0pDYwJ3H5zekxMOLGnuCsDUE+v39DRs9sZNN+MIHuH6
 X/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770978325; x=1771583125;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDQfHVTRQv4xMMrS4p2AANAIh8A+HqLCnJKkkHWQVC8=;
 b=YTZuvgDlnezkM4hETtdCeiI2GVWIOE+FytaJSVaEE0gX+HMw9L0goK56gk4lgf140I
 nxe1+e6/ptsVDYiZ1K8NYMgmC2olckdrMlKrljJGQNY+mOolG7bGwZxk+TYxVjfYjgyG
 zvydTAqEYCxTGhO+IuO9YFnV90k9nOU98jjpSO2joXZvCnR4SCRHe9j1m8+XYo7Ntccl
 PZcXtFEDPqIlVGfo52+q3XtVhwUx38T6k2AVwtFjXfo9LkO6clRNSTUTETyXkfeJcTqd
 EEdMQKgMtKhW2vsri1wdkKyt6CIIGXQ1SZDhn1RYA4cXrlyTvHm6t+Mxa1RAsBYkwcip
 MtpQ==
X-Gm-Message-State: AOJu0YyBNU+9sqB/OZbQGbS2s1qopvM6bt2EfyZSEYW+gd9CL8Q4Zg/J
 acU8GZF+XhWbjtw6iX4cq/1Cnu6OLLJUun5TDIAx4oF9AzGUwWoDNFC47pHpmK8qUtk=
X-Gm-Gg: AZuq6aILVfxRfV2aldhsdPJ1nUkRHYw49ExerjMSBsT/CKHDyjCXED7vrpNIQj+IB29
 vkQdej804vqO/MjVcxrea6yXXc7frYx5CB5OwOdS7z1G/eLcFCU6f6YVqduWsAaTQj6hwBQYRLB
 vSS29MLOJE99infZQEgD0yhG8z6Heu3OW1dYEEGhEXYHBj4wyDr1Whtjf6dyjSWiwdF6qpGYWak
 /8XXDHt3twu2P3sXUE3vemyR1qrxjkbhR53REQrt8324WeGYbQFUHht79gy89IzXlcvQaMl8klk
 yZM50kLG9Mil6iRyO4RLL4s3s0oYY2EgxCYomTmZle6lMaiSBaZZtkLGig/8G23SZs5/NCFoD+c
 iZegj7HHhPOMULteM8zDHTCf9zm4mRtQOZh3R/dgDefhjGWI7gMxIaY8rsP/ADd6jYE5kg7PXg8
 RQ5un07ay74ZD3Cy+XRXBLb6TPfbM76q0=
X-Received: by 2002:a05:600c:1908:b0:480:1dc6:2686 with SMTP id
 5b1f17b1804b1-48373a0fe51mr22641915e9.13.1770978324823; 
 Fri, 13 Feb 2026 02:25:24 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4afsm461893315e9.11.2026.02.13.02.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 02:25:24 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 13 Feb 2026 11:25:23 +0100
Message-Id: <DGDRF6E3INEX.3HLBEYJ7CXC0D@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Wei Gao" <wegao@suse.com>
X-Mailer: aerc 0.18.2
References: <20260125063035.31171-1-wegao@suse.com>
 <20260213023801.11713-1-wegao@suse.com> <aY7ulL28AnCh2qP6@yuki.lan>
In-Reply-To: <aY7ulL28AnCh2qP6@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_pidfd02.c: fix clone3 EFAULT in 32-bit
 compat mode due to sign extension
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> There is no need to have the (uint64_t) cast here, the uintptr_t cast is
> enough to fix the problem.

aggressive static analysis and future changes might require this
cast, I wouldn't remove it just because compiler automatically cast to
it. Also it makes the conversion explicit and more readable.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
