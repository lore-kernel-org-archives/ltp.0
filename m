Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567E6CD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778142893; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=DPjyVFRoj5WLdNrMRGap6wmXgYx8XBZ1mkcPKc6FJfQ=;
 b=nYL3RuJOIcznS64c4DQsQPohaD4C/Ox+FFmTomlw0/p1TPBwQSCXUR6QTGSZbLulJoGYg
 R/7IUVfpMpIY0cpuGB78DSN2i+975tCTQrmFk4j7wAlJobFCBiy85kbmyzFYFsh8vVVCkMd
 BGKWuaMWgFjYFLq00unDuRMhRSKce0E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1983B3E2C38
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:34:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4448E3E2497
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:34:30 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5224310007AE
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:34:29 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44e5624c053so322684f8f.2
 for <ltp@lists.linux.it>; Thu, 07 May 2026 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778142869; x=1778747669; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=U3Bb7S9aORaCKJBM28eSqmvN+R1nUlsY22ORB2Dtav4=;
 b=TyQ/MYRd/xrkVRZqfh57MSiwJsfLdO9cBAzOtjuiuhMcbhR4/3cKA4+sMOMoiIiKBm
 cnLTxMxabmWpFYrZWffGsZjlQfGrfVKvB6ydKQz4RSMHm18eoH1NoWSD915y7MSLUORI
 1auUIZc/X5xSyNeSJKn8kOmTsxPKZDwPP7Ca6Yi6mGkjkCTw4YfOadJ30Rrd/p2Z8TE/
 pWPtlWeF9PKEmX1jbHg4flWIYM83JKVFISUJoxLU9okZtUsi02vvW/8hSpDzzmb7w5XR
 QMvNFwWvgfgR4XPbonpKDeyj0a2jCy0J1N8aWLSE4gApLyYIs38omtN3evjD/f0JfNFn
 eAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142869; x=1778747669;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3Bb7S9aORaCKJBM28eSqmvN+R1nUlsY22ORB2Dtav4=;
 b=aWnwrS38NW5tCIRt4V5zzsQVAubgkKCoeZiCmzQuz9kgB7ibdjP1m7rbGpNitd/qxD
 ThhW3ttSpy0+R8sPpy4i7Rq61tdTplcbrxNumCOMuYmGxBrUEZf7723NJBHs0/Ayd8dr
 ZZaX6O5g+AfuHLuYrhAVGljBsFXfCbyOjE9En22/9cUMEVsH53XAwQs0henyoUKc/1FB
 vdHxookK3JUEvXnHyD6/Fqm0/BprpExb6fyMGwRYqIA31mWU61F+uZScNtnwCXQdEEC6
 Zf6FtVMBXqxWAxT349photm3MqTAg7syT+mVnrzDx1zO/iq7p6dRHXPVLsVYIxBLx+3V
 7QLQ==
X-Gm-Message-State: AOJu0YwAI/qzumIS/SQDOVsIqlCy/KJ1p0zdaYrnagsYBmbPV02WVSHE
 sQ5Xi0YAu2jAm+Jx8JyeO5Yj31GvtkGGDpN1fiHvuoz64TRMeAG6S77q/eLRh0LsrIg=
X-Gm-Gg: AeBDievOW4cPjJIBgxc1850lZ2s0VZKTLYB1uDqVqQhhqvl+Fma7l804UVnRcP6tEN5
 Oopl+ZeUEm7/q4TX/dz+99R2RRmYQwXDdYIolmAfMEvWFMCVt2q89ErJ9a/afIVoS88NokTAwuV
 nzZRjsgi6K6nj/Gix+EIzo7SL0bUPhXGkL713GO/6aCZV/ZUhLX5PjhUlXcJ9X3rjmFEmz1XhV1
 eWIN4npfv+d9xGKlQAJcZuDF7I4BYlcvrG0JVad4uUOsCnl0OmDFcd1BO5YxWRya24oMtiwy3aX
 YJMU+mKnO1+XLSmpFosgIIk6gwZB3txaVzpmCKXKHKRIl67b55s23SVubLPB1omZ1KWwfwtY5Z5
 1Pl258rOTq6e/2g4o1AvLv0oZcrwRbiswRfbdRXWv1Uyf3MNCIsQQCsE8ho7Q9wDOlDYGSmh1se
 AZUC9W4ASRIrWr2Oa2n3xBz3jajNlwJMJWLJR/LUVk9ouoroBMfqOKMN9B0Dfoqh07hxfWm/5lp
 09fztUJs2nWAiEzzGvEdWY3C6z2CJHu4aUxPuiEgSiiDQ==
X-Received: by 2002:a05:6000:288e:b0:449:af52:6167 with SMTP id
 ffacd0b85a97d-4515b056e09mr11750453f8f.8.1778142868555; 
 Thu, 07 May 2026 01:34:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48b23sm19251055f8f.14.2026.05.07.01.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 01:34:28 -0700 (PDT)
Message-ID: <69fc4e94.5d0a0220.2c863.0e79@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260507072238.102543-2-piotr.kubaj@intel.com>
Date: Thu, 07 May 2026 08:34:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Also it's not compiling anywhere
https://github.com/linux-test-project/ltp/actions/runs/25482508839

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
