Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1139CA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 12:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791807906; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5mqLKsX/h/jaauf4DKrafxRAg0ZpT0LLRRaLUUYRCc4=;
 b=nLH1s5/AbQBkDL+ncDYQBQyWWiDTVWqSZZzi3Z3DHYmxoYcY0l1crAH58mFB6cf3lnFry
 Hio3yR7k4JJmdskbBQ7HoKplAUd+od33JoNDiAZD/FMIlnqsJOJrzSW8MIpdJ1S9OU9A3cC
 SEkO1yYEt0Ih/vseI/wGuewvFGdugoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5EE63EA854
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 14:25:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24A7E3E1B67
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 14:24:46 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D506E140012C
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 14:24:45 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so15755365e9.3
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791807885; x=1792412685; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sjZh9NuXqQhX+LV+yzXbPaPuZ1EioZ/lMI6xoAOE+MY=;
 b=UaMgQ7aLdRePnaACSgR2gBki5ZKS4lLYNC4BRz79ls/oZ41TLL0rCMz92Kh7p0pRWJ
 1Dl03WnJjYKCE0hrZ/gDxU9jy1ElMrDwlp+n5GNbNqVkUn5Kyx3UE+jmEOrBPfhGRlQn
 0V5uYYpjJXHutpkeKsIqHtXaaiD/HodRNjUK8rUHr/F08IoDPemefqctSQaALpxRWBWO
 keqYUUY4hTxAM8+WDdWAzwKRa9kf3PBq2WU2/dbXlGIkbcisRTW2IhBkvCDJzn2UpV56
 ujXS77tIx5MXlXIbcpKrLxz/80qyTPg3FFz/Nh6q7Sj99n5Qu81rj/DAcksh5GK2gzK7
 cUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807885; x=1792412685;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sjZh9NuXqQhX+LV+yzXbPaPuZ1EioZ/lMI6xoAOE+MY=;
 b=jsZVH4zVYhrTKM5eySIHqUcIIzSXfKWbD0uCp4+zmKNM0fLcqF2tkWTtPvhD8Cub5X
 RlQNuFaiDKxJHEB9JjHEBxrI8Ts7WPEPVUQfAlrnHjUJWiV2ew8voLpA92GB74mMKSQ8
 j67D0PmhW8IWCW5Y8r6XNOU25jB9bO+roOuN2DOm9RMw1Hf5ewk/xco+LFGmze2fpf7u
 y/pLzP4Fc/tDQfxHxZiMwcJKzIz0Xh8+ZsgW7xlW+mpWYZ1qNjCUidXRMFazlgvVIHNa
 jxqfKMHyDsXSNkrLqKI9hhS8GEq3pBsIeoBaBKdgm7FdTtq1wkJLLiolw7N3+9Lc1hR4
 XhjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjk2STPnxJtkmSuibakCUWekDiWy0e8B8m4oflZk0MKFeZFD5yTpQ4fw4TWhVqzxnn4qo=@lists.linux.it
X-Gm-Message-State: AFq9FYLu4TUKdy1jRSYMa7gFL71HTE9wQX59UgKiTjYaHspFwmSipd1e
 bQLYaRulXvmlCjcXV6KX6jPb5OJTbYTuyhPuEAtCdHqksdkjzN3xsDY+RhA0GCh0ARY=
X-Gm-Gg: AYBFou2RiejCgi1coQTNAgZPMfvJqtmgVcPv47VF/+jL+Dh6hmE8WrjtyQq1PPxfjZi
 c9mfgk2osf8m/QgjSwrcCSdUFti66UU5hr1M8QHLrhu2/IGQEbemxA0IaIgAAngW5JpQvtDLQYt
 eUSg7kgN0Kp6hDgzFGuNHEEXDgUYTGpUsMAFe+hsmm7UiyXsJC7RtpI5iMqNGmr5z2xeG4HJSol
 DwdGxMEp/jfavr76+4LjZPckAd2JcnyNiKmYGJa4dZdIrvw7O43d6eLLdTdJRdxx6Cfnt7AnAN2
 YvInXx/P+/4thR5Q85LkKXioaPQ1lQHyVauTSfZJv7uSWm1QUXUby/hdbQnwAsbSNoPE5W0Slps
 +Gs9ubCx0sn2bfrvM0pkFPYQqJsFEM/+E6p4qOJSM/IJf/R3TV1fBdre6WHro1ac57DSiVIJiAR
 THh+dcmSQsPzynqZ0W1BbW2iJG9+10K/uCTkKplCjGVfvMuNPOJcAo5Qb9Nr95UgfPGp0+iGUwn
 Qe22ZoAEyA5RmQeYnbdrh1Y27RFwQMTL953hdoh7k3ANFeEsvSgxLUEVMLEZM9fQkNpzWygMixh
 tA==
X-Received: by 2002:a05:600c:8b64:b0:4a1:7703:e537 with SMTP id
 5b1f17b1804b1-4a18e49302emr173886945e9.10.1791807885096; 
 Mon, 12 Oct 2026 05:24:45 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf135fasm251632295e9.5.2026.10.12.05.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:24:44 -0700 (PDT)
Message-ID: <ifSVZvHsWCaLinAgtZoIIvpkMS0DfVOX5iZ4@localhost.localdomain>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6ac3932e.d5b2c389.14d673.04f0@mx.google.com>
Date: Mon, 12 Oct 2026 12:24:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_{set,
 get}attr: Call the syscalls via tst_syscall()
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

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

I think I reply to the wrong email. Forget about this RB.

The `sched_setattr` definition falls back to `syscall(__NR_sched_setattr, ..)`
if it's not present inside the system and if you see that error, it's probably
because you are linking to the wrong library locally.

Please confirm it so this patch will be rejected.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
