Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E9FF532EF
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774341229; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0l4ZspGuT9TxkEEJ5HiIX7J81uW2FA7oz1147Is/FqE=;
 b=SIMyNjPGRW5esuiNQzAlZ4Aj6eXJigRUJKU+Nj4cq5iHfsJef0iuYVUfzhS4mmZSkPHeu
 qoOP3rjWVls3zKzizpB+ej6zX9bC6LHRU1JwRdg4fkcW7DOGK6eE10BP6irLpytFv7OJxDK
 Gt1g2Qhy6C/r4M6kJUV1BSGd6ecrlbs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 866213E26F1
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 09:33:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1466C3E2257
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:33:25 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 501F92001DB
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:33:25 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48704db565eso27792685e9.1
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774341205; x=1774946005; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vUmldIBO0TqL01t83CUMGwcE/M1yn2wxv36awN4HcRI=;
 b=VZJKUvhbMK4AGL9y2VGnsBmXXOztpWyC6FK7tADtasM4cjbc6+POAniNv4V01lhtOq
 BfXBs74BQFxrNISEG79PJWE638Zz54apAuVIbqrDX61twnwnrTCI/TJ5Zokqa50nxHpj
 dygVWxICgBypuCRZLqkzMU5R1lZgMJv7bbWbqbj2nnNQnwenxiRyIOF0Hg/W8oj6BNkq
 A5siaujS1oI6jLiNp6Xc5TrswVj6gFyPOQuY3p5P9eRIzz7pywczw0cQYFFPpC6wcpxU
 EH+CxlVRks6sluXdFtKc/1ftDUrgml9cEg2hKiBV+RzUGpaljIbv+J4rnk4WmtxQAxJm
 ytUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774341205; x=1774946005;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUmldIBO0TqL01t83CUMGwcE/M1yn2wxv36awN4HcRI=;
 b=FCSo35bOrtHR2fvMfruPOwLatROv/wr37E/iMdl0Vqax7T33l8gTcSNRntGLZ9ybSj
 kYO+f4iR+aZnlVj0/wCyuQTGtXQ4CT46YS/ElfJ115YdohCDIQc79ofbs2xF5CvsWAri
 BJ//ZYcmucb6VNgIsvKRGthgwJ+mYa6HmuF6LylFfHf/heZEWNnApiHEzjwctbgpty6P
 FQXew93o6toDje74oRSJcQVaoLtANuGTFxcHzRvb2WWxBEI6vcqvZY3/8lhnrJBd6mjc
 pqXm+pHJyZO4FYWj3lgJVZ8o6roO4q9m8U4kJI8TK1nRrR5fVeo2DkQq6jCtazFDOE5j
 xPRg==
X-Gm-Message-State: AOJu0YwE26lJD9AkZEuTipUrJspv/LQrHBY4MMTYBf2uRPBO4pQc3bb8
 ydvB4YPy02BQB3bWpORoKBeMVZsEoMdlN6byVHJibsFK4D1Rnq4DZ42SBwdKXk8oTuk1rLP8gir
 ufDOk/Kg=
X-Gm-Gg: ATEYQzxzQmrrsJRoeMl29n20EWc2FWbNsgk+5PKfHXXyAtoSrfUCe+zv4JDAqJNNRCj
 KooEoWDdFsD7n6AaFHzHRopqOIQ/oMOq5RyQZ3oW4b+5NoNmxyVGPoj035rvnpn47OHJ0q05WOF
 vA9eJ3j3gTFlK8Yk0zZISJxKziSamXDR5xz6Wr5J+yGnScyvHAc3ADmmbGLLuqhR2E41mUyYanQ
 +wjBlf8c+BusMic4p+7+udDBFLQHNJwn6U7bA+HHNJR9Ki3vI4iiSrf2s8c3OD1popB1dtPSKAj
 mP7pZNyCjwjh6hcWe0cXMmcSy63L4c372rVSDGKugu++d6T//UKOyZqmuCe3e+25CNF5TOgr+kK
 jcleKFuP26eiE5hTQC+Pn4zeQplsovrgp447a9JNV3Z8wZ2nNqCUBOEchKkZ0g4MYPcHmG+MKe0
 YbaFSozmS6sgGMaYU0D/K+fOFBsDBTwRk/ueNDGfnjiRFnG0uG+keUUlkx3TByZrGqN9Bb896Ly
 DUVtNhNpTzASRSN3W1PVbOlpD/mAB2GJK+zyqWxj7euacEjFz8MJKk5Mipww3YxqJ16hd/IGnCR
 ZA==
X-Received: by 2002:a05:600c:35c1:b0:485:3b50:fe54 with SMTP id
 5b1f17b1804b1-486fedb2545mr250496575e9.11.1774341204678; 
 Tue, 24 Mar 2026 01:33:24 -0700 (PDT)
Received: from p200300ef2f4fc9009d1d98240e97e0a8.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4870f6c0fa6sm16372405e9.1.2026.03.24.01.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 01:33:23 -0700 (PDT)
Message-ID: <69c24c53.050a0220.eec9a.6546@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260205135724.23772-1-chrubis@suse.cz>
Date: Tue, 24 Mar 2026 08:33:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> diff --git a/lib/tst_ns_checks.h b/lib/tst_ns_checks.h
> new file mode 100644
> index 000000000..743d3d09d
> --- /dev/null
> +++ b/lib/tst_ns_checks.h
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#include <unistd.h>
> +#include <stdbool.h>
> +
> +static inline bool tst_user_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/user", F_OK) == 0;
> +}
> +
> +static inline bool tst_net_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/net", F_OK) == 0;
> +}
> +
> +static inline bool tst_pid_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/pid", F_OK) == 0;
> +}
> +
> +static inline bool tst_mnt_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/mnt", F_OK) == 0;
> +}
> +
> +static inline bool tst_ipc_ns_enabled(void)
> +{
> +	return access("/proc/self/ns/ipc", F_OK) == 0;
> +}

I know header is used only once in the code, but we are missing header
guards in this file anyway. Otherwise there's a risk to break LTP compiling
if imported twice in the future.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
