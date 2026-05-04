Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AA1FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777891120; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=BSGXcb5Bb88fTT/M2zSP25V4UnUNVcxn7M5Yx7iGve0=;
 b=X6lTCwpe8hHOT2WHSyXsp/kz4GUfAKi8XT7/UOI4goqnhXkOZpZkfOcE0yztmE/ZRUWVl
 K8rCsiKQEZA5lfnlTm8oizjvqEUIPtuFnZiWKfOvgiwjl2UqYTmwIfh0cIjn2DsAZbiRwnE
 swb/2U0oykEjnJZosVFc2E43g6T8f64=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662273E2CCE
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 12:38:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C53363E13C4
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:38:16 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9E77600787
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:38:15 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so25457145e9.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777891095; x=1778495895; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=btBTgbBAhLJ9U8vjjWTQjluGAJ8CsIsLSk+RMrouNxw=;
 b=ZVfAV6MYxIaqo4N8VET9OtInt05T2h39BtgbMlxegBO7wcpW4M+kMZ6z+VaZjmaV8/
 tiT5pTORg1HkcM1MSDjEfIBK6UPrEgWdW3ggjVnqUC4UdBEqhKUCghQY15kJ9wdRbRMf
 sHSZeoOodInWw7HVCXg+KXrjs+zoArUKzlx3BFNuxsYJVDAzq9MD9rkHBJP7XTXbmejb
 kHj2H8zSOjOH/dds3arfu+ZlYxHV30fzoIpK3TPkpaP4k4wwVzlzMM2MZKcQDKDPrV4X
 Ox3+pg5yqehIWEK0plx6/J1sRSJDLMI38mEgS8nnXS4ZqjXHsyuelPjgjix4iicj63/q
 7wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777891095; x=1778495895;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btBTgbBAhLJ9U8vjjWTQjluGAJ8CsIsLSk+RMrouNxw=;
 b=c9FsJw9kfzdfT7tXnsx72EIfAcAXt39ys4jnSSovTvZDrvnukYSMjOywt0VRCrnIA8
 01ERJ1/dDjyW4c/DvUnNKRE+bgr5GgOPn6qjg+XQAQb+OhSg8g3rXa1iNptKz+cS5NKj
 U87foBFl7UsMU4j5RF0npssh0toUuJNddQuu6NkDbjJJ9X70Xz7udRY+chX9OmPubi8n
 47DSUyO1Bz4yoXqF/o2dbAR95akJZpb/qCVC71QQCyGM5E31D0FjleS8Lnb7UOfRmJrf
 bU6EXXpHJvTxo+xsnwAnOgPNI+TCuHThSVJ0jsvVv9FjvZyYkKX+EzGgrF1/hIixuJ5h
 u44Q==
X-Gm-Message-State: AOJu0Yw3Wvyvz7a7QpgV407llBRoQCVQOEw8QnD5yKKKmHHgf8Xgihgm
 Le+Jepamu37JNP4PV/LHYNP3O7/QFuZcGKHJyRCj3QuKWu83ojKN0E8pC6uMblpfahM=
X-Gm-Gg: AeBDietrLPt4tcfhNHfkSl1AkPXs/7D65x1JU6aBiVVvzbHkYIArN36d3H9X8VKNsuF
 T8OVKk51TYVjsIlEq6R3jpmhCUgX4fD9FQ8xBqcm3EFHsLi8GkuvoxvKlIGnOprqe93/OvjPZau
 wazpy2nvbJC02d1tUoC8nj9IQd1wJRR5RZwZ2dULZ5qgnh401ppJh15fbu/D8AtkoMDMmbLQ6jm
 OA8W0doCU99Wp6nBKrp0x5jpxr4j6XqouwRr12k0xS4T31XU8AAmevpKISxEULayAmhebJHi/Mh
 Wq5thHxuHlWNidBxYJaiFTY1PNk1xrLfd0dnLXws85aKwZy1DQzVmvgi0AKRYrYKE8zgtolVFao
 MrPA+r2Ti62SDKFzYcR5tj+HvCFSYsCj6AgnBEIlDX6r5UC5+CSfEwnix1t9dt7NtK6COz4DCTW
 67GP6VOaeFRrBQEMkyb62UA0aSFP2dTliQ4AuBaODHx4zqa5s8xuBm
X-Received: by 2002:a05:600c:548b:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-48a97098a19mr150379625e9.2.1777891095236; 
 Mon, 04 May 2026 03:38:15 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d046faba7sm32886715e9.30.2026.05.04.03.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 03:38:14 -0700 (PDT)
Message-ID: <69f87716.050a0220.1399cb.5bb5@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260504-fix_b4_check-v1-1-8673c1083319@suse.com>
Date: Mon, 04 May 2026 10:38:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] b4: fix errors in b4 prep --check command
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, now b4 check should work back again

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
