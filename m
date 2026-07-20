Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005EFC44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784569381; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=DYIAjrlOOz+I0cRHYH+XEYV4iPkvwiDxVil+yDn689I=;
 b=hte4ivU1+Z2BMui3pEyQevEwdlqDUxX/F3zfLna0jc3jIfgNkEMGU1zZVhj8kzD3/qBH1
 yTuiJYocXeZ4XCS1Lh3OqdtlGpbOyjZz8P2n7ChyZwxknQ4XJ1mWWo2jFreiGoJzB+7RqtK
 TilsTPC2cmEI6EH3MDaNEkQ+VBFdlFo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DDFF3E9610
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 19:43:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28C403E92C2
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 19:42:39 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A739E600159
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 19:42:38 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so2210908f8f.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784569358; x=1785174158; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aALfZjTteKAf1Nm2EJc3gH73/3e2m/6Tt9R7tHYyItk=;
 b=MCzWQ3VweMur/9/8a5xEBG9eNBWUxiAPExuKKpLqkbpuyqlEuE+BsxImCOWWjDxq4G
 oSl4DrnKW79TqNCx+fmBfH1NIjwHwzQpDLkTQ3ApaMO4+iIh3a3E2PRGwsLCmnsraIVH
 Lx+IUrKKdzyIB+POqM3IybzPJ2Nt8eElFCh5RzZQ0ye4UHx9pQzQKgvKW+SfRnX0rYaG
 jI1UsaVHnpmc5558iinQ1yevUdQhoOMLyavf27a5i+2guPjTx0B7/UEHQDBuPMpJol+S
 8DsyCbERLam8GVIylY/xVQaD42LYsgyZI7UFdCWtt/VWBP1hhP+CkR6nVw5DkJv3C1J8
 e9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784569358; x=1785174158;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aALfZjTteKAf1Nm2EJc3gH73/3e2m/6Tt9R7tHYyItk=;
 b=Q2aJIcCABJJ52NJft3jcKKSHIeBvjATlN3jeWjhn+h+/KJ5gfEY1NdyEjVDXMu2z3Y
 UKems/Rqhrg97rp6v4O4peRKp4EkIhwPVx/wV+WggF1RRhAeSCwl+gR2u7dScbIePZdz
 Z31lZCPmLzqastpcmYoBhKmAJogOy+fp4vjL3udjDv0R62jvvQsk9hV0St62RqnGkOL8
 UdzoNf1E0yzgxhEsw5dE8Tvbr4f6jSicWOxw+FHxf+6Jbf8x4k2aC32/NMiFm3Skr/Er
 g4SdIwBQIcjYooY0x6p6n2MX1XE4PUgIfZZz5G+MmZd+q70JVWLLfNPvGzGpADMdKmgA
 X/9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoILYHLP+eZ9dKLU6wl8WKy686yvOJoDaelBDMq36bVyKYSV/8hIsmLuaDF4IgL1shDSXo=@lists.linux.it
X-Gm-Message-State: AOJu0Yw3V4aDarD1JBUDim4ouq8IIBaRTRJ6jbZOnxAx5jftQELqRUXu
 RDJml8Kn6tYzetgyNQBZHwm1UIscTpk0EYJVXhZac2M0R4X7AsLjCI4R8+k0wg5CHOA=
X-Gm-Gg: AR+sD106lxiVVb9doSECpEOKIPeBMvHZc4ii2WaInfQwcwuijJ6bAL/VtXdL0U9ka4t
 N211NP9zYC5SNEpnPS4hhPaijgbTcQl13TvXnpUy61J+bft6KzB31hgT/Iq8HepQQUhsuDOrBUu
 1rIfKGfkAHmSSUT6GDcBRnWrFDfVVOHgjeqEzKfgAylzKtMeQFxFL7ElEb2WUjMrsO4HEv7Imbn
 jOWv0fd/kf8TBlhmhWjYGp1DpNuiGVF7A7Rh1PWq2MeOXO/RDOEXqBfkTFYnLCkICUZ88ow3d2N
 Emd3LarX36Ak+Pqo+YIIcvNPoheFDSBwgKB3AtqUKvSgkUTlBAz6SBmgM6X4BiC9Doi10i1xdhh
 S1JTdbx59SwT2K/jfd4T45/NYuTYBOcxjN1R6huFZAZZYAllL1FGrqkP8YgvFRBlvz4Au4Um80q
 65W0+14iEvHHo8fnW2y3/RKVZ1Xg==
X-Received: by 2002:a05:6000:24c4:b0:470:8e2b:9c84 with SMTP id
 ffacd0b85a97d-47f5a42119cmr25017278f8f.7.1784569358026; 
 Mon, 20 Jul 2026 10:42:38 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2313sm31492938f8f.23.2026.07.20.10.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 10:42:37 -0700 (PDT)
Message-ID: <6a5e5e0d.df882948.1d1828.94b2@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260720155351.4024-1-linuxtestproject.agent@gmail.com>
Date: Mon, 20 Jul 2026 17:42:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] setsockopt10: Bind test sockets to any free port
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

> Setting tcp0_sk = -1 (or 0) after the SAFE_CLOSE() here should fix it.

SAFE_CLOSE() already set fd to -1, so we can ignore this review.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
