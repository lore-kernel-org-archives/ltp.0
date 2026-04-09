Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B69F31E21
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775746327; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Fx3MlyXGozrUhmZjpXhefFeEZZjMyHMqs4PG58/Sk00=;
 b=q0JVEIaNWbAcy3+4poYjL9RyhoY3bDsac5FMCfTW5l2rA6jUeMSYRBUbkTrUgGTtdhz9W
 jOeKVFtliflSSK5i6nGma2JsDEer5x1Mkv2sLho129RQiSGU+r/x7H/jHdP1oyrobx09qp9
 ra3oATEc1eGPvWKR+nEzFXbcCuBYuIc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C25E3E5447
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 16:52:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E7DB3E2A1F
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 16:51:42 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5876614002AA
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 16:51:42 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d5ec211abso423299f8f.0
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775746302; x=1776351102; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JFMGBNkbyxRBwOBrfLVn7WlfM/W7MRpzxEyXcS2QnEA=;
 b=Rslo6Z5YMMI9WqNFZwA3Qb8hWassfkUpR0l2jHA0d+wPDeo9V628c/iKcPhImoRaSC
 k9+oYy4LKnpz+ahdAI/S8bywW1e6xzcuRbw5dBnW5BH9VEc19CQGZUbQtiEEqAkZZN4r
 98J/623amubjRAuze/uPXueoau4iClZQeAj5FQcVTx1Z0/Th6TwEq/GvZZR5oF8BJxAn
 S7wpuB8OyUS3zmFj+hhiTOjcBGx/sp0brI6yUVSDhbXw8WBEM47z3e2TTLR10xlLLps2
 xk7sQ34n7oncyp3ohAXyVceDNT7radKxVR6M3CKmGdrDrlkYQ0NiBL2jj96mrmLMxkGc
 uWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775746302; x=1776351102;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFMGBNkbyxRBwOBrfLVn7WlfM/W7MRpzxEyXcS2QnEA=;
 b=n6BS64r7nE0hisHuCvrL9mGTX6ofJoTPcDXVT9uV29T4MrfXgRhWpWXV0NY3tZvACL
 iVOL5BvJmQTHWVivbeIPCLvH6jtaL4CPgRbGN4oMQJMUoNL6tY4tL/SaU3ms+uW0LyZ6
 +Sp74zGrFCUzP0D766fnLozy8YgfpyAkbjjJ/tlqyOEzMstxlr8OCF0+AYBFp8/JXSNe
 UhS13lE1aa4Cvqt1NzWAGrCm12mXD3QUWoBIRiPjAS4v+1L+MdUv7VIBjSarH6nD5m+p
 jL2H3akneCCfX5n5j3Gw5/vrNw22FQiV2AsOsvxws7wtHb+2vym+JubIfATTOsBeYamD
 gOgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrsTf41eGpo/KNy2L8OKKUggpshY6hBsI39vxW82xuyJ/GWrlwjQfOQ1u/RjHfZVzoumE=@lists.linux.it
X-Gm-Message-State: AOJu0YzBR4ogRtnKkCRHMiBv9msGuGepOOfJiXPg3Hn3gd8Q4Hpjbg+u
 sMsFGLBD1rGxb6Nft10b26WPx/LKyOTZ3z9zkSD/2N3NOgJG9Qy6Fu+GRzF9t0sXoWutcSaN4IJ
 CGfssMdSqHw==
X-Gm-Gg: AeBDiesCkyxWCNO3Lg53fuYcR63RQcFE9eqi6Ojex8hOtvqHoZjksbQUCYB2xILRv0u
 ueDgv/pKq7sSYSdcQuTEUMhulA6BhhlP1XdR/zMHJgvCVQ20jd/rbM8lNU/s146pfxaPSMP5Jxm
 HvRuS8zXPb6gxPsg9mfPB4iBvmlL29SpktlAjWWkA0XDhP9L4OHqU4LEukwJ8uJCZ6pR0ETKC8x
 EHMAjHlYmE3veKs8EdwWpqPkGpsPa80Lh6NCaSyz5xfjIjnvuXQ9TTSiJJPUqzHmmBsP/0QxG84
 mx/dP/1G7bRMN9eP9T2ChutvYvAbICev1HDcupNFAt//w7WsTvlf14xHRcCa6YIqR1Ofwcff1wk
 hhPRhyWujuiiQLMGkUmMoyfGRwZgqgVJRg1NW2CcW5NTlznVfQjsTGUKmITZPnUXjiG3ZwknbR0
 Ojl2kJDjr7ClaUyShMDPgPSPbuBuMzT9G6j7nHFUZqvwRWC9ZhHKSOBgy6oa990aFwm4V035tN2
 PTkEiXYNvhjJNJ3XoV4piNADwC6z7pvjwSSv42qz1sZP6cGP1uVCXnguJn1jieI9SbijMDDKapD
 spjjhKZOHQ==
X-Received: by 2002:a5d:64c3:0:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-43d29276ac6mr36510627f8f.11.1775746301653; 
 Thu, 09 Apr 2026 07:51:41 -0700 (PDT)
Received: from p200300ff0f085301c60b3f6236adb066.dip0.t-ipconnect.de
 (p200300ff0f08530146115d0b2dc6d03f.dip0.t-ipconnect.de.
 [2003:ff:f08:5301:4611:5d0b:2dc6:d03f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a6f73sm72343676f8f.8.2026.04.09.07.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:51:40 -0700 (PDT)
Message-ID: <69d7bcfc.df0a0220.ff8d6.b1e2@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <69d7b49f.050a0220.28f87d.4332@mx.google.com>
Date: Thu, 09 Apr 2026 14:51:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] userfaultfd: Add new test using
 UFFDIO_CONTINUE
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

Hi,

sorry I was confused by the patchwork interface (sigh). All good, I will
review the v4.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
