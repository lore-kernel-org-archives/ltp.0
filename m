Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C19CD98C7
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781521539; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=HRQOScWEAd6dgFYp8bSgc8wS2aFtBiqXtZZtSaInpF/wmNZGz9tQB/W618FX+u9KjEgv4
 BV6OvauBCiKr3kj0zXaxZSa0mUe7ZEn6mLUAcBC8NzjvCs/SDQIRA7yx4rveZnWqSX6HF+r
 KvmityXAzqBffvEBxrtqlq0SbjhUZ8g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547EA3E5C13
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:05:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDA8C3E59C9
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:05:18 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68792600841
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:05:17 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso39063375e9.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781521517; x=1782126317; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=PgZ/e8q+Kn0xjIL3OelLIlHD0CKwadgPLlvZv2V1d7cN17g8Vyreew2lprmQG+zm8g
 jpMu/Y8CR7ZV6BtEQ3RTpuytqw1lXc2otbJNMdDfj2L+BoJGsK1+3Dtlo6y1qXWZxi/M
 ipjcET0u+B371H7XZ0pgQ3Sg6N5hYlZ/pWFdfl5EeR3KJz4eak9aDy7m0zZILtOPwmPB
 oCVkdcra4tsd/YNMQoFwgSJwtGm2gDaT5iOhiJzoBsxS8nyYMF2Enf2RGrifrCOWKvVy
 49VFOb4Mum+GdVfmABtJxElDu6vjXy90CrM5ahrQw0RxSByKObMUrBjrWJSlo7wwKqK5
 cSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781521517; x=1782126317;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=CG+R2+Zmh+UPDXGo/CAzQgnR1StX22FcphgNyuzcSMAGvCRYu6JB9VOZxjSzwTqV6d
 ytAyHLBqlTPPaNGTcobU0v74w6s8t92Y3aN490ZAvNgvFbvDQiAKfBg52HapOT5OXUow
 qbAU3Msoe0a7U5IBzp80KLUV2qCBR5ZI4saDK4bl8mCM1x9kTC4Jf+G+F97sjwx7A3WZ
 XMV+9BE7om75Slgibwl0NT0xv7yNfp14d9dyRkTahVpqrsUwJFdjYhSDdJWovFkIrV7G
 4evk2fXcjNzJF/fJUiTx9th893pc4Mx9vcuyCwIrXYxwYsPiAZfMTKq0a7eBsdi6v7Lu
 KSqQ==
X-Gm-Message-State: AOJu0Yz6rrce2gGZMbs6g2c8en5vEa8fr7fjeeLNcto7JH6jy4NFrJeq
 tP8HDdHa2kRtcr1DhQnce4e3mxeejihj/vlM17KaCITQUXV6Sx3xAKC/ZTQXdfTbidKkFaUwScX
 UFafx8m/mNQ==
X-Gm-Gg: Acq92OHXkdFTrLirScwb3OLhx25hpYUMQLMlVpqb8pDhnXJLyi2GjRob6XrJUFSRYbJ
 p0Y1UmK93bSbiqPC0RhCWHuk3RcXn+EPPmE2WiuxeStFKZiM6sXBHp3Zh3PwE6O1hJhS+HMhhs4
 TcSoW5mwo/CDsQ9u/2zjCOs9I6oALyFBLM6RSY58k0Gu9P9mlmyoPsGyWa5cD/HsLS79XVI2/1h
 KvlHQLlpd+878JA3mYr/ghQMAsNbvpFFPtLW1K4NbaCry+fR3Jq/Rr0Z+UkXhqTTnYjR6odh3Zf
 MMYT+erhfycZx9Xzh9VjTQslm1YXRHNzeSYR70SuUCl3nGsOuMWGEH8tKS587DfyhLYJl+pnm/e
 QOjeGJGknblI4UUfJTBTG8KRaewwFfUnvWadDMBIrCsu4VILcxcxwDlw+CQGyRW2z6bz2XeebWh
 bEmFq95Ca7s5gUFw5yfzeAL8pytbMD2cufihSEEMHZdXLJYrL+ttzFH2A1Xy47xxduRb9nkd6/P
 APiv4dxgmw=
X-Received: by 2002:a05:600c:3b29:b0:491:ba04:2ce4 with SMTP id
 5b1f17b1804b1-491ba042ce8mr150934015e9.16.1781521516670; 
 Mon, 15 Jun 2026 04:05:16 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm36282043f8f.24.2026.06.15.04.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 04:05:16 -0700 (PDT)
Message-ID: <6a2fdc6c.7d2905a5.2ed87e.25b4@mx.google.com>
To: "Wenbo Ma" <wenbo1.ma@intel.com>
In-Reply-To: <20260615012911.36607-1-wenbo1.ma@intel.com>
Date: Mon, 15 Jun 2026 11:05:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix/pthread_sigmask/18-1: Fix race
 condition in signal thread join
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
Cc: Wenbo Ma <wenbo1.ma@intel.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
