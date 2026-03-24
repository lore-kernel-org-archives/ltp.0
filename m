Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B03E9A777
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 11:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774352850; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=2Vejlld0m/MP6MJqa/WmLwI42PWQRPcnhw5bntADXYA=;
 b=IMjL5/UkbRfx5k/MP0U7J5r9sg6Mcj7J1Pjk66fnRWXUru/OXOodZafZPMheRuv6fKNHV
 EWLM19vPDeKEAu7afh3ZIMDG5dgFFK72+918Ft8kWa0dlirIxRev738kVALDtKA4ITFzu5L
 k5tDGLY9VepIsf/tObo7tnEVVxvaM1c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 909613E4935
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 12:47:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CEE33D0E17
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 12:47:08 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DA04600231
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 12:47:07 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso11161775e9.2
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774352827; x=1774957627; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xGycWYaSYkun93kDU9tsiFuQ7MMzDlv0nLK6wzhWVsA=;
 b=YNThJ+viEiGxFONOtFdRHTNppCAkJSdeIr/aJc2/4MzPUxRrMIZpiiDB81n4uKH/Ch
 UC5RGEhZ0fOKbKJ4j1NB6XoLl7oN6LU8DrStjSRCD6x3KJ245DTjlRA4kKvsRULuFtyq
 NffUEwxRWOl7ikwCgfaafn2AMHXVa1MD8awEH5zqhI1vH+URsiWTVN0u9kGrtfAZRoCk
 pRPyBO3/xTavffXtLiOS/5fYcIx7NGig+saBzdlnZWm9Z2iC+xQfHGncEdj3lGP0gUcQ
 DpfErRLahRZL2eafHWdPweYMgjCyoipGJXjAbTxQCuWGknb+H8XP5WMUwi//877SW5Em
 lv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774352827; x=1774957627;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGycWYaSYkun93kDU9tsiFuQ7MMzDlv0nLK6wzhWVsA=;
 b=Y/kDXUJP48jkOlRzE6yAbd2PJR4aepnejSrdGNTmhJ9JtXpP1dKQ6Mb44kwY1dHNQn
 QA3cGxUIsrxwfOohmRCT8bRWhDhMCt71m1IbPV9zDZYKM/32w5Jynuwo5TfF639yvGOz
 ll2ICocsPSPs8emMvaSHLhnGYOI4/Z0D1UYgfdUycbD5jzdWfoeIQBW2I2enjZo2OZiJ
 OR2ML6MG/HE3Ju7cxvgSEwRyky9nQS0RneSXx3z9t5PIxlkahDOo90Z8CbSgOY2YNCFk
 rqWYJdm94VbDYJ+S/RATBVGS8Y3D2MiKgjnN3nHN5vW2Cr/cSZtrQWozwlLxPsj9v/CB
 ry0A==
X-Gm-Message-State: AOJu0Yx+3UqsLg3F7nxoiQxIVP4epSy1ElkasK46XaMRlLCASnytXkvs
 omUGj0wQAlsehfCRZOvbDq68sBzPOiHds25ZmexsyyfHcIJKbvk4rV0DEkdPu10D8JU=
X-Gm-Gg: ATEYQzx9VzUTcu1gJh1xBiMBElds0ynymWmhfUBJS5U3XwI0iyiiPs0C7J+RAH75HcQ
 pMKt4UR6kEHzK38Ec3GyTcMSp5ctycVYWecUsgJcLZkfq2XyJk9IUx1rdpm270Tpgj3q3QjOObR
 Ftuq5c7yGfL/mZHn+N5Yi4C7rp+TLFlJ3j1wQ9PR+8K9BRsKZ8TSa5N9QzSq+JHHFRCq+H2ezp/
 HOR8vfp4tjpZOsoYidmECvFZj0RvSjDrnYoNoCa4ycHl59XSdSW/YG6g3fxFJFvpvGFEsoyb4Vl
 QfHRqJ+TtMpcv20WSU4k0mgaFAOL0YpJWGxpqLCXr+KX8pw0eJHGQb8LQDowvVQZF9K75SwxF6m
 RMssmJAK76SjFX0AQ15cRFq1m/531U9t6RViD4/Hrw5UegG+Z07qrB5wbX+LCth/rQ7miIYOUSp
 Tkt/soFP4hMSJZ8Usjgj+M69oLMmsFLXt/MHmJh5Uf
X-Received: by 2002:a05:600c:a31c:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-486fede723dmr181958305e9.4.1774352826961; 
 Tue, 24 Mar 2026 04:47:06 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4870f6c094csm35993835e9.1.2026.03.24.04.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 04:47:06 -0700 (PDT)
Message-ID: <69c279ba.050a0220.27df7e.8a04@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260324104018.10834-1-mdoucha@suse.cz>
Date: Tue, 24 Mar 2026 11:47:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_memory: Fix hugetlb mntpoint
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

Obviously correct.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
