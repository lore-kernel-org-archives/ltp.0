Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5312AC5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 11:06:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B5DC3E7009
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 13:06:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 773113C713B
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 13:05:45 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A7D6600D2D
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 13:05:45 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc2c6e0688so26203225ad.0
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786100743; x=1786705543; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Khj6aFfZGQ+w/xnzvXY10NeIfo71Gp2roKQ9vynJS1I=;
 b=hrxoUVYViKFt0IG/aJDi7SEJxa2DC3l3Dj1N0+nOtjR8+G68M/BxZVtuZMcDPuR7Ov
 9DX8X5aeM0bVweTPpHG4qoec/sYaB+jdYZnSJrFa44FJ3GpSwULpmgcsL5fsh1UcIJCX
 cpCi8p58p1x63Tv3/Vqs8ZzAYDSGf1clYZHNkczrtIZaeVTJxGshhphzJwxw2Vc1ERe2
 awHmSSc24KX2otimnwi57WNrXLBZlJhBbdf8LlYtK5VhEBam7gb4TQl7ZKq3dqQiy6H1
 N5Bn/oRpz7YH0JbkZ18POhCKxOh/PeK6O0GjDgcpfQBTlUhkr9qz0r2xbXhGKO2YjUiy
 h1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100743; x=1786705543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Khj6aFfZGQ+w/xnzvXY10NeIfo71Gp2roKQ9vynJS1I=;
 b=pS46lHU1DkWJQGeIgBowqafc4DaJ/f6EDGqc+iYFm2H78Jse/RFSN4AyAOKy3I7kPu
 vyquobuOCer2FT49QEAuMfnPLTU8se5FF2yETeaXakJK6ufMRGboADkzEFcqC3QS4HOv
 4aA583RbswscsO920t98d6kn+JE40PJBBfQUtiXTd+qoM8tIXQbUnMofNp5P8hlPDDKk
 AyLiUKAGt4fx4OjtG7v8vNrrrKe3AE2bVA+FG+Ziw5Bp9vNzoniDC6B71j0+vW41BOwV
 vw5xNki5aSQUF0t2aZ8rpbdjXXOhr7/A0+V2ipA+kDdd0ICpjcXG0VxWm/zXUCUMqefI
 itxg==
X-Gm-Message-State: AOJu0Yx6WNXZlfn8qefD6r5uYcZkAMn19CAZQ7pSpamuwa3cz/KWiHaM
 kV6ExvrC4ubyT9uEMYdn4E6miTF10AfxbQLNPLqiKWcSS1wgoH72DtOlZafXpdXR
X-Gm-Gg: AR+sD13G2FYylNdKaBjHmta+Xoeowhmesh0w2HVx6fm0vF2lUWbubEFfL3/ODZZ4LT8
 3Imrmm5/u2EV38MgeraK2GHg2gUAfFLG/GntlEzSQ/xWLdbwearluUpAy0FNU/3JQB26pG+n4jw
 VacUGIU6/yuOilh3msAwbULUh3O29bDVaj5/fY+lovrXt2atQ2NqB4VzkNoJhSivPVF6++qy968
 82aArBHiGymaUV40d9rbUfaLs9Q8SFiXJpHa3uf123d0cYLH8SNGQFC1i2S3GS76nDEwKgh6EKw
 /IeGkjngjXF/QpgZmNwA9yM+7JKtKws1Blcea8xnQyOJefj5XmRxstWlj1MWRcqZmtR82M5Fn2f
 DgTKuN3OZhjbSAL3e47eLLOZWa9LaY6SEuPI//Z9Lk4UJ08SNdIhtVQvYZec0GStIs6uYbXDx+j
 Zr/jLQbzIlebo4dMFHrPmjAJXR1loOlNw0VOzZ67lDLxV54fe859t6fYuzpZRzJB60ulYm56wMc
 lz7u3SVH+fUr8FuuW7blb8PXFRDCpiSkAfI1bc0oMTNiDtW2WnXho8RGOWnM9UKJ7UIBX8IEFGD
X-Received: by 2002:a05:6a21:1fc8:b0:3c4:397a:69ba with SMTP id
 adf61e73a8af0-3cb85ef8666mr26375333637.28.1786100743335; 
 Fri, 07 Aug 2026 04:05:43 -0700 (PDT)
Received: from
 runnervmvrwv9.prajoiou5htenajwodrmzf4tne.dx.internal.cloudapp.net
 ([68.220.60.11]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm6800835eec.9.2026.08.07.04.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:05:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri,  7 Aug 2026 11:05:41 +0000
Message-ID: <20260807110541.8702-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807100439.2796808-1-wakel@google.com>
References: <20260807100439.2796808-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Use backoff polling to wait for loop device nodes
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

Hi Wake,

On Aug 7, 2026, Wake Liu wrote:
> lib: Use backoff polling to wait for loop device nodes

> Introduce an exponential-backoff retry loop in both
> tst_find_free_loopdev() and tst_attach_device() (starting at 1ms delay,
> doubling each try, capped at 100ms) to wait for the device node to be
> successfully populated.

Could the timing description be corrected, or the implementation changed to
match it? TST_RETRY_FN_EXP_BACKOFF() starts tst_delay_ at 1 and passes it to
usleep(), so the first delay is 1 microsecond. MAX_DELAY is converted from
seconds to microseconds, so passing 1 retries for about one second before LTP
timeout scaling, not 100 ms.

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
