Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F92FF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777447350; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0hXDD8dLnArOOzKAnaymgzOg90mobsE+/giIu5zK1mU=;
 b=gO14z+TASVm4T2oxnW/S+xPZzQZ2PJ0522USV7h6gD0/ESYTWFeULhm9hJqSrARywhJ9y
 0/o7/UZE0kcRYuRJNnN6T0Q6MInddyekj9cfLPU8k94FP/FjdlPuOvnK1Hs56gs7H7YDAKF
 GoiPd4PKRxJACektzeDRT0GqAmcaIg4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580373E28A0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:22:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B40493E2114
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:22:05 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8433B200A0F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:22:05 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so148119155e9.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777447325; x=1778052125; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8DTIBxlqO5bxlH8d5cVGDmXsFj/prWLZNoobwn5zd5I=;
 b=fq8syVIuX2nv4SU7bz4NLduLCiavIBgR0rUvaPq6gWVBNIGFNDHyJSt+mzzGxRHAQ9
 yZ5c5lGG2W4TLjHczzgRqP3/4K29kPJiE1n387WMZCvVDKHc1GfLuCVHlSG3aMXNb9JL
 oeD7M0fUPESXVszuSk5pQSc0xWBB2gG/Yj+J/p/scqQjYhzOzdzoXDQFA03dxp5HolKA
 IW0poAh03VtDx342gAaEwToU8zXAdV9SRx3IBrAdyAUH77/rMJ6br8tIJK96LKhwC5oQ
 ivl+YGy4UOk/U5IDK8wl/UQ87AKhGTTT0tRk90N3Xr2hfm5+Es6zC5BeN6NCApTSsYoQ
 iDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777447325; x=1778052125;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DTIBxlqO5bxlH8d5cVGDmXsFj/prWLZNoobwn5zd5I=;
 b=I4OuVk1WVI359v4xdQZilRyW4gHB79i9Ba+bXU7AkhlWqi/+t6MDpuOIV5uzL9wMfN
 FI6NiLu+he5WxBcaZWpWVrab+4E15wtH0aJQLhAqLfRY51xfRjU3INyi0jjJIhZPaE0g
 +9JN/Mzfp5sl36Py8lORt3X84I0uIK5ePRajfzJXWSlwbOjj2EOFRLOjaah49HlVh3X2
 7eEQwOcnNFW0ZscHYfxl2S2DGWKxw8+HgAWc3AeroJIJGBbTSL3l+WkSeJ68BLel0McH
 YRvcGDKBvDhrHY2q1yqM7cEOf+N7mknZsz1PoEIraIQ/vTEsgxPs3wj7kWG+S5jN2bSx
 kZkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RtlXmZ64xoFU9UsNebr8lTCccj07DDLC1ZmI7McNwserAYGSPSlh0+dk2pEyFrCszOEI=@lists.linux.it
X-Gm-Message-State: AOJu0YxxQF9FKuN2wNJ+KWmMldWu4M8kBxMEWXBzNsrS5bbQXlIjZtBM
 yrj7YsMZaMm2cpKiro+aIzjO5AbkrdjuDIUg+HknsuFCOBdJ13D2Iz7w7wURY6nHBQ0=
X-Gm-Gg: AeBDiet4FJKm2hi/o5vR2srIqSh36HIYjIBp5/E7vx90m/IvsJQk9qtxwDYP4k61rGN
 KDAazhGcMhq/UkhsztPuGJEW9SOwzpT+W1tZrWRalbcOnPQeWan1YXOBimJXmKcIs8KC/eNggq4
 JnGnDzsLuTz1I5IuTvxbfbMT3Y3zBz8q7bsuds71lz0BBVHQ6aXn3N32AKUSHZvKzUais7lgwdl
 Rl774EPc2jWqJWuRnwszw7mjA/3PJzrXx4jD8PJbkq1NWBYxivP2qRbaaqJS+4snz+g76cKA4Wl
 ULMznPxSr5a1dJT6y1I5t7mAhjSg+zEC0NkmxTmoGIsNXskWDrnJaCjAk+VwAkHW+AJeL39G2QC
 bXmhyL6VRMQyVW5yENLym0OJrgelXf3bn0psrneoLKQeu1lXbBl4gtZbnGqG3Zgh9Iib8yLIo8u
 70wlCWIaknxxTlpWpiZpZLTyy752J9cW+oJy/UYLwGPZsJPWAWUiDBZqUkeun9Akagxl7Bk4fFC
 Nfe+mhZEXAcqSSXzYhHTH9bUxQHvps7NNJ/fe6994lhUW2dgdw6DqCYni5z9xZht+k0+J4l7mWs
 EL0fdbJC/QVx
X-Received: by 2002:a05:600c:a315:b0:488:9e54:94c0 with SMTP id
 5b1f17b1804b1-48a77adc73dmr71294625e9.8.1777447324843; 
 Wed, 29 Apr 2026 00:22:04 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c305371sm12128145e9.18.2026.04.29.00.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:22:03 -0700 (PDT)
Message-ID: <69f1b19b.050a0220.12d48.3521@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260428144259.3779-1-linuxtestproject.agent@gmail.com>
Date: Wed, 29 Apr 2026 07:22:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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

> 
> New Open POSIX testsuite headers should carry a "Created by: name <email>"
> line and a brief description of the file's purpose in the copyright block,
> consistent with the rest of the tree (e.g. helpers.h). Please add both.
> 

This is correct, I will fix it before merging it.
Ping @Petr

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
