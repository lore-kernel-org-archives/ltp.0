Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AEFC61DD3
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788164224; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nhg8HYZEOWPev7hHYOOMjUBPTa21B03mLVf1CKsSkKM=;
 b=qyaguKXVJoR7/iujtSgIK0YKJvTVJlGO3dGvRTcKuV4hdU0yxI7RggtAn3k8veYskq703
 /rswW+yUeW5xYn2C0G1CsONmKGhm3tHaEmPf7V9O2ZPQAt5TFiG76pYJBLfvG11BV3U4usK
 nKICBc+GtekKErb/wG5Pfvcq2KrlfYE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BA043E59C9
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:17:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A69053C064D
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:16:43 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E35FB140099F
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:16:42 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2800588f8f.3
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788164202; x=1788769002; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LWHpe78Wci9rMsp0End8666QHc904JKUeG/I3bpAl0w=;
 b=PSwtixhG/tnAX2l8yh0um0g2f9mkZLDjnhuI1qSDoNe9Kii4aaRLC6/hSCDdbmKiIi
 fOcKPnEtXc60tQjquul8Ln24ULXjz10D4rRIh2w57Yn0xl+tiL+gfz4CLGBuNFAKSNK0
 GbGxxpE8YLdPrEg3oC9C6uWSD4cqHvH/B9BVnHshb/NQcpu926w1vEDOkz/gUVIq9LKh
 RcUz+8IRnZUHqLZqTrWQBOLNmgRgc59Yc3pAE5F6hnZQFYo0pSP+mSiUQwx7ZzwjeC1s
 IUR3c3fG74xmnbpICCTa4ttjlq2da+LCcCfhKeZ7nxKLrZeVXchriColTjjZ5VS7oUV8
 fd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164202; x=1788769002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LWHpe78Wci9rMsp0End8666QHc904JKUeG/I3bpAl0w=;
 b=ZS8PeLbYsAFz+oJuRcthRqbEQyf3DVV7oYO8FgsHEpd72BHfepvifNGsVLuqOwkX51
 dYFhpt1gdJPgBt5udJR3FBpZV8TEuOOepw0dWB28JnG7QoZug0l4NsZ1LjhmVQfVAANU
 aYFtgBoUIkMTVMWxmS6K/XdMCdPJBDm6S8XX1lMdoPZk0+uRCZKyqi6fVhXSJVuocEcL
 lit581q5q03IOURREjj2Vg9Ik5jZfAlQ1mYWKPdajeUtpzRSxyes2RRv0ustsIpoogYB
 UHKHhopDAfhUIxC5ZcQCoIvPNqwlF0GuMAKWDVDsY5agNMMG2I+EcHUVE0ObC19TYxzu
 Lzhw==
X-Gm-Message-State: AFuF++kkWnVYq5+99YUk76I4CQvSyOtY2KYygfyNGIe9fI6vJkeAGmn1
 TV/Nv419Kla+kNkfTiNOsm/Yy5C8PKpbKRpNLm/Ik2aTzhWRBYnSl8pPmP4gIwd3ab4BKrFUrQS
 6QtI=
X-Gm-Gg: AYBFou2253oqS0z8xYJQUOce6gYiDfUsAdNekvga0R6OOjucTRK7Imd18PWeG/0kRhM
 oh29y4CDY3s3883A6DNLyAMkplM/V/yh0wjpB750yZp/MTf2bdNBOqzmYrqpSjPIkNOQesajXdO
 dAFeWwR9mpZEAF/Ze1S7DBoJMdsyS6fpx4+SHCgIDT94AdYPJfOnksr6VC5jMy+Wzwjn3nanvTE
 MNNMhQDiRfqK2PMq3SHHCtBPGAiN44kwf4OkG9Sb4fU/ZIxi+2g6B+VyZ2dbc+g4RrUJr/L9N+f
 NMlUvULdRjPCRMAwWqOpZNe42XY4d93WAqJbYyCcrG1fXdC3dMM5OR+BtYtothMeVg/tuBgohM+
 P1Dpct9A+ucub0JyPSgd8FMtLsHwM+2JdwpcTAQUvtpIXlcrihj/JCljcOHbeWz1poF9XzdeYLu
 kgZM/ARWQkp5qngCHCP7waVEeTXhjd1TJdOyeZKKS3GpgyFEW/BxB4jcmdIwP9PreUHaFBSucvN
 b94MFx8f3SYP6unxL9cTG5J8fxeq3xJ
X-Received: by 2002:a5d:5f50:0:b0:482:e263:2c7e with SMTP id
 ffacd0b85a97d-482f79b351cmr41843132f8f.13.1788164202272; 
 Mon, 31 Aug 2026 01:16:42 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-482fbab3f16sm23450001f8f.1.2026.08.31.01.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:16:41 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 31 Aug 2026 08:16:32 +0000
Message-ID: <20260831081638.19539-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v9 0/2] shmctl03: Fix 32-bit compat mode failure
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

v8->v9:
- use enum for type of tst_assert_flags
- update comments format

Wei Gao (2):
  lib: Extend tst_assert_ulong() with enum flags
  shmctl03: Fix 32-bit compat mode failure

 include/tst_assert.h                        | 36 ++++++++++++++++++---
 lib/tst_assert.c                            | 26 +++++++++++----
 testcases/kernel/syscalls/shmctl/shmctl03.c | 13 ++++++--
 3 files changed, 61 insertions(+), 14 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
