Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C66C43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782981660; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=VJZkzti0ne5lMHNbITPYv4a17d9eYDEd7vhKMXftSCBSto3A9HQfkYNIo3dFf1nyOzA1P
 4h9FnuKLPhomnxq9enZ4sSiD6dd6j0LiO0z7kx5T0GTHl6L7LLHzPUFiL9iDQVAe2AsnewV
 1JYKT/KYgt64jKT/7XoqbW/zdYZ5X20=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC65F3E4A11
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 10:41:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 352363E4A05
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:40:41 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8457E1A0067E
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 10:40:40 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so10436995e9.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782981640; x=1783586440; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=gEhSpej0gliYpL956DWWqF6aUVRlRhpU9uO4yd9I3t2R5tVKfjkzgD3Y6RI81EpyqZ
 d4rYVfDkdn8eJS1yrc6z8jztw+ifgiPvUjtpolr59bpcG/x6UZZ3Ld26GYDVlyFbwhUg
 6e8MQqOCjc1kYG6/uIXtKwbesLduf/MiBpp3l5di2XFUyHPiWKc7icvecFZK+/8aS0dp
 YraLSXDtuPctVRmr4dH/XgM5NZRq1ih5/a9uC+sgy46FHYTitS+HIWxRPAwGKYfOim9M
 OnpdroKqYOaufqNMYB1+yswORbjmAB0Zs/K5Pp6xBy7FcistioXm7Kpbbj0u7jd3BraH
 Rbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981640; x=1783586440;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=N+oAlH1W43cHLwtNulDOggUdtGkiaMzcG0wtubFL3W/X8HT5Jb0LzlVPVLFHIit/Yv
 JTIuXVIx4owusrC5FrjoO/eO0Q5m5RT+rOjFba9p6d8IF72erufQoG7ouzGV/kbr3KvA
 shxQXvo2Ne2Dlq4H+GEygiKirWHIKd/eHLuX4yqNmlqBhoIviGaUsj/ufHI8csFq96Nc
 PpW3NjWLfJQTJEkzUKYae7U+7pXUVm1aSf46tZLruCadpSB4vXUmdm1jpuK3PVBVD2y5
 W4JN9X3R9WrLfN5xixRTawXTZz8hZx8jOdY2gX6v4kFOWVzMragWDyy7oBU9qF733g2q
 RMxw==
X-Gm-Message-State: AOJu0Yx6wAjruQ+UvO/vb+5QKCSf+dl93CMMPea5W87tbooYv7WbxUjt
 ClLjSVrlfb27ThYRYUAJZaUEsRtioQoSfPLg1YwqAnR/OfwX4HuQbiPqxuNvLXSNUAQ0AoacW6N
 a99qSUkox8Q==
X-Gm-Gg: AfdE7clykKikfB+Lxn43nmrGiUkf0biWvhAYSRKnAiwqSfDSng0UeplfYoeuLUHwYmm
 E99S+7DRVHFkrz8/dY0zycoXcOfHt6yu/5IlTiG0qN89tlAF3bYEbRfZDjuopHJouoMIzBHnt5e
 5vXwJy3guLxoVd5j2I0pYZ1Js1EghSLhZJhp/zXFVH9cfu6sqzEGHI3DyMkIB+VtHuoNZFCJlx6
 Ft8MV6+MM3uWaiuLahjLjWt03xhCzlhGDZQLbLLrG3IIaG+9A5PLmT26taNTOj8B0wc8XKhaV4s
 z/5VECFjTn5sSk2UqQr/DkSs8XS74DVWWo8STwmM/N68+/JmXCb6lMz+LyWpMnnS1Gk9qiP0bTR
 +l+mMbg6qPl5RAEmz21bgf5CUC8jAU5S0iDUj/d/A8fzzPJ3SQuCLYTQtfJ1U5o+JCvk+VoWRRs
 sRwGLoXCPbHvOtRrY3Ot0LBfiD7HJ/OePzVMYOm7eTZrZCTqcJNdA+oKgRSE35l9xsmcFnEK3jr
 mO/sOaSrLLDopBdsMitpkYfqjLUO890F0babnVpVPvbqZtQCQ2O1uRQ+nDFQERan/M=
X-Received: by 2002:a05:600c:828d:b0:493:bf86:85c5 with SMTP id
 5b1f17b1804b1-493c3df3495mr58808745e9.36.1782981639886; 
 Thu, 02 Jul 2026 01:40:39 -0700 (PDT)
Received: from p200300ef2f13eb00a65561a8bfe9e52d.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0f433sm7508856f8f.32.2026.07.02.01.40.39
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 01:40:39 -0700 (PDT)
Message-ID: <6a462407.f31388b9.22372f.ee5b@mx.google.com>
To: "Vasileios Almpanis via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
Date: Thu, 02 Jul 2026 08:40:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
