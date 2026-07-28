Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5597CC54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785223700; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=SK0aueNnC+Xt80AXTHv0HbN4VvvYbv36VdUuG3BtlXh2PAO3ZRewp7WKpcp3MtEIyrd5p
 9BB/djBJJgt2LLok5ZIuMqTByd6UfQ+wU6+XwvdyfEkqrKOjXsyZ/XcWFXyxsZMfRa+QUNy
 JlSSc2kAgLMA15xJ+pBBhWh21YNyQ6E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 357233E5237
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 09:28:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA9FC3E4EE9
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 09:27:58 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 376EB10000E5
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 09:27:58 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so3097409f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785223677; x=1785828477; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=UqdRc+RALaOI1gJp/t6j8R2k7RQuys3X2PVeeHfXMLc9vu5/nH/H1GEFBpKWHm1o5e
 oZwMLOBAtmHSlb4BJPONXydQF5MwD+PB877ZursMnAAq3PAK2wPYIpXBqm31603yfwd5
 7anCEUfuah8/UhdSUO2RqvkTDFXZNQnsEd3gYLA+bz/vi36fgaL+NSyZOLffejW3Ki9W
 y7MCaDAbILCmQaAn9jqEpyLaBTZo7ebd7eTrFL86BaRT0+PxhJCo65+NIWmDQ0J3sjWH
 hzuF0vOiK9wmEDIdZuws9175aikF0PSsgDlDa/OYFY6B3XlTt2wl+g+PRnWm9e2rIAt9
 H5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785223677; x=1785828477;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Yi2FNc1mEuOEh//1hQShu1q+96+JgXZetj42I1CPhuPrZU7nnpB2RxxWO0m3mv+eDz
 CycmWmH/7claI9pldrK8hAqTdmLW6Dh0wYl9x8V+UlM7FsfZzhG70oI67OCvtf3v5W0G
 EE8r3t2XvyXxz1H8e4ZmNm/ryYaT7tHivQ0TxE6o/ma/fNUTtWufCxHSG0RTGEiU1hEy
 QEUx6BEQ8Kmb9QtG8SaUU2XFpJd4fs8BswS3c2TRAUGzvIOW41BW9exfMwCo8M+U1IoS
 Vkt+nb4P1lja7ypXYg9XaznzhTM2Xl+VTtxoTqdr7/m/mse0NuXcDkFOmew4qNqkExb5
 S1+A==
X-Gm-Message-State: AOJu0Yzxf9us2M8w2zcVPCDSDctQoiOlLr9XwUNRHgn1YpEabudde42a
 B650lffum9+L2mbHLDXYVGpwsAtQEGdWeifY+qoFNpDpG/HjCL60MFofZnL8bYOv5ni4Hy9RVX8
 GUv6rtYZq5g==
X-Gm-Gg: AR+sD13WP/6ilDxu5fTvRTyJ36Q9JRTFUShTKn7bgTOWv73Gmh5UXqCQt7s5WDX2HAm
 TaPbrcRkiVrArc3D2g+MKlO/VCC8F0qkgGyi4GAiOyTfUu77o7ccxl8BPYrvzr4UpMCTZla+xgz
 cYazbkAyD84d710jkebK6hhixnqxafsI7fc5afjyUNp0aQXGVjrMBFJg/5LFU4FGkxah8GyWJBT
 T9AqF2L6lYU9AKUrXzDnt+3WTWzSfs4VeHD/hLw27ewOfoTAF6Pt0hCZ/EKUq5bRw6SPjvlj6N1
 Io8Ttcv+mE3oxbYUzvDYaCAPZqVBn4+DZOGMcjSfdScUEKRuybM9kZCp316A1nhJ2jzWfpU/fuR
 wIK3KGP6DBsTS9cTcMQD2lN+M5526nUvpQJuMGDIXGjRkVSzGan3Jfngu4NHtV36hudApzd4Jpk
 hsv0CxQ7yXtWOWtobG6vEAC33qdA==
X-Received: by 2002:a05:6000:70b:b0:474:cd60:1154 with SMTP id
 ffacd0b85a97d-47fb1f21bf7mr1149284f8f.41.1785223677432; 
 Tue, 28 Jul 2026 00:27:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bc62basm59064400f8f.13.2026.07.28.00.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:27:57 -0700 (PDT)
Message-ID: <6a6859fd.d9578069.494be.8002@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260723104458.1287008-1-andrea.cervesato@suse.de>
Date: Tue, 28 Jul 2026 07:27:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inode: convert to new API and merge into a
 single test
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
