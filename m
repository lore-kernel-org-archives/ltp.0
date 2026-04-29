Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC767FF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777449220; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6KfDzk15tModXo5oW8IlV9SY7rukeojngQmwXQoOLc4=;
 b=FlT4txwS9zHTF+Vv+VsLWjHMiP4Ka5DOnw4DOi5Y9njYUpzVdMPts9d1d1GNzMg0414Jn
 xAt6ABBFDPhVDgEuXPi46B9PwTGmM6rlD/SZ8mkyg8gx8jgtnBFXqW+KjTphV1cYE35sAdJ
 N53Du7ERIiVPaRnrX87m8eNb3Vb8S/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52F543E49C0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:53:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DE5E3CA104
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:53:15 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 31B971A00994
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:53:15 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso125534425e9.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777449194; x=1778053994; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3KuAMwIfSMe4uKd/lARsGZb+5MN2CuuAhcSIYy32JME=;
 b=BYUq67m7kqd++v8BWNzkGOw0PUZmRALqezfue9lfKbMMCeg/q8824gmzx1Iuiov84O
 1HFiNpssXwr3HlyGngN15piegGwIjkx9qx1l3p8telRWDar/eTVI/1WXrTOShndTVn2h
 K8oEaRmRjNiEaCIhq7HecLo2zMd0yrdGw8lej3c6Dn12Vii64KFEgqC1tyYJB1Yo4KXZ
 uaI08F2ExDu3cArWZuh8Owg1VdkujbtG75SVubT4osjUzon9QsXLSVF06r+E2aS1M+wt
 4FW8lnLIydNGW4PfL1KNPThYyisvTIREoO5kfpfgNBH2R2dhutnZ9yp6XAmrOkQ4zMfg
 VkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449194; x=1778053994;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KuAMwIfSMe4uKd/lARsGZb+5MN2CuuAhcSIYy32JME=;
 b=bZCh0ayALeSs747zGLiTZVMYJcM64oONycONlqfnkrSOhRy4dLolBjBit763vWCINE
 5c5tLdJ7/Rzg7gjlsaTzU6qHhL2QCZgG83TiCqp8NBFjUN6+lsOzze2EjlqLQptFScb/
 UTPKrRwNrYpp5KU+z7U6r1SGP6xS2e2PXr5NI3ZhnFEghW1ZV/ORv0NGfFUdU/0hsdwr
 2pAU34qyglwCKcFr5cxYFBvLHRuYlCqdkVUpKG9RdQVIUmmzj3EpL9JtvIVO829vosu+
 xDMM7WzDrOqMCol2WQEz1Pawk30ZTmpju2yrEd1JVl6EoUFM7J8wtBEQKYXRpkox8d08
 SGQA==
X-Gm-Message-State: AOJu0YxjTvCbHb9M9RiqA80CivEhB0Z0B/wRfnqgWBpbSzrNtPFeF9/A
 qbSJFXGMTYvwdILytlkbUZOIv6XUkPfZFgs4JNH5AOc0TYig01lCIWgS+kR8epf3Uh8=
X-Gm-Gg: AeBDietVUYRIxlhvivzflxQ9Sdg0c4pxVFem9MyA2NQZuzjYoDl+J1wEbTf+fZ8yZ2S
 cjrv/N7rPpcgu+Nphji+zFI3E/bpiS1kEiCkBzdNiX9RwlZOQrUV0R7A9wgI0NaGJ8uiEqX0CLh
 1K+8oqDctr5NDSEeHWDnzKICi51AfXJ+5KhqUj6Jxw3pzAjqsC9ozLBHNp290NoZHW9j+w3iU/j
 YOGGsnuRPP8Kvmi7kHBFXjkFcI4uF/KaLIQr3pPn82toH8uxwnoYXw5rneAOmz8/K3wu2elTQ3O
 /igukvDsDra+3oGsR4JP16qgr5/ZN0DlHY6KTODsAfp/H6DUS1wuaRJxzQr7RY4kWKogriVejbU
 2QA2IQunmfprrrOBoUgGZd/x7adh6Kj38we/3ZRe7G67ccb728/TRm9kzvZG0puEn0zIgig1bx/
 2XzUw5o72YjyP81XZIX/U80gT5BsN1x/6h6ozLcRpgeaM/qkhFAH4ndGm0sbGHJUSgsF8n5AQbQ
 9JDdi+zfq8078q/MlYJAsorOI/GxBcKjGiCmoD7fyJ/rGjt9fwBAOFJS+DuOXrdd5Kl7C1j0EGP
 IpVCYbyz0OhBGkNQMPchRY4=
X-Received: by 2002:a05:600c:c08f:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48a7b533e57mr35421015e9.17.1777449194420; 
 Wed, 29 Apr 2026 00:53:14 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c319385sm18236625e9.9.2026.04.29.00.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:53:14 -0700 (PDT)
Message-ID: <69f1b8ea.050a0220.2c172.5acd@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260420094437.731979-2-piotr.kubaj@intel.com>
Date: Wed, 29 Apr 2026 07:53:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

I commented the wrong patch. Was v6, sorry. Let me complete the review
here.

> +static void run(void)
> +{
> +	bool status = true;
> +
> +	for (int i = 0; i < nproc; i++) {
> +		int online = 1;
> +		char path[PATH_MAX];

This can stay out of the loop. `snprintf()` adds a string terminator
so there's no issue with this.

> +		unsigned long long msr_highest_perf = 0, sysfs_highest_perf = 0;
> +
> +		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online", i);
> +		if (i)

I think I missed a part here. Did you double check if `i == 0` creates
an issue while using SAFE_FILE_SCANF ? Please verify and eventually
remove this check.

> +			SAFE_FILE_SCANF(path, "%d", &online);

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
