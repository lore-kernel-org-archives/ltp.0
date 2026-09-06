Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F088DC79F85
	for <ltp@archiver.kernel.org>; Sun,  6 Sep 2026 16:03:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A23E3E4B5C
	for <ltp@archiver.kernel.org>; Sun,  6 Sep 2026 18:03:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EB8A3D06E0
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 18:03:00 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5CBF820013D
 for <ltp@lists.linux.it>; Sun,  6 Sep 2026 18:03:00 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-396d27bb2beso2330711a91.0
 for <ltp@lists.linux.it>; Sun, 06 Sep 2026 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788710579; x=1789315379; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gnlglnodLe7GnC3nwrwxPcHQd5AzyIHvwB1opbCZVM8=;
 b=FC+AE04K5mpJB8kuCxv/hf8JXHeHjMePiom8ovX81nMnOMdDefHoyjzQdQTPtlBeSH
 CFHWhbHJQ4jLCPxFAaHYbFVzjk1GtcaT9ByPFI4pvj+wTXnMwelfKAsHgiwCtmfpYmHu
 7dCMjWl/8SokQ3LSUJb+ETUiJ3ghfzNn5N8XZNMtAaaO/2x31ycpN7dFp0aZNrByuN6B
 YZ/CCWrOg+gBWtxx5++cjc1e60DUEOSOkHyl5ojrLQ2yT7kPl/Vo202rds0c6dplIm3Y
 TpyZ5/IMdNn8kH/wHEE76GoyUIanaKdLWIKWOnmOKhSzgv8MY2HCIWvK+2TUNhCIphdS
 x00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788710579; x=1789315379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gnlglnodLe7GnC3nwrwxPcHQd5AzyIHvwB1opbCZVM8=;
 b=LWLrJgVBuBtnpJZhqbrFKRntmcdtsc5Be325zcHzNO2JLNDMB9MqaaPCSqWPKuTMl5
 9hr8SCEjrGLDzGo6qW5KqRqlLnE5WpYYF7Hfxg6Ap/3L1rQojfdlUdtXG55vlU6DlCsV
 WT0pOhoJTIer1UqK8UEVMIWzH1qs0bPV5c6VD3xWEfUBbB98uThoWFsway4jA1spSmK/
 MbbOa0TnTftVvYl06BP88PWt7FdxfwATp7U/IQ2YyLj3Dz3XF+g7eIBBF0wJOoEyu6/z
 dYwC218/jrND/4s4TtwIddBMQMWh0yZTo/+PVy9vct/YSfw3GEEWgzKMt4hs1+MR1M45
 ae+Q==
X-Gm-Message-State: AFuF++kmUnfei8DrrNn+Akk4v7IvSa9hcXx0XQdmJb6I2hCmsMYX6ucm
 blRETnniJRmPCLDmHUDFZFStH/zzvl8X7K8ycsTCvzAjG2PJfsleuatU
X-Gm-Gg: AYBFou09jF4poZqWiRJBnE0B9yyonStf4qn2HGTQ6CaxMJLaqVo8ERzV2aeQJrNIRKu
 ZvBnd68u3DQjTOTwIVeCVhxLp0xZ8ofefXnusETTdPlGil5lW8IgpxrHBvf1IIiVcr7pY4Xcg6y
 zFocgw/AeF4Fe5lryMXyLUZyPYuAMOJJuajyt0m5M9H+GGbnnEv5SdvyoKtxQ1+qjg+URyjhpf1
 wbt1W5UkIe9prQwa6lYJuBQfw2wBEUOtO/VBoTTej2J9vxmKDSXE6pwYIvkZMq6N37qesIjWkf9
 7xF/+CNb0F2qz+JSgKtsssuxh6q1noICD3iY8/LkdpV3j3Sl2CgFt3C3j/dX9ccRMzo/Q/cKgjm
 UIOqmoLsVtTGICZyS0tVSzpJ3kS913bmfRq4QFe7FNMLdKr8RgYMlWybdOcUHpRk+TGdvGGjia5
 ljh6wfgVHE0/SJQHj4ACWbew/1v8br18uoxweg8huLiQF1NDXU/IjOSYz+pNC3u2QyV35NjdHFZ
 p6+xkl7bDz9KIIZbvANx+qcwU1IUyzR8OoBAsS+ADYqnRGWeReP4VBhVk7ASvvPZIhGz2f6Mv0=
X-Received: by 2002:a17:90a:e703:b0:398:d843:cad9 with SMTP id
 98e67ed59e1d1-39b26226de8mr29038199a91.19.1788710578622; 
 Sun, 06 Sep 2026 09:02:58 -0700 (PDT)
Received: from
 runnervmejwal.wxrpj2k41buetg11k0dzziqzpc.dx.internal.cloudapp.net
 ([52.159.226.1]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-143243f780csm19153323c88.13.2026.09.06.09.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 09:02:58 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Sun,  6 Sep 2026 16:02:56 +0000
Message-ID: <20260906160256.8824-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906135650.52112-1-mmenashe@redhat.com>
References: <20260906135650.52112-1-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] read_all: Fix buffer too small for long paths
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

Hi Michael,

On Sun, 06 Sep 2026 16:56:50 +0300, Michael Menasherov wrote:
> read_all: Fix buffer too small for long paths

> -#define BUFFER_SIZE 1024
> +#define BUFFER_SIZE 4096

queue_pop() still aborts for a 4095-byte pathname: after copying its final
byte, ++j is 4095, which satisfies BUFFER_SIZE - 1. Use PATH_MAX for popped
and compare j against PATH_MAX so every pathname that fits dent_path also
fits the queue buffer.

Verdict - Needs revision

Pre-existing issue:

read_all.c:218 has an unnecessary blank line before a closing brace, as
reported by make check.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
