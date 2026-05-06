Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B45CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778066561; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=W1KYvKqAbP6/lNIfg3LA6vqMR7YoZyRfyBW5fM/1AVw=;
 b=N9+EBxQHKH7wFqKpfB0F3xw1w+JciNVSYEh0VrudmMM7EzmJtBQc+6Q+JzdtfXZQPQPCj
 +1rHE+qpUrytOXV5QMO4Uhy+6mUnP7C0vb+u4sdjeDkUeU3Mz3TvOaYzYqslx0EsjVZegm/
 59GsElRCM8jSeDR24IG2ULr3ptwGWZY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B1AF3E6161
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:22:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7E793E2CC3
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:22:19 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1FFAD600B76
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:22:19 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891f625344so8837375e9.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778066538; x=1778671338; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=36dJdIxPWkAHDWL1Qe8vAG1B2Bxr25MCNyQq3QJu3Zw=;
 b=b/S3hNHEqGF9MzLneWcY51VCj/EauPM4Z73RMuOgX4hE7ADcrfK9p37I/yA7lOPaBx
 PSW65DN1vkd0835WhHHyc377efSQDpbewhagj3OLPD6+zHgvsa1JZbmzQ8OSaTm93yL7
 ydaWjG1Uzbp4LRA9sdfh3LYO7oWp+qhzpymj13kTSy5rwW04JGOVHbFCvI8jtz1TeEsA
 12Je7NvblMfY4EuwjTXR2r4UOcDX4z6PSD8HDjHDKulJ69yGGP1auz7Yumxh4Kwa9B2a
 wPZllnrC6IDpT8T5Pu1kpor772xQzu3G5P3HW6myWpzy6LFEknjvkHnWpCavttsQzwW6
 e2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778066538; x=1778671338;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36dJdIxPWkAHDWL1Qe8vAG1B2Bxr25MCNyQq3QJu3Zw=;
 b=fQ0YHkPd3Q/hmNrLNVR6U5XnmOvxXq9WSscKQ5NN0bn6fX32tT62v36FeWS0TgflbO
 HnbVKosqPp2986K5EfmprzdUZea7AZ2nsMK+ic7AS/JaEgcPBpvCK5gqwbKz0KDTd5D6
 dAXhsn9CpEY3fMsQlIcSXeNClXtROw731WMPv1Ja/DWaHa75cHpEbS0/veJp9PjFHZ/E
 JYGPDuNSRbkKEbOrekFLW4EWuWCWWLhypHqzPDsoRYjRvSuzh0Zx+bsK2vz+mpEjFojd
 GOHsptvQ5wu2Og5TLMz1/Mw9xeBxl+wpHx9vppuhQJWeTaEogSLBnI8ixNiwy1kxcMYc
 Y+6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M7tlco2R9raV0hOzv1FqfxmSW0vpE+7U8QqqLvWC0UZTYgs006qzANi/G52zpShI6Tjw=@lists.linux.it
X-Gm-Message-State: AOJu0YwqhJoPQCMwEjMz3AkcZB/23adVkNEg6f6jJB4sjTjEHW/FMTV1
 ovWXUh4vElblzlra5/zChgjRFseXbYdlxwERZpoMDSp398boMkw2tTWeyFLzqR09d/UApB/8Hxc
 YNAiyS41bFw==
X-Gm-Gg: AeBDietr3mVyr30llolSk5nX9gOjm4qCPRVk1j3aHm/b2RgSGsfO87zXRVGO/f3f3b+
 3EQEeSdWbR8ZG14e1gnOzw2lYAh8sP9gZN6lmI5B37G3f7w/46DKvzvPGJW19OKs/9gw+3VAgVt
 hfbSN2S0WWiMh0Xzsqp2a71Dq2wZtaRVeyiFYShV7p1iywIXFsx2OOwx32ncAh6guj1NVjI6L2u
 2rkzpaVuLh8UdBNyIGNi4EkJXLZ/EMA87gFz5gP+c8V3DD1ZK2hymFqIctlmBB52Ulirg8x629k
 +PFA5I8mFZ6qPcu/ws9Oh/AoI5qJYk83A3oGAZh4Uf4/lKyG+qUakvknrIYEbW1NI74WEZtKtEu
 6DCHYkrub38lijDWZSF8MI2eZy22F4JGHCHOXgbvnw5HdXdOU1NaZ2DNFzwIKZhXPz991YjDz0d
 5/o2cpDzWooW/Z63/IOfCBqmiWQxL3c/vGGSiCnh2xWLWHqwKc80LNApoVG8SeFwUUMxF6y5vB4
 sn2yYyf40ro6+N0aDSkLyI0c3mwK/VkFrpMtD/6F3VEb06ufsF2tTI/9HN+8JYMTnTeRjCKPGRc
 x59ingdCum2R
X-Received: by 2002:a05:600c:a305:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48e5227db96mr27607435e9.5.1778066538368; 
 Wed, 06 May 2026 04:22:18 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530d8691sm32733245e9.2.2026.05.06.04.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:22:18 -0700 (PDT)
Message-ID: <69fb246a.050a0220.1c51cd.b1bf@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <69fb1e29.050a0220.2040d8.e2aa@mx.google.com>
Date: Wed, 06 May 2026 11:22:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Minor fixes
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

Sorry I was over-reading the various userfaultfd testing suite.
This one is correct and I merged it.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
