Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875A5CDB46F
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 10:00:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E23873E555E
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 12:00:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEA703E53B0
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 11:59:58 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 74546200747
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 11:59:58 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8de7bfa31d5so45622526d6.1
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 02:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782122397; x=1782727197; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wuqa6C8aqP93f618+NwqGKQoksP6QxRhn3xP6D9qT6s=;
 b=SDzWE6CQtjh1k7FycLe1nQy2ig3GjGDWpKXFBBlWPFkMgZmZV50+lDAkeceD677EUR
 mRPApt+NpLm8NSHFy9iVczqKYpVjvUCcFkBrlog7sIPovCi9s20a1YXJ5gklXEN7Tzft
 +QmPbO/sUBRIHXLRI4HFM1+K1LUk4ask7ec890IfcXQqmPpSMZbA8U5rb9wBO51LZwom
 LnpyjNJR8MwPSUQL5yzm38r3c7zIRGO61e4QlfhbG+hVfC3q9klY54CVGgIi8xhxdNqJ
 0tct4F9IfglMbJ6sgCr883wTyrJeMycYZhbSuqpKfuI3t4F1ydJKV3HtKO/Kc0axVao+
 0QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782122397; x=1782727197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wuqa6C8aqP93f618+NwqGKQoksP6QxRhn3xP6D9qT6s=;
 b=ZhOyJTO/cOl6NdePo4P0DjUCcm0IEmezUdWob5Gu7VO5rW0bBaAsJqk5kMlYUjliGM
 uVhEGROZivESdq+XinpuAWD6OUN7yquiIUMvFzxono3qTtePgPnM8R2sNegWuaL26DMb
 jWTFFczGqKWykP4HlbHCJqHaUjl18OVcVZZFvQgETOT+4vFpUZ2xcTshULddeaiPQq9e
 lb2l64lsh9m3jHC0A28JGTvNzwzgGv434XdeVYIi6iOwEnH8+gaKFQ7FxT66KDx4rWr8
 odNd+ce7s4b4/j8Sth/unPu1V1qch4E5jh0mRv9Dy41U9YeLxxrQarBdq0N4Cx2DSqoI
 DV1w==
X-Gm-Message-State: AOJu0YyaU7IaKPM+JZwYdKkG+ZDMIAUOkkz+gO0rRVueMDoe72aU2Ntq
 EcrTBypYGDe1Jxg0llYdk6CO6ef12dUw2gG8l0Q0VY3knxIxaBSBtu17
X-Gm-Gg: AfdE7cnN2y5DPSs13uOPfgLYqeGOdpJghkerQY3IKTye/3grx8LsTsT33pvGYq7n9tX
 0t30oL/GGU4kFcHUymGOio6+vLecCEXwcV2wop6a7zRWyhBYiJyVL2SF3+f1Os/syHbSZ05ijSH
 GN+ApYpyW8ZLM0o5j/wUQvM6z/qtkQRjonDHK8fPc0E7dkj8e4aRAnSHGt7QZfekxSNLZDwjQs/
 3JaeTgoPj/pREJQHo3nmnJgaPJREiEhkhgEPYptH6e/JKg0EmGuCsYYt4GPMFxHKAVcnPAqVKzt
 iqaWj2BJ3s9U1sZ00DAjHQVt708C13McL/GkCm1sD+ANqW7Lbfk5kC3X/PVB2bISsR/pX5/eA1D
 oKAK6SE/aVvJUC6r61b/a43TzW/PyDsc0tJd3DgiN06AHZPXuY/rvUW2P8yvRJGAQ2M/5l1sONW
 gmQzq1EOkJ8wpW6rU9iKe78TMKP7NqOTa2wQAlDx/jbMfCA6XWF3+JNej+0DEaMTn/rG8zCMN7C
 3JARRsmuQoTQiJQCtAfx5raC7D4lonumznJPw==
X-Received: by 2002:a05:6214:4a03:b0:8df:250a:5f6c with SMTP id
 6a1803df08f44-8df250a6051mr211940946d6.16.1782122397232; 
 Mon, 22 Jun 2026 02:59:57 -0700 (PDT)
Received: from
 runnervm7b5n9.zjkurybzvyseff1vs2zn4x4edf.bx.internal.cloudapp.net
 ([20.120.84.84]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cde319sm90984796d6.31.2026.06.22.02.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 02:59:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Mon, 22 Jun 2026 09:59:56 +0000
Message-ID: <20260622095956.4046-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622072044.141940-2-piotr.kubaj@intel.com>
References: <20260622072044.141940-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] rfim: add new test for verifying RFIM sysfs interface
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

On Mon, 22 Jun 2026, Piotr Kubaj wrote:
> rfim: add new test for verifying RFIM sysfs interface

> +#define RFIM_ROOT "/sys/bus/pci/devices/0000:00:04.0"

The PCI BDF 0000:00:04.0 is hardcoded. While this is the common
address for the proc_thermal device on Intel client platforms, it is
not universal -- multi-die systems or future SOCs could place it
elsewhere.

The test gracefully TCONFs when the path is absent, but it also
silently skips on systems that DO have RFIM at a different BDF.

Could this discover the device dynamically instead, for example by
walking /sys/bus/pci/drivers/proc_thermal_pci/ to find the bound
device?

> +static const char * const rw_dvfs_nodes[] = {
> +	RFIM_ROOT "/dvfs/rfi_restriction_run_busy",
> +	RFIM_ROOT "/dvfs/rfi_restriction_err_code",
> +	RFIM_ROOT "/dvfs/rfi_restriction_data_rate_base",
> +	RFIM_ROOT "/dvfs/rfi_restriction_data_rate",
> +	NULL
> +};

The kernel's dvfs group also exposes rfi_disable (RW), ddr_data_rate
(RO), and rfi_restriction (RW). Any reason these are excluded?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
