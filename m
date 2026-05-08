Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4FDCD3447
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778247694; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=DFWKHuby+EZt2VgqoicQDeZSAFyw3x1lVvFs9pSC6/ks6WFTv0i+aQwNdDNd2rSIdJUUQ
 UJrsjFq5gPn5ZDmPnZ0hp6osknH51poCjmAMoBr2EmIQLRqF2X+BxyxE4TyqYRWjWX6emu2
 Hnka3V35wI96oB4LKEt+kmCe0IXuerk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 033A63DDAAC
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 15:41:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 606E53DDAAC
 for <ltp@lists.linux.it>; Fri,  8 May 2026 15:41:11 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 758E31400975
 for <ltp@lists.linux.it>; Fri,  8 May 2026 15:41:10 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so12357355e9.1
 for <ltp@lists.linux.it>; Fri, 08 May 2026 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778247670; x=1778852470; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=VoBgA1DWFy+XZnHEyEMagYckqTwbMJiYk1Z3SPDAvEEwSWdNc/3VKq6KbKg7SprKkv
 6AFP28W24Be+nrO9nXDnOEU0TQLrwv1whDlQA0kM7UMrKfrqoNun26foMv71jG57Cfiw
 uQ7vbApeYVVLs5xdu6rMmkFwvL0+61DGvHpLxALru55OX/ezIRuXOWS58sBjbyuF+uWs
 xKozVxdvCKKuKlgtfVhSLNTHjQckdi3+z/V3ELBFmiS9/Jd500hZ19zbRb71uoLGcJFY
 R6X/afgrGoL5QxIzLp3rhhdeV4NYjFu1P3OPeK3jVvZsnQ40BluVDhWaTKZevmH0Ovht
 N3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778247670; x=1778852470;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=dpWzpoW2Y2gApaNsjmxYdYAOhb38PYAiIOLyU3KCwqTDOeavrGRuOviHmY9blp4yMs
 GVo2UGrcpy4woN4nY/lDp6djThSD7roTN5jMd3Bf55HGxJwnbtGoSfl3lCz2/dK+w2a0
 zXwT336S2Q204+WxXiF4ONLpUMTrpHv/VJbJfqhZ08U3FtFsAKMBvS8A5YV/4mL+esYM
 iQ4UKpFQ/go17LBVARJXtCgJ0r1MDyAKRaKcB/jhQRjmfeqZ94ORrr4lKHfcE+4XYzlp
 a8CAhRF0VccfZff7ZCf1Ao8tNCANXMft2nD8ratvKG6+URawQPS4TLuTwkUyl6v1lmyj
 kPxQ==
X-Gm-Message-State: AOJu0YzVxPRjyeQp82Elu6RzzEFcb1dHSS2ATp1KyAZG8PfR+dKgsmBg
 BsuHNXN2YOIzYb725/kDT/w0axg0IMRRAUKBFxqwp9M7uxGd3Uon1fwa15haQsUXwUE=
X-Gm-Gg: AeBDietPErQL4aG2ZMEG08KKkYorkAjcPfziFinsjLdFYIcxadQyOVFr3iq1HbpJYNA
 FSzfAeJXWsja03UoMy+J4Gmh/f8QhUbiuOyG2IRkuY6JcPi3ywf3bajj9z5afvtkv80w1+WnXCb
 nGdhptcTzLhdoVChg/meI7KSKdsM/cEu55rGc5qrAFzUCItQ9hbH5pI6Bq08E5WcsthEtdLXD93
 +4Fd7e9r3U66SaMgFGLCgIEDsJoYlACUuhajnDMhK0xo37XbfNvTZfHtdsJOb505VqljON7bix3
 C0sk3KfTPfNOZ/8NO3GxYD/ZQahgcO6xpSWlYKs+shei2Klc+3EZ1VQjDTa19NoI4Bl7kBMztjE
 yM/QMeI3qVQLoAQFEJf5gXt55zYZo2m/QDB/3xWBeY9vR64A2SpGH1bpme7lvdUkZlxsYt9YwD6
 /vSakgdlcPqrJyLtHsFScb5fdJD8e7yifnyuU+p7WHJFN3KnRcnYf8MFCZnymqrYy8dBtUKb5Px
 guS5kwxMVJZK4uTsbLgqteGWeABO5CwfGA47C37RRPEzw==
X-Received: by 2002:a05:600c:4e0c:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48e51e16e58mr214877595e9.9.1778247669693; 
 Fri, 08 May 2026 06:41:09 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68eef8a9sm38681135e9.8.2026.05.08.06.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 06:41:09 -0700 (PDT)
Message-ID: <69fde7f5.7b0a0220.c9977.c4cb@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
Date: Fri, 08 May 2026 13:41:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] cve-2026-43284 reproducer
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
