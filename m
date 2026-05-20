Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19938CD4F3C
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779286006; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=X8ckAkxp2Jbwp0lODk/oX6TrNuaaU8Aomb4IPIOdM58=;
 b=QPTP++iF7VfHLDLQBPLAioljvkNbpUe1gPyhN7sa+vcyNLUT2kXcTHmb7vdcrGxF6owtt
 85Xztv1eYiygPxUbdHk3oFLClTw/aVAbTrqkCD35Kj896gi3Dbcb3on3f9syODeyHlDtVsV
 Cshfgn4BAU4qiC8/pcnKYglVMPdTUkg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29A843C71F6
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 16:06:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B41033C7179
 for <ltp@lists.linux.it>; Wed, 20 May 2026 16:06:22 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4F3D1A00A27
 for <ltp@lists.linux.it>; Wed, 20 May 2026 16:06:21 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490229aa522so16227015e9.3
 for <ltp@lists.linux.it>; Wed, 20 May 2026 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779285981; x=1779890781; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RWLOLxCVWvYTJ40Xcg8xYd0sB3LASYmAilMtLiWDalg=;
 b=VibyyQQU41PN79LsBQ9yrCEJMvfc/hNr5pn+mfQcGl9Ctr4AE1Ml0sGDN+ZmA9PyAg
 g0Mlx1XyJ06IPgxZJ+u4hkapviJSIABepZlORi6fGSPbPXyoznZcDN3noFBNR9v9hiYr
 C9I04R+7Q/qPAN7of8pxA1iGLM2l/9JS41pJdjnSBBdyb+Lclk9SXxvU5Kio5u5lHsjE
 Rh5uIr121tqvGojrPArbBgdOE5eq5XV8+HbkxRKk6acNVFtFz+Z16ummYm/GA2SLkjj1
 2hYRCZnGdMT6b3E5jj5gzHmqo0LRwWRA8AUU5LVPcfMsLEWup49PLTR0IiuE4u+Yq+xv
 dXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779285981; x=1779890781;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWLOLxCVWvYTJ40Xcg8xYd0sB3LASYmAilMtLiWDalg=;
 b=Ejs1HLS+KTNOdJ6mJtsrif4uu4S1aBAD1jdo78Zmcjg2F+E1DbmVMts5FDHLwuKL24
 XlAYKmVHDXCpsQ6XdR9LudK4shtsBLJIKzJl0kLfMRvrgXa1NL+8V2BoRsgpicPyn0sc
 cDCvlp6aiiyXyxHjcjDigZQIpooIN1MNiNAaYPwd13bb41G2MhZNRtUl3KmHzELpZnYO
 cVyPwvUQLFNzXZXirJJmRZm1pKR6Weadw0vwnVJytta3/oZPyCnCuvrmRtx3Hcqaw7YO
 Yl0DbehTNV+uZE9p4R/QpC9v963eKjFUUHH1Be7/QC5iT/X3K54oY4ep7Uc3a8B7GGiG
 pGEg==
X-Gm-Message-State: AOJu0Yw5/l2c7Za1KfGbojms1j5Nyei1VCgqjnX3MUKxMsvJK8YSGezu
 L1bVtAEpcG0gsZ/2YOkAVOhOrgkfC8o04OwRYSELq/b/+PBz3C0xzbRjsLRp724KN1iXl3xl8/n
 n37C1ryUa1Q==
X-Gm-Gg: Acq92OH2HRJD8HklzR1XXfV4eDO0fED7AjrzLpZsnFqtwsILYUS3ws5UOIz9F8zH5Dy
 Kf3KDGT+qvynAg/wCpFXA3c6LUIKUEHZO+9edjQSmTkweuc8noom+pSOXlpEyAxHpyTKjvKl0Ye
 i8meZ8w20ZynmI784WHhmiN/Wy1dGHpopsO84Nx28zKM3j29rLOUBZX0MK05MP5LocqblNv7145
 iPMLv2LtotsaCpYeLUQCHqXNzxen8Soq+KLTko1NIKPTFwhk5y9Tdlfs6TZFVEEAKckIH47PclY
 bhLSj+WEkUR86nwjWnASBJ8pzou8ADUUu86rH0rNhMBHSg89gGzk+eqtkfanWgFuT1ive8SujFs
 NkMZpdnHOfRCtcLbiiyp5kwSZyoK8Lt5I1JT3HywjlnXKHeqfsmOyS9ntpbqwWD+Gxf6Ea2LHmk
 AHBgfepW4FsLBD8fpqlsA7qm8FU5msHKym0vt92xi0s/oNlYjs1W8+fyO8V9YMhhy77dxkMJgb
X-Received: by 2002:a05:600c:1d99:b0:488:c078:bfda with SMTP id
 5b1f17b1804b1-48fe631389bmr351677815e9.26.1779285980655; 
 Wed, 20 May 2026 07:06:20 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57943b2sm409527605e9.8.2026.05.20.07.06.19
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:06:20 -0700 (PDT)
Message-ID: <6a0dbfdc.267d17c9.1759da.71e3@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260520074427.39155-1-mmenashe@redhat.com>
Date: Wed, 20 May 2026 14:06:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Michael,

the patch-set looks ok, but I noticed that you didn't add your
name to the copyright tag. This is the standard in LTP in order
to recognize who created the test. Feel free to add it.
I'm particularly talking about:

  Copyright (C) 2026 Red Hat, Inc.

It should probably be:

	Copyright (C) 2026 Red Hat, Inc.
								Name Surname <email>

or in one-line, as you prefer.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
