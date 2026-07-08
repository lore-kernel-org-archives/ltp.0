Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70070C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 09:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783501937; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=63PYi+gsKrYkZ0WiBeqEHBf24/VkBkOq6spHg22XyNM=;
 b=XdpcCRfeiFj1Unw5KYN7bPr4qbwU8SSgTGJZwHLFZsKDXQ1TiqGet4FTHic//2df6eH/I
 yLDWw/motQnuKDPG3V4/mkNetVqPXLm2vBkgWrfQeuYJSV0vvVBzkuqo0AI+FZsMpRgIsWg
 jxQJY3W3AqcJxbIBzT5I9H5Nv0vgSiA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 524823E29AF
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 11:12:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78FC13E29AF
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:56 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BC89160080F
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 11:11:55 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493c2b3dc8bso2575355e9.2
 for <ltp@lists.linux.it>; Wed, 08 Jul 2026 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783501915; x=1784106715; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=35/eKvRnD0CIDztgAI7EfROrkQhezoYtnaCwLIoxJgo=;
 b=Y6kyiLB3K9yqnIxVmU9A2ab6/PyKIgGvt8ncw857wDkvPSQyNLMsldcOzHII7sx/wn
 LknW1E5yQlJZz8wRu2uWJ55KFRx5peE8GwMLVR/86fYzdBZZniUbPCqWrgCvx72Qb/B0
 FOYUX1eRcPw2sz8AyM5bPesDLcBPWc+LJv+LW94CBY4OQrOhARgudPtlgy02tqp3d9xO
 anwSJxcVUjXMURQ4fagyO1DOqHX1q5yz7BxTHacTG7lmVDfT465qDbW4CWG8Ox90Nmvy
 utu6vE9ymTTi+S7cgQbslUifhaChPYyVXLibqAgDvD3+kBPWlPMhO43nv3czN1hK7gl6
 bTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783501915; x=1784106715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35/eKvRnD0CIDztgAI7EfROrkQhezoYtnaCwLIoxJgo=;
 b=THUcwHJEgzEKiqro1MVwLYxpK3g9kKfIVXq1/EaMFpxcCdGaNNnidDXc7IccXMwL3x
 eJTN7F/FM7xR60hSsjUyPzN9g4oAzPalMZvIxUuwnRVBqfjYRZbvLUUItXIivExt3LvP
 wlNXFFrhV+/vX5j3B33p6W0A+EoNVdwAmi6M1op8+kzLoNojNm+1J+FS/aHH46VcLN+k
 Bcrx9p3h9Ed5ZQGMGfZHia650kW0SiLGFxINm5PBfnSRizcOCDK75RQybxbZhERKL9Ao
 tZx/jK20VmP4OiK0UYOy3NIIcFwvU9lIKldTcDoBBXuZLHeIi568Kai01DVrB2ymxk1v
 zwpg==
X-Gm-Message-State: AOJu0YyqDrvUl3oo7jnk+ztMFelPutGR/TH+WhVxRxdA5TKwyF4f8ivv
 92FNLGRhYR3rhUe85hWcbXWO9E8bMaZcwsOOy40/tmwgWqvfe0r7HbKl29vi2Lm2bzT2ZyrGxcV
 VN38lDwc=
X-Gm-Gg: AfdE7cnzVONlPMz583nf7DAuQT2JeFFntJwx+IQVO0Z2LL9n9f1LZCfyLN5op0mRzdR
 MV1y3MtBmJNcWjvS0lfqKJAkuzSIW1SXx7K5kPQE8MjRFisip5XTmflvHPJ4IV4fpr8NIOJ64Y3
 CUiuMMxLf4I1yCg2Pj30VFbkhMMff0A9jbImT93I6YJ1OhnZrB+nTXIQ5ENi5cdlTt/Ni3eIA+c
 p0vOWvUjLh+NLgtCszWOjBGZ1zP3OPZld39JsS43zznFVW8Vrpie9qh7GIknO0rdvUx46BvUs7j
 6UV2pjuY46+W2dGFmr2NudD8G903EJgOcGIJF5KZmHzhnlx1OBuugk9HKulhbrt3x7L/8wfEvZx
 RDa9mWYydXAcTLCvB7IPvghO6rtB2C3EiXJ+sBlSXDkFNH20kcAIIm6Lf3KeGKbXwFuKP2CydMo
 A=
X-Received: by 2002:a05:600c:3acd:b0:493:be3e:cc3 with SMTP id
 5b1f17b1804b1-493e68c8058mr13178885e9.21.1783501915078; 
 Wed, 08 Jul 2026 02:11:55 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm41579105f8f.15.2026.07.08.02.11.54
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 02:11:54 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  8 Jul 2026 11:11:50 +0200
Message-ID: <20260708091154.999385-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] syscalls/cachestat01: minor improvements
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

A few small cleanups and a fix for an unchecked fsync() in cachestat01.

Avinesh Kumar (4):
  syscalls/cachestat01: Remove redundant memset() on cachestat buffer
  syscalls/cachestat01: Drop stray newline in tst_res() message
  syscalls/cachestat01: Add spaces around '<<' operator
  syscalls/cachestat01: Use SAFE_FSYNC() instead of fsync()

 testcases/kernel/syscalls/cachestat/cachestat01.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
