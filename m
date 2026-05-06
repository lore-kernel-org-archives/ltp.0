Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69BACD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C4393E6164
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:47:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 694D13E6157
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:47:41 +0200 (CEST)
Received: from mail-dl1-x1244.google.com (mail-dl1-x1244.google.com
 [IPv6:2607:f8b0:4864:20::1244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B129B1400BF8
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:47:40 +0200 (CEST)
Received: by mail-dl1-x1244.google.com with SMTP id
 a92af1059eb24-12c1a170a50so8504853c88.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778071659; x=1778676459; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SK+FsaCLgbmjyd7GA2xVFG9pU/vXVMPcOZf7sQmGA2c=;
 b=mi3s93lQnDyRcL2y4y4gXs5338a3TFOprGyGafbAnmrBWj6GLwmhvaMxN7kGV3Flh7
 EgmgFJWX8EpgM3vWUOlIMcJMnzfrs/5kuNEjW9KWK2QtOwzR+6ySm71AV4I/O+otcyaq
 osORojo4B35jHNkhbQjq4AiWtBxPF6jFtlIJUVWRbWkNUB4w+mxk+pO7Jy7s1D3/FEnH
 yo2xaczV5OE/NPFiG5d4DjpZCnZKL5z+aMZHr4icHzL2thFBuIyXd+7yqhHcSPSM1CH/
 dtI5OFgfpzvJDBI4Z2TZwE9y5VHx8cDMZIcD9zbilKGXAofaZn9ed6BoPgHdGRWLrrwv
 vLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778071659; x=1778676459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SK+FsaCLgbmjyd7GA2xVFG9pU/vXVMPcOZf7sQmGA2c=;
 b=B1BDrb/6JFd+ALqN5hJxeNQVGqtGdfClGSAZVEq0VJtP3KGUZ+pBxlnZ5no10EW7DU
 ZNLazoixReXIarHssDvg9BYo+ZCQVUHWaiwhndLu3V02IBmGWAyaJR3REfq8WlHxdV2h
 kpbWBk/fLL2uZ79iQvuBB/su4X6NtK6gmYfCrQbJth1SNKPlvRLHOS8xsf8PVzcwq+5c
 G0CYnw4dQKSLobX+KCZ7yXfPSbE4UuiNhkjTWjmQ6K8n9S5oAsicf2Ez/j5aRl/5cJES
 FgGWySw66BFRx8oFI8gqlRCUPPHB5ciJtelPKH2qoIOquIvaqIWQa3+cfm7XjQfbpgDV
 /0gA==
X-Gm-Message-State: AOJu0YzecRTMo7qu3SR1sVaAgbEWyWzpizUUGP10/0pdVkaXUJrROj3L
 GgAdeqp4dDDpjGkAhnzHNJY73F9kCN3T6YuLfl4AIVHD5SC0FRFKqge8KY3CoAaInL4=
X-Gm-Gg: AeBDiestIzgrGk8eHnqLRZMcA7jv1vX9hNl1tb2dOdFxNuU7yM/IP8Vv2StPVXPs/pZ
 9ECe01FYtJ6/0Yk7PXeVaXelFGaLvyi/Vf8NWf8VKAoTh9VpOwCQiha3YMrf3xv4VlW/FNNwKT0
 sy5JdXld3X5A5vyGycbATSLURZjB0bLd2WuckEyo38hoYeh5QvmUFVTNZeKrBL2B2c7tPcct3od
 rDa4z09+a+m+/Wrxh9W/alZmub9sVhpkKPwBZKiKrBe0ZLmk4cgut9rqPuoxU8/lrrpIk+eaEb+
 Y8dMwoxgzCB5nRUqDm7Ho20R1zUfCqzzNlar9hGR/PMDFo/uzP0fvs3bOijcsHQVZ9Gka4/H2mH
 +mL/XN+oEqOVuNTxRQTH4vwtqk+NgDp8dUJoe4iT+SfNxKXj5DT12S+vNFDbqHWDEhYEuFjibq2
 Z8XKCy7SsIqOg8Zu/Gawoe8XVRE6oltQ6iTUneDgGiw7WjgQesPC3rpgWJnLQT/zQlVh4AIUrMy
 hVkPBQYFwooTiWZglxeXgkSMYp0GRGm/Da228YrnkMMcAZ4/II=
X-Received: by 2002:a05:7022:322:b0:12d:ce34:3fa0 with SMTP id
 a92af1059eb24-1319d14d688mr1526620c88.32.1778071658912; 
 Wed, 06 May 2026 05:47:38 -0700 (PDT)
Received: from
 runnervmeorf1.jdewmzakebre5puvwiecsuzmmg.yx.internal.cloudapp.net
 ([52.161.178.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13202db2c11sm3674606c88.9.2026.05.06.05.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:47:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Wed,  6 May 2026 12:47:37 +0000
Message-ID: <20260506124737.3866-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506091035.59822-2-piotr.kubaj@intel.com>
References: <20260506091035.59822-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

On Wed, 6 May 2026, Piotr Kubaj wrote:
> cpufreq.c: add new test for cpufreq sysfs interface validation

> +	tst_res(TDEBUG, "Checking whether scaling_available_governors contains \"performance\" and \"schedutil\" after switching /sys/devices/system/cpu/intel_pstate/status to \"passive\"");
> +	snprintf(path, sizeof(path), "/sys/devices/system/cpu/intel_pstate/status");
> +	SAFE_FILE_PRINTF(path, "passive");
> +
> +	for (int i = 0; i < nproc; i++) {
> +		...
> +		SAFE_FILE_PRINTF(path, "schedutil");
> +		...
> +	}
> +}

run() exits with intel_pstate/status still "passive" and each CPU's
scaling_governor still "schedutil". On the second iteration (-i 2) the
status check fires TFAIL immediately, and the governor branch hits
tst_brk(TBROK, "Unknown scaling_governor: schedutil").

Restore the status to "active" and the governors to previous_scaling_governor[i]
at the end of run() before it returns.

[...]

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=502943

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
