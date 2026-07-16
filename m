Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555EBC44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784199547; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=ZQ9b9IbBjYpIiq6u+aw57XJqOSF38G3fZzkfJ3Pnnq3zkviEYVWQhriiNH1gfd9cBqSmB
 Ol+rlwwtfzgeEKONlOgueds0CN/bN0DaSrcHblsqvURd40v2LFc9fqwjHP8NzBz0ry4YliB
 Ng9/tR5OL1cad/0qtoKrEHYVndBg470=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB49C3E2543
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 12:59:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEB103E1CE1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:58:46 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 63ADE1400C6D
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:58:45 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so40485895e9.2
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 03:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784199525; x=1784804325; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=TXJI4WhD+60zvmkN2Fjqrm7/QTGWbvND9HpYlfqkQ8LR4pkPnOPFI2qMG2SvqHjNyG
 B8A/1voIVj1KRQJEs8mJ3WP0mIayw+tnEhRhFUCIc4FMA2nFDY12NFlSIguQJaXsaLQ2
 WLt1E/avT6e8fPh3jOTw2GQm9mWSndvSUpFx7vhrACR9XtmvbWNmTqGRnr9c1JrsIec1
 HjOsOfaG2ZxBViD5IZi1BbW4maRoXX328dcXYRZ4+stV1ASjHeVpIJHvzDLEJTTDsglj
 SYxmOtltyk8k6wY5gVIpRDXuowkKPuUVtCeb8T8TByIhDjaqQbYbgV7L01DylnfFMJzr
 m51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199525; x=1784804325;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=PaDbiJQZXPn6ytoBF+xd40j6yPqKvGTY6OEQg0jyAY2D6m653KOCvoArj66hUv1Och
 r/j4HFNj8mt7HVlnVcjnW7zh7g8sK5HYgvsLmxoqf6/lb4n1TqQP7rHRrJRHsBePGnZ5
 NSDozKMslcgIW27HW6/zMGxTuOq/i+bXI1VtnRQZtF55TACOv85pjm/xbCE1O9ielkmK
 4Tk8014aFw1BqZxUMoHMwn1gTCKWwthVZu9zqE99eRYj5IEB79pvgNXI6hBAlhUliPUX
 KUHpxQofefkD03DhAFABaYF+HNRcNhJvaRYHTRyiLBpetEP8Lh+1Of9Tncf2AfG6wcJv
 fK/Q==
X-Gm-Message-State: AOJu0Yy1PAjzTg6b7tnJldgzcaH+JX/y7fr38MfTiEDO8Tp7xxp7WbZ8
 7nXO1pznZDmpuqiin6tvmBHqNmWdnyp/bRKan0k+lS5SLOpOV3dMGTpUVenVD8ATdY2cdpBLoVb
 ViD0SPik=
X-Gm-Gg: AfdE7cnCKymU3z4SzVAppvNrvVaFFV04iOwN33D9ZeCJoneooBnwJn6AlTOJD7lPnRa
 SmlkGLiESmHvVT6W5sTCJ8afROg2YaWvic5FnUqQHrjfczV90KrjGWrzfSdJ1JGq86gqvmqCx/Y
 bZlRtCHdf1Bx1XuXZma0ga9Y3eVTbROnlJY+uddfUDcOFFVulPaVhov50DrpC03NFjmoa3h7noB
 eJ5GC+8+sMAvBB1phmA9fLbscCTtfzkmBItyouEYnYXE9CuJ0O5mJw54+kQwarWvhwUwosKAja8
 S0XWdlU/j5r9qq9Vh7ORujibtVnOVUzIXJpT8WqHiYumo1F3g/9RIth/aIR88sk4jBPPWTsQp43
 N9h/cfYjGlruCEi9XoE+lLAlyIxTWSemil4XUy3yClVv2O5gtNbDgMq93F1f+69genYHQ4lAOfy
 V1Qvh+FoMSALjqWa7IiC1nDQ==
X-Received: by 2002:a05:600c:48a5:b0:493:c6ed:a044 with SMTP id
 5b1f17b1804b1-495389dc98fmr80587425e9.34.1784199524710; 
 Thu, 16 Jul 2026 03:58:44 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541ebe485sm47571275e9.14.2026.07.16.03.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 03:58:44 -0700 (PDT)
Message-ID: <6a58b964.abb839ae.2f7437.7af5@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260714075710.894370-1-wakel@google.com>
Date: Thu, 16 Jul 2026 10:58:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] madvise09: Reset cgroup limits before retrying
 test
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
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
