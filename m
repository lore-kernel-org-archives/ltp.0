Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9798BC48BF6
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708499827; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qZ/YJMO4RPa/makypMTFykrRjnUVsKIMemnAhfzeX00=;
 b=bIq61758XzyBVHHwrFW6iKvdJ8Z5unCaFppFCK2nYFSwx8FrgmwoCcaWkZo4MOJVnFhw7
 dRf5gSTOjPSEs+Fys5Eyp/yCZAhN9Is9By05PE+dwwTKHp0PW9oa1VAU6/+x4BSR1X7YTiV
 9Nnr4ZjywElDSFhhR9BmUc73xxYRUqU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9196E3CF21A
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 08:17:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 441B73CD90D
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:16:46 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F2DEF200AF4
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 08:16:44 +0100 (CET)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d109e7bed2so3495451fa.2
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 23:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708499803; x=1709104603; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOjBdUDbOWfPLzaKOQ4F2V2vYw5MNspDEr5LKrKudck=;
 b=cNe+b0WHcKiVOURuct3IMvbTsO7X5SVbqOAim5op59oKybH7I/zUhHTdqu5/p6xU6W
 RnHCk2itPng0MUga4CXvH4+VYF+nG14xtNusM/kiXD+blJ12qjGrKUObTK/1rJCfq+zp
 7+BRQg9m16oQtR7IQMrkYpGAOx0bKT89EQ+MjIb8X9GRMmrSXFtST2bTVT6YdkZGVS1q
 juSJc4R/VaOdq8MEjuyzt0nZVFXyfdKSbczKWHaAcoMAw4RmfMjahc1ShsHkyiNT1r2F
 Zs8ZdXNxA8j6nTtxhaiU8uzMkXDYL2BfsAvmoaeWBXT2xwSMvoC4L/i19OXVkIKEU+EG
 f3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708499803; x=1709104603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOjBdUDbOWfPLzaKOQ4F2V2vYw5MNspDEr5LKrKudck=;
 b=IEg7iC2dRs+dYi7RBLGaRpkXj3hW8GjdkU0zLo5yhUJyM1dSGLy2H4lqgGeGMCrENq
 g95YfUKCcA+zRWZS/fPOY09l951AXWcvMQr5/+AitZcu+JdwjHnUke5uLiSq69YM3hNa
 /kqB06iByLeHKfGzx4HVp54fK8i8aIvvYtjwo3jWnf1RsKily0p6P4x8d5TX+ydYcD2v
 jpmKNrM1DfUMRyePLUUZOBMjV4Mo3FF5X9JJyFiHJBIbSrpkhXpEGhpl+Pb9t+1pWxY/
 fFFeJqV9cwgxj/jFMkNmsKVRdqQpi1ENF81B1Mar4u4eo2ZM2JrmBmjdLUeUikNutomm
 2ITQ==
X-Gm-Message-State: AOJu0YzKreGB1RbnVDMscJHfa4LxdnagcmQhj8K6n2/7yM+B/jixi6AO
 9z/dPGIMcfgdCRCVIYoScZg3LtNn+KNnvmbgteWtRNYiOyQ8Cngq6X0qmCOOzcYyii7gU4Eij40
 =
X-Google-Smtp-Source: AGHT+IFzousrFfgR8i1E1j6AJ7pYIU4irivYw8IZlZXWn7G9L/hPJdR9qWel+3WfDRP74NffPmg7Ew==
X-Received: by 2002:a2e:8089:0:b0:2d2:3a5e:8688 with SMTP id
 i9-20020a2e8089000000b002d23a5e8688mr4656924ljg.48.1708499803596; 
 Tue, 20 Feb 2024 23:16:43 -0800 (PST)
Received: from localhost ([223.72.38.233]) by smtp.gmail.com with ESMTPSA id
 b1-20020a170902ed0100b001dc35d2208csm328230pld.70.2024.02.20.23.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 23:16:43 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 21 Feb 2024 02:16:33 -0500
Message-Id: <20240221071635.17239-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240219134845.22171-1-wegao@suse.com>
References: <20240219134845.22171-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Set system default umaks to 0022
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  cgroup_core01.c: Set system default umaks to 0022
  statx07.c: set umask to 0022

 testcases/kernel/controllers/cgroup/cgroup_core01.c | 2 ++
 testcases/kernel/syscalls/statx/statx07.c           | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
