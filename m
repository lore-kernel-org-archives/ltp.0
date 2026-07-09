Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF729C44501
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783618717; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=pvNFIhXJo5/Vazm5mFXEGyHHI1hSNb/7H2fG3FWqttxE/3HVdUcCLnFji/NXyvsQUspRi
 e7kjbrcvPkEtQNNmQLoznzuZ/B0uWhuhTv+84mP674+ke5JvGP4VAYNiujoHjAKvjy9PXaC
 0CDmP2dWy3dSKGTRMO+B98qkgvqcHW4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DC633E1CDF
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 19:38:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 185993CF935
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:38:14 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CEC531400C7B
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 19:38:13 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so498685e9.3
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783618693; x=1784223493; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=BLmJRe86Rq13BDnOMiLQWYH/wBayoAgIqdpiKasbt3+MtKbfxqWyclIkMADM7Wbh0Z
 7Q+nonhwNe20UXpJCIPABHuFQuV8d2OCOaeBdGyK/EE21mqDD9iOVt8yO7rtQTpflUGr
 bNR/a5BjW361rbprfiEXc7uOUHfVbh1Xf350zA2DPSReB22fy6TVr57lFIi5mRO6Tdfi
 NAZr/c1ODo1y5swCxawqC+0RosbcdORl6Na49LK4W6fPkvZwSnSiEktkZ8LI7XAufrO4
 4MtQS9cCQPEzcxjZTNuFXbslBCqhaFaB5e9SW8yi5cgPA2y68zEz3FrEdlwZA72mfnEM
 pZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783618693; x=1784223493;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ZKBtyJieH0bJSgW3FJgg27Tg8RspNIya/paHHrUUPm7yStceFR5sLPpQ8wscAx/ztq
 Ma3mWqAx3vpk1dQ1RiLsIQZl4nRcNp6FA48O5ZvLjNbY75t1cYSLVMVroJve6r92t234
 Xfw14NjBzCq7zyxw2WLVIl73ydnaoNcbDtNdD3XDRp/Xr9ns5SJj2bop8Pef0x8K8Ui9
 77ZZz+asYOZst/7ge/qmKmP1fUzi33lstb0135+rMoMVFmZwAwcPxGguI2uIWI1hYqlG
 Qnmo9cV0Pipmqo2CSx7B5EEH9TxNjr5Qxt3UChteHFdse7EJccnslWXcLcJDnRG42gEH
 ft2w==
X-Gm-Message-State: AOJu0YyqAHJIIaUCB+B2+C+80hYIoBA042CRcvEavfQCIN/emj7Ps4Ie
 HYBPTg5TlGoG6RDbK50/wkRYyWZGKZi8hM6IO5at5LcZ2/Hi8esRGth919QWCuTMgqU=
X-Gm-Gg: AfdE7cneLw7vurmdvwIqw9i4vhFNyMon/f5xkL//DTGuHZye0Fh6yhDwAIYMMY0BG4p
 Y3F6TZ6T44Gmg1/WHlegXsX53pVlhCYIMAUSFKP1GquGikFlSYD771QWIdl81LPgA9fDmxWelcm
 AJzW3ZZM/O2/MHUhCu83S2v5Hji+hmiV2+TX5LlIeUhI++FFa6hOGhk78ZRKsKNQuOhaX2HQBFM
 SxuvQXc185OODyG3v6VAqyKO/NFC91zGdFhMMrpg/5etLt2ULrCBrYb592mlL1WBZLSyMF7Uh0l
 oCS8K4OaDKgmNJvfhGImmylNDYLdj/Z95St6I+uAXN6ymZD81FXAnRhusoorT7YTfbVjB6zQi26
 y885LXaQFlN5L8Fx1VoCPK12KzUCa/njQ6qh2Qsa4iqpwlDgaiWHWbDku6SQAWjdapcT8bHTo+B
 X4IyuQmzB7O6pKkd9afuX4nz5fXSt1OJg=
X-Received: by 2002:a05:600c:4692:b0:493:b750:bd20 with SMTP id
 5b1f17b1804b1-493e68a5f91mr84232625e9.15.1783618693176; 
 Thu, 09 Jul 2026 10:38:13 -0700 (PDT)
Received: from localhost.localdomain ([37.162.122.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a6d752sm91365305e9.2.2026.07.09.10.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:38:12 -0700 (PDT)
Message-ID: <6a4fdc84.cdeae0b1.345f6c.4cb2@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260709102837.54583-1-japo@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:38:10 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
