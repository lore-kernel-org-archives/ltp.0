Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E3DC43458
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 05:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783403309; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=bXkPdpHSBin10IdUJF91New34AdmSn5d3gkupiQPlec=;
 b=cLiiEr/KxyAh4GorkhXoFsRC0xw62J4Rs+P554RxMb+hsuR3CHinxLrZCMtD2e6hq90z1
 iRYRjBWAtXA38A8uW0nBISEdiL0gA/X+NOi8DtLswCvWupHU1oUOiISm3zdP/aCTZOX9uK+
 qqFGsPLcVtrU7SMi3VDj8ZotF0oYxYM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3983C3E2A85
	for <ltp@archiver.kernel.org>; Tue,  7 Jul 2026 07:48:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 265653E149F
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 07:48:08 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9722D140077C
 for <ltp@lists.linux.it>; Tue,  7 Jul 2026 07:48:07 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so2342358f8f.2
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783403287; x=1784008087; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CAlzBOUsxO5SDerNDrP8k+HqgGB4HhDY5e9w5SyDrc=;
 b=XDxUwsGI75uAaRvb4fmjBb8rJMFHq/Ok6dYDW4k5sPfSZWph2hpgVMlWQOfD2v6r/H
 YP766MubZMDw5u20pPus71f2cPsp4mkfllZJuZcT210g+AnbXBrFUIvLP/dpW2P4aUHu
 fgAZ0Lf9GchgnBAx6CxAW/QiWy4RpzQyWM9hZ2BT+MYbT0WsOxQDPQkrW9L4vALxKR6q
 52SSgx6uiBJU9FA1qup+N95e2JHicqGd0tEsuAmGzKGGdbqWod/TusA4r9KpBpZHraco
 jCpZGnuxCfw2CNdoA0qAjH2r2GQEGvZDE9rEDCO7itjrNCOT8j4EhY5VQvBImAU9I2BA
 x1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783403287; x=1784008087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8CAlzBOUsxO5SDerNDrP8k+HqgGB4HhDY5e9w5SyDrc=;
 b=BeJlw02uat1IRig5d4hjccrLFDC3fRSrAf25r6kcEls5651WvYT/6EEQ1lo0hk7Kf8
 svyH1HLTa5XLwb6JbzjiMjWGV1q36HYDVbtbnL9oawSo5PxPkD+VM9ZdF03KaIkRaGop
 huaIAzysUEa5pi12JvdwVTV/fZwfbMFdbC1rogmSMZfZN3Nb1CmfvKDGTjsb/qrI0MLt
 pu2LuhcVydPBQadh+oCD4kSzfqkz2C03rekpA1byFrEcyXnoxkj7V0VFULmElsMuOffS
 P+GCm6g0BEDQpQjvSQVrkgnS7uEjVoZhZRHvhSNY2DJiyYxxTxFgcv64vqXdTDR+X+uU
 Araw==
X-Gm-Message-State: AOJu0YwGvlPCLAeBP+IGHHBLDsNq2xJD4sx53Lc4cVV/hfGN1PC+IKbn
 Tl5auB1Y4AZGFfuRd/pDWcgH1O2DwSIRtAKdYR9Nndil293NhytpfGyoPTX66kmWeyLswc4nuZV
 0cKA=
X-Gm-Gg: AfdE7cmvJ9qMWLrBeiytLiJLuwGwPNot+wgphSrzRDXEXy/PbSHcfA78luDZNKzIAxE
 30qadwRZ9RWYBVgqRWdcaG1aEi5YIGswmqhcrrTStHLwBh27ZgTbQ58Gatx6xvEq/IC+YdwjRn4
 2Gd8yO57mogOBcfbdsICEcdzbkrrpR/A63gGt+CDmEMtj6xQ5Ms8Ds4boA9UG9sIAuh5Uk4JSXz
 bDaVYALRA7glhpDEwdnEallElpek208+SAkMHFVKT9qzIhMl404WSJS8c4/ot7c7xhFNpcL5NBi
 DpsFWShsINjc3TeBlBQtzhGQV/hVRDXMV043APvqIbCyv7iBeMDsOjLYWc0Henky7/rJMErlA8L
 rzQEAG/otlzRks6aBo2hAPOsslkyr3Mr+MAjVitCSAEIKZOkF89u1UK5DqClOE1eMYwmyc1MNAw
 aH
X-Received: by 2002:a5d:4289:0:b0:46f:9db2:8ebe with SMTP id
 ffacd0b85a97d-47de66dc138mr2704896f8f.42.1783403286958; 
 Mon, 06 Jul 2026 22:48:06 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47a9e4d8410sm31158555f8f.15.2026.07.06.22.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 22:48:06 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  7 Jul 2026 05:47:52 +0000
Message-ID: <20260707054804.24232-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://patchwork.ozlabs.org/project/ltp/patch/20260707022959.24088-2-wegao@suse.com/>
References: <https://patchwork.ozlabs.org/project/ltp/patch/20260707022959.24088-2-wegao@suse.com/>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v10 0/2] open16: allow restricted O_CREAT of FIFOs and
 regular files
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

v9->v10:
- Update comments for tst_get_free_uid
- Update logic of tst_get_free_uid

Wei Gao (2):
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_uid.h                         |  27 ++++-
 lib/tst_uid.c                             |  28 +++++
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 134 ++++++++++++++++++++++
 5 files changed, 187 insertions(+), 4 deletions(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
