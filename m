Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C192DCC6B08
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791902301; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=JA4x7vzQXCZYTL1JtOjkObXwI7Ty66MH6xJ7fFWy6kw=;
 b=E/QBHVw6c+++m2Q4X78AcHM1F7p9jRkXHxju9dtiBVCg2cl03CcJmX4ijpjbNnnNkuwKI
 BpeKK9k1QxxMXsFklJJ9PYNZK4+sl9PnEJ50sawSy7IlwiAahbMCnkrQF9olcHcri46vRUm
 QJmIiit9TdotGoYNCfVVQGVOAeWf8rE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10F83EA840
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 16:38:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CBE33EA835
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 16:37:59 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 873B160090D
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 16:37:58 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so2836329f8f.2
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791902278; x=1792507078; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5L9dEPqwlkCtY0BpBEgCj2/a6FVc2NiFJS9KKSWWzxA=;
 b=PxheOv9Ff+PCE7GufEJgz+VL2b7B3kMm03V21YofExMWC6YPYMryln/6SADnsnJdfW
 MMCkGZZ6T9VvGHDs0cbrx8WRig/F0UZyoXbthvlAIQ/YP/RuTia/cKrEkyfRTisboFNA
 5dVkjIj5DgEwwkxefgQCnjKe0ZS65Kf2gwy5ZhTSFrXM4Z+mESk4HkcH/zsqvvB043D5
 Yj1ATtFQeiH7pKsqtcumyLYqiG3FxNVl1QONaTNO2aI8FiBL8lf8nNmFyme1pR/3+uH+
 scCodqMJ5SmI6wva54bdRYL/L60DZoOQpbVLQ43JUHw30iTcz+umyJNo5XYODilPrMhY
 o3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791902278; x=1792507078;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5L9dEPqwlkCtY0BpBEgCj2/a6FVc2NiFJS9KKSWWzxA=;
 b=o6hc6FhhngL812Q3W3burMoQz1QnCfbtxjWMzemYQOpxYzDqVM9spJ8FtQMi5QFoA1
 O4DekxXwYc5Q/NPTAz5VFs+eP/7+ocptOQuShhMhnJgdiQUh5+RQ3OuI7+BAMhI74jNj
 zuKkiWF4lCxpumayGCzMWAkv/Ild9zIkpGbchggoKXHiAFQ1q/WZOPdz7G+QazINDygf
 JW9mUYmN7UO+BjVF8YxDjB6LWNB/h0PjiZfJPq8GgjxNw8GwNXmlh+7DovXFFZjTrq0T
 prTfu5jrlexTM9HAFtOirCNsgqA1E/11vJmVz3ttjdLtA0Q/z5Qz8Tz4wUcc1JZ8LVoq
 MP+Q==
X-Gm-Message-State: AFq9FYIHzfoD3zi+w2OFx1iy9m61bPdtNfcGGKTmIBoIfNFZ1hc44/hY
 SVqo8+Wgul7xFFBFMTr88FhKm5RZait0nFCAXkCZ7JdokIUNaoOpo0ZxUFeQqGHqb9k=
X-Gm-Gg: AYBFou03O/e2K9x8vZtrFy8Wan9tzkemXDf/w1XcF7gPneQ0Q68xSS10znN4u/BX/Tq
 gK37FSvBmvwKVsgmPDaHWV5meSIKmBLNb1YvYh33dMw6Wfr/xHmFpEeJIDZRnletvqUC+pz7pI/
 sZHgPSmTDDZdgLwQeMMrsjyzY5FuswJ9AVhf1qBo1pzuMQj/Vev5mGC0pIGOaxJa86y86moIQ46
 C5yOpURo1mPmrbe8yTSPYzsuJ8cYwP0yxlUul2nk9I5tjvAS9YH01zkWlxfu8ytusUG3ljp0J7Z
 h8MCBgb4Eb56IOfhRCUDlMSoUe9xiVdGlRaiMEPSiQ5RzgAKAUPVSa8vFco4u52CfqLOkpb4DZQ
 LQ4hqQblnlJpMELjEnDTYHgkoSD/mVfq0OALMX0DV+TvwbsQbC4IzuNoZp2X1ybPw36CsdT7GJa
 c+Hj/oPZeDbtAQsj7jIBFSHaTqec/G3KHesQxmEfdHqawSGb1Det/XPyqVUZ+tO7i6a19EpSuCw
 N6dsYPcXF8g9guwmRj7CREtiWHJ/LQJQwM1zQcjVlNnV6XU
X-Received: by 2002:a05:6000:2685:b0:48c:6724:b67d with SMTP id
 ffacd0b85a97d-48dbacddb35mr23763293f8f.38.1791902277679; 
 Tue, 13 Oct 2026 07:37:57 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc50e0sm7195948f8f.49.2026.10.13.07.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:37:57 -0700 (PDT)
Message-ID: <4QKaau01y4bOVD1gjocqnaPgUH5VvxLh8Gl6@localhost.localdomain>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <CAOcRiAGowTMaxdJmSS61_PmQLsuwUO+iS-NVkWJC46CHNpqNJw@mail.gmail.com>
Date: Tue, 13 Oct 2026 14:37:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pathconf01: Allow EINVAL where POSIX leaves
 support unspecified
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

Hi Wake,

> pathconf01 is a positive test, and the einval_ok names actually succeed
> on glibc, musl and Bionic since Android 15: they return >= 0, or -1
> without changing errno.
> 
> TST_EXP_FAIL_ARR() and TST_EXP_FAIL2_ARR() expect the call to fail, so
> they report TFAIL wherever these names are supported for directories.
> I tried TST_EXP_FAIL2_ARR() and all 10 einval_ok names fail on glibc
> ("succeeded" or "expected EINVAL: SUCCESS (0)").
> 
> Here we still expect pathconf() to succeed, and only want to treat
> EINVAL as TCONF for the names where POSIX leaves directory support
> unspecified (POSIX only defines EINVAL for this case).
> 
> Does keeping the einval_ok check make sense to you, or would you still
> prefer storing an exp_errs array in struct tcase and checking it with
> tst_errno_in_set(), the helper behind TST_EXP_FAIL_ARR()?

Indeed, my review was biased by unrelated usage of TST_EXP_FAIL_ARR().
The patch is correct as is and we don't have any macro hich could substitute
the manual check we are applying in this patch.

Thanks for pointing it out.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
