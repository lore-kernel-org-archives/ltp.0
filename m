Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB108C624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788518517; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=EIhcyOKeRVCDX/0rre7bhsRwwVVEPIh8NVYB6ROusfq0ZAQphDDyVkhrmUC0dS84X/Mek
 m7DOwx/ZPMButsWT+bpWNKRbxrKYDkHQoBgiymQ7NIBR6cKWenS/SvAdJWkdQ9svkeRUpMY
 mfdR95q02dMpJX5UeWc6Cnpbxz0Twhg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A3C23E9745
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:41:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DC863E20D2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:41:36 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9BE2C100112D
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:41:35 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48441a2ba14so722319f8f.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788518495; x=1789123295; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=dNeJi8eI187RBl3uuPuhGLMWahqouGfWa6XYh0e16iJdAiYX1KiOPfNvGwLYiicYkY
 qgK4F0xs4+5GXEeAKXvpm1wC5sJNTEvS0fxHYG57EMDX5jQxME1zIfAOF3o1DaVCYVYa
 OtXOI156OzsMLI80an6gBRyikZDBGHR7cPDtRJYjvanA0xkxvLnGw+YfzKUvduZgWVjB
 HqVK/fBgeCDsLwDJfN9HTfSq8MVl8WNVSK45EEbEMl8u5CAZv6C9NUNWFJbgGhLR7uk3
 4618pHCoLVHJ1Ac9T9x51NPf+qQg1+2WPIqTeeryk6yxETw7S4UDYlCvC3y50pVOewAx
 nghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518495; x=1789123295;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=O74cHnyZSVfwfONxOTdUjf1SoHSz6NGdT+u8XhzD0e29BSQcP3UH5LA5jzVo3t/Okc
 P0t9v16GfqphojKGtm0yN+F5uGSsErdViVw9ldQ7OtSa23R1rFnHODcXwRWwB+aFHcVL
 o3b3b6lPXpP2kGZPXIQy3gT1hLAlLAkGJJkYfcZGyGZM+oBU45QDp+zJg0PmYxUGq9uX
 Wd4Dt78BQ7eEgwol3PTrVeSH0ZK/EFPNIBORRCp+AHsFfWm1Syfs2QR7yGlsNYJ2fvfR
 yRI+gccssAStQdSf6WjeKWGLsUE8ZaNctCgvQMyLVMo4MFwlzVuWHVl0Sfh3PR8YJN5u
 FyeQ==
X-Gm-Message-State: AFuF++nv5S9RpP2xsik046yUpyRofVy4KXXoy1AI4/hbZm6Ejde5H1mA
 V3NX8o0+kDC0++ZXnsHvfQdaBkAVnWt25ZBDTTbX/U++5+6nZ1eJfhrOxP1mlGOEC3s=
X-Gm-Gg: AYBFou25nCfi5kfsL2bwA4BZ+sJRKIAAjSK0G2k2e0VoKE5XVgnN4mzoeR4UoP/qQsp
 YJF8QmYMx5Z3K3KHQRuFA654axoc0fxIQg2Pyh5UwdW+BQwojwt26B+gnZw/TJPMrsSKl5wzfUl
 /ZKGmya2WFXVCkoZbQSzr0YObrFiWTHRFrrk6Mut8H8Fo9HdOJf5DS1bmyRYIKCZ1PJSk6DIC2t
 1FyawX++98Mjq1Jt8Q3kygRCiAs/Y8/Uv4nDzD7NyHNUk5Rs9151im/uL8EC3NxGO6cWanf1/Xq
 NCP/Q4uCIWsXY37623Xt2633RT3licxv3ekxkKfulUHBOu9+xmShTcrEkucDNoT4FQoWyITjz2X
 d2FZqdVM/pE6g8OncBNrGTNujb1/X8AH0EDFTGMVqBLbA19LXXZ32NI84d645+cR1EDlXe5/dWg
 L337K8vk3060gASf5BEbOs1y48m72eURpMZniNdAwYSXtfr47eKXvdTAuYOMQvRWLglQVLMRSsA
 PTaBwAaKWUa
X-Received: by 2002:a05:6000:2209:b0:485:8a46:7057 with SMTP id
 ffacd0b85a97d-4858a46719cmr3750135f8f.41.1788518494855; 
 Fri, 04 Sep 2026 03:41:34 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588135600sm4599023f8f.2.2026.09.04.03.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:41:34 -0700 (PDT)
Message-ID: <6a9aa05e.18b7d65e.17573c.3511@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260901224512.1180203-1-wakel@google.com>
Date: Fri, 04 Sep 2026 10:41:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/sched: Fix sched_getattr/setattr fallback
 definitions
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
