Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E33C61DE2
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 09:01:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 856AF3E947B
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 11:01:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C790D3DFDB3
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:00:53 +0200 (CEST)
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 075561400B8A
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 11:00:53 +0200 (CEST)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fab5so959923b6e.1
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788166851; x=1788771651; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OuN4GWppsPphL0wQ5Cn8sojZRBy18Ltz+OZWOcgyWp8=;
 b=BwcuxmEOxq1VUYTSHIe1Qh8ThO7PQazIQtj581XqCM8lBD+/9zESJXAMRVb2v6n9BA
 s4wYDg3MQqn0X5jP1lYYcIlbX9D2IJJkANYx1upUg6uY/XWoXvcjwQmnb2AaMJSgMaK+
 JR79VzMsdP3menCu83XvoaiTRwgh6XjzRB67NrIh0ehW1XRgswvj+5WRhkN+UyKiUyT5
 cTPNLxNNsYqWTbtr0i/spCjyGEktvEgV05E1/J2fV//m7rAqHzPfWk2piqASSwRet8rP
 oyfxAJS52NpdVbBUb9bzNnyeO0X6d/gXIuphDG322UbBNX2MxhTga6wo9si8LLie6GZw
 Bprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788166851; x=1788771651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OuN4GWppsPphL0wQ5Cn8sojZRBy18Ltz+OZWOcgyWp8=;
 b=aE6Ko73RuQfPHlVzrpdhfiAxWoN+EFgGpX2z59qWDUc+nB2Bk/+KQvrZuvCliTyGxo
 gYw1lql73XazJpBR8Eu5aIjzmruKEEaqo14nz1zGCbswrfbgH+QIDQmO0ryq37sNGcXU
 HKgjfsFg+LoX7+rk0cpR4FTZEhs9AMqKR8cYYdd2GkOLCGCO3JNGXxkZWlLGCpHBx5g3
 k8hrMX+h4e1RZgwfBosSj1nrfAHfX3pqn/ZYBLh0WUhhIOLzdzU2nhsnql/0BMdFYm0L
 EViOla6UMh65Yy4hqOYrGBaLXZh7w7z4GfDk5xSuzmRSmcOqfstcTROXg1vub5FSNG88
 ryAQ==
X-Gm-Message-State: AFuF++kd7hdgAdreT1jCv/sWhg+cnXNC+JPiNvS/Ycr1nna7THJtgooW
 5eN+q9wOQikWt9Fnw8p3G1F0ges3jyyYu4dPdUSqqPxUy4lOE2m4drIA
X-Gm-Gg: AR+sD12XoAzou1UilqF9ddGQJ/AYfeep9OZ1PxmFtOKnCNktNeC3CZEnjs8DDsuUkzy
 B8cQFD5iPXC2gzhoGt9G7FVjBTkeW/alnXPlLD4bT0EdsHu8SSddUJ+a21QgtbmI73PRQM6Qvbf
 HQqU1PDdbPUAFQOEN1ClMwA3X0pb6iDYkGTeZW9/rOK6H78/FWf2rPp7Zs191Eb5zq8wcXy5l7Y
 hLgWwUg9RydBp4bYIILfaPQ+vxF8m5MGtaKF0WgHFVjMTT+Pey0lWI5XEebaTuzRob/q0BNEBtU
 aB172IWdyjKkSkycw4/r5B/WOCFh4FjfMVZ3HLRBjTriLrIKSALppv3q6P7vOexYmQyTMsL+FCd
 OOeVklqPwcNeKTu1bf7yPJEr9ev5SBDo15kP54cHs4Az2x/wrsFMdpJFoBKn8au280ket7qhjRD
 ynKkalYnf1O6VpvV/pPSv/a7RHWeazeOyID1sPgewZgZ1wTlzMXnDi9rIZSW9jPXe8LdZ3nD8i3
 mVj+oaK9J7DlQDxnyWbmltTFaXp4nI10cxISBc+wpz+FAe9/iwhdQD7FsEv4WMLO4xucEzjsFg3
X-Received: by 2002:a05:6808:6f98:b0:4b3:79ae:14a3 with SMTP id
 5614622812f47-4b5b1340dcemr1437746b6e.3.1788166851197; 
 Mon, 31 Aug 2026 02:00:51 -0700 (PDT)
Received: from
 runnervmgx7h7.0obh14kmosuu3f42i4cqtqqd3c.ex.internal.cloudapp.net
 ([64.236.161.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1675509sm8000927b6e.7.2026.08.31.02.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 02:00:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon, 31 Aug 2026 09:00:49 +0000
Message-ID: <20260831090049.4155-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831081638.19539-2-wegao@suse.com>
References: <20260831081638.19539-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Extend tst_assert_ulong() with enum flags
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

Hi Wei,

On Aug 31, 2026, Wei Gao wrote:
> lib: Extend tst_assert_ulong() with enum flags

--- [PATCH 1/2] ---

> #define TST_ASSERT_ULONG(path, val, ...) \
> 	tst_assert_ulong(__FILE__, __LINE__, path, val, \
> 		TST_2_(dummy, ##__VA_ARGS__, TST_ASSERT_NONE))

The modified public TST_ASSERT_ULONG() macro needs a kernel-doc comment
documenting its optional flags argument.

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
