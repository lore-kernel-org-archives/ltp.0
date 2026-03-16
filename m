Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C041F46445
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773657619; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=VDxUhJSzWFD/8J8R1R2S6AshTpuJN3wv7BwnOBa9po4=;
 b=gnTxmyN2J0BdsmX0x4s8nHyL1/Xan9Y6e5cJFUt0xxuGuFeMu/FNdbR6UbFkQ2vqCTzrp
 Ufl/iBRg8/6vNtGX6lAxRBGAQ37zogkpsYCb465lDOH/Tzabqcq5fP48DtSnMa8CqjxryQk
 CExr0DblkRtg3d2l7Rik3ROL+cBYogU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F158E3E1570
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 11:40:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E29403E1332
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 11:39:55 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B5716008B3
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 11:39:55 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so52470045e9.1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773657594; x=1774262394; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CKdpTnoHrhExjeKI0J9t+sog97JYQKMnvroe4+hVHMg=;
 b=IJdB4bpdtrFwttq34TAoF1G/eLhM/7PBB5BUVgD/HxzTEje7BNrb/8N2KkIK7CUyjV
 3VBG2kccobfdU8emUbLEioYU8FOVAuMb3MLEyIMZL6FaIzsMpbAC5Be/NOJlrAtfUEmN
 16jlKEbGdjvpfhch7317QAmA49yvNz5j5pupf/pmN/3w1RUNzrB58bYIMIdqjGrJpbd/
 reOt4GUXaF1llZCK7Zfgg6cYx+9skM9qNgdssmQ1vUi9yE9SPajD7tU69d+dy19pnUgK
 MJH8vWM9s+HU5bJAfKyFpx0FyckQQt6MEoWIERfnSSssFSlEAV8G+TxKZ9tkaIKvfeFh
 uOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657594; x=1774262394;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKdpTnoHrhExjeKI0J9t+sog97JYQKMnvroe4+hVHMg=;
 b=RY54E7qZGd4gjmP8VFVFZ9E33utfGAjsjOYvXyWtELDcVnz4CkF4Ky5sCUk8vFuTtS
 GeJHY+yf/kMX5dLfMNUXu/VkSbTQ0GI89LAoOdZhZCs3fU5SQSrGxL1X3GC+r/5svg3M
 WxDnb8y9Gtntfpxfe+3GWHgoxdPQcLgXzc9FGU4ObK7oMgUatIbP0vkrJRJk1uQap9vg
 MEXh9guE8RvG+5IKQkHISL1sL5/fRTlelKn9t+8/fAGxnJDAN0EtXraLNYoOd901gyJa
 CA9+mW8uRLocoUoRTa11X8ln2xIqRnClopHIqjQebBd3A03uMIbBjgmGxKLPfwnVKp9d
 3ZrA==
X-Gm-Message-State: AOJu0Yw2YULobdF7NP7XuvLpNuo6USyDaAFNlBV6FmYrgXAxTJsIdnCO
 7s7+U5vU+ZMjEYMG4GFKzM4Hd9haJIDfzNsL80gH1ubGFF+rajkBmK9X+41CTVsb4Ww=
X-Gm-Gg: ATEYQzyNe7Y0XGjZ02LAQYvL5/EgOlgRUk8RbNrak7Jq4vA3PCyThpv45Dsq30uPaUk
 nFeCffCvsIfmntuCyDD5C4OmS44m8pm2nrXIYQHq+G+HZMr05LbJoqo9g5R5Sn4eChQPQN4Qdrj
 4GR1JiG8PfEOwIHvB+Ec0cJNdvF+0mJ0fdQxklFoe/cZj+WC5OBjBiIPHZIdPmpzSue5cG88LE+
 OGAaRHcYrvCEy4QblF5yRJq815IaCI5fETU0I7HCstFf7wcXmGeDNyigPRPWrPTiFvOhHul0pGM
 OKKvrPBs46ZHU5EEWp1ul5l4jtqGITxZoqNyzXRDYiYAoOLqifgWdWTqz1iq6fyxHgMskDBMiMJ
 1mICTSqToIF2tGPukV4XHF6+sqlWlc/w5ozwZOwb2wiy01yK3dGwyB47IYcRJdcKeWekQC+GNEo
 EbiLQxebwEt+TUjEUbsCBLqkLlZ6lF4vpDv8PBOy2gOm+LoqfkrdKe32FtzOh/3e/7i7qb2R33X
 rJCtkwu0G8p3Ng0vT7hfsgOxTxGuWKODLFjWJFuDCToRbLDf1DstbjMur23bbf9MfyxEAAeoBGS
 tA==
X-Received: by 2002:a05:600d:644d:10b0:485:30d4:6b98 with SMTP id
 5b1f17b1804b1-485566dd75amr149899435e9.15.1773657594514; 
 Mon, 16 Mar 2026 03:39:54 -0700 (PDT)
Received: from p200300ef2f4fc90053e282780f88a5bb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b65fd3dsm396214795e9.10.2026.03.16.03.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:39:54 -0700 (PDT)
Message-ID: <69b7ddfa.050a0220.48979.eb6f@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260313132305.16232-1-mdoucha@suse.cz>
Date: Mon, 16 Mar 2026 10:39:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio_cancel_4-1: Rewrite test
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

LGTM
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
