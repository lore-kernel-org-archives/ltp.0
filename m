Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE79EC5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:58:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D5F43CE321
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:58:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 93AC43CDC08
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:58:11 +0200 (CEST)
Received: from mail-oi2-x00.google.com (mail-oi2-x00.google.com
 [IPv6:2607:f8b0:4864:32::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0AE271000533
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:58:11 +0200 (CEST)
Received: by mail-oi2-x00.google.com with SMTP id
 006d021491bc7-6b1342d8cdeso62347eaf.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787212689; x=1787817489; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U4DcYR1r8A6Pb/ovi5pI/iCbMSfks76sgI+NcBjX0o4=;
 b=ZHzSH98j/KXJKuDPyjcH3hUYCszYO/kuNRP7rtgqi3revIupHJPicO/jTZrPHR4ryI
 /R43fBIjbonwSxoA0+3eWCA1YNE+WOPkRZm/l63GZRSKceixMjKbmCUNkL2ca0WGC54K
 bZbZECi9BuCZTKePvrha1waPK7icHQkbUygbKh/KrjsP8rdLtfqLhPoB/9SvPvzQwcDr
 eS2G9oGPJU8lm+A391uVY+nJLZ72D0yDRDi+i9/9hOwyxfBnkg+Wr9wUhO5TkxabY7Ez
 vRh+CzRodIOTM5lkeEhG3aJ6SnKLI+QS7+Gtyog5CeY2CnoijtzyvDDly7ut1A9IVQEw
 a2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212689; x=1787817489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U4DcYR1r8A6Pb/ovi5pI/iCbMSfks76sgI+NcBjX0o4=;
 b=GaAeW0MopsvmPMrTmKtI5t9rFVk9exbjh4+rZiwt1kfiak+n33kGOyRrnRLgiC6iMy
 wzJn/QCoVoL8tyUE1W2SKhMGruN/vcbCMikAumku/klv50Fq/60eW/GgowbyqxWN3HYw
 FO6r+Q3PpyGbtNns3rj2N8HuerqH30biZDedNVobuXSjIGBZLO4v7IxcniSoMtG4SYAt
 nm4w4k8vr7O5vficvzMECjEbgv3OZXx7hrX8KQS74nnxnPIn03GLJXUO2tYtr84if3kz
 oOB9vKHlQfuWC+yBA2NBYDOzBNGxtAksM8xPfM4JQKRbS1kTKXKP/DZzvJGC8zxOYtJK
 dQuA==
X-Gm-Message-State: AOJu0Yz51HS7JRrVU/7Mhw2MsPmOaDBL/81/2fKqGXZOP058TfwuoxRb
 SO+JTCD04eqeKN6XXKgeYZNKPwIekKGwP1iAYrwEycU5HQAzFrFnphP83jmlK2Gu
X-Gm-Gg: AR+sD10+FP0mqd2meOqqbiMNv5LltSvi5NFXjWZ/JCW9nJLLhpVPTu02X7ay54OAMXl
 dv3yEOSatsfKYNeHthZq0ioI22eIxmAMObwhMz5Y3VSVb9DxAqhnpqJGGyK9/mrkiZ4wgH+bFEi
 2YaQ+035mBHROMruDev424IipRUlobsDa4OC2uwk3rOC7uhvnDsAFG5hgIYuVvEI8xUnsFgfdMj
 YxRjQBRp+lfaWZwZxZwm+qedMkRVXU3dnDh1Ts6dsLED4V3lX1Zil92bmKLh9NfSMCPjHs4TvVc
 5Bdzm567PosEEZxJNpD6rTrlbXYchTJqaxMd/0gZE75KB8Wqfcm29jpNNs6q6Gyhu4vqkFQYwJx
 WuveY7ynjtro7fqGtNBaLACbbVm5GXXMAI2HPRWk/R7I8pM5OQ8EfvgwSjassqakO6j5/xjMkJK
 +iM+ESKp2+1SBnfgUiLPtEOuWKWHCaYAoFwt335m+v7CeFF/orwDtY65/2Mp7av1g1Grk/5uCuT
 MOKCKDrBtBX2oPJZp5Umu6XFL7J9xG6Mti/0OIPIxF0DafybOwA156xGTjb+6L29jdmyMWkq4d7
 0Q==
X-Received: by 2002:a05:6820:1792:b0:6ae:8ee4:e01f with SMTP id
 006d021491bc7-6b13c2d221bmr10635600eaf.4.1787212689584; 
 Thu, 20 Aug 2026 00:58:09 -0700 (PDT)
Received: from
 runnervm76f27.vtumybzwn5zupfpawyogdsmmte.qrox.internal.cloudapp.net
 ([158.23.19.38]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13c90d160sm4658469eaf.0.2026.08.20.00.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:58:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Aug 2026 07:58:08 +0000
Message-ID: <20260820075808.9294-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819161634.1341577-4-chrubis@suse.cz>
References: <20260819161634.1341577-4-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add tst_sysfs_assert
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

Hi Cyril,

On Wed, 19 Aug 2026 18:16:04 +0200, Cyril Hrubis wrote:
> lib: Add tst_sysfs_assert

--- [PATCH 1/31] ---

> +/**
> + * tst_sysfs_exists() - Checks whether a file exists.
> + *
> + *
> + * @fmt: A printf-like format to build a path to the file.
> + * @...: A printf-like parameters for fmt.
> + * return: 1 if the file at the path built from fmt exists, 0 otherwise.
> + */

Since kernel-doc section labels are case-sensitive, should this be "Return:"
(capital R) instead of "return:"?

Could the stray blank " *" line between the summary and the @parameters
also be removed?

--- [PATCH 14/31] ---

> testcases: sysfs: sys_hwmon01

Could the subject describe the change by adding "Add", consistently with
the other test-adding commits in the series, i.e.
"testcases: sysfs: Add sys_hwmon01"?

--- [PATCH 15/31] ---

> testcases: sysfs: sys_leds01

Could "Add" be included here as well, i.e.
"testcases: sysfs: Add sys_leds01"?

--- [PATCH 19/31] ---

> +/*
> + * Change the link-layer (MAC) address of an existing network device.
> ...
> +int tst_netdev_set_hwaddr(const char *file, const int lineno, int strict,
> +	const char *ifname, const void *addr, size_t addrlen);

> +/*
> + * Enslave ifname to the master_ifname device, e.g. add it as a bridge
> ...
> +int tst_netdev_set_master(const char *file, const int lineno, int strict,
> +	const char *ifname, const char *master_ifname);

Could both new public functions use kernel-doc /** comments instead of
plain /* comments so they appear in the generated API documentation?

--- [PATCH 22/31] ---

> Similar to sys_net02 but checks bridge related files after briding a
> virtual ethernet interface.

Could "briding" be changed to "bridging"?

--- [PATCH 23/31] ---

> +static void cleanup(void)
> +{
> +	if (tun_fd >= 0)
> +		SAFE_CLOSE(tun_fd);
> +
> +	if (tap_fd >= 0)
> +		SAFE_CLOSE(tap_fd);

Since both variables are initialized to -1, could these guards use the LTP
"fd != -1" convention instead of "fd >= 0"?

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
