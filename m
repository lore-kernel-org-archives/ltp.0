Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF895C5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786443375; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=EUJpywDtYnvDDlIC58vVlUiSa5YdDrxiyOzv8TY/f0Y=;
 b=Hf/WM3TqhPczdVfap9LsI0BNTEm17XuF8GJS9Ga/7B+nmrpy636cNfdGeo9MqhttImihk
 mvR88qmntQ/cre+RTtVRVUBbQYwLRQH4rzIPrhuOASrOhXqqy4ng2heH34VMUDm3CmCCfMf
 m94soboS7G6aSmZX+3re18lZ7tAFAs4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A92F3D0523
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 12:16:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2864D3CB92A
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:15:56 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A05D1600653
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:15:55 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso21452505e9.0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 03:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786443355; x=1787048155; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6P72V9fc3krkRRb5Lh1s5XPcTzfRf+rC4v7gCt07kBM=;
 b=ZISZMaSHzzApAgwHBXOJfty1FvgnVaRzKVqzGUsYzuPJuNvzxnmMf6zEf4Prw8euvA
 9EchgpgFl2E1ae5elSHcv5pCsanFxIaorsDuK/xExqjgURwDFVu68RsE0wGEq0peBIbP
 PrRsVUMlBcpvhpoJVDQVcKtcSZhcJicdlC6DNzeYwH3GFrRakexcSio1EROWbGDSK7T8
 j1JzMSRHz6oxq829e4J5tZ4eBhu5hPYQxeKbQCIGPorlVUZ088PjKrB609Ymi2n/mRKL
 DTSCD980oW9VjVeG6oDh0N6TEYqOgr+lAk+k8MlyMY3ysQTzUTuwg7kF09eA4qkX9Jaj
 pf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443355; x=1787048155;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6P72V9fc3krkRRb5Lh1s5XPcTzfRf+rC4v7gCt07kBM=;
 b=fSoV8mQU2/23wdb767IJzQ4eskKxLSRcvrd2TNh/JzSeKNpgT3eOPYLEIU0YEvxLdH
 DNPtrMWCHFUNuTjmouMS46vHA4VL+MsGHzf9uZSkpLtdb7GRF/3DYjwJxrpPJW8qpKKM
 c5l6Z7lVnc5eRtFLFlli6Krwx5JySCII6AJVwY7JCNdbm6UYImeTvXfcmWjCm8Wm5dBa
 PtWQ7E+wMjt+VYDUJKNTBAIywwcgkscxGKUZzzCLoqLSSeqdLssB9EIQP0fjhek9dn9D
 ZPDotNHyq/bmUrctw2HXTfyIZcg3m09KmZQQVtMztedExNaatYEBtr6d05a1U+8MY/MG
 imxA==
X-Gm-Message-State: AOJu0YynJ6uAZLr+fkZ2q+tNCSbpJllgivyuzkEQP506in5gFM4rJR7N
 HXh/qS0QuhjkV7CKKhptKRQ3efimVix7bofVNC7izRJRP9TQg99LZGEXqdvc0wpEa58oTUhIwW7
 02kRdsOM=
X-Gm-Gg: AR+sD11PCwTGNNOCqs5hWap7zl4bqjl3BKGzH7JsZ2noa9jmKaV6+JH/mOm0zgyHdjV
 SXZ+XZaieu6mpyhchAm7rHIyk20xFZj/9ZqszDBIzcWpIthU87UEeiv0LsitkaXcyi+gurDrmum
 VH98XBJB8OG0gXIftlloHrhWFw55UWyKd9oWfDBxfRFVRsO7jeB39GOvGqA2+THeMZlkTSAP6EL
 vfxKiy9zdS2P9qwBkPXdSXlAZ04hxeqK8cYn/5IPVKk/UfoSERSowtzeufkFwMN9V4VFp7+6CVP
 +H0UzVTIHC2qIc+CmimPdRvoNmnPSs6ElGyIYB1zroMSCqJUZlUUyRe31d+Bn5B29f6lTybstb5
 VsFxr2gk5cxJpCKDU9v8UnRozqJTOylS0dzf7hG/Co8QwuPRGCvtlhegNSikmROdzlIf8JYVx89
 VHuihIttZ+2rYqAMxcp96KzAz41STX80zR3UA8LNhUSJ/NxsqVu7h263GLLqP/DZ0FDb+D1g==
X-Received: by 2002:a05:600c:5289:b0:499:7410:545 with SMTP id
 5b1f17b1804b1-4997846adeamr40237125e9.12.1786443354948; 
 Tue, 11 Aug 2026 03:15:54 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788f11b8sm36620085e9.10.2026.08.11.03.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 03:15:54 -0700 (PDT)
Message-ID: <6a7af65a.24f60c78.2beb43.4fda@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260810083009.1846957-1-wakel@google.com>
Date: Tue, 11 Aug 2026 10:15:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuacct: Dynamically adjust
 cpuacct_task execution time
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

Hi Wake,

please use version tags because now we are lost between
different patch versions.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
