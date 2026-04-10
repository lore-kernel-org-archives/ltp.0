Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96803F4485A
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775826909; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=yvjaYA7tAhjzfgBliF9HnMljqhUK2gn/iD6D7L9PWXI=;
 b=rLxsnEGYIqV91rc2/Ff9JymNGoCLd8cLOYBCFHKykkLIzQL+2O/qKtWNJ0KBGRXPqc6Tf
 ZbDQAmCFkN+bvoYYTLvIuq/S+wHGFqvcVdSSaQFjfEQlxCLacpqenSTj636OAto2iaSn0d9
 ialz0rS6N46/Mz4mw3y0i6YgHcUxQRc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CF9F3E4C19
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 15:15:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C245D3E1565
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 15:14:44 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 32EAA1000941
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 15:14:44 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so1275220f8f.2
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775826883; x=1776431683; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=d+lT1iwnND7VEKhvfC3wTkutrIuYkVRvp2kZ3bybcZg=;
 b=ERoseXg1sskuOZlT5an1I2Ssl6bX/FYAuP35ikJv/MP7vppZlmoEW1WgdQIRbQ6ZY8
 hSGk9CCUGIx8x2n0haLi3su6pRbzs2bFFhMVz9qmXMYtT+oqTpmQ4ndo39wAtUnujLFE
 0xq4WUxqL3Wa62OCj67Hu59WOYVtKss5s8RaY5jHfbA4sHQSdYZkV1T2w/dvNJzZXn/6
 SrxsB5WvcRD+OZWO7ji4kHNgyBcQgaLw2xtOWKxmRa771S63RZs6+vjZnxGf/QZF3L3H
 5IjUxiwEpv/vV9qHMAwKi9t6FgIX0bTGP2rQW12HOSAZL/xp1z6lABpztGbRRfKcW9PD
 LLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775826883; x=1776431683;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+lT1iwnND7VEKhvfC3wTkutrIuYkVRvp2kZ3bybcZg=;
 b=XQQ7ykgJKI8Alj8Zg4YSZ6etkOwLK7Rj8NhCMhYwyZABNoq8mB5YnFKEQ+SWD7wAeS
 GdSdaVU4bkN5KD9auLybLhJxCoFVGnwp1OAN50d0o8DMWK0grTY7FRSxDiHTeBe5QMMb
 hZUKsmTPnfnFpnWcy6M2vfaanGxLkhW6KQZRbaHfUCxmh+eHK+sCiP18lxxKhGdxDel9
 6hem4k+9hus+x2FP4A5JuodC8UlETkBOCzHfvJaueKtQOWJqtPsay9QLdr6yrD6Wkucc
 9lL95unV2m0BNA61054SpO3Mb2MdSJg6S0QzK5KwhZYaSGyTw930Ul1JYVRusDHW1HKS
 E0Zg==
X-Gm-Message-State: AOJu0YwU1AqcAhcLdyNLcJDdDsbbxmh+aPHK8b/Wfvopkyht43n13LLh
 tKQZ+TKEODdXTFle3I47rPhRIfWnGQZjyo24B3Xskg7Nw03OVRX1z7kTalC5/2okcA2Mr8In3RJ
 xr3mSlmAAfw==
X-Gm-Gg: AeBDieuXevJcK+J6XbJi4GNbS5u1ZUijf1KxApFUoN7G9syRSWbsNpoQHOvHSIZolx3
 R32Nm74B2YwAMrxB5w0huAcek717ISiwHPBADMhgfQeWviRQJQdHOhMPjepEUuP5kOhayIwyyFb
 RKXvkIpak1CYZQNLFzyCSITXw6i7teZOrRFH9iQQfPBv8/xTGDGfP+ZnsX35TpzIYkUb+AUclpM
 aUEGkxbU/1rsk9e09TNpfIkX7SDEVG60ZS2rS9snJhUG/fkgSaSFNHv7HV9y++hAt1BDWOOcUNY
 q0KUYpTRStmr/qITseBz/Gq7QJx0Is2tchFSDhsucv1MCV00LcoExZ0kFkrW7axlEjEfDF5+RKS
 jTR2/Cf3CRmFu3DiyjJ3njiEYZWBdXJ7QDWcZu8+RgtWvOA4D2wV4Kx714RKtmnMe70Hj0hKFmA
 SjwhTXciJClL9Z15xp5VjKsbv2YuC/uOyqdcou9rG7wXlcoS+PIsuvk33ZFrw7u0TZbxKwEeBv2
 BrWXt1vCT70xmg+sqDrc2nmrgBwhwJlzE/o7EN7prgKGg==
X-Received: by 2002:a05:6000:26c4:b0:43d:3088:76ab with SMTP id
 ffacd0b85a97d-43d6423d2f2mr4448938f8f.6.1775826883218; 
 Fri, 10 Apr 2026 06:14:43 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e462fdsm6962661f8f.22.2026.04.10.06.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:14:42 -0700 (PDT)
Message-ID: <69d8f7c2.5d0a0220.1f0e56.6472@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260407092616.15563-1-wegao@suse.com>
Date: Fri, 10 Apr 2026 13:14:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] shmctl03: Fix 32-bit compat mode failure by
 forcing limits
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

this review is pretty accurate. Please follow the suggestions here first:
https://github.com/acerv/ltp-agent/actions/runs/24074831444

King regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
