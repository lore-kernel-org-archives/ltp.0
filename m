Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE53ACD8CB9
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 13:28:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 835F63E6E73
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 15:28:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AB723E6E72
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:27:52 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4CBC5600706
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 15:27:51 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-1382533d428so892936c88.1
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781098070; x=1781702870; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIqiFTA3FyHNEXvgmhPjm4DeVLTFroC/J+g0CGfd+9w=;
 b=CBPNWn4aYvBfvC5ZdjEtZRCUEYLW5UstD2LUlAKXGmUXqAJzQVfujw+PEvqwTjRghp
 jHCOpHDXgi6xF5qAfffJeQODj1Y+z/jZlAqHVL1auqb9XneBepoQycEO+jRcJd9IybFD
 GKqq23JqLjS/Zb0rJwFi1oRck8lmg2DlrVqweMbEPZCEBzaWS/5XHGiwMsgP7V4WmXxL
 bVe9hlZuGNiGk5Egbxs3ime2Q89idtbxysh8ahKJNdZkJbTLRAqLr032AjInvoOoyGN+
 ws6V9eP0K3TlkzYFMXergHO/HKlITZ6u/a1jK0PCYz0myOh8bIVb/XI8LqOGU8taNYM7
 yV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098070; x=1781702870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vIqiFTA3FyHNEXvgmhPjm4DeVLTFroC/J+g0CGfd+9w=;
 b=UAWSl1wMG/EAa5vPtqigDCZ1EW8M4N6u6cR1puKiv93YH5UoyvcqN1R1+aYrfDqFaZ
 OMrumF46hFddDVqlGUdvab5ujpSFT1ZCWXjXV3j8aV7s1UG08CX+GgEo7gZLVtoL3N5t
 yRYYQGD/3Tksc2jWot+pgO4rO+4PRcoi2kqRLT5AF3+U0HndJXGOw3NN5baeEUY9BDVN
 VVDXbg7wwDMtnmLrzX5NABH8RGt/eeicGdpuJ6lwGv8k0KEjXtgcjOGuU2nHgjcnm+As
 zSoMYyQoDgEkW9ar7QCW2EmSV5ujNOhE5S9xa7GcdG35b92KX2CfXQbF7QxjtMu32Fkp
 REqA==
X-Gm-Message-State: AOJu0YxQPiaEpkRHJXX+ilUXZ8leKdepHsULRH1fnbqVKabxQLv4uzFt
 G6OhCq4r39WTKwIs7kzwKiFvoH1h4ztuJOuQKnNZvIi49dGPomCk49S3
X-Gm-Gg: Acq92OHAbH1IM/maco7b9IUpv9WXD3kRaPMvisheBnoXvicf0szmaVwUkquUly/VBy8
 csduuADTznOAMJ2jyXSsvUq3W7oP8DMv2Lxu62Es7/QLQL+vRKXcAAMYJQq481VbglQUwnASbd/
 UZeLPNYf7dgVLyhWM3N80h8dTObXL3QgY2H+lehabbRtAufMqaj4l88rdQXJL8w2s6fOOUk5/oc
 a1s6B/mXuhLn473te+5rA4G/zr/asjETmCD6BHJsh1EaIyMJiPSRn7voc/Qr7JfV14sRqgSIMRI
 1zFO9h+eUpqbI/LNpV3/3KZJT0qbWVUq3vixApPCsyzZwJ0v3iNcM6YVuBBdPRpG+VdK8m8WEWB
 VWk+34bGbUEZea1kAYL8gkBTHvrvlDTb99rZ0it6J3CnVmwptPgCj7ZlKhE7R1akBGB4H/b+Ss8
 gYZx+W3oFVsLid4W0HzVyZ8pe0Lh0HapZ4Fa/ClKXtl7b+kAX+3+HSX6sdNHQO6qI9j8TZ6lzQy
 brF8RPwGASEe85/8Ykxp4jPW3fg4GF9dWwO7je2NYoLhwjq61/ciw/HZQCGEzdk/Q==
X-Received: by 2002:a05:7022:609d:b0:12a:6fb7:87e3 with SMTP id
 a92af1059eb24-13806727e05mr14694792c88.31.1781098069282; 
 Wed, 10 Jun 2026 06:27:49 -0700 (PDT)
Received: from
 runnervm3jyl0.fsbdu2ptzlfurncko4thihjhgf.phxx.internal.cloudapp.net
 ([172.182.213.146]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f548ade9sm17891286c88.2.2026.06.10.06.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:27:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 13:27:48 +0000
Message-ID: <20260610132748.4098-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610-fw_load-v1-1-df9d38315e38@suse.com>
References: <20260610-fw_load-v1-1-df9d38315e38@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fw_load: Modernize ltp_fw_load kernel module
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

Hi Andrea,

On Wed, 10 Jun 2026, Andrea Cervesato wrote:
> fw_load: Modernize ltp_fw_load kernel module

--- [PATCH 1/3] ---

> diff --git a/testcases/kernel/firmware/fw_load_kernel/Makefile
> b/testcases/kernel/firmware/fw_load_kernel/Makefile
> --- a/testcases/kernel/firmware/fw_load_kernel/Makefile
> +++ b/testcases/kernel/firmware/fw_load_kernel/Makefile
>  # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +# Copyright (c) Linux Test Project, 2026
> +# SPDX-License-Identifier: GPL-2.0-or-later

The SPDX tag must be the first line of the Makefile, before the
Copyright lines.

--- [PATCH 2/3] ---

> diff --git a/testcases/kernel/firmware/fw_load/fw_load.h
> b/testcases/kernel/firmware/fw_load/fw_load.h
> +#ifndef FW_LOAD_H
> +
> +#define MNAME_KO "ltp_fw_load.ko"

Missing `#define FW_LOAD_H` after the `#ifndef`. Without it the
include guard is non-functional.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
