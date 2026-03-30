Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD18FF4956
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 07:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774857511; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=BYTq+4ASF5y+1DJb3cOp1SQ4hDVOMZUPzXf5qRFg1KU=;
 b=FFpAVad3GyAHskqwInRTvi2ewm/gYHbmvFxriXHU+Zu3qxC12wKrsq75MRguq/oXekLZN
 5ZIsS/AkLB0l7khpTFaZBLsUIIra7BCL3C5sZHZPrmHTU2+LT2g7bcftm7LYbcADwQd+rpw
 lhhlBUjSnsAr4ZFRC0YHV0UP2vMMyZ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3C083E4EDE
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:58:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CA853C235D
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:58:08 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E19761A000A8
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:58:07 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cf906b007so604387f8f.0
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774857487; x=1775462287; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LofyRng60JmG5czWXwzDIEwNhRC8Nmk8FpVAjDLdIR4=;
 b=UrFdDQ0tPkcg/mdF7XU+RXmVX7XNXOVXpU8jLHCOVEm+4lVD8t/BdgiKkiMfog18b9
 u4lzwNPE7pPWXagIWzuUnTgbY+B24UoI2QqO+VvmN/PV589u/97Vj21qb1aEHR5+Cw1p
 WVnOOXlWzvYFbp6mBe8CYxmM8nfWM6ZG2UiBWiCbI13UnjKGWvs4tNN0/DBTqmk3kVrp
 YP93wGnSraVXxhVXwKT/l0YvPeDjLlyDc8c5vOOJV0ZhvLcHSKUe5zB+bxYPL0B50re1
 tYv2W9JhCIKdTvP424LFS24PkSx6gAiB72d+RHqP2zSPwj+417a2ZylctSbAEThlI4Ky
 iZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774857487; x=1775462287;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LofyRng60JmG5czWXwzDIEwNhRC8Nmk8FpVAjDLdIR4=;
 b=Cg8GtxdORVjVT72FiruwowuSWnhtQNLJ/JUGERrN2gBwR9fhyFpiL8Hpw0Q2Iqg3bY
 DB5UDosgB2wYCtfl7Iq89pheOEkbQ+OETcflSZCA9x8adgs0UC1wgYOad4Yi8fiok3Hr
 y19r9U1w0evpO7LpFW95V+rBosYIuGK5yumk0lAaK7cDQVjaqMawpmjqd4uvzJuamfU4
 t3AY+ulFGBc699YXC54YLLpMMkCw2GiMI2vW+Ul4svi2BVCcKxHQguFz40SUqd/qhR1R
 V2aTd+QqlNTX2YFJyWGXW+bAOc3Lamib+NxSBGIWrur/b5CjVgj2ck2mchJgyeBwd8sF
 nY3A==
X-Gm-Message-State: AOJu0YybZ3C+lULLLUGdg4LHPdcMsmItX1g88FPftpPkHJurqAyO87J1
 qptaPalj2W3jk6Oy2CiqdOGy2kxIg06gDk03glHqZUs+2CGGH+91yGJ02CEfuEcWRJiGPOxKnxQ
 O2lUPsI8=
X-Gm-Gg: ATEYQzzeRYnepVaTB3nSjLncsUGrLw8HeKuHewvFni8oCVI9aDdhtVjY2seb0WLKRP/
 WcQqE6qEmoDvZu9VZ/2LOiOS7ecSox6OMr0F39GjY+ilHlMi6d1KqcI7Fh2NQFk6unijQDQ/nBa
 Lz8wrKS0KbxPD/NvQPHxZIH7OrAqmg7WStqbHzBrWZnj4yaDTesjEFK02QP98I8U7xYgNvBa0EG
 EVXN0v1Sj8pAPqA/PVfN5INByjSkR3NFyy/hM5tny4GwaR8O1BDWi9PsPt4scVDSGk2hbgL3/VG
 yZvyfmmf1MTZwkoUM+LRqwSOE/ANwEWYjdODYIKrnBHz3c5GkYkW1Ahm1f+++PZ54UGAQXYLwjm
 H+gQPW0mZYuQydJ/QhF2b6jfPfATAwRyeLYGblLoy/JokSh+9csz397x3uGg7KQxnoGOH4g4Vqy
 D/XosfqoBphsB0ChuzFLS5NyEiUrj+RBUwUw7NRVCxLL5+icQ+UW3/WnDHGswQ4S4dLcsZTwynE
 yNS0w7X4onkAfZ/niHfDSNGX54aToo71fT9XlYoU3HUaA==
X-Received: by 2002:a05:6000:430c:b0:43b:86f7:2ecd with SMTP id
 ffacd0b85a97d-43b9e9813ffmr19261945f8f.8.1774857487234; 
 Mon, 30 Mar 2026 00:58:07 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e9e18sm16218844f8f.9.2026.03.30.00.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 00:58:06 -0700 (PDT)
Message-ID: <69ca2d0e.050a0220.155f63.a4e7@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260327160157.76906-1-rbranco@suse.de>
Date: Mon, 30 Mar 2026 07:58:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Minor fixes
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

Hi!

>  	if (msg.event != UFFD_EVENT_PAGEFAULT)
> -		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
> +		tst_brk(TFAIL | TERRNO, "Received unexpected UFFD_EVENT %d", msg.event);

Looking closer..

TERRNO here is not needed. At this point SAFE_READ() passed and we are going
to print the errno from a previous failing call (most probably from a previous
`-i` iteration) if we receive the wrong event.

We can fix before merge if other accept this review.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
