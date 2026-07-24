Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6337C53200
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 17:56:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 047783E72A3
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 19:56:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC4543E1C8A
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 19:56:28 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 095E360042C
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 19:56:28 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51bfca7f85aso4738751cf.0
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784915787; x=1785520587; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TBxqd2Pft1aqJXwZEJLTo373fE6s8oGyRFibg7CS7vo=;
 b=iAd8rTynez6vvlAFZCws/z2E4N2N14spY3MFED1JG0v3pnLf/L2gz+ETSO40xG0lkA
 RQEvsRcnsxbCOOofZDCOrs2Bs8ezhMqNdySGHceK5NiBsbYBtRDolXutdDePoXydEekf
 2DJMdZlpJL5VaFdVJVKh1BcqQ5EErXi9u+aCoynL2Hd/hAdN9CYnzhQBSyTGQxKCTQA1
 QQ02O7aOBrAtVdz0DqjToNJuPi3rdeZ7CcR7Cm4Hgh+1f6tRjNOBtjkEn4X3OVwfCewf
 pQ4hPH+Hvk79e8uy3up9/JEM4MJgdRsVjpaZT7S09XpSa4hIpGnhGF9FmSyIrJUM1itc
 sL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784915787; x=1785520587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TBxqd2Pft1aqJXwZEJLTo373fE6s8oGyRFibg7CS7vo=;
 b=JJEsGX0phHGmT9EZ43QaKSbLExyBwdDIsLVWj5laT6sgNcyfmooc43vTCdcc7oUntk
 M6nubndUtmWoQhuoVJH0k6VtDEyLodzvkj6aKUxqm2Id0Kf1ymW/7ShEk0kxHmfvYDLB
 E8XNc0/unrzcVWC2mM+Zvo1rDo8NElM7zY+dJVrP+4HyLtPZSNOZp6AvIeY1hnpQlWRY
 qQRF9bTtvqce0WAr5r5kcyyZF4hyFMt2M7xgqqe1sj1W8qvpipsRyXr341j9Rh/xR4ce
 bs4IL0hLW8vRIfEktZnUTYdDZwtBO5QdHzD4MFEO6qv6orwJcM9v7cPPP1D+nDYw7ePu
 DWGQ==
X-Gm-Message-State: AOJu0YwkJG5t6cMa6miDluGdYR2l8FV/dU87ZGhmfWh/UGNGdttDLEbV
 I5Wpb+2TF8ZHkByjHR8si7wyUKwUqGy+vlQffbhSY4Mm/pDom2xqjrW/
X-Gm-Gg: AR+sD13LhbZmseeNdZa2vIZhSsArtQzIwBkkqiCyyGOOV8V4JCBu5IvtqC8g53cdnPl
 XqvDv96jSazjpG1WIC5cw9tviu+vjQQNAFAcx8NAxP/mz4XZnTLQW5cLnJEiT8uXH5NTElRHEXa
 kMv0l1UMmoGegVWMbIiHH3rf9At4U6FGHaNye7M25kzLXGYn1aVCB1gGYTqGre3jLxs9lH7i0Ao
 SsIF3cjO7AJGHQb+U4gAMrgmOWpPZPyZ9teuAfq1PGIMRyAE0rMfnS8mf9wkmMvfKSFfqSHeoS3
 nbWBHu6Ds4qQoFLuiYdYbxAX9V+7Uk5N+NsR3r6KAlFYw34wK0LvLvA+CfVObXZGXoU7SIe0DeP
 D0cSkrBvJk0sjUL2UJRHQnGOFWDDmWdcPJNaV37K80kR2bdc1w/qEpKIga8wNSDqJ1phT6zMSA0
 +pS7esscLdnCnI8ojwL7O3UZzd0nhIVtqh7FWoKccgXymOANPEw4JeFmt/+dhh4qOQER23CLmDp
 JxXLfMi34jAVS3ruA==
X-Received: by 2002:a05:622a:4c06:b0:51c:63d:fc10 with SMTP id
 d75a77b69052e-5283de34e9bmr78576681cf.25.1784915786651; 
 Fri, 24 Jul 2026 10:56:26 -0700 (PDT)
Received: from
 runnervmvrwv9.yo2jsnv3aaiufmiidgoerdg2xa.bx.internal.cloudapp.net
 ([172.174.165.6]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e854e43csm3336876d6.16.2026.07.24.10.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 10:56:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 24 Jul 2026 17:56:24 +0000
Message-ID: <20260724175624.8856-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-cve-2026-64600-v2-1-c039960448f6@suse.com>
References: <20260724-cve-2026-64600-v2-1-c039960448f6@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

On 2026-07-24, Andrea Cervesato wrote:
> cve: reproducer for cve-2026-64600

> +static void cleanup(void)
> +{
> +	stop_pressure_threads();
> +
> +	if (barrier_initialized)
> +		SAFE_PTHREAD_BARRIER_DESTROY(&barrier);
> +
> +	if (target_dio_fd != -1)
> +		SAFE_CLOSE(target_dio_fd);
> +
> +	if (target_fd != -1)
> +		SAFE_CLOSE(target_fd);
> +
> +	if (clone_fd != -1)
> +		SAFE_CLOSE(clone_fd);
> +
> +	free(tbuf);
> +	free(wbuf);
> +	free(rbuf);
> +}

The header comment says "Root privilege is regained in cleanup() so
the library can unmount the loop device", but cleanup() never calls
SAFE_SETEUID(0)/SAFE_SETEGID(0). setup() drops to "nobody" via
drop_privileges() and nothing restores euid/egid afterwards.

Other tests that drop privileges the same way restore them in
cleanup(), e.g. chmod06.c, acct01.c, creat06.c all call
SAFE_SETEUID(0) there. Per capabilities(7), effective capabilities are
cleared once euid moves away from 0, so the process is still
unprivileged when cleanup() returns. The library's subsequent unmount
of the loop device would then fail with EPERM, leaving the mount and
loop device attached.

Is a SAFE_SETEUID(0) (and SAFE_SETEGID(0)) call missing at the start
of cleanup()?

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
