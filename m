Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77960C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783613132; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nqYhVA9EJAULbtteTpPZqIjuhoSH6o2URUpZE7xS92k=;
 b=T/DZYbvzyYAxStAPpgdUJ1zF/egRDo8IEf6ag+K+zLKY7BfaBaLcZIVsE+Spcbdnyx3zJ
 s9qj+sksWWWuEZfGxAHXoXjYuMp5EFcNpRymEIpLzOWrlEtKIQcuxThNLA8DWhnGjbdPd02
 21KIiYxuZ9esftC50lhd49DxTDZtIDc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EB683E72D1
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 18:05:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F08B43E2956
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:05:11 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 41EB91A00A37
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 18:05:11 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47df440fcd5so19441f8f.3
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783613110; x=1784217910; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UdbK519KtnaflM+F2/70IlYDrSi0AUfdZ+uaf9T46ZA=;
 b=EurK9FXnHDNbZVXdCK/HasHChIDwbjMfyAcUTP2UYw9CKaWNGKwsLi1jUymmRSb1Ac
 PXrRJsfjX0BTQdG/e25koCwkUgbjtRsw5CI1ietB14ZjppCst3dusdQCAxyjB3Eo8Y1u
 dgoo4eKqFOMpqlOEOrY7IhZBwVSGGlQvvRBnle2CucMEVtiBnL5zk9m+Y/sxYdxsjc6d
 K0becYNY4Bu2iaaEBjZCn5dVVAZZS/2q6YqWNJLAKvufq7tIj+0Jnc4HRjGaKTerqBdU
 krYdj/yLE6iHe82x+sz5pBhLtDP3kjeyN98Eag5A4pIfOFLGV/ifwdVf+5Ya4jRDoEQs
 mRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783613110; x=1784217910;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UdbK519KtnaflM+F2/70IlYDrSi0AUfdZ+uaf9T46ZA=;
 b=fcHo3fSMz5fkT3yZk0LL3vmoJ3sDTVg4JYjT4QHIE2Lq3D0dh1yrfbYr4ofYoc7Ryg
 W7wVXMzd5b1rmlBA2dDm/IuXU8y0AcV/9WFuDsWnk569VASwBfPQ8bflfJgd87n9e95z
 suo8kq70lPTXxXPdvte9TGMtrzCPrf/sP3/m366YrEOhZHD34PB1uiKtBM3f5MZxGMYv
 dorEhuyEmZPmzs73r7VpIFdgkTco1s6IObcc1I4X2u4BjqZIdH1X+G1bRatYQK7NGwwa
 qpp4bgkz3nNI9noaFN4HOcZKuOcAjzJ0g/nwKDQT3FlJCIUVcOv87Jhz1hQsh6uESnG3
 YaFQ==
X-Gm-Message-State: AOJu0YxxwrjH3vCCEJTSgbjY0CJl6eR4qDwCcDJ44Kaqxpz8Sf4AaUg7
 oIpIo/Hr6whHdAd/sCf6efSFXEumhrhseLXTaaY/DeUf0cy9+10eLDeZw/vni0mXFoja0snA9BS
 WAh4S7Bc=
X-Gm-Gg: AfdE7cm1gddwRPy3izmEdO8U/8RWJCah9D8KrqjZRcSiRPXouCV1jW00QTeszV0k/Gf
 upoZ8mQA7Lnv7sfdR+DvPERzYPTgXfgWM89g7RW+qPr6C8Lz8XyLvH1pldJWsrNcxHKFO/Zm2ba
 Z478Ct1efBUChCkYaeQxJjoma4tid8mbOWk7PXGgMhOP0S7LZWCEzmKCLGmt7AK7TfRHz63ym/W
 0ilyDdrMX/o8gSpfDtp4LvZSuEXM1Exa/nul2R3EMHLZJFM1qG6ElkDo7XF7Bs09rJ6Rl28O5Jw
 j6XZwWMO5HaZ8k9AJGfDGGhJXCy++CBlCvZv7AfYwtQec3SO2rdzA+A5G17ygIhSLb+VKd66E1x
 QtzrUDawuLwsGCw9egWUcnDOf0K7Ct3a2RnOlnoI9PWhVWA8pHSjqmx7KWtYJgH6oEGh4fEi0Zw
 ZpP+vr1JlUNybqJcytP4F9wXud3MVQQ6kq
X-Received: by 2002:a05:6000:24c2:b0:475:f100:360c with SMTP id
 ffacd0b85a97d-47df0822e2dmr8243519f8f.59.1783613110214; 
 Thu, 09 Jul 2026 09:05:10 -0700 (PDT)
Received: from localhost.localdomain ([37.162.206.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039bcdasm54464904f8f.21.2026.07.09.09.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:05:09 -0700 (PDT)
Message-ID: <6a4fc6b5.f7de3709.381bfd.204a@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260708104215.507193-1-wakel@google.com>
Date: Thu, 09 Jul 2026 16:05:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ltp: syscalls/madvise09: Reset cgroup memory
 limits before test retries
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

patch doesn't compile:
https://github.com/linux-test-project/ltp/actions/runs/28939178833/job/85856906947

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
