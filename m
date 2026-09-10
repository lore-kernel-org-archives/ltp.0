Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A14C79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 15:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 231693E72E0
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 17:03:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7D53C4E6A
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 17:03:12 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 28F1860017B
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 17:03:12 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-39b2ad83680so2974360a91.1
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789052590; x=1789657390; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3SI1pPWw6EpNIsvVKIwSnC3ESfDS/5am/3QpIHnY73E=;
 b=sYAhgyBQi5Kb4JRJZHFJLh2/HfS5fU4spdx05q29+0Fx/srQIvjGDKJCwEsc7RMltp
 /9A0g3ieTzi4NXzEyT2ydQXUWXbxPodGHO9dCpfPLy74Ruh5PRqWndYnBvKzKQCBIlKn
 AgEH1z32I7iJ4tiC3T0jrPOIg9S6L2xe3om59NfLrmE4jAwUMhb3wvJ+M2g3nGUNy8uZ
 HKRzS68sRG7l8fnCbyCK43rt3VPzLs8b03EJj+jCdNMtx59FJvStXMsfIOwPf/dXbZHz
 vB9TkXEfq89UCR3FP7uu7GmjBHOirJV29u5zq6bzjGWLnt667Dsc0KQ4YIq47Li/7/uA
 2oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052590; x=1789657390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3SI1pPWw6EpNIsvVKIwSnC3ESfDS/5am/3QpIHnY73E=;
 b=D6IE0Y0bxmjIzN/cRDMs/xY6yVbX4v5OeFiYm9tEYCjDIqLtsSxL4CpqyYZX5CZqCL
 dPyhi7BF80ZEUW11DFq80X6+SW1toHx7VTxk6dLBxkHQdAWrgpgkEBnf4R+wBklxgbnC
 8vtSz0Rs1cWMPo3d0GMylLMgyGleWbasEkGIucGtOixn5OrkUQSGGGJcHzLhBv7HrJLn
 MdBCfJExy3yMr8H7yj4SxW5fmJ/M4MZdFFCRnvXKWww357Dtn8dCzz2RvuYvYzzOQiHG
 n5aMFAR2ImZ+yHMGHwn66NuNTUShNcB0v6mx9nc8ubzMZJimynHO94UGSVLMwklnhf1k
 gkuQ==
X-Gm-Message-State: AFuF++nUHlkBJz0hTwThqcDIa5JfHXo3BBSsABvtEUC4ynOg/ASsXUA8
 ZYKAT5g5uVdDEuHWHsPrtxAbhcG7os1QSTvv5/5DL7lpQRke2gJRrsmMKdromCyw
X-Gm-Gg: AYBFou0nzvs2TXOM61QVDP1UUtFxTC3uifPeSQntLxDsyt5CO5ms5lncAYi/LIaRYVP
 DppEETzRwfQCEWn0U9fzWkgWbE/77CsvjwRyuV/vdwynz8ORY98L7JxwmZ2D4G0OjFjLxqR5bXR
 7KYKaWTRFByc9ffBZ27J/DaXcez/FY2/Mhz88bxpCZmqy+EdTIZtIgGxdibzpg7K9Ge66kIK/GG
 bC2pA26tJLYEBlzjjDeUP5gCwGT55i+2/o8/OJBARU7qECb1rMSiqcWYlQIsANGDedA4PDlYBVP
 fg1HgUyY+GlNWgKAOYWl1cDi2AIvXhA7sk5bz5HCYP5reuPWtzJwLcq1XPwhqG/ch071SdELFSs
 zJQ1Q9AoqY1sCPfVK1QxW83TYL5g4iZMHJxhVjMqyYiDhBG6e8zpS152rIVpofxe7jG3m0X3zKD
 vSITinVMDm977Qp9VoIwl1SG/BDyEtjSnaQ6wzH32vxn+ThvBxwCgw8CpzN6p2/sEscg8Lf4vQg
 aS0v7ytGVfc7H0b3imxgQvk4zFzUqgq7yBYnbIIW/joFF79/XzqhyFeme62/OjMo0nitEJnYjRH
 ha4We4jC9a0d
X-Received: by 2002:a17:90b:498b:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39d70c55164mr13262386a91.25.1789052590165; 
 Thu, 10 Sep 2026 08:03:10 -0700 (PDT)
Received: from
 runnervmlun5p.vlhbw3y3jgde1kfjxwvs020s1b.yx.internal.cloudapp.net
 ([52.161.182.123]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143240d86c3sm47847898c88.0.2026.09.10.08.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:03:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Sep 2026 15:03:07 +0000
Message-ID: <20260910150307.9310-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910-coredump-v11-1-e87e2100dbe3@suse.com>
References: <20260910-coredump-v11-1-e87e2100dbe3@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add SAFE_FILE_VPRINTF()
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

On Thu Sep 10 15:27:11 2026 +0200, Andrea Cervesato wrote:
> lib: Add SAFE_FILE_VPRINTF()

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
