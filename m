Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9869CFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 06:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777445581; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WVSgpKGwiROD7D+33jtYL/lWrJNOTxGTydfZL8Vnj4w=;
 b=PVoI67DklJB/tWm+tzQ9iEQguIpNWkiNWpMliC9Qf7WVlApiTc18/8kMYCSS01m48ChnA
 XUHzXtCo9sIaIkX+RNcsKWcFw1NT3zmrDETw2OQHp+9LHy0NLJYsZARbrKwe6d4zje9+hZs
 wrdyJuoXNtcCEm6qzFBIISrnQnK48Z8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19B0C3E289F
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:53:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDEE03CFB7E
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:52:37 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB2671A008BB
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:52:36 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso7309870f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777445556; x=1778050356; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3FxJDN/tKazaCGzFaLbOhvR6nkpQBZpgeE4cBVjCmno=;
 b=AgSGuBzAAsqVmSci+AHCcgvRRb/EMN9RYGAoEgNFb5sh8ts0fl7QsTSRGxsK3a3SHj
 zOfITvEKhufrT+ZC+CtI8O1oyQ3Cc3xc+hx6k8Vpih/KHmP3kSd77gUO9kfvQK79KGYT
 5nyVdIZu0D0lHR4JXZamNcXzm6ufiNjDbdjgeLUMXT6ONSP+E8qJgbxdnOfdWoZYIyZn
 iOTQI8uIdFKUrQl3cnuv6R/BzI1NhNobnyoOOixYOBWNaZdimtPX4L96FxOUmGx50UBi
 H9msHCH9ARx2LjwkOXzngxt0FspWqlO8TVTz/VxMTSXfXbnpCJ/XNTaLV4JJqBZ2BJUd
 0NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777445556; x=1778050356;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FxJDN/tKazaCGzFaLbOhvR6nkpQBZpgeE4cBVjCmno=;
 b=RMpJ/3g8HHPmEBVZKDCI3LrhbEAbRtrsZRt81S9EvDeKtHU0m+wTejg2GGtYv/ovAw
 XRSA1nduQGHXTGSMz8EL2RAidcyX8eV2Yop6P4L2vShU3SuhSuxjx9Lb0ThaXuQon/Yf
 rR3/jXwc/6q9divmkusAmjXobLsGpFTz/0iV6bVsoxnqA6a2AnoDFv+J6hdgLLtVLk6b
 Aa71GmVJ7BM0mVLSTJpJwHgxZGHvgHY8SpntMm9nuPJfdPOLB/yMcu8hz5sMbX+di8zE
 tSutKggONGqu5LV4OgglNDvZg4ubzK/Nr2+dBoBa+i9zeykwuuxHzsiU854aKL8Vrae/
 pkaw==
X-Gm-Message-State: AOJu0Yz10vufcCzW+DBysoZzzXu4XYbrszSiEuDtky5tPAvv8wC/TsIJ
 UVZnWTjkox0lM719VdB9/VQDi8Tw5PX5PdZ22a2dNT4NJZ5RcknOqCZRilJw3jU58sP34mu1Kdd
 XzLR8ifmAWQ==
X-Gm-Gg: AeBDiet49rU+hSpm7WfPXhlC+FfCYOIwaPOcsDLav4QI+NTLiL/ONfRd7sq+e/gM7A5
 WCp9v7qSKX9Q7WH+MwuWAR8UPyXl4t1Tnr/m+r3FgTJj6QsaQ268+WQgNSqAyWNeq9lQJkvzQ+z
 NOdUXNFInbBPkt9rXE+U76ibjdRY4QQSs9smmIIRlLUuvOm71W30lMdnADR5yY/K0IJQ2FptqSU
 1AefpjaUEdwcVhtS5tzsecrdiTBwp1aaCz9gzvG9e3KdY0WKV3C3Sn8OdChGB146d+wFC4jkD/R
 pmk6fHXIIX4itW2n1AWyrsG5IjiNDnALEkFVYhm2ktuch54Wx7imBwuO7RWdFJ5i1QhiMq0pEqI
 /BZGIbMVHcvTanTVPQpbm6OuS8rGL8BxgIzXQJJy5KfpufwZjPcW/B/OdLGC3ArOY4YNuAsaOuj
 cNvJZHodHhv0xxzMDU2SjTXshKim18Xg3RTzI6nhUVGbsB4WgYgNvgNJ52RmtfGl2rvPl9fp0yM
 35kvcP1UPZOaJICI4J7yU7f9nPkg8UTPvq1Pp6NljpIxQ==
X-Received: by 2002:a05:6000:2dc3:b0:43d:67d1:2022 with SMTP id
 ffacd0b85a97d-4478ee6223amr4372587f8f.19.1777445555855; 
 Tue, 28 Apr 2026 23:52:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b120bdefsm3699213f8f.0.2026.04.28.23.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 23:52:35 -0700 (PDT)
Message-ID: <69f1aab3.5d0a0220.2e761c.6b1c@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260429064011.3200745-1-wakel@google.com>
Date: Wed, 29 Apr 2026 06:52:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/userfaultfd: Handle ENOSYS in
 SAFE_USERFAULTFD
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
Cc: camann@suse.com, Wake Liu <wakel@google.com>, rbranco@suse.com,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> When CONFIG_USERFAULTFD is not enabled in the kernel, the userfaultfd
> syscall returns ENOSYS. Currently, SAFE_USERFAULTFD calls tst_brk(TBROK)
> for any error other than EPERM, causing tests to fail when they should
> be skipped.
> 
> Add a check for ENOSYS to return TCONF, so that tests using
> SAFE_USERFAULTFD are skipped appropriately on kernels without
> userfaultfd support.
> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  include/lapi/userfaultfd.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
> index 0c9e34c84..09126d856 100644
> --- a/include/lapi/userfaultfd.h
> +++ b/include/lapi/userfaultfd.h
> @@ -244,6 +244,10 @@ static inline int safe_userfaultfd(const char *file, const int lineno, int
>  retry:
>  	ret = tst_syscall(__NR_userfaultfd, flags);
>  	if (ret == -1) {
> +		if (errno == ENOSYS) {

This is already handled in the tst_syscall() implementation.
The solution would be to use:

static struct tst_test test = {
  ..
	.needs_kconfigs = (const char *[]) {
		"CONFIG_USERFAULTFD=y",
		NULL
	}
};

for all the tests which need this configuration.

Where did you see this issue? Do you have a use case scenario where
this happened?

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
