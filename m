Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CF0CA5FCB
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 14:17:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 334D13E6994
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 16:17:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 501033E1894
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 16:17:27 +0200 (CEST)
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FF04200DAD
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 16:17:27 +0200 (CEST)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-81b29872a71so2267311a34.1
 for <ltp@lists.linux.it>; Thu, 01 Oct 2026 07:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790864245; x=1791469045; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ac8JY8OPAFIIJoGm0MUZdWgVlvdcuOLJrMcX502yAAo=;
 b=IRvyxNJku+tsJJGs19FoNczofnLZNiz4RzRnoyWZvaWp3WROqaMyH/q5YIjWqgNMft
 AmS/nsXJQwaY9lwW7/1E05VTQmAIa2/3Maxoss4La1/fg/cNgQuyqvVE+M1sv5V88vyT
 Jc0ITNGEvrIlp28Lke7n8JttUYJAbc0sOM1DYPe9dy7hqxZznBqZ6J13nP1Liitj2fa+
 OrtVowyx0BK8PE7xfK5zIRD97Q5LVsxpPeU0eexk3JzCZYg2BLSejJBzgPVLSNJqDgVa
 UmEQcGPju7OXVw1NN1Z7ASro7sdhgBFrThNHy0K2in8W7AGE/RDw5MN1DGQlmTKOVa44
 bctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790864245; x=1791469045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ac8JY8OPAFIIJoGm0MUZdWgVlvdcuOLJrMcX502yAAo=;
 b=V9PSDTDUdXbhrpnzLQQcs2hmvKCFrib2dPIntjs+DKaffkaKhX2UI5kum9cr71pkXx
 C1lCwUzQMjatrTCG7DDL8j0HQF72x98dlJmkTGF093lGJGF37Su+diWnLAgS0exzLs5s
 EezPMO5Se60C3Bksgz8ImHjehBsj/R1iRFzkGKnqaSGCF/skYtNHUg6TViZqZUTmcJB3
 gvs9db2V2jskVuMvWs9AjTSd9vQ+0KIn5JWXqMXlnNdQbndGgXm9+VyKrGm8MyBtRIRH
 dtBPxwMPTpKZLA1r17tRxzqnHLzmrjxAMVkBgkvhth3SYI4MJY88J3E/nduAvWFpsg0p
 B8Lg==
X-Gm-Message-State: AFuF++lS4KGW+xfLA+3RYKpPfTuC2UWNNAxBaaPj7qJjRplhTZpHos8n
 gpXftM9w/+UQ70Sw9GwLbHYRF0wQk18Y9PNChmcJ88BoyY9q9gg93oxD
X-Gm-Gg: AYBFou37OCLddcVnApBmsl2ZPHTy2w8T4P00NVSbaD6yeCUS6/zXiN6UUwaLtIPHc/j
 elP1CL0x1qzwWPUOimWP7fMw54W6kflR+UTRrBIq1noVT9UAJwPPKAW4E6CgXeCr4d9NtHwmmHd
 ETVs4A4QnR0eofHitfDm0BpFRqZ1uASVCyc+XF//zdQ+GZ3kI5ifI0VO0zVv6f87ngZ0OwmuQVv
 WnV1EUkNwNH0lPymEh10/l2Eeiql922cN8UkabmsEVN2Hy7f5hw6HpB9X8JOyVukWA9iCzRy1uT
 1RapNkG1WFsGRarnOFmT4ANkE2Wpkzj+8ObI2hzQiKtCJDuiq3nJZNaiSLdVfBbLuyNGR66kNXW
 Ub2qkMMN6r094WsvJbYATg4QLUJL6gMyAvOz8SPvy30gAcNdL4SNoY7ByS8kuN2Vju8UGLRReuW
 2LGp17sUpqz4m9gT35IWowyqXEqOjRNqHiarRFDKwYn+io1WA5X/xYfMdHKvhnh1VXJtzlkGmN2
 biMFm7gI1kTnsEBu8WBqTMYbPr+V/njsdiXJrKongl2ANujH5qpBBa2hPwxqerxCiCIqJPmSmjn
 kHqrCV8=
X-Received: by 2002:a05:6830:6d0d:b0:81b:8032:716d with SMTP id
 46e09a7af769-8204e2713b9mr5328493a34.20.1790864245483; 
 Thu, 01 Oct 2026 07:17:25 -0700 (PDT)
Received: from
 runnervm8df0l.wv3yo1g1wywupeactyiklw0fkh.gx.internal.cloudapp.net
 ([20.29.38.0]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8212b52c1ecsm2410271a34.25.2026.10.01.07.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:17:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  1 Oct 2026 14:17:24 +0000
Message-ID: <20261001141724.4041-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001-fix_aio_suspend-1-1-v2-1-d444497432ea@suse.com>
References: <20261001-fix_aio_suspend-1-1-v2-1-d444497432ea@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: Fix aio_suspend/1-1 completion race
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

On Thu, 1 Oct 2026 15:22:08 +0200, Andrea Cervesato wrote:
> openposix: Fix aio_suspend/1-1 completion race

Verdict - Reviewed

---
Note:

Compilation and execution were not validated. The generated Open POSIX
Makefiles are absent, and the direct compiler/run command required approval
that was unavailable.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
