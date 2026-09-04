Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE547C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788510230; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=k1pKO1epQ0okzq+JJqUM+wZH0iJ/On2y4soR3L5rVPU=;
 b=HfxhSE9/4gzZCTwb4ouOct5f4oVyw/zUDNAWawaveHdj0Mh8BVmIQQoz5rnB5gsFo8I1K
 t2IrlkrWCbIpXWTszvKxDKIqmn0UXNSoKLAAuYs/3gmEAMeHpNfsSL9QTvOsYEu/p2OUDPz
 wbdbGWTzs2tHr5m7nDS8E+KryKdaZUQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C6DF3E969F
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:23:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 387A63E5507
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:23:31 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 85AB4601D6A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:23:30 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso6018375e9.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 01:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788510210; x=1789115010; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=icm/WXNDyF/o+zX4FUfbqnOwA7+2ifUYMtXmURCAZsE=;
 b=OdKwLSkoWtVMfNmupXuTNevOnT+NqvKA5mbuSwxH+dlrXewuwlP2KhbTOyhia0iqOb
 xnJJzUfD2RqG5flPgxjBAyKF2qMFk2v6KXHPQ2i2CCH0M+EULNcTG/slkysJIor2xtbC
 +fk+3EsuA43XF69cSj7LkZx7tNQuuFZGrkcJ5kwreu/Q5Kxtj+K+LqT/rIcr8pbMpUwS
 cJljRWLo9NGa9tSFOKrIHD8Nxiu+/D0OwFXGYUBESAmiVFHassLYLLje/GiwK5oShrom
 Xwz/JEUmyWpJlqzlfbCc/hd5JdzkyYhgISgInKeNXYH8iAkGAkuqihzR53vro+gancBL
 +GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788510210; x=1789115010;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=icm/WXNDyF/o+zX4FUfbqnOwA7+2ifUYMtXmURCAZsE=;
 b=iwf3B+hFVd5kmAEoPRjx9ZPX0teLpj2QOmi9D6KxmWg7Csuv/H3s1mIGczhijgNKX3
 UtNw1uUhFRg9dFlCGVMhh8NpdBSIr4KibpWxo2jDXkpl6mNlUYUbsaotO42lof720rGt
 ubtnm3jUV2rPnQkQDkUHAtpdiuiJi/Q18T0yLWqOQ8DMQg+jq5ryiN/2bPgR8VeAeKQQ
 hhDl2wQfvF08xvjiA3PNipNW9YF1cmHR28OiAxkuj8wES3QPhg5+iWN8uaiC/2oa1DZ0
 Vkij81juHDUwyB0+Ha1htDYm4y/S1YNswyRNGRrCf+j+5bawef/Pxqifoqq1Ff8/LIPa
 ThAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1Pcmg14q7FfE8La4obNVIuGDR8tIWoPIM1qbgrSwcD1xGTHWoTfgVZj2RxkJ3GFGvEHk=@lists.linux.it
X-Gm-Message-State: AFuF++m8sG2u9PHORhMmmHcQvhmhVuoiRG71wKpwTDiI2P7sbPb35WKo
 OTVFVuKKDCqU27NBelNGZZ1katmGCnEEyvcVZf6EpJsGIpDbunviMpHzK7nbS/sWN6PY+OLfzrY
 4CAvrvvt6cQ==
X-Gm-Gg: AYBFou0/e+WpcN0eq0jW+M4W1CqGZLFbSrpkvGRWYvFcnqRtZbERfGs6EI7Ncfh45Za
 xQRATgyPdFWsU0R8+mrMNaSi2caQEvpkWT8DyOhf/sDlyMhiKh/LGLUaIxpteWwehXqzUkM+Eni
 sE6gXFIfcsrVgfWk26fxmnmSwwzyt4YPVLDWdPgszMQlDI5OZ9HC71mjt6RSYXIBLTRwJKmsH6+
 2w7XzvF8uZ5Ce8BxL8KqKp2+xqKatcEDkbbRhECVv6Y2kpxU3AdUxf2Jl6RwIwMuxVi7PxJ0a32
 22QE7bIvoSf8RmjpZWG+D2XLF2KgJgZcHtw1BQ8V6UxV0XsT0Iqr3hf9WEPGt/vtZfOh74RSl2m
 t9H2b4Ygda/bpnRI8GvQ8XEc63ut26XOqooziVulrDGSQvc5QEZ4RyHCnG9HH06H6kUHr/9+R8L
 JlNDIJcuNNEIGXT6ACOGD4/NepljzcVHkoXq2p8P+Q1bH5v/wV8W04/r5cXJcoha2C6GUjxQFDG
 o0kMuUrMa8/MiDvZblVuUE=
X-Received: by 2002:a05:600c:3544:b0:49c:f5c0:aa79 with SMTP id
 5b1f17b1804b1-49cf8244bd0mr41380435e9.9.1788510209814; 
 Fri, 04 Sep 2026 01:23:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bbb51sm4718047f8f.30.2026.09.04.01.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:23:29 -0700 (PDT)
Message-ID: <6a9a8001.d5b2c389.20594a.c6cf@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260904082049.8988-1-linuxtestproject.agent@gmail.com>
Date: Fri, 04 Sep 2026 08:23:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_setattr01: Convert to new API
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

> Hi Andrea,
> 
> On Sep 4, 2026, Andrea Cervesato wrote:
> > sched_setattr01: Convert to new API
> 
> --- [PATCH 1/5] ---
> 
> > Rewrite the test to use the modern LTP API (tst_test.h) with a
> > struct tcase array and TST_EXP_* macros.
> 
> The body only restates how the test was converted. Please explain why the
> conversion is needed.
> 
> --- [PATCH 2/5] ---
> 
> > Rewrite the test to use the modern LTP API (tst_test.h) with
> > TST_EXP_* macros and cleanup callback.
> 
> The body only restates how the test was converted. Please explain why the
> conversion is needed.
> 
> --- [PATCH 3/5] ---
> 
> > Add a safe variant of sched_setattr() that breaks the test with TBROK
> > on failure and use it in sched_setattr01 and sched_getattr01.
> 
> The body describes the wrapper and its callers, but not why the shared
> wrapper is needed. Please add the motivation.
> 
> > +	if (ret == -1) {
> > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > +			"sched_setattr(%i) failed", pid);
> > +	}
> 
> This body contains one statement. Please remove the braces as required by
> LTP C style.
> 
> --- [PATCH 5/5] ---
> 
> > +	TST_CHECKPOINT_WAKE(CP_SPRAYED);
> > +
> > +	while (!tst_atomic_load(&stop_spray)) {
> > +		prctl(PR_SET_MM, PR_SET_MM_MAP, (unsigned long)&mm_map,
> > +		      sizeof(mm_map), 0);
> > +	}
> 
> > +	TST_CHECKPOINT_WAIT2(CP_SPRAYED, 18000);
> > +
> > +	SAFE_SCHED_SETATTR(waiter_tid, &attr, 0);
> 
> CP_SPRAYED is signaled before the waiter enters PR_SET_MM_MAP, so nothing
> ensures that sched_setattr() overlaps the controlled kernel-stack buffer.
> Use the PoC's page-boundary and hole-punch mechanism, or an equivalent
> mechanism that guarantees a usable overlap; otherwise a vulnerable kernel
> can complete all attempts and incorrectly report TPASS.
> 
> Verdict - Needs revision
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

The whole AI review can be ignored

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
