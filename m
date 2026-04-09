Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4819CE9DE62
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775722796; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=jI8u+Upi5dBJeQjCj9IGACFIBvuzB8qEGD+JtHx7xCc=;
 b=otcfiITXzppxKbBvM5fGmB4ieM845g/VXM78MEe7XQRkEg5f2T8R1P7OMqmuex8Z16wlp
 7xYfoxDOTsFQrgPA5yf4uCpsG7YsLG98LTtHUsf+WFIub2ZgAHSM6uAVsL3CQXliuY86Ucp
 M+Oua55RLk/rBabFdphCfETPBBlsC/g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9C6A3E1557
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:19:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B75713E1557
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:19:31 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9019110006D8
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:19:30 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so3809735e9.0
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 01:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775722770; x=1776327570; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pPumh/2sXwE4ONXR37Sqj2hEBLGXGV1+PSdyOnfmHZU=;
 b=G+Q/5FON6E2no7xwPbgv8BHGEHdv5ACnSFbe+guwHldwtVgfpOPgSz0UqjISTi9oeL
 TAtDLdxPHb0LcBVfId0o/a5G2I2RblJQnnrkER7SejTcbldBLyfPyXoCBIiieLXoMNvE
 oX5JoMr8qzeYt841ueKpg/cmLgWoDkbAlM9HYsyD/mXampfdb+IUUDihHkOpqkq7uSCL
 vVRXNbTqRumfR91xgoBZK1vIVAFASpsGefaWYMUU0ty64HwwOySrquwtet3FR44MfwoW
 8cbYs7zpPdc2exenIXjyD/6ke0Cb2wBpLAh/6WXNtLvInHqSigMAC4XdSLH4rMaLRuEA
 RKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775722770; x=1776327570;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPumh/2sXwE4ONXR37Sqj2hEBLGXGV1+PSdyOnfmHZU=;
 b=lA1qpspqZwOAURRSp4nCRemlwkOpNYBPyTY0r9VO4pZOFeCgqXB5QjUBG6S+fuiE3H
 dcYtPhyuRQpysByNmIHnevB4qTuQQDvf9z3q/9A5r6cSX/VU8Kkm4rKptkUYDs15YAQF
 RrBiObB1GObNJx/MWlHEo/KjbFpaROp7gD1yaHeJ2POyaPvTlPNpYgu8gL07K6R0P9nS
 F2Ta1yl0fQBuyRLHfN4s6sKsd45RAkjcDe0APVxAclqFGuRI4xjbMoTPWNZFQsTPThoj
 9NjdPzjie8n3WbnVrmA+CpX+ZuArbEDKeYIXW36jAxUV2hOPHAxPr2HOHJeSlF5DCd+S
 1QSg==
X-Gm-Message-State: AOJu0YwIR6ix/hnJjmePoZsuzoZsoi18AsRbVFv6AwT3FZttEFNNJ+ag
 v0dA7SAcbdYfca3xb1HrQOEv7JUq++GgnxKewB/NjOed9eRrRc755NKKIHXdb99cvw9aSDpfb1F
 FQcxYROHpRA==
X-Gm-Gg: AeBDiesCW1SLDcPLytvtCXEtKen5nA2D8AHXU/uojPDuLIiDq+PjbLoNarpEDEbfq/U
 T9pSzK4pHbu1QOhgLwfqtQ73O/A4oIBlqgUaOU9ZmmhUTb1gSf9fwynI8LJ0Y7OSmX9lQM0Mtyp
 ct97Y8pUK3nTNO4hDwpsQb5Z6upS3atNKGSZ3DmCiJCFR/w7iRDryIZ8VAb97rI/U2XLRxB3KdL
 cM/gEYF2hqVpZoPy58kTJshdSZFkp98NtJjksR7CkuDzus6swxpGNpRoh5NvvKeBMw1tWNmFDq0
 tm0RN5uJhssfQC6qPHUq59QTVauDNTFY5cMeM6UAHJBEzAvk0IDc18fqKH4PoawX3erz+I6RonL
 8nnJFo4VzUYjHb1I4//x47mVLcbT7noXvMyI+RLg8xBLjGzfM5ZJCh5zFW9w9KvfQ1XR8mu/xLI
 OCufqDyaotNYcW1f05EgALnnKZYZnmEC+LwsdTP7cZENS7arRRDqZeYd+xR+nbRijVS5FmFrNnc
 eAQ0iYgWD34iwuukG/UgyrvfE0qX5/mbIowG7mm/GQwSA==
X-Received: by 2002:a05:600c:1d21:b0:488:c6e9:1e0c with SMTP id
 5b1f17b1804b1-488cd5282demr30360195e9.5.1775722769939; 
 Thu, 09 Apr 2026 01:19:29 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd11a5ccsm30851865e9.2.2026.04.09.01.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 01:19:29 -0700 (PDT)
Message-ID: <69d76111.050a0220.2d9a31.f219@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260327140310.2306-1-always.starving0@gmail.com>
Date: Thu, 09 Apr 2026 08:19:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] open: fix cleanup condition and use snprintf
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

Merged, thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
