Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD37C4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 02:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1714010633; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=VsLpmnki/uZ3znB1qcPTONtfTdpbbT1zBfZQ5gCHSaw=;
 b=avpSHYq+EjC2ZD4PNdp6d2aw0LSen+G4B4cC7quapjRRaHdb1z9X4I3ut4gMFBCT3N1e8
 fSPO8Q5AF8Rw3WnP8d2xZlUpiMMtwdyQUdhmte3dl3Jf+NkueQx1wD14uVXKOBKLNm6TkJ8
 M8ZE+VJcFAu87UAwDEBri67ypeIDXos=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53C6F3D008D
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 04:03:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F2C63C7191
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:30 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06FE9600954
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 04:03:28 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41a1d2a7b81so8780525e9.0
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 19:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1714010608; x=1714615408; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SErYzNRQCvAH3LbUK2uCHwWfsqIMY4MYdaq2IpU3EFE=;
 b=cA2e2YMxvM1Vm3VPdxfcH95BxVS7clO0RPChbwZcJfJUsoOeZBDLk5+3G317c2Yj7E
 Z76xPUJcsgW1sLzBvtWElIruZHDxqBenanMhYD8hsHz6CfEdIBfQIqBBUtNSCvAJy9FY
 kHFK/GA2Xbh5nZQ3oeB4bHuALY4emDkQpVtLbM7LeZiiyntYM07+PRHi+u2GECCu5bMa
 VlVWntnRcf8ktSnFwKJf/rkvHwvv5FpUJhIQzOAvuFobKiNDs0q6EdKBCYB0j7NVaYQg
 Qgmw/X2Fs+3lWxZhlGM/NM/JdMPK7OURK+aUJULHXZk41un8jhvZ1NHibvyGLiXh6iFm
 BXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714010608; x=1714615408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SErYzNRQCvAH3LbUK2uCHwWfsqIMY4MYdaq2IpU3EFE=;
 b=JdCvlo+dSm38P5RKMHRS4H67GPkCBbYoqkLbnBgr2HpzGVyvr01X8LVgSY4goTLgv8
 YacDjbKIiV1hnI5m/cg7jup24RtuOp52xPN8W4gOyTqN+ZmcoTI+OYPUW6cdcAOknrYe
 w7Ryjxy//khitKjexNxtkGNbC0AdYH6HyQsslurteGTS1DdS4JAEaoeorrtCDoiKW1mh
 4qZFyicdCZNoS6jOfZG8RiPD0xHEvCX/S6PWngzSrcuv+G+EsgK0ndIeDLa2N4rRDy/w
 XK5TgJa6CcTUssL4UKb1+ieAru64lrnVXom2f1Zuj2tXSf42GSFDZpOy1iEn8jFWARzo
 b+fA==
X-Gm-Message-State: AOJu0Yx44S7KhqSjRW/CA8GHN/K9IhgoxcRXf/GWT3tjQc/GZRfPBVDl
 EzuYsX3kiWkvoJN7JVkYKAWasEEAbkzg1yZ2Lt7w8ixnCVfru7PvPMjBkYBbrEo+Yc0LQU5WgeE
 =
X-Google-Smtp-Source: AGHT+IHCTIi/W4j6zs9cWKsCLPaQ00vzdSxeXTDzmuCLDJgmizkvxIwHIU8R4QQRAjXGnJgtkVJGCw==
X-Received: by 2002:a05:6000:1448:b0:34a:e07:a2fe with SMTP id
 v8-20020a056000144800b0034a0e07a2femr1035945wrx.21.1714010607639; 
 Wed, 24 Apr 2024 19:03:27 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 g30-20020adfa49e000000b00343f662327bsm18723552wrb.77.2024.04.24.19.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 19:03:27 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 24 Apr 2024 22:03:05 -0400
Message-Id: <20240425020308.25367-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240415025100.2103-1-wegao@suse.com>
References: <20240415025100.2103-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] lib: Add TST_EXP_PASS_PTR_{NULL,VOID} macros
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

Wei Gao (3):
  lib: Add TST_EXP_PASS_PTR_{NULL,VOID} macros
  sbrk01.c: Use TST_EXP_PASS_PTR_VOID
  sbrk02.c: Use TST_EXP_FAIL_PTR_VOID

 include/tst_test_macros.h               | 45 +++++++++++++++++++++----
 testcases/kernel/syscalls/sbrk/sbrk01.c |  8 ++---
 testcases/kernel/syscalls/sbrk/sbrk02.c | 17 ++--------
 3 files changed, 43 insertions(+), 27 deletions(-)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
