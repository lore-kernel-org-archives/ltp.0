Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576D4C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782981617; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=juXPbJTL9+AIgjAvPNoekXvqckblfnAeRNbFE6ns0oa7RTx70xYHuJ2GBq6VTsW5GXEf/
 kqV8/Tl5GL/fn9+kWWtxkaVgI3VGBkdHacgqtJRGNswYk77mIIyVVTkhd0ISyE01/KgU0QQ
 6EE6SogVOKtt/34SPKlw6/xkvwz6Wyg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 116A83E4A0C
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 10:40:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18FC83E4A05
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:39:56 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B815600715
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:39:56 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso8601295e9.2
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 01:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782981596; x=1783586396; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=MUniaOX7WzynDnhtMFtkIp/NCG3eivT4CerRBMLac4cpRQRk1aqjz0gQVjnMRPK81N
 xb9nlFP5CKTiLkfgS7S98WLvx+iFEmXMy+LWVnN2xC3k8M3sNb6DE+lb1UaIdLfhykGd
 teHSb35w8j8K2/4Qv5qesWcOXsojLk554KP3Ew7ehQGyf7y2Eens4SZmVO3Du5yxPSE5
 WomsTQHb32/Fn8jJM+2b7zQK3bcb2SF4NYhaiulJMEsIrC0PhE1oJMGA5EIYcbl+lmx1
 VwpMAVrs6glidgoEyCjJ8NiW6FqdftSIAqMWTLahTZQg5wLKDpqMLRrx5wmuPWPACyh9
 IGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981596; x=1783586396;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=mFKc0ymCJ9OQJxkVHNVAp2NkTv6ZMW6LXiR7CiZol0JSJm87EWmGn8m+KibU8E7dmS
 lS62XkAXWZwKFGxQ27ohQXko8AtcCdWp3gwCsdvbefGs1NGpZmYaOubwRwQNGnJ37YRJ
 JudWmFo36CahWezIos5s9Zhq7RcJZNeRsIyiFLGvLb8ldTuhiCYiSy4X0gGW4JKl0q21
 CapgL3Gzy84MbAARH4+1KjqXp4/4xurKRfwuY1KxZByVkqKufC3ZZlrLzQckVs7ycicC
 sGvhyMK87dXBnX+T+DNAo6flzPbxT6QyuCfo6DTqtdDlXaTp2dZBoMK3gX7MEa3kJyxL
 0aYA==
X-Gm-Message-State: AOJu0YzXOrSb4TpXAd5D9ZxlBtAGJB1VzptW4ONQuv1wpfObP2v+m36I
 rM57KqZ9W4G6GxogwHW9QwHEC518oF/ZsBFDUzV6Sov5HD3MOnG7gCDCJT3LVm4ZM+gWa60HwaE
 qoQHcM9Skww==
X-Gm-Gg: AfdE7cmeWt53TWO9VCBMq/yeVoyJAQsTGw60jjSBivA0yeTPNH51okP5RSZ9YXQ7lGD
 675/0QvQ3nxQSookk8Oz19bvDEWfdpBtxGnNMEkZxx45zjLTbeX0rlc5dVlv0ECtX7f+IJoyvJz
 Qhi3PTf4PRGleUKBKbXqroOF8wE4nB+Ghd+CGmRbDXVfHPB/PWJTPlVLIJdKtEiTSuGlrId14dC
 lqat96oDm+Cg8da1mL4JW+lXvawToZblL+U34YjAIY95GKc2YwqemoaQiBUMnTqOlPt/SB0g/3x
 uN7lVGDShSKaWJ8qJ90G09arEMu2J/XcD2omjVrBEW1Ss6mKAG4DTyfVgAekVbnVPFYqdeESPww
 r6x9aPT68dcVOaUjzwlKif0fO4tBa6n1k84l//O54PlkrsYyeUxO8IaR+loULuLxvrIEv0mI2d9
 PqL5HlUBrB0DbV6GiMejrCuugjrOfR/BXe6hVlvzlaC8XXHfc7b/KUScph6qD2pNILsjCbtVQtl
 peKLIAKIufOfXDIfxsxC2fuAPu20oqHoS7l0X+urHGi1mgmq0QWiK5E/RIyqANnfRI=
X-Received: by 2002:a05:600d:c:b0:490:e60b:6860 with SMTP id
 5b1f17b1804b1-493c2b3d25fmr55779375e9.7.1782981595672; 
 Thu, 02 Jul 2026 01:39:55 -0700 (PDT)
Received: from p200300ef2f13eb00a65561a8bfe9e52d.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe616f5sm73864615e9.1.2026.07.02.01.39.55
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 01:39:55 -0700 (PDT)
Message-ID: <6a4623db.9499cc59.2d96e0.fc7f@mx.google.com>
To: "Vasileios Almpanis via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
Date: Thu, 02 Jul 2026 08:39:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] df01: detect "fuse" fstype in addition to
 "fuseblk"
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
