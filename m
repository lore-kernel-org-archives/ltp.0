Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF6DC79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 12:06:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01EF13C6135
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 14:06:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3B93C6135
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:06:33 +0200 (CEST)
Received: from mail-oo2-x00.google.com (mail-oo2-x00.google.com
 [IPv6:2607:f8b0:4864:31::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7687D20075C
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 14:06:33 +0200 (CEST)
Received: by mail-oo2-x00.google.com with SMTP id
 006d021491bc7-6a3900cb2b5so1426313eaf.0
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 05:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788782792; x=1789387592; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dcfX65ejRIL+4vBYxT/CTrE0AaMvOpq4QrcRyZdZ+Fw=;
 b=HYfYZfkY7ZZl0eE+IiNuC1N6wE2U5qgyhFxMC2y4r8mQzA3pOkXLjRwcHl+pA+hasU
 DFvImZAjjAEZcjcdtNVcvQvczjN2rffiGrWqbeTRovLSmIioKbefDPYQCkqkI51BmIVm
 NAb6sxO4v+aTGYfUr8YjVDoHEngXwBYj8hkBrhGUYXO6GzRdacivgHYxpGMK6sj8f+8z
 ZH6zpQnZen1r6Pi600xER3RPdUppV7WZP8cQhI84wXJBRhzoCJd1IzrUjKG3L1k7Gqgn
 QqvMbDjXAb27afZGZPlytE8FgSXAt0dp6Z/jfGZd0b33Dfpg49UNNKiDIiPk0RmpmRWD
 icCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788782792; x=1789387592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dcfX65ejRIL+4vBYxT/CTrE0AaMvOpq4QrcRyZdZ+Fw=;
 b=GJPDuuWIAyR35XbWldnsoT9qOoZtBwwJjQ+RmfyIEDkEX5P0UQn0K2rjp/aAuNs8sB
 yAmfI2vJ20KnQy9l0bfLvstcspuGWOHvgGuT1Iy1AfGbvehIdrSWH4tZizxLDG46gqOu
 IGp+zjU1XT1JnyNRZBOCY7xfE9VOywWK1sb+Ub0F17nyzml3D4cez79WIPuhHMxH04kg
 lkPXlIQF5nKq+eMwadqZ1k5SiGu5HkFZLGXzf562IyCCKo/Fv34mwK3+kY4hrt3dR1uh
 x4YpTK/j1CllEDOxSdLxGtgo6SZOd7aoU/sH9prlp0YVEWYw1iOPtoopA/Vne31yvYwr
 12pA==
X-Gm-Message-State: AFuF++kybx2k33NyxKGkRm/q9iGmJGL0WwZcBJqlZCo9F2gkZpUpoVMu
 HKlj2lDOJ3RM+yXvH5C8A7Zt/rqf21E77vMy1R0pDy91zjIS0+a2gO2n
X-Gm-Gg: AYBFou3tRKYBSjyQYDirYB9EEn4xHz6QeCdsQVQnMoCSyslh+2+bojVUWrpOiL5KcqA
 VpNDUdIHFs5oX8weGBh2ShjpkDLTrvwnM+09yGljC1OZ/FMOX9ViS2rHTKTcxAkbgsOylsK94eh
 nj42OGSSaXCfwJfLyQzxB01S3qqMVyK6p0tCUw4LkMXfM7Gh23ImX3XgGLUc1cjukYT0wYHTbrm
 h/lPgyLzNXfdugvQ0wxLcZSNLHGubF+G1uAgr41Suzwm0tu83hb5mYUcDlTXO9L6By8O04CzNxe
 xCupYPumRYioilzhibYTScw613C7hlQcvTorJ8WtMZ2ZojbWs/kwAGn9so/jD213uCURCe2I/uQ
 veyhnxu2td1CXWugo3cGO3jm3hd1ZkCi/tyd0xA7PI3pPO1R/BDyT39auAtkzfFa1Rtq++5Ia/D
 KgGBFJClhi7mHPE983kt8p2is5b5kwCWfwP8JwaVjlyQBZgB8vtZIUGOzPGHZWKIkG80kPUQcVG
 ivRujey01Cuw/qOmyr7HbkdqB2AgA9rQ52Q8lyA5grNGlCP+YTffnK86T6N3Higvco1sdOuD7H5
X-Received: by 2002:a05:6820:c2d2:20b0:6b7:b4b0:8915 with SMTP id
 006d021491bc7-6b7b4b08d9cmr7222557eaf.15.1788782792041; 
 Mon, 07 Sep 2026 05:06:32 -0700 (PDT)
Received: from
 runnervmejwal.cuahjxprzsyevh2onn3h2zuybf.phxx.internal.cloudapp.net
 ([20.25.153.61]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm23653797eec.11.2026.09.07.05.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:06:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  7 Sep 2026 12:06:30 +0000
Message-ID: <20260907120630.9097-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907-process_mrelease-v3-1-03bde3e5d77c@suse.com>
References: <20260907-process_mrelease-v3-1-03bde3e5d77c@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Add process_mrelease01 test
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

On Mon, Sep 7, 2026, Andrea Cervesato wrote:
> Add process_mrelease01 test

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
